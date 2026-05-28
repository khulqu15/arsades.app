import { randomUUID } from 'node:crypto'
import type {
  CreateInstitutionPayload,
  InstitutionItem,
  InstitutionStatus,
  UpdateInstitutionPayload
} from '../../types/institution'

import {
  findInstitutionById,
  findInstitutionBySlug,
  findInstitutionList,
  insertInstitution,
  softDeleteInstitutionById,
  updateInstitutionById,
  type InstitutionListParams,
  type InstitutionRow
} from '../repositories/institution.repository'

const allowedStatuses: InstitutionStatus[] = ['active', 'inactive']

function createUuid() {
  return randomUUID()
}

function parseJson<T = any>(value: unknown, fallback: T): T {
  if (!value) return fallback

  if (typeof value === 'object') {
    return value as T
  }

  if (typeof value === 'string') {
    try {
      return JSON.parse(value) as T
    } catch {
      return fallback
    }
  }

  return fallback
}

function stringifyJson(value: unknown) {
  if (!value) return null
  return JSON.stringify(value)
}

function toTimestamp(value: Date | string | null | undefined) {
  if (!value) return Date.now()

  const time = new Date(value).getTime()

  return Number.isNaN(time) ? Date.now() : time
}

function normalizeSlug(value: string) {
  return String(value || '')
    .toLowerCase()
    .trim()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function normalizeStatus(value?: string): InstitutionStatus {
  if (value && allowedStatuses.includes(value as InstitutionStatus)) {
    return value as InstitutionStatus
  }

  return 'active'
}

export function mapInstitutionRow(row: InstitutionRow): InstitutionItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,

    title: row.title,
    subtitle: row.subtitle,
    slug: row.slug,

    icon: row.icon,
    logoUrl: row.logo_url,

    contentHtml: row.content_html,
    contentJson: parseJson(row.content_json, null),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

export async function getTenantInstitutionList(params: InstitutionListParams) {
  const result = await findInstitutionList(params)

  return {
    data: result.rows.map(mapInstitutionRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantInstitutionDetail(tenantId: string, id: string) {
  const row = await findInstitutionById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Institution tidak ditemukan.'
    })
  }

  return {
    data: mapInstitutionRow(row)
  }
}

export async function createTenantInstitution(
  tenantId: string,
  payload: CreateInstitutionPayload
) {
  if (!payload.title || payload.title.trim().length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Title institution minimal 2 karakter.'
    })
  }

  const title = payload.title.trim()
  const slug = normalizeSlug(payload.slug || title)

  if (!slug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Slug institution tidak valid.'
    })
  }

  const duplicated = await findInstitutionBySlug(tenantId, slug)

  if (duplicated) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Slug institution sudah digunakan pada tenant ini.'
    })
  }

  const id = await insertInstitution({
    id: createUuid(),
    tenantId,

    title,
    subtitle: payload.subtitle?.trim() || null,
    slug,

    icon: payload.icon || null,
    logoUrl: payload.logoUrl || null,

    contentHtml: payload.contentHtml || null,
    contentJson: stringifyJson(payload.contentJson),

    status: normalizeStatus(payload.status),
    isFeatured: Boolean(payload.isFeatured),
    sortOrder: Number(payload.sortOrder || 0)
  })

  const row = await findInstitutionById(tenantId, id)

  return {
    data: row ? mapInstitutionRow(row) : null
  }
}

export async function updateTenantInstitution(
  tenantId: string,
  id: string,
  payload: UpdateInstitutionPayload
) {
  const existing = await findInstitutionById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Institution tidak ditemukan.'
    })
  }

  const nextSlug = payload.slug
    ? normalizeSlug(payload.slug)
    : undefined

  if (nextSlug && nextSlug !== existing.slug) {
    const duplicated = await findInstitutionBySlug(tenantId, nextSlug)

    if (duplicated) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Slug institution sudah digunakan pada tenant ini.'
      })
    }
  }

  await updateInstitutionById(
    tenantId,
    id,
    {
      title: payload.title?.trim(),
      subtitle: payload.subtitle?.trim() || null,
      slug: nextSlug,

      icon: payload.icon,
      logoUrl: payload.logoUrl,

      contentHtml: payload.contentHtml,
      contentJson:
        typeof payload.contentJson !== 'undefined'
          ? stringifyJson(payload.contentJson)
          : undefined,

      status: payload.status ? normalizeStatus(payload.status) : undefined,
      isFeatured: payload.isFeatured,
      sortOrder: payload.sortOrder
    }
  )

  const row = await findInstitutionById(tenantId, id)

  return {
    data: row ? mapInstitutionRow(row) : null
  }
}

export async function deleteTenantInstitution(tenantId: string, id: string) {
  const affectedRows = await softDeleteInstitutionById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Institution tidak ditemukan.'
    })
  }

  return {
    message: 'Institution berhasil dihapus.'
  }
}

export async function getTenantInstitutionBySlug(tenantId: string, slug: string) {
  const row = await findInstitutionBySlug(tenantId, slug)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Institution tidak ditemukan.'
    })
  }

  return {
    data: mapInstitutionRow(row)
  }
}