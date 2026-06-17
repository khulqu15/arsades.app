import type { RowDataPacket } from 'mysql2/promise'
import type {
  ComplaintPriority,
  ComplaintServiceType,
  ComplaintSourceType,
  ComplaintStatus
} from '../../types/complaint'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'

export type ComplaintRow = RowDataPacket & {
  id: string
  tenant_id: string
  public_code: string | null
  service_type: ComplaintServiceType
  title: string | null
  message: string
  reporter_name: string
  reporter_email: string
  reporter_phone: string | null
  address: string | null
  latitude: string | number | null
  longitude: string | number | null
  attachment_config: unknown
  priority: ComplaintPriority
  status: ComplaintStatus
  assigned_to: string | null
  response_text: string | null
  response_at: Date | string | null
  resolved_at: Date | string | null
  closed_at: Date | string | null
  source_type: ComplaintSourceType
  metadata: unknown
  created_at: Date | string
  updated_at: Date | string
}

export type ComplaintListParams = {
  tenantId: string
  serviceType?: ComplaintServiceType | 'all'
  status?: ComplaintStatus | 'all'
  priority?: ComplaintPriority | 'all'
  assignedTo?: string
  q?: string
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'priority'
}

export type ComplaintCreateInput = {
  id: string
  tenantId: string
  publicCode: string | null
  serviceType: ComplaintServiceType
  title: string | null
  message: string
  reporterName: string
  reporterEmail: string
  reporterPhone: string | null
  address: string | null
  latitude: number | null
  longitude: number | null
  attachmentConfig: string | null
  priority: ComplaintPriority
  status: ComplaintStatus
  assignedTo: string | null
  responseText: string | null
  responseAt: string | null
  resolvedAt: string | null
  closedAt: string | null
  sourceType: ComplaintSourceType
  metadata: string | null
}

export type ComplaintUpdateInput = Partial<Omit<ComplaintCreateInput, 'id' | 'tenantId'>>

const complaintColumns = `
  id,
  tenant_id,
  public_code,
  service_type,
  title,
  message,
  reporter_name,
  reporter_email,
  reporter_phone,
  address,
  latitude,
  longitude,
  attachment_config,
  priority,
  status,
  assigned_to,
  response_text,
  response_at,
  resolved_at,
  closed_at,
  source_type,
  metadata,
  created_at,
  updated_at
`

function buildWhere(params: ComplaintListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.serviceType && params.serviceType !== 'all') {
    where.push('service_type = ?')
    values.push(params.serviceType)
  }

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.priority && params.priority !== 'all') {
    where.push('priority = ?')
    values.push(params.priority)
  }

  if (params.assignedTo) {
    where.push('assigned_to = ?')
    values.push(params.assignedTo)
  }

  if (params.q) {
    where.push(`
      (
        public_code LIKE ?
        OR title LIKE ?
        OR message LIKE ?
        OR reporter_name LIKE ?
        OR reporter_email LIKE ?
        OR address LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword, keyword, keyword, keyword)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: ComplaintListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'priority') {
    return `
      FIELD(priority, 'urgent', 'high', 'normal', 'low') ASC,
      created_at DESC
    `
  }

  return 'created_at DESC'
}

export async function findComplaintList(params: ComplaintListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM tenant_complaints
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<ComplaintRow[]>(
    `
      SELECT ${complaintColumns}
      FROM tenant_complaints
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

export async function findComplaintById(tenantId: string, id: string) {
  const rows = await dbQuery<ComplaintRow[]>(
    `
      SELECT ${complaintColumns}
      FROM tenant_complaints
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findComplaintByPublicCode(
  tenantId: string,
  publicCode: string
) {
  const rows = await dbQuery<ComplaintRow[]>(
    `
      SELECT ${complaintColumns}
      FROM tenant_complaints
      WHERE tenant_id = ?
      AND public_code = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, publicCode]
  )

  return rows[0] || null
}

export async function insertComplaint(input: ComplaintCreateInput) {
  await dbExecute(
    `
      INSERT INTO tenant_complaints (
        id,
        tenant_id,
        public_code,
        service_type,
        title,
        message,
        reporter_name,
        reporter_email,
        reporter_phone,
        address,
        latitude,
        longitude,
        attachment_config,
        priority,
        status,
        assigned_to,
        response_text,
        response_at,
        resolved_at,
        closed_at,
        source_type,
        metadata
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.publicCode,
      input.serviceType,
      input.title,
      input.message,
      input.reporterName,
      input.reporterEmail,
      input.reporterPhone,
      input.address,
      input.latitude,
      input.longitude,
      input.attachmentConfig,
      input.priority,
      input.status,
      input.assignedTo,
      input.responseText,
      input.responseAt,
      input.resolvedAt,
      input.closedAt,
      input.sourceType,
      input.metadata
    ]
  )

  return input.id
}

export async function updateComplaintById(
  tenantId: string,
  id: string,
  input: ComplaintUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof ComplaintUpdateInput, string> = {
    publicCode: 'public_code',
    serviceType: 'service_type',
    title: 'title',
    message: 'message',
    reporterName: 'reporter_name',
    reporterEmail: 'reporter_email',
    reporterPhone: 'reporter_phone',
    address: 'address',
    latitude: 'latitude',
    longitude: 'longitude',
    attachmentConfig: 'attachment_config',
    priority: 'priority',
    status: 'status',
    assignedTo: 'assigned_to',
    responseText: 'response_text',
    responseAt: 'response_at',
    resolvedAt: 'resolved_at',
    closedAt: 'closed_at',
    sourceType: 'source_type',
    metadata: 'metadata'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof ComplaintUpdateInput]

    if (typeof value === 'undefined') continue

    fields.push(`${column} = ?`)
    values.push(value as any)
  }

  if (!fields.length) return 0

  values.push(tenantId, id)

  const result = await dbExecute(
    `
      UPDATE tenant_complaints
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeleteComplaintById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE tenant_complaints
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}
