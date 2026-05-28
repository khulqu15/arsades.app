import type { RowDataPacket } from 'mysql2/promise'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'
import type { PotentialStatus, PotentialType } from '../../types/potential'

export type PotentialRow = RowDataPacket & {
  id: string
  tenant_id: string

  potential_type: PotentialType

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

  owner_name: string | null
  manager_name: string | null

  production_capacity: string | null
  production_unit: string | null
  market_reach: string | null
  estimated_value: string | number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  website_url: string | null

  contact_config: unknown
  statistic_config: unknown
  metadata: unknown

  status: PotentialStatus
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export type PotentialListParams = {
  tenantId: string
  q?: string
  potentialType?: PotentialType | 'all'
  status?: PotentialStatus | 'all'
  featured?: boolean
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'title' | 'sort_order'
}

export type PotentialCreateInput = {
  id: string
  tenantId: string

  potentialType: PotentialType

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

  ownerName: string | null
  managerName: string | null

  productionCapacity: string | null
  productionUnit: string | null
  marketReach: string | null
  estimatedValue: number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  contactConfig: string | null
  statisticConfig: string | null
  metadata: string | null

  status: PotentialStatus
  isFeatured: boolean
  sortOrder: number
}

export type PotentialUpdateInput = Partial<Omit<PotentialCreateInput, 'id' | 'tenantId'>>

const potentialColumns = `
  id,
  tenant_id,
  potential_type,
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
  owner_name,
  manager_name,
  production_capacity,
  production_unit,
  market_reach,
  estimated_value,
  email,
  phone,
  whatsapp,
  website_url,
  contact_config,
  statistic_config,
  metadata,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

function buildWhere(params: PotentialListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.potentialType && params.potentialType !== 'all') {
    where.push('potential_type = ?')
    values.push(params.potentialType)
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
        OR owner_name LIKE ?
        OR manager_name LIKE ?
        OR market_reach LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(
      keyword,
      keyword,
      keyword,
      keyword,
      keyword,
      keyword,
      keyword,
      keyword
    )
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: PotentialListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'title') return 'title ASC'

  return 'sort_order ASC, created_at DESC'
}

export async function findPotentialList(params: PotentialListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM tenant_potentials
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<PotentialRow[]>(
    `
      SELECT ${potentialColumns}
      FROM tenant_potentials
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

export async function findPotentialById(tenantId: string, id: string) {
  const rows = await dbQuery<PotentialRow[]>(
    `
      SELECT ${potentialColumns}
      FROM tenant_potentials
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findPotentialBySlug(tenantId: string, slug: string) {
  const rows = await dbQuery<PotentialRow[]>(
    `
      SELECT ${potentialColumns}
      FROM tenant_potentials
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function insertPotential(input: PotentialCreateInput) {
  await dbExecute(
    `
      INSERT INTO tenant_potentials (
        id,
        tenant_id,
        potential_type,
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
        owner_name,
        manager_name,
        production_capacity,
        production_unit,
        market_reach,
        estimated_value,
        email,
        phone,
        whatsapp,
        website_url,
        contact_config,
        statistic_config,
        metadata,
        status,
        is_featured,
        sort_order
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.potentialType,
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
      input.ownerName,
      input.managerName,
      input.productionCapacity,
      input.productionUnit,
      input.marketReach,
      input.estimatedValue,
      input.email,
      input.phone,
      input.whatsapp,
      input.websiteUrl,
      input.contactConfig,
      input.statisticConfig,
      input.metadata,
      input.status,
      input.isFeatured ? 1 : 0,
      input.sortOrder
    ]
  )

  return input.id
}

export async function updatePotentialById(
  tenantId: string,
  id: string,
  input: PotentialUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof PotentialUpdateInput, string> = {
    potentialType: 'potential_type',
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
    ownerName: 'owner_name',
    managerName: 'manager_name',
    productionCapacity: 'production_capacity',
    productionUnit: 'production_unit',
    marketReach: 'market_reach',
    estimatedValue: 'estimated_value',
    email: 'email',
    phone: 'phone',
    whatsapp: 'whatsapp',
    websiteUrl: 'website_url',
    contactConfig: 'contact_config',
    statisticConfig: 'statistic_config',
    metadata: 'metadata',
    status: 'status',
    isFeatured: 'is_featured',
    sortOrder: 'sort_order'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof PotentialUpdateInput]

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
      UPDATE tenant_potentials
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeletePotentialById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE tenant_potentials
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}