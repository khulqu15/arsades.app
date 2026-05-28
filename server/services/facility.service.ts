import { randomUUID } from 'node:crypto'
import type {
  CreateFacilityPayload,
  FacilityItem,
  FacilityStatus,
  FacilityType,
  UpdateFacilityPayload
} from '../../types/facility'

import {
  findFacilityById,
  findFacilityBySlug,
  findFacilityList,
  insertFacility,
  softDeleteFacilityById,
  updateFacilityById,
  type FacilityListParams,
  type FacilityRow
} from '../repositories/facility.repository'

const allowedTypes: FacilityType[] = [
  'health',
  'market',
  'education',
  'sport',
  'emergency',
  'transport',
  'water',
  'public_service',
  'office',
  'worship',
  'tourism',
  'security',
  'custom'
]

const allowedStatuses: FacilityStatus[] = ['active', 'inactive']

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

function normalizeType(value?: string): FacilityType {
  if (value && allowedTypes.includes(value as FacilityType)) {
    return value as FacilityType
  }

  return 'custom'
}

function normalizeStatus(value?: string): FacilityStatus {
  if (value && allowedStatuses.includes(value as FacilityStatus)) {
    return value as FacilityStatus
  }

  return 'active'
}

export function mapFacilityRow(row: FacilityRow): FacilityItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,

    facilityType: row.facility_type,

    title: row.title,
    subtitle: row.subtitle,
    slug: row.slug,

    icon: row.icon,
    logoUrl: row.logo_url,
    imageUrl: row.image_url,

    contentHtml: row.content_html,
    contentJson: parseJson(row.content_json, null),

    address: row.address,
    latitude: row.latitude === null ? null : Number(row.latitude),
    longitude: row.longitude === null ? null : Number(row.longitude),

    email: row.email,
    phone: row.phone,
    whatsapp: row.whatsapp,
    websiteUrl: row.website_url,

    contact: parseJson(row.contact_config, {}),
    operationalHours: parseJson(row.operational_hours, {}),
    metadata: parseJson(row.metadata, {}),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

export async function getTenantFacilityList(params: FacilityListParams) {
  const result = await findFacilityList(params)

  return {
    data: result.rows.map(mapFacilityRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantFacilityDetail(tenantId: string, id: string) {
  const row = await findFacilityById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Facility tidak ditemukan.'
    })
  }

  return {
    data: mapFacilityRow(row)
  }
}

export async function getTenantFacilityBySlug(tenantId: string, slug: string) {
  const row = await findFacilityBySlug(tenantId, slug)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Facility tidak ditemukan.'
    })
  }

  return {
    data: mapFacilityRow(row)
  }
}

export async function createTenantFacility(
  tenantId: string,
  payload: CreateFacilityPayload
) {
  if (!payload.title || payload.title.trim().length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Title facility minimal 2 karakter.'
    })
  }

  const title = payload.title.trim()
  const slug = normalizeSlug(payload.slug || title)

  if (!slug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Slug facility tidak valid.'
    })
  }

  const duplicated = await findFacilityBySlug(tenantId, slug)

  if (duplicated) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Slug facility sudah digunakan pada tenant ini.'
    })
  }

  const id = await insertFacility({
    id: createUuid(),
    tenantId,

    facilityType: normalizeType(payload.facilityType),

    title,
    subtitle: payload.subtitle?.trim() || null,
    slug,

    icon: payload.icon || null,
    logoUrl: payload.logoUrl || null,
    imageUrl: payload.imageUrl || null,

    contentHtml: payload.contentHtml || null,
    contentJson: stringifyJson(payload.contentJson),

    address: payload.address || null,
    latitude: typeof payload.latitude === 'number' ? payload.latitude : null,
    longitude: typeof payload.longitude === 'number' ? payload.longitude : null,

    email: payload.email || null,
    phone: payload.phone || null,
    whatsapp: payload.whatsapp || null,
    websiteUrl: payload.websiteUrl || null,

    contactConfig: stringifyJson(payload.contact),
    operationalHours: stringifyJson(payload.operationalHours),
    metadata: stringifyJson(payload.metadata),

    status: normalizeStatus(payload.status),
    isFeatured: Boolean(payload.isFeatured),
    sortOrder: Number(payload.sortOrder || 0)
  })

  const row = await findFacilityById(tenantId, id)

  return {
    data: row ? mapFacilityRow(row) : null
  }
}

export async function updateTenantFacility(
  tenantId: string,
  id: string,
  payload: UpdateFacilityPayload
) {
  const existing = await findFacilityById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Facility tidak ditemukan.'
    })
  }

  const nextSlug = payload.slug
    ? normalizeSlug(payload.slug)
    : undefined

  if (nextSlug && nextSlug !== existing.slug) {
    const duplicated = await findFacilityBySlug(tenantId, nextSlug)

    if (duplicated) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Slug facility sudah digunakan pada tenant ini.'
      })
    }
  }

  await updateFacilityById(
    tenantId,
    id,
    {
      facilityType: payload.facilityType
        ? normalizeType(payload.facilityType)
        : undefined,

      title: payload.title?.trim(),
      subtitle: payload.subtitle?.trim() || null,
      slug: nextSlug,

      icon: payload.icon,
      logoUrl: payload.logoUrl,
      imageUrl: payload.imageUrl,

      contentHtml: payload.contentHtml,

      contentJson:
        typeof payload.contentJson !== 'undefined'
          ? stringifyJson(payload.contentJson)
          : undefined,

      address: payload.address,
      latitude: payload.latitude,
      longitude: payload.longitude,

      email: payload.email,
      phone: payload.phone,
      whatsapp: payload.whatsapp,
      websiteUrl: payload.websiteUrl,

      contactConfig:
        typeof payload.contact !== 'undefined'
          ? stringifyJson(payload.contact)
          : undefined,

      operationalHours:
        typeof payload.operationalHours !== 'undefined'
          ? stringifyJson(payload.operationalHours)
          : undefined,

      metadata:
        typeof payload.metadata !== 'undefined'
          ? stringifyJson(payload.metadata)
          : undefined,

      status: payload.status ? normalizeStatus(payload.status) : undefined,
      isFeatured: payload.isFeatured,
      sortOrder: payload.sortOrder
    }
  )

  const row = await findFacilityById(tenantId, id)

  return {
    data: row ? mapFacilityRow(row) : null
  }
}

export async function deleteTenantFacility(tenantId: string, id: string) {
  const affectedRows = await softDeleteFacilityById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Facility tidak ditemukan.'
    })
  }

  return {
    message: 'Facility berhasil dihapus.'
  }
}