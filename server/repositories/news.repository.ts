import type { PoolConnection, RowDataPacket } from 'mysql2/promise'
import type { NewsStatus } from '../../types/news'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'

export type NewsRow = RowDataPacket & {
  id: string
  tenant_id: string
  category_id: string | null
  title: string
  slug: string
  description_card: string | null
  description_content: string | null
  cover_url: string | null
  status: NewsStatus
  read_time: number
  published_at: Date | string | null
  created_at: Date | string
  updated_at: Date | string
  category_name: string | null
  category_slug: string | null
  tag_names: string | null
  tag_slugs: string | null
}

export type NewsListParams = {
  tenantId: string
  q?: string
  categorySlug?: string
  tagSlug?: string
  status?: NewsStatus | 'all'
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'title'
}

export type NewsCreateInput = {
  id: string
  tenantId: string
  categoryId: string | null
  title: string
  slug: string
  descriptionCard: string
  descriptionContent: string
  coverUrl: string | null
  status: NewsStatus
  readTime: number
  publishedAt: string | null
}

export type NewsUpdateInput = Partial<Omit<NewsCreateInput, 'id' | 'tenantId'>>

const newsSelect = `
  n.id,
  n.tenant_id,
  n.category_id,
  n.title,
  n.slug,
  n.description_card,
  n.description_content,
  n.cover_url,
  n.status,
  n.read_time,
  n.published_at,
  n.created_at,
  n.updated_at,
  c.name AS category_name,
  c.slug AS category_slug,
  GROUP_CONCAT(DISTINCT tg.name ORDER BY tg.name SEPARATOR ',') AS tag_names,
  GROUP_CONCAT(DISTINCT tg.slug ORDER BY tg.slug SEPARATOR ',') AS tag_slugs
`

function buildWhere(params: NewsListParams): {
  whereSql: string
  values: DbParams
} {
  const where: string[] = ['n.tenant_id = ?', 'n.deleted_at IS NULL']
  const values: DbParams = [params.tenantId]

  if (params.status && params.status !== 'all') {
    where.push('n.status = ?')
    values.push(params.status)
  }

  if (params.q) {
    where.push(`
      (
        n.title LIKE ?
        OR n.description_card LIKE ?
        OR n.description_content LIKE ?
        OR c.name LIKE ?
        OR tg.name LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword, keyword, keyword)
  }

  if (params.categorySlug) {
    where.push('c.slug = ?')
    values.push(params.categorySlug)
  }

  if (params.tagSlug) {
    where.push(`
      EXISTS (
        SELECT 1
        FROM news_tag_map ntm2
        JOIN news_tags tg2 ON tg2.id = ntm2.tag_id
        WHERE ntm2.news_id = n.id
        AND tg2.tenant_id = n.tenant_id
        AND tg2.slug = ?
        AND tg2.deleted_at IS NULL
      )
    `)

    values.push(params.tagSlug)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: NewsListParams['sort']) {
  if (sort === 'oldest') return 'COALESCE(n.published_at, n.created_at) ASC'
  if (sort === 'title') return 'n.title ASC'

  return 'COALESCE(n.published_at, n.created_at) DESC'
}

export async function findNewsList(params: NewsListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 12), 1), 100)
  const offset = (page - 1) * limit

  const safeLimit = Number.isFinite(limit) ? limit : 12
  const safeOffset = Number.isFinite(offset) ? offset : 0

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(DISTINCT n.id) AS total
      FROM news n
      LEFT JOIN news_categories c ON c.id = n.category_id
      LEFT JOIN news_tag_map ntm ON ntm.news_id = n.id
      LEFT JOIN news_tags tg ON tg.id = ntm.tag_id
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<NewsRow[]>(
    `
      SELECT ${newsSelect}
      FROM news n
      LEFT JOIN news_categories c ON c.id = n.category_id
      LEFT JOIN news_tag_map ntm ON ntm.news_id = n.id
      LEFT JOIN news_tags tg ON tg.id = ntm.tag_id
      ${whereSql}
      GROUP BY
        n.id,
        n.tenant_id,
        n.category_id,
        n.title,
        n.slug,
        n.description_card,
        n.description_content,
        n.cover_url,
        n.status,
        n.read_time,
        n.published_at,
        n.created_at,
        n.updated_at,
        c.name,
        c.slug
      ORDER BY ${orderBy}
      LIMIT ${safeLimit} OFFSET ${safeOffset}
    `,
    values
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0),
    page,
    limit: safeLimit
  }
}

export async function findNewsByTenantAndSlug(
  tenantId: string,
  slug: string
) {
  const rows = await dbQuery<NewsRow[]>(
    `
      SELECT ${newsSelect}
      FROM news n
      LEFT JOIN news_categories c ON c.id = n.category_id
      LEFT JOIN news_tag_map ntm ON ntm.news_id = n.id
      LEFT JOIN news_tags tg ON tg.id = ntm.tag_id
      WHERE n.tenant_id = ?
      AND n.slug = ?
      AND n.deleted_at IS NULL
      GROUP BY
        n.id,
        n.tenant_id,
        n.category_id,
        n.title,
        n.slug,
        n.description_card,
        n.description_content,
        n.cover_url,
        n.status,
        n.read_time,
        n.published_at,
        n.created_at,
        n.updated_at,
        c.name,
        c.slug
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function findNewsByTenantAndId(
  tenantId: string,
  id: string
) {
  const rows = await dbQuery<NewsRow[]>(
    `
      SELECT ${newsSelect}
      FROM news n
      LEFT JOIN news_categories c ON c.id = n.category_id
      LEFT JOIN news_tag_map ntm ON ntm.news_id = n.id
      LEFT JOIN news_tags tg ON tg.id = ntm.tag_id
      WHERE n.tenant_id = ?
      AND n.id = ?
      AND n.deleted_at IS NULL
      GROUP BY
        n.id,
        n.tenant_id,
        n.category_id,
        n.title,
        n.slug,
        n.description_card,
        n.description_content,
        n.cover_url,
        n.status,
        n.read_time,
        n.published_at,
        n.created_at,
        n.updated_at,
        c.name,
        c.slug
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findCategoryBySlug(
  tenantId: string,
  slug: string
) {
  const rows = await dbQuery<(RowDataPacket & { id: string })[]>(
    `
      SELECT id
      FROM news_categories
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function insertCategoryIfNotExists(
  id: string,
  tenantId: string,
  name: string,
  slug: string,
  connection: PoolConnection
) {
  await dbExecute(
    `
      INSERT INTO news_categories (
        id,
        tenant_id,
        name,
        slug,
        status
      )
      VALUES (?, ?, ?, ?, 'active')
      ON DUPLICATE KEY UPDATE
        name = VALUES(name),
        status = 'active',
        deleted_at = NULL
    `,
    [id, tenantId, name, slug],
    connection
  )

  const rows = await dbQuery<(RowDataPacket & { id: string })[]>(
    `
      SELECT id
      FROM news_categories
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug],
    connection
  )

  return rows[0]?.id || ''
}

export async function insertNews(
  input: NewsCreateInput,
  connection: PoolConnection
) {
  await dbExecute(
    `
      INSERT INTO news (
        id,
        tenant_id,
        category_id,
        title,
        slug,
        description_card,
        description_content,
        cover_url,
        status,
        read_time,
        published_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.categoryId,
      input.title,
      input.slug,
      input.descriptionCard,
      input.descriptionContent,
      input.coverUrl,
      input.status,
      input.readTime,
      input.publishedAt
    ],
    connection
  )

  return input.id
}

export async function updateNewsById(
  tenantId: string,
  id: string,
  input: NewsUpdateInput,
  connection: PoolConnection
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof NewsUpdateInput, string> = {
    categoryId: 'category_id',
    title: 'title',
    slug: 'slug',
    descriptionCard: 'description_card',
    descriptionContent: 'description_content',
    coverUrl: 'cover_url',
    status: 'status',
    readTime: 'read_time',
    publishedAt: 'published_at'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof NewsUpdateInput]

    if (typeof value === 'undefined') continue

    fields.push(`${column} = ?`)
    values.push(value)
  }

  if (!fields.length) return 0

  values.push(tenantId, id)

  const result = await dbExecute(
    `
      UPDATE news
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values,
    connection
  )

  return result.affectedRows
}

export async function upsertTag(
  id: string,
  tenantId: string,
  name: string,
  slug: string,
  connection: PoolConnection
) {
  await dbExecute(
    `
      INSERT INTO news_tags (
        id,
        tenant_id,
        name,
        slug
      )
      VALUES (?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
        name = VALUES(name),
        deleted_at = NULL
    `,
    [id, tenantId, name, slug],
    connection
  )

  const rows = await dbQuery<(RowDataPacket & { id: string })[]>(
    `
      SELECT id
      FROM news_tags
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug],
    connection
  )

  return rows[0]?.id || ''
}

export async function syncNewsTags(
  newsId: string,
  tagIds: string[],
  connection: PoolConnection
) {
  await dbExecute(
    `
      DELETE FROM news_tag_map
      WHERE news_id = ?
    `,
    [newsId],
    connection
  )

  for (const tagId of tagIds) {
    await dbExecute(
      `
        INSERT IGNORE INTO news_tag_map (
          news_id,
          tag_id
        )
        VALUES (?, ?)
      `,
      [newsId, tagId],
      connection
    )
  }
}

export async function softDeleteNewsById(
  tenantId: string,
  id: string
) {
  const result = await dbExecute(
    `
      UPDATE news
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}