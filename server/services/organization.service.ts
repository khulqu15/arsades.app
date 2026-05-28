import { randomUUID } from 'node:crypto'
import type {
  CreateOrganizationPayload,
  OrganizationItem,
  OrganizationStatus,
  OrganizationType,
  UpdateOrganizationPayload
} from '../../types/organization'

import {
  findOrganizationById,
  findOrganizationBySlug,
  findOrganizationList,
  insertOrganization,
  softDeleteOrganizationById,
  updateOrganizationById,
  type OrganizationListParams,
  type OrganizationRow
} from '../repositories/organization.repository'

const allowedTypes: OrganizationType[] = [
  'government',
  'village_government',
  'bumdes',
  'youth',
  'women',
  'community',
  'religious',
  'education',
  'health',
  'umkm',
  'tourism',
  'culture',
  'security',
  'custom'
]

const allowedStatuses: OrganizationStatus[] = ['active', 'inactive']

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

function normalizeType(value?: string): OrganizationType {
  if (value && allowedTypes.includes(value as OrganizationType)) {
    return value as OrganizationType
  }

  return 'custom'
}

function normalizeStatus(value?: string): OrganizationStatus {
  if (value && allowedStatuses.includes(value as OrganizationStatus)) {
    return value as OrganizationStatus
  }

  return 'active'
}

export function mapOrganizationRow(row: OrganizationRow): OrganizationItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,
    parentId: row.parent_id,

    organizationType: row.organization_type,

    name: row.name,
    displayName: row.display_name || row.name,
    slug: row.slug,

    shortDescription: row.short_description,
    description: row.description,

    logoUrl: row.logo_url,
    coverUrl: row.cover_url,

    email: row.email,
    phone: row.phone,
    whatsapp: row.whatsapp,
    websiteUrl: row.website_url,

    address: row.address,
    latitude: row.latitude === null ? null : Number(row.latitude),
    longitude: row.longitude === null ? null : Number(row.longitude),

    contact: parseJson(row.contact_config, {}),
    addressConfig: parseJson(row.address_config, {}),
    social: parseJson(row.social_config, {}),
    operationalHours: parseJson(row.operational_hours, {}),
    metadata: parseJson(row.metadata, {}),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

export async function getTenantOrganizationList(params: OrganizationListParams) {
  const result = await findOrganizationList(params)

  return {
    data: result.rows.map(mapOrganizationRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantOrganizationDetail(tenantId: string, id: string) {
  const row = await findOrganizationById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Organisasi tidak ditemukan.'
    })
  }

  return {
    data: mapOrganizationRow(row)
  }
}

export async function createTenantOrganization(
  tenantId: string,
  payload: CreateOrganizationPayload
) {
  if (!payload.name || payload.name.trim().length < 3) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Nama organisasi minimal 3 karakter.'
    })
  }

  const name = payload.name.trim()
  const slug = normalizeSlug(payload.slug || name)

  if (!slug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Slug organisasi tidak valid.'
    })
  }

  const duplicated = await findOrganizationBySlug(tenantId, slug)

  if (duplicated) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Slug organisasi sudah digunakan pada tenant ini.'
    })
  }

  const id = await insertOrganization({
    id: createUuid(),
    tenantId,
    parentId: payload.parentId || null,
    organizationType: normalizeType(payload.organizationType),

    name,
    displayName: payload.displayName?.trim() || name,
    slug,

    shortDescription: payload.shortDescription?.trim() || null,
    description: payload.description?.trim() || null,

    logoUrl: payload.logoUrl || null,
    coverUrl: payload.coverUrl || null,

    email: payload.email || null,
    phone: payload.phone || null,
    whatsapp: payload.whatsapp || null,
    websiteUrl: payload.websiteUrl || null,

    address: payload.address || null,
    latitude: typeof payload.latitude === 'number' ? payload.latitude : null,
    longitude: typeof payload.longitude === 'number' ? payload.longitude : null,

    contactConfig: stringifyJson(payload.contact),
    addressConfig: stringifyJson(payload.addressConfig),
    socialConfig: stringifyJson(payload.social),
    operationalHours: stringifyJson(payload.operationalHours),
    metadata: stringifyJson(payload.metadata),

    status: normalizeStatus(payload.status),
    isFeatured: Boolean(payload.isFeatured),
    sortOrder: Number(payload.sortOrder || 0)
  })

  const row = await findOrganizationById(tenantId, id)

  return {
    data: row ? mapOrganizationRow(row) : null
  }
}

export async function updateTenantOrganization(
  tenantId: string,
  id: string,
  payload: UpdateOrganizationPayload
) {
  const existing = await findOrganizationById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Organisasi tidak ditemukan.'
    })
  }

  const nextSlug = payload.slug
    ? normalizeSlug(payload.slug)
    : undefined

  if (nextSlug && nextSlug !== existing.slug) {
    const duplicated = await findOrganizationBySlug(tenantId, nextSlug)

    if (duplicated) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Slug organisasi sudah digunakan pada tenant ini.'
      })
    }
  }

  await updateOrganizationById(
    tenantId,
    id,
    {
      parentId: payload.parentId,
      organizationType: payload.organizationType
        ? normalizeType(payload.organizationType)
        : undefined,

      name: payload.name?.trim(),
      displayName: payload.displayName?.trim(),
      slug: nextSlug,

      shortDescription: payload.shortDescription?.trim(),
      description: payload.description?.trim(),

      logoUrl: payload.logoUrl,
      coverUrl: payload.coverUrl,

      email: payload.email,
      phone: payload.phone,
      whatsapp: payload.whatsapp,
      websiteUrl: payload.websiteUrl,

      address: payload.address,
      latitude: payload.latitude,
      longitude: payload.longitude,

      contactConfig:
        typeof payload.contact !== 'undefined'
          ? stringifyJson(payload.contact)
          : undefined,

      addressConfig:
        typeof payload.addressConfig !== 'undefined'
          ? stringifyJson(payload.addressConfig)
          : undefined,

      socialConfig:
        typeof payload.social !== 'undefined'
          ? stringifyJson(payload.social)
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

  const row = await findOrganizationById(tenantId, id)

  return {
    data: row ? mapOrganizationRow(row) : null
  }
}

export async function deleteTenantOrganization(tenantId: string, id: string) {
  const affectedRows = await softDeleteOrganizationById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Organisasi tidak ditemukan.'
    })
  }

  return {
    message: 'Organisasi berhasil dihapus.'
  }
}