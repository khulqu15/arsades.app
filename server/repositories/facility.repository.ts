import type { RowDataPacket } from 'mysql2/promise'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'
import type { FacilityStatus, FacilityType } from '../../types/facility'

export type FacilityRow = RowDataPacket & {
  id: string
  tenant_id: string

  facility_type: FacilityType

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logo_url: string | null
  image_url: string | null

  content_html: string | null
  content_json: unknown

  address: string | null
  latitude: string | number | null
  longitude: string | number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  website_url: string | null

  contact_config: unknown
  operational_hours: unknown
  metadata: unknown

  status: FacilityStatus
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export type FacilityListParams = {
  tenantId: string
  q?: string
  facilityType?: FacilityType | 'all'
  status?: FacilityStatus | 'all'
  featured?: boolean
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'title' | 'sort_order'
}

export type FacilityCreateInput = {
  id: string
  tenantId: string

  facilityType: FacilityType

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logoUrl: string | null
  imageUrl: string | null

  contentHtml: string | null
  contentJson: string | null

  address: string | null
  latitude: number | null
  longitude: number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  contactConfig: string | null
  operationalHours: string | null
  metadata: string | null

  status: FacilityStatus
  isFeatured: boolean
  sortOrder: number
}

export type FacilityUpdateInput = Partial<Omit<FacilityCreateInput, 'id' | 'tenantId'>>

const facilityColumns = `
  id,
  tenant_id,
  facility_type,
  title,
  subtitle,
  slug,
  icon,
  logo_url,
  image_url,
  content_html,
  content_json,
  address,
  latitude,
  longitude,
  email,
  phone,
  whatsapp,
  website_url,
  contact_config,
  operational_hours,
  metadata,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

function buildWhere(params: FacilityListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.facilityType && params.facilityType !== 'all') {
    where.push('facility_type = ?')
    values.push(params.facilityType)
  }

  if (typeof params.featured === 'boolean') {
    where.push('is_featured = ?')
    values.push(params.featured ? 1 : 0)
  }

  if (params.q) {
    where.push(`
      (
        title LIKE ?
        OR subtitle LIKE ?
        OR slug LIKE ?
        OR content_html LIKE ?
        OR address LIKE ?
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

function resolveOrderBy(sort?: FacilityListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'title') return 'title ASC'

  return 'sort_order ASC, created_at DESC'
}

export async function findFacilityList(params: FacilityListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM tenant_facilities
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<FacilityRow[]>(
    `
      SELECT ${facilityColumns}
      FROM tenant_facilities
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

export async function findFacilityById(tenantId: string, id: string) {
  const rows = await dbQuery<FacilityRow[]>(
    `
      SELECT ${facilityColumns}
      FROM tenant_facilities
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findFacilityBySlug(tenantId: string, slug: string) {
  const rows = await dbQuery<FacilityRow[]>(
    `
      SELECT ${facilityColumns}
      FROM tenant_facilities
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function insertFacility(input: FacilityCreateInput) {
  await dbExecute(
    `
      INSERT INTO tenant_facilities (
        id,
        tenant_id,
        facility_type,
        title,
        subtitle,
        slug,
        icon,
        logo_url,
        image_url,
        content_html,
        content_json,
        address,
        latitude,
        longitude,
        email,
        phone,
        whatsapp,
        website_url,
        contact_config,
        operational_hours,
        metadata,
        status,
        is_featured,
        sort_order
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.facilityType,
      input.title,
      input.subtitle,
      input.slug,
      input.icon,
      input.logoUrl,
      input.imageUrl,
      input.contentHtml,
      input.contentJson,
      input.address,
      input.latitude,
      input.longitude,
      input.email,
      input.phone,
      input.whatsapp,
      input.websiteUrl,
      input.contactConfig,
      input.operationalHours,
      input.metadata,
      input.status,
      input.isFeatured ? 1 : 0,
      input.sortOrder
    ]
  )

  return input.id
}

export async function updateFacilityById(
  tenantId: string,
  id: string,
  input: FacilityUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof FacilityUpdateInput, string> = {
    facilityType: 'facility_type',
    title: 'title',
    subtitle: 'subtitle',
    slug: 'slug',
    icon: 'icon',
    logoUrl: 'logo_url',
    imageUrl: 'image_url',
    contentHtml: 'content_html',
    contentJson: 'content_json',
    address: 'address',
    latitude: 'latitude',
    longitude: 'longitude',
    email: 'email',
    phone: 'phone',
    whatsapp: 'whatsapp',
    websiteUrl: 'website_url',
    contactConfig: 'contact_config',
    operationalHours: 'operational_hours',
    metadata: 'metadata',
    status: 'status',
    isFeatured: 'is_featured',
    sortOrder: 'sort_order'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof FacilityUpdateInput]

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
      UPDATE tenant_facilities
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeleteFacilityById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE tenant_facilities
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}