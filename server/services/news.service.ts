import { randomUUID } from 'node:crypto'
import type {
  CreateNewsPayload,
  NewsItem,
  NewsStatus,
  UpdateNewsPayload
} from '../../types/news'

import { withTransaction } from '../utils/mysql'

import {
  findCategoryBySlug,
  findNewsByTenantAndId,
  findNewsByTenantAndSlug,
  findNewsList,
  insertCategoryIfNotExists,
  insertNews,
  softDeleteNewsById,
  syncNewsTags,
  updateNewsById,
  upsertTag,
  type NewsListParams,
  type NewsRow
} from '../repositories/news.repository'

const allowedStatus: NewsStatus[] = ['draft', 'published', 'archived']

function createUuid() {
  return randomUUID()
}

function normalizeSlug(value: string) {
  return value
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function stripHtml(value: string) {
  return value
    .replace(/<[^>]*>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

function createExcerpt(descriptionCard?: string, descriptionContent?: string) {
  const text = descriptionCard?.trim() || stripHtml(descriptionContent || '')

  if (!text) return 'Belum ada deskripsi.'

  return text.length > 180 ? `${text.slice(0, 180)}...` : text
}

function estimateReadTime(descriptionContent: string) {
  const words = stripHtml(descriptionContent)
    .split(/\s+/)
    .filter(Boolean)

  return Math.max(1, Math.ceil(words.length / 200))
}

function normalizeStatus(value?: string): NewsStatus {
  if (value && allowedStatus.includes(value as NewsStatus)) {
    return value as NewsStatus
  }

  return 'draft'
}

function splitCsv(value?: string | null) {
  if (!value) return []

  return value
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean)
}

function toTimestamp(value: Date | string | null | undefined) {
  if (!value) return Date.now()
  return new Date(value).getTime()
}

function toMysqlDateTime(value?: Date | string | number | null) {
  if (!value) return null

  const date = value instanceof Date
    ? value
    : new Date(value)

  if (Number.isNaN(date.getTime())) return null

  const pad = (number: number) => String(number).padStart(2, '0')

  return [
    date.getFullYear(),
    pad(date.getMonth() + 1),
    pad(date.getDate())
  ].join('-') + ' ' + [
    pad(date.getHours()),
    pad(date.getMinutes()),
    pad(date.getSeconds())
  ].join(':')
}

function normalizeTagInput(payload: CreateNewsPayload | UpdateNewsPayload) {
  const tagNames = payload.tagNames || []
  const tagSlugs = payload.tagSlugs || []

  const fromNames = tagNames.map((name) => ({
    name: String(name).trim(),
    slug: normalizeSlug(String(name))
  }))

  const fromSlugs = tagSlugs.map((slug) => ({
    name: String(slug).replace(/-/g, ' ').trim(),
    slug: normalizeSlug(String(slug))
  }))

  const map = new Map<string, { name: string; slug: string }>()

  for (const item of [...fromNames, ...fromSlugs]) {
    if (!item.name || !item.slug) continue
    map.set(item.slug, item)
  }

  return Array.from(map.values())
}

export function mapNewsRow(row: NewsRow): NewsItem {
  const descriptionCard = row.description_card || ''
  const descriptionContent = row.description_content || ''
  const tagNames = splitCsv(row.tag_names)
  const tagSlugs = splitCsv(row.tag_slugs)

  return {
    id: row.id,
    tenantId: row.tenant_id,

    title: row.title,
    slug: row.slug,

    descriptionCard,
    descriptionContent,

    excerpt: createExcerpt(descriptionCard, descriptionContent),

    cover: row.cover_url || '/assets/images/profile.png',
    coverUrl: row.cover_url,

    category: row.category_name,
    categorySlug: row.category_slug,
    categoryId: row.category_id,

    tags: tagNames,
    tagSlugs,

    status: row.status,
    readTime: Number(row.read_time || estimateReadTime(descriptionContent)),

    publishedAt: toTimestamp(row.published_at || row.created_at),
    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

export async function getTenantNewsList(params: NewsListParams) {
  const result = await findNewsList({
    ...params,
    status: params.status || 'published'
  })

  return {
    data: result.rows.map(mapNewsRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantNewsDetail(
  tenantId: string,
  slug: string
) {
  const row = await findNewsByTenantAndSlug(tenantId, slug)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Berita tidak ditemukan.'
    })
  }

  return {
    data: mapNewsRow(row)
  }
}

export async function createTenantNews(
  tenantId: string,
  payload: CreateNewsPayload
) {
  if (!payload.title || payload.title.trim().length < 3) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Judul berita minimal 3 karakter.'
    })
  }

  const title = payload.title.trim()
  const slug = normalizeSlug(payload.slug || title)

  if (!slug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Slug berita tidak valid.'
    })
  }

  const duplicated = await findNewsByTenantAndSlug(tenantId, slug)

  if (duplicated) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Slug berita sudah digunakan pada tenant ini.'
    })
  }

  const descriptionContent = payload.descriptionContent || ''
  const descriptionCard =
    payload.descriptionCard?.trim() || createExcerpt('', descriptionContent)

  const status = normalizeStatus(payload.status)

  const newsId = await withTransaction(async (connection) => {
    let categoryId = payload.categoryId || null

    if (!categoryId && payload.categorySlug) {
      const category = await findCategoryBySlug(
        tenantId,
        normalizeSlug(payload.categorySlug)
      )

      categoryId = category ? category.id : null
    }

    if (!categoryId && payload.categoryName) {
      const categorySlug = normalizeSlug(payload.categoryName)

      categoryId = await insertCategoryIfNotExists(
        createUuid(),
        tenantId,
        payload.categoryName.trim(),
        categorySlug,
        connection
      )
    }

    const insertedNewsId = await insertNews(
      {
        id: createUuid(),
        tenantId,
        categoryId,
        title,
        slug,
        descriptionCard,
        descriptionContent,
        coverUrl: payload.coverUrl || null,
        status,
        readTime: estimateReadTime(descriptionContent),
        publishedAt:
          toMysqlDateTime(payload.publishedAt) ||
          (status === 'published' ? new Date().toISOString() : null)
      },
      connection
    )

    const tags = normalizeTagInput(payload)
    const tagIds: string[] = []

    for (const tag of tags) {
      const tagId = await upsertTag(
        createUuid(),
        tenantId,
        tag.name,
        tag.slug,
        connection
      )

      if (tagId) {
        tagIds.push(tagId)
      }
    }

    await syncNewsTags(insertedNewsId, tagIds, connection)

    return insertedNewsId
  })

  const row = await findNewsByTenantAndId(tenantId, newsId)

  return {
    data: row ? mapNewsRow(row) : null
  }
}

export async function updateTenantNews(
  tenantId: string,
  id: string,
  payload: UpdateNewsPayload
) {
  const existing = await findNewsByTenantAndId(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Berita tidak ditemukan.'
    })
  }

  let slug = payload.slug ? normalizeSlug(payload.slug) : undefined

  if (slug && slug !== existing.slug) {
    const duplicated = await findNewsByTenantAndSlug(tenantId, slug)

    if (duplicated) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Slug berita sudah digunakan pada tenant ini.'
      })
    }
  }

  await withTransaction(async (connection) => {
    let categoryId: string | null | undefined = undefined

    if (typeof payload.categoryId !== 'undefined') {
      categoryId = payload.categoryId
    }

    if (payload.categorySlug) {
      const category = await findCategoryBySlug(
        tenantId,
        normalizeSlug(payload.categorySlug)
      )

      categoryId = category ? category.id : null
    }

    if (payload.categoryName) {
      categoryId = await insertCategoryIfNotExists(
        createUuid(),
        tenantId,
        payload.categoryName.trim(),
        normalizeSlug(payload.categoryName),
        connection
      )
    }

    const descriptionContent =
      typeof payload.descriptionContent === 'string'
        ? payload.descriptionContent
        : undefined

    await updateNewsById(
      tenantId,
      id,
      {
        categoryId,
        title: payload.title?.trim(),
        slug,
        descriptionCard: payload.descriptionCard?.trim(),
        descriptionContent,
        coverUrl: payload.coverUrl,
        status: payload.status,
        readTime: descriptionContent
          ? estimateReadTime(descriptionContent)
          : undefined,
        publishedAt: typeof payload.publishedAt !== 'undefined'
          ? toMysqlDateTime(payload.publishedAt)
          : undefined
      },
      connection
    )

    if (payload.tagNames || payload.tagSlugs) {
      const tags = normalizeTagInput(payload)
      const tagIds: string[] = []

      for (const tag of tags) {
        const tagId = await upsertTag(
          createUuid(),
          tenantId,
          tag.name,
          tag.slug,
          connection
        )

        if (tagId) {
          tagIds.push(tagId)
        }
      }

      await syncNewsTags(id, tagIds, connection)
    }
  })

  const updated = await findNewsByTenantAndId(tenantId, id)

  return {
    data: updated ? mapNewsRow(updated) : null
  }
}

export async function deleteTenantNews(
  tenantId: string,
  id: string
) {
  const affectedRows = await softDeleteNewsById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Berita tidak ditemukan.'
    })
  }

  return {
    message: 'Berita berhasil dihapus.'
  }
}