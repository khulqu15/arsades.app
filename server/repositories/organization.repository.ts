import type { RowDataPacket } from 'mysql2/promise'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'
import type { OrganizationStatus, OrganizationType } from '../../types/organization'

export type OrganizationRow = RowDataPacket & {
  id: string
  tenant_id: string
  parent_id: string | null

  organization_type: OrganizationType

  name: string
  display_name: string | null
  slug: string

  short_description: string | null
  description: string | null

  logo_url: string | null
  cover_url: string | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  website_url: string | null

  address: string | null
  latitude: string | number | null
  longitude: string | number | null

  contact_config: unknown
  address_config: unknown
  social_config: unknown
  operational_hours: unknown
  metadata: unknown

  status: OrganizationStatus
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export type OrganizationListParams = {
  tenantId: string
  q?: string
  organizationType?: OrganizationType | 'all'
  status?: OrganizationStatus | 'all'
  featured?: boolean
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'name' | 'sort_order'
}

export type OrganizationCreateInput = {
  id: string
  tenantId: string
  parentId: string | null
  organizationType: OrganizationType

  name: string
  displayName: string | null
  slug: string

  shortDescription: string | null
  description: string | null

  logoUrl: string | null
  coverUrl: string | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  address: string | null
  latitude: number | null
  longitude: number | null

  contactConfig: string | null
  addressConfig: string | null
  socialConfig: string | null
  operationalHours: string | null
  metadata: string | null

  status: OrganizationStatus
  isFeatured: boolean
  sortOrder: number
}

export type OrganizationUpdateInput = Partial<Omit<OrganizationCreateInput, 'id' | 'tenantId'>>

const organizationColumns = `
  id,
  tenant_id,
  parent_id,
  organization_type,
  name,
  display_name,
  slug,
  short_description,
  description,
  logo_url,
  cover_url,
  email,
  phone,
  whatsapp,
  website_url,
  address,
  latitude,
  longitude,
  contact_config,
  address_config,
  social_config,
  operational_hours,
  metadata,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

function buildWhere(params: OrganizationListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.organizationType && params.organizationType !== 'all') {
    where.push('organization_type = ?')
    values.push(params.organizationType)
  }

  if (typeof params.featured === 'boolean') {
    where.push('is_featured = ?')
    values.push(params.featured ? 1 : 0)
  }

  if (params.q) {
    where.push(`
      (
        name LIKE ?
        OR display_name LIKE ?
        OR slug LIKE ?
        OR short_description LIKE ?
        OR description LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword, keyword, keyword)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: OrganizationListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'name') return 'name ASC'
  if (sort === 'newest') return 'created_at DESC'

  return 'sort_order ASC, created_at DESC'
}

export async function findOrganizationList(params: OrganizationListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM tenant_organizations
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<OrganizationRow[]>(
    `
      SELECT ${organizationColumns}
      FROM tenant_organizations
      ${whereSql}
      ORDER BY ${orderBy}
      LIMIT ${limit} OFFSET ${offset}
    `,
    values
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0),
    page,
    limit
  }
}

export async function findOrganizationById(tenantId: string, id: string) {
  const rows = await dbQuery<OrganizationRow[]>(
    `
      SELECT ${organizationColumns}
      FROM tenant_organizations
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findOrganizationBySlug(tenantId: string, slug: string) {
  const rows = await dbQuery<OrganizationRow[]>(
    `
      SELECT ${organizationColumns}
      FROM tenant_organizations
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function insertOrganization(input: OrganizationCreateInput) {
  await dbExecute(
    `
      INSERT INTO tenant_organizations (
        id,
        tenant_id,
        parent_id,
        organization_type,
        name,
        display_name,
        slug,
        short_description,
        description,
        logo_url,
        cover_url,
        email,
        phone,
        whatsapp,
        website_url,
        address,
        latitude,
        longitude,
        contact_config,
        address_config,
        social_config,
        operational_hours,
        metadata,
        status,
        is_featured,
        sort_order
      )
      VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
      )
    `,
    [
      input.id,
      input.tenantId,
      input.parentId,
      input.organizationType,
      input.name,
      input.displayName,
      input.slug,
      input.shortDescription,
      input.description,
      input.logoUrl,
      input.coverUrl,
      input.email,
      input.phone,
      input.whatsapp,
      input.websiteUrl,
      input.address,
      input.latitude,
      input.longitude,
      input.contactConfig,
      input.addressConfig,
      input.socialConfig,
      input.operationalHours,
      input.metadata,
      input.status,
      input.isFeatured ? 1 : 0,
      input.sortOrder
    ]
  )

  return input.id
}

export async function updateOrganizationById(
  tenantId: string,
  id: string,
  input: OrganizationUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof OrganizationUpdateInput, string> = {
    parentId: 'parent_id',
    organizationType: 'organization_type',
    name: 'name',
    displayName: 'display_name',
    slug: 'slug',
    shortDescription: 'short_description',
    description: 'description',
    logoUrl: 'logo_url',
    coverUrl: 'cover_url',
    email: 'email',
    phone: 'phone',
    whatsapp: 'whatsapp',
    websiteUrl: 'website_url',
    address: 'address',
    latitude: 'latitude',
    longitude: 'longitude',
    contactConfig: 'contact_config',
    addressConfig: 'address_config',
    socialConfig: 'social_config',
    operationalHours: 'operational_hours',
    metadata: 'metadata',
    status: 'status',
    isFeatured: 'is_featured',
    sortOrder: 'sort_order'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof OrganizationUpdateInput]

    if (typeof value === 'undefined') continue

    fields.push(`${column} = ?`)

    if (key === 'isFeatured') {
      values.push(value ? 1 : 0)
    } else {
      values.push(value as any)
    }
  }

  if (!fields.length) return 0

  values.push(tenantId, id)

  const result = await dbExecute(
    `
      UPDATE tenant_organizations
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeleteOrganizationById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE tenant_organizations
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}