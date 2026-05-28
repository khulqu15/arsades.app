import { randomUUID } from 'node:crypto'
import type {
  CreatePotentialPayload,
  PotentialItem,
  PotentialStatus,
  PotentialType,
  UpdatePotentialPayload
} from '../../types/potential'

import {
  findPotentialById,
  findPotentialBySlug,
  findPotentialList,
  insertPotential,
  softDeletePotentialById,
  updatePotentialById,
  type PotentialListParams,
  type PotentialRow
} from '../repositories/potential.repository'

const allowedTypes: PotentialType[] = [
  'agriculture',
  'livestock',
  'fishery',
  'umkm',
  'tourism',
  'culture',
  'natural_resource',
  'human_resource',
  'industry',
  'creative_economy',
  'food',
  'craft',
  'custom'
]

const allowedStatuses: PotentialStatus[] = ['active', 'inactive']

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

function normalizeType(value?: string): PotentialType {
  if (value && allowedTypes.includes(value as PotentialType)) {
    return value as PotentialType
  }

  return 'custom'
}

function normalizeStatus(value?: string): PotentialStatus {
  if (value && allowedStatuses.includes(value as PotentialStatus)) {
    return value as PotentialStatus
  }

  return 'active'
}

function normalizeNumber(value: unknown) {
  if (typeof value === 'number') return Number.isNaN(value) ? null : value
  if (typeof value === 'string' && value.trim()) {
    const number = Number(value)
    return Number.isNaN(number) ? null : number
  }

  return null
}

export function mapPotentialRow(row: PotentialRow): PotentialItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,

    potentialType: row.potential_type,

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

    ownerName: row.owner_name,
    managerName: row.manager_name,

    productionCapacity: row.production_capacity,
    productionUnit: row.production_unit,
    marketReach: row.market_reach,
    estimatedValue: row.estimated_value === null ? null : Number(row.estimated_value),

    email: row.email,
    phone: row.phone,
    whatsapp: row.whatsapp,
    websiteUrl: row.website_url,

    contact: parseJson(row.contact_config, {}),
    statistic: parseJson(row.statistic_config, {}),
    metadata: parseJson(row.metadata, {}),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

export async function getTenantPotentialList(params: PotentialListParams) {
  const result = await findPotentialList(params)

  return {
    data: result.rows.map(mapPotentialRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantPotentialDetail(tenantId: string, id: string) {
  const row = await findPotentialById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Potensi tidak ditemukan.'
    })
  }

  return {
    data: mapPotentialRow(row)
  }
}

export async function getTenantPotentialBySlug(tenantId: string, slug: string) {
  const row = await findPotentialBySlug(tenantId, slug)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Potensi tidak ditemukan.'
    })
  }

  return {
    data: mapPotentialRow(row)
  }
}

export async function createTenantPotential(
  tenantId: string,
  payload: CreatePotentialPayload
) {
  if (!payload.title || payload.title.trim().length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Title potensi minimal 2 karakter.'
    })
  }

  const title = payload.title.trim()
  const slug = normalizeSlug(payload.slug || title)

  if (!slug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Slug potensi tidak valid.'
    })
  }

  const duplicated = await findPotentialBySlug(tenantId, slug)

  if (duplicated) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Slug potensi sudah digunakan pada tenant ini.'
    })
  }

  const id = await insertPotential({
    id: createUuid(),
    tenantId,

    potentialType: normalizeType(payload.potentialType),

    title,
    subtitle: payload.subtitle?.trim() || null,
    slug,

    icon: payload.icon || null,
    logoUrl: payload.logoUrl || null,
    imageUrl: payload.imageUrl || null,

    contentHtml: payload.contentHtml || null,
    contentJson: stringifyJson(payload.contentJson),

    address: payload.address || null,
    latitude: normalizeNumber(payload.latitude),
    longitude: normalizeNumber(payload.longitude),

    ownerName: payload.ownerName || null,
    managerName: payload.managerName || null,

    productionCapacity: payload.productionCapacity || null,
    productionUnit: payload.productionUnit || null,
    marketReach: payload.marketReach || null,
    estimatedValue: normalizeNumber(payload.estimatedValue),

    email: payload.email || null,
    phone: payload.phone || null,
    whatsapp: payload.whatsapp || null,
    websiteUrl: payload.websiteUrl || null,

    contactConfig: stringifyJson(payload.contact),
    statisticConfig: stringifyJson(payload.statistic),
    metadata: stringifyJson(payload.metadata),

    status: normalizeStatus(payload.status),
    isFeatured: Boolean(payload.isFeatured),
    sortOrder: Number(payload.sortOrder || 0)
  })

  const row = await findPotentialById(tenantId, id)

  return {
    data: row ? mapPotentialRow(row) : null
  }
}

export async function updateTenantPotential(
  tenantId: string,
  id: string,
  payload: UpdatePotentialPayload
) {
  const existing = await findPotentialById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Potensi tidak ditemukan.'
    })
  }

  const nextSlug = payload.slug
    ? normalizeSlug(payload.slug)
    : undefined

  if (nextSlug && nextSlug !== existing.slug) {
    const duplicated = await findPotentialBySlug(tenantId, nextSlug)

    if (duplicated) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Slug potensi sudah digunakan pada tenant ini.'
      })
    }
  }

  await updatePotentialById(
    tenantId,
    id,
    {
      potentialType: payload.potentialType
        ? normalizeType(payload.potentialType)
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
      latitude:
        typeof payload.latitude !== 'undefined'
          ? normalizeNumber(payload.latitude)
          : undefined,
      longitude:
        typeof payload.longitude !== 'undefined'
          ? normalizeNumber(payload.longitude)
          : undefined,

      ownerName: payload.ownerName,
      managerName: payload.managerName,

      productionCapacity: payload.productionCapacity,
      productionUnit: payload.productionUnit,
      marketReach: payload.marketReach,
      estimatedValue:
        typeof payload.estimatedValue !== 'undefined'
          ? normalizeNumber(payload.estimatedValue)
          : undefined,

      email: payload.email,
      phone: payload.phone,
      whatsapp: payload.whatsapp,
      websiteUrl: payload.websiteUrl,

      contactConfig:
        typeof payload.contact !== 'undefined'
          ? stringifyJson(payload.contact)
          : undefined,

      statisticConfig:
        typeof payload.statistic !== 'undefined'
          ? stringifyJson(payload.statistic)
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

  const row = await findPotentialById(tenantId, id)

  return {
    data: row ? mapPotentialRow(row) : null
  }
}

export async function deleteTenantPotential(tenantId: string, id: string) {
  const affectedRows = await softDeletePotentialById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Potensi tidak ditemukan.'
    })
  }

  return {
    message: 'Potensi berhasil dihapus.'
  }
}