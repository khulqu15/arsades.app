import type { RowDataPacket } from 'mysql2/promise'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'
import type { InstitutionStatus } from '../../types/institution'

export type InstitutionRow = RowDataPacket & {
  id: string
  tenant_id: string

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logo_url: string | null

  content_html: string | null
  content_json: unknown

  status: InstitutionStatus
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export type InstitutionListParams = {
  tenantId: string
  q?: string
  status?: InstitutionStatus | 'all'
  featured?: boolean
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'title' | 'sort_order'
}

export type InstitutionCreateInput = {
  id: string
  tenantId: string

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logoUrl: string | null

  contentHtml: string | null
  contentJson: string | null

  status: InstitutionStatus
  isFeatured: boolean
  sortOrder: number
}

export type InstitutionUpdateInput = Partial<Omit<InstitutionCreateInput, 'id' | 'tenantId'>>

const institutionColumns = `
  id,
  tenant_id,
  title,
  subtitle,
  slug,
  icon,
  logo_url,
  content_html,
  content_json,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

function buildWhere(params: InstitutionListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
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
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword, keyword)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: InstitutionListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'title') return 'title ASC'

  return 'sort_order ASC, created_at DESC'
}

export async function findInstitutionList(params: InstitutionListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM tenant_institutions
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<InstitutionRow[]>(
    `
      SELECT ${institutionColumns}
      FROM tenant_institutions
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

export async function findInstitutionById(tenantId: string, id: string) {
  const rows = await dbQuery<InstitutionRow[]>(
    `
      SELECT ${institutionColumns}
      FROM tenant_institutions
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findInstitutionBySlug(tenantId: string, slug: string) {
  const rows = await dbQuery<InstitutionRow[]>(
    `
      SELECT ${institutionColumns}
      FROM tenant_institutions
      WHERE tenant_id = ?
      AND slug = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, slug]
  )

  return rows[0] || null
}

export async function insertInstitution(input: InstitutionCreateInput) {
  await dbExecute(
    `
      INSERT INTO tenant_institutions (
        id,
        tenant_id,
        title,
        subtitle,
        slug,
        icon,
        logo_url,
        content_html,
        content_json,
        status,
        is_featured,
        sort_order
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.title,
      input.subtitle,
      input.slug,
      input.icon,
      input.logoUrl,
      input.contentHtml,
      input.contentJson,
      input.status,
      input.isFeatured ? 1 : 0,
      input.sortOrder
    ]
  )

  return input.id
}

export async function updateInstitutionById(
  tenantId: string,
  id: string,
  input: InstitutionUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof InstitutionUpdateInput, string> = {
    title: 'title',
    subtitle: 'subtitle',
    slug: 'slug',
    icon: 'icon',
    logoUrl: 'logo_url',
    contentHtml: 'content_html',
    contentJson: 'content_json',
    status: 'status',
    isFeatured: 'is_featured',
    sortOrder: 'sort_order'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof InstitutionUpdateInput]

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
      UPDATE tenant_institutions
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeleteInstitutionById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE tenant_institutions
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}