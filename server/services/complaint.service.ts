import { randomUUID } from 'node:crypto'
import type {
  ComplaintItem,
  ComplaintPriority,
  ComplaintServiceType,
  ComplaintSourceType,
  ComplaintStatus,
  CreateComplaintPayload,
  UpdateComplaintPayload
} from '../../types/complaint'
import {
  findComplaintById,
  findComplaintByPublicCode,
  findComplaintList,
  insertComplaint,
  softDeleteComplaintById,
  updateComplaintById,
  type ComplaintListParams,
  type ComplaintRow
} from '../repositories/complaint.repository'

const allowedServiceTypes: ComplaintServiceType[] = ['aduan', 'laporan', 'pengajuan']
const allowedPriorities: ComplaintPriority[] = ['low', 'normal', 'high', 'urgent']
const allowedStatuses: ComplaintStatus[] = [
  'new',
  'in_review',
  'in_progress',
  'resolved',
  'rejected',
  'closed'
]
const allowedSourceTypes: ComplaintSourceType[] = ['public_form', 'admin', 'api', 'import']

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
  if (!value) return null

  const time = new Date(value).getTime()

  return Number.isNaN(time) ? null : time
}

function toRequiredTimestamp(value: Date | string | null | undefined) {
  return toTimestamp(value) || Date.now()
}

function toMysqlDateTime(value?: Date | string | number | null) {
  if (!value) return null

  const date = value instanceof Date
    ? value
    : new Date(value)

  if (Number.isNaN(date.getTime())) return null

  const pad = (number: number) => String(number).padStart(2, '0')

  return [
    date.getFullYear(),
    pad(date.getMonth() + 1),
    pad(date.getDate())
  ].join('-') + ' ' + [
    pad(date.getHours()),
    pad(date.getMinutes()),
    pad(date.getSeconds())
  ].join(':')
}

function cleanString(value: unknown) {
  return String(value || '').trim()
}

function cleanNullableString(value: unknown) {
  const text = cleanString(value)
  return text || null
}

function normalizePublicCode(value: unknown) {
  const text = cleanString(value)
    .replace(/\s+/g, '-')
    .toUpperCase()

  return text || null
}

function isValidEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())
}

function normalizeServiceType(value: unknown, fallback: ComplaintServiceType = 'aduan') {
  const text = cleanString(value)
    .toLowerCase()
    .replace(/\s+/g, '_')

  if (allowedServiceTypes.includes(text as ComplaintServiceType)) {
    return text as ComplaintServiceType
  }

  return fallback
}

function normalizePriority(value: unknown, fallback: ComplaintPriority = 'normal') {
  const text = cleanString(value).toLowerCase()

  if (allowedPriorities.includes(text as ComplaintPriority)) {
    return text as ComplaintPriority
  }

  return fallback
}

function normalizeStatus(value: unknown, fallback: ComplaintStatus = 'new') {
  const text = cleanString(value)
    .toLowerCase()
    .replace(/\s+/g, '_')

  if (allowedStatuses.includes(text as ComplaintStatus)) {
    return text as ComplaintStatus
  }

  return fallback
}

function normalizeSourceType(value: unknown, fallback: ComplaintSourceType = 'public_form') {
  const text = cleanString(value)
    .toLowerCase()
    .replace(/\s+/g, '_')

  if (allowedSourceTypes.includes(text as ComplaintSourceType)) {
    return text as ComplaintSourceType
  }

  return fallback
}

function normalizeListServiceType(value: unknown) {
  if (!value || value === 'all') return 'all'

  const text = cleanString(value)
    .toLowerCase()
    .replace(/\s+/g, '_')

  return allowedServiceTypes.includes(text as ComplaintServiceType)
    ? text as ComplaintServiceType
    : 'all'
}

function normalizeListPriority(value: unknown) {
  if (!value || value === 'all') return 'all'

  const text = cleanString(value).toLowerCase()

  return allowedPriorities.includes(text as ComplaintPriority)
    ? text as ComplaintPriority
    : 'all'
}

function normalizeListStatus(value: unknown) {
  if (!value || value === 'all') return 'all'

  const text = cleanString(value)
    .toLowerCase()
    .replace(/\s+/g, '_')

  return allowedStatuses.includes(text as ComplaintStatus)
    ? text as ComplaintStatus
    : 'all'
}

function normalizeCoordinate(value: unknown) {
  if (value === null) return null
  if (typeof value === 'undefined') return null

  const number = Number(value)

  return Number.isFinite(number) ? number : null
}

function serviceLabel(value: ComplaintServiceType) {
  if (value === 'laporan') return 'Laporan'
  if (value === 'pengajuan') return 'Pengajuan'

  return 'Aduan'
}

function publicCodePrefix(value: ComplaintServiceType) {
  if (value === 'laporan') return 'LAP'
  if (value === 'pengajuan') return 'PGJ'

  return 'ADU'
}

function dateCode() {
  const date = new Date()
  const pad = (number: number) => String(number).padStart(2, '0')

  return [
    date.getFullYear(),
    pad(date.getMonth() + 1),
    pad(date.getDate())
  ].join('')
}

async function generatePublicCode(tenantId: string, serviceType: ComplaintServiceType) {
  for (let attempt = 0; attempt < 5; attempt += 1) {
    const code = `${publicCodePrefix(serviceType)}-${dateCode()}-${randomUUID().slice(0, 8).toUpperCase()}`
    const duplicate = await findComplaintByPublicCode(tenantId, code)

    if (!duplicate) return code
  }

  return `${publicCodePrefix(serviceType)}-${dateCode()}-${Date.now()}`
}

function buildAttachmentConfig(payload: CreateComplaintPayload | UpdateComplaintPayload) {
  const hasAttachmentConfig = typeof payload.attachmentConfig !== 'undefined'
  const hasAttachments = typeof payload.attachments !== 'undefined'

  if (!hasAttachmentConfig && !hasAttachments) return undefined

  const base = hasAttachmentConfig && payload.attachmentConfig && typeof payload.attachmentConfig === 'object'
    ? payload.attachmentConfig
    : {}

  if (!hasAttachments) return base

  return {
    ...base,
    attachments: Array.isArray(payload.attachments) ? payload.attachments : []
  }
}

function resolveReporterName(payload: CreateComplaintPayload | UpdateComplaintPayload) {
  return cleanString(payload.reporterName ?? payload.name)
}

function resolveReporterEmail(payload: CreateComplaintPayload | UpdateComplaintPayload) {
  return cleanString(payload.reporterEmail ?? payload.email)
}

function resolveReporterPhone(payload: CreateComplaintPayload | UpdateComplaintPayload) {
  return cleanNullableString(payload.reporterPhone ?? payload.phone)
}

function assertReporterName(value: string) {
  if (value.length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Nama pelapor minimal 2 karakter.'
    })
  }
}

function assertReporterEmail(value: string) {
  if (!isValidEmail(value)) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Format email pelapor belum valid.'
    })
  }
}

function assertMessage(value: string) {
  if (value.length < 8) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Pesan pengaduan minimal 8 karakter.'
    })
  }

  if (value.length > 4000) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Pesan pengaduan maksimal 4000 karakter.'
    })
  }
}

function resolveAttachments(attachmentConfig: Record<string, any>) {
  const value = attachmentConfig.attachments

  return Array.isArray(value) ? value : []
}

export function mapComplaintRow(row: ComplaintRow): ComplaintItem {
  const attachmentConfig = parseJson<Record<string, any>>(row.attachment_config, {})

  return {
    id: row.id,
    tenantId: row.tenant_id,

    publicCode: row.public_code,

    serviceType: row.service_type,
    serviceLabel: serviceLabel(row.service_type),

    title: row.title,
    message: row.message,

    reporterName: row.reporter_name,
    reporterEmail: row.reporter_email,
    reporterPhone: row.reporter_phone,

    name: row.reporter_name,
    email: row.reporter_email,
    phone: row.reporter_phone,

    address: row.address,
    latitude: row.latitude === null ? null : Number(row.latitude),
    longitude: row.longitude === null ? null : Number(row.longitude),

    attachments: resolveAttachments(attachmentConfig),
    attachmentConfig,

    priority: row.priority,
    status: row.status,

    assignedTo: row.assigned_to,

    responseText: row.response_text,
    responseAt: toTimestamp(row.response_at),
    resolvedAt: toTimestamp(row.resolved_at),
    closedAt: toTimestamp(row.closed_at),

    sourceType: row.source_type,

    metadata: parseJson(row.metadata, {}),

    createdAt: toRequiredTimestamp(row.created_at),
    updatedAt: toRequiredTimestamp(row.updated_at)
  }
}

export async function getTenantComplaintList(params: ComplaintListParams) {
  const result = await findComplaintList({
    ...params,
    serviceType: normalizeListServiceType(params.serviceType),
    status: normalizeListStatus(params.status),
    priority: normalizeListPriority(params.priority)
  })

  return {
    data: result.rows.map(mapComplaintRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantComplaintDetail(tenantId: string, id: string) {
  const row = await findComplaintById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Pengaduan tidak ditemukan.'
    })
  }

  return {
    data: mapComplaintRow(row)
  }
}

export async function createTenantComplaint(
  tenantId: string,
  payload: CreateComplaintPayload
) {
  const serviceType = normalizeServiceType(payload.serviceType ?? payload.service)
  const reporterName = resolveReporterName(payload)
  const reporterEmail = resolveReporterEmail(payload)
  const message = cleanString(payload.message)

  assertReporterName(reporterName)
  assertReporterEmail(reporterEmail)
  assertMessage(message)

  const providedPublicCode = normalizePublicCode(payload.publicCode)

  if (providedPublicCode) {
    const duplicate = await findComplaintByPublicCode(tenantId, providedPublicCode)

    if (duplicate) {
      throw createError({
        statusCode: 409,
        statusMessage: 'Kode publik pengaduan sudah digunakan.'
      })
    }
  }

  const publicCode = providedPublicCode || await generatePublicCode(tenantId, serviceType)
  const attachmentConfig = buildAttachmentConfig(payload)
  const status = normalizeStatus(payload.status)
  const now = new Date()
  const responseText = cleanNullableString(payload.responseText)

  const id = await insertComplaint({
    id: createUuid(),
    tenantId,
    publicCode,
    serviceType,
    title: cleanNullableString(payload.title),
    message,
    reporterName,
    reporterEmail,
    reporterPhone: resolveReporterPhone(payload),
    address: cleanNullableString(payload.address),
    latitude: normalizeCoordinate(payload.latitude),
    longitude: normalizeCoordinate(payload.longitude),
    attachmentConfig: typeof attachmentConfig === 'undefined'
      ? null
      : stringifyJson(attachmentConfig),
    priority: normalizePriority(payload.priority),
    status,
    assignedTo: cleanNullableString(payload.assignedTo),
    responseText,
    responseAt: toMysqlDateTime(payload.responseAt) || (responseText ? toMysqlDateTime(now) : null),
    resolvedAt: toMysqlDateTime(payload.resolvedAt) || (status === 'resolved' ? toMysqlDateTime(now) : null),
    closedAt: toMysqlDateTime(payload.closedAt) || (status === 'closed' ? toMysqlDateTime(now) : null),
    sourceType: normalizeSourceType(payload.sourceType),
    metadata: stringifyJson(payload.metadata)
  })

  const row = await findComplaintById(tenantId, id)

  return {
    data: row ? mapComplaintRow(row) : null
  }
}

export async function updateTenantComplaint(
  tenantId: string,
  id: string,
  payload: UpdateComplaintPayload
) {
  const existing = await findComplaintById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Pengaduan tidak ditemukan.'
    })
  }

  const hasPublicCode = typeof payload.publicCode !== 'undefined'
  const hasServiceType = typeof payload.serviceType !== 'undefined' || typeof payload.service !== 'undefined'
  const hasReporterName = typeof payload.reporterName !== 'undefined' || typeof payload.name !== 'undefined'
  const hasReporterEmail = typeof payload.reporterEmail !== 'undefined' || typeof payload.email !== 'undefined'
  const hasReporterPhone = typeof payload.reporterPhone !== 'undefined' || typeof payload.phone !== 'undefined'
  const hasMessage = typeof payload.message !== 'undefined'
  const hasAttachmentConfig = typeof payload.attachmentConfig !== 'undefined' || typeof payload.attachments !== 'undefined'
  const hasStatus = typeof payload.status !== 'undefined'

  const publicCode = hasPublicCode ? normalizePublicCode(payload.publicCode) : undefined
  const serviceType = hasServiceType
    ? normalizeServiceType(payload.serviceType ?? payload.service, existing.service_type)
    : undefined
  const reporterName = hasReporterName ? resolveReporterName(payload) : undefined
  const reporterEmail = hasReporterEmail ? resolveReporterEmail(payload) : undefined
  const reporterPhone = hasReporterPhone ? resolveReporterPhone(payload) : undefined
  const message = hasMessage ? cleanString(payload.message) : undefined
  const status = hasStatus ? normalizeStatus(payload.status, existing.status) : undefined
  const responseText = typeof payload.responseText !== 'undefined'
    ? cleanNullableString(payload.responseText)
    : undefined

  if (typeof reporterName !== 'undefined') assertReporterName(reporterName)
  if (typeof reporterEmail !== 'undefined') assertReporterEmail(reporterEmail)
  if (typeof message !== 'undefined') assertMessage(message)

  if (typeof publicCode !== 'undefined' && publicCode !== existing.public_code) {
    if (publicCode) {
      const duplicate = await findComplaintByPublicCode(tenantId, publicCode)

      if (duplicate && duplicate.id !== id) {
        throw createError({
          statusCode: 409,
          statusMessage: 'Kode publik pengaduan sudah digunakan.'
        })
      }
    }
  }

  const attachmentConfig = hasAttachmentConfig ? buildAttachmentConfig(payload) : undefined
  const now = new Date()

  await updateComplaintById(
    tenantId,
    id,
    {
      publicCode,
      serviceType,
      title: typeof payload.title !== 'undefined'
        ? cleanNullableString(payload.title)
        : undefined,
      message,
      reporterName,
      reporterEmail,
      reporterPhone,
      address: typeof payload.address !== 'undefined'
        ? cleanNullableString(payload.address)
        : undefined,
      latitude: typeof payload.latitude !== 'undefined'
        ? normalizeCoordinate(payload.latitude)
        : undefined,
      longitude: typeof payload.longitude !== 'undefined'
        ? normalizeCoordinate(payload.longitude)
        : undefined,
      attachmentConfig: typeof attachmentConfig === 'undefined'
        ? undefined
        : stringifyJson(attachmentConfig),
      priority: typeof payload.priority !== 'undefined'
        ? normalizePriority(payload.priority, existing.priority)
        : undefined,
      status,
      assignedTo: typeof payload.assignedTo !== 'undefined'
        ? cleanNullableString(payload.assignedTo)
        : undefined,
      responseText,
      responseAt: typeof payload.responseAt !== 'undefined'
        ? toMysqlDateTime(payload.responseAt)
        : responseText && !existing.response_at
          ? toMysqlDateTime(now)
          : undefined,
      resolvedAt: typeof payload.resolvedAt !== 'undefined'
        ? toMysqlDateTime(payload.resolvedAt)
        : status === 'resolved' && !existing.resolved_at
          ? toMysqlDateTime(now)
          : undefined,
      closedAt: typeof payload.closedAt !== 'undefined'
        ? toMysqlDateTime(payload.closedAt)
        : status === 'closed' && !existing.closed_at
          ? toMysqlDateTime(now)
          : undefined,
      sourceType: typeof payload.sourceType !== 'undefined'
        ? normalizeSourceType(payload.sourceType, existing.source_type)
        : undefined,
      metadata: typeof payload.metadata !== 'undefined'
        ? stringifyJson(payload.metadata)
        : undefined
    }
  )

  const row = await findComplaintById(tenantId, id)

  return {
    data: row ? mapComplaintRow(row) : null
  }
}

export async function deleteTenantComplaint(tenantId: string, id: string) {
  const affectedRows = await softDeleteComplaintById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Pengaduan tidak ditemukan.'
    })
  }

  return {
    message: 'Pengaduan berhasil dihapus.'
  }
}
