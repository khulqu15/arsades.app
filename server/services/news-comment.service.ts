import { randomUUID } from 'node:crypto'
import type {
  CreateNewsCommentPayload,
  NewsCommentItem,
  NewsCommentStatus,
  UpdateNewsCommentPayload
} from '../../types/news-comment'
import { findNewsByTenantAndId } from '../repositories/news.repository'
import {
  findNewsCommentById,
  findNewsCommentList,
  findNewsCommentStats,
  insertNewsComment,
  softDeleteNewsCommentById,
  updateNewsCommentById,
  type NewsCommentListParams,
  type NewsCommentRow
} from '../repositories/news-comment.repository'

const allowedStatuses: NewsCommentStatus[] = [
  'pending',
  'approved',
  'rejected',
  'spam',
  'hidden'
]

type RequestMetadata = {
  ipAddress?: string | null
  userAgent?: string | null
}

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

function isValidEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())
}

function normalizeStatus(value: unknown, fallback: NewsCommentStatus): NewsCommentStatus {
  const status = cleanString(value).toLowerCase()

  if (allowedStatuses.includes(status as NewsCommentStatus)) {
    return status as NewsCommentStatus
  }

  return fallback
}

function normalizeListStatus(value: unknown) {
  if (!value || value === 'all') return 'all'

  return normalizeStatus(value, 'approved')
}

function normalizeCount(value: unknown) {
  const number = Number(value || 0)

  if (!Number.isFinite(number)) return 0

  return Math.max(0, Math.floor(number))
}

function resolveAuthorName(payload: CreateNewsCommentPayload | UpdateNewsCommentPayload) {
  return cleanString(payload.authorName ?? payload.name)
}

function resolveAuthorEmail(payload: CreateNewsCommentPayload | UpdateNewsCommentPayload) {
  return cleanString(payload.authorEmail ?? payload.email)
}

function resolveAuthorPhone(payload: CreateNewsCommentPayload | UpdateNewsCommentPayload) {
  return cleanNullableString(payload.authorPhone ?? payload.phone)
}

function resolveContent(payload: CreateNewsCommentPayload | UpdateNewsCommentPayload) {
  return cleanString(payload.content ?? payload.comment)
}

function assertAuthorName(value: string) {
  if (value.length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Nama komentator minimal 2 karakter.'
    })
  }
}

function assertAuthorEmail(value: string) {
  if (!isValidEmail(value)) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Format email komentator belum valid.'
    })
  }
}

function assertContent(value: string) {
  if (value.length < 4) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Komentar minimal 4 karakter.'
    })
  }

  if (value.length > 2000) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Komentar maksimal 2000 karakter.'
    })
  }
}

async function ensureNewsBelongsToTenant(tenantId: string, newsId: string) {
  const news = await findNewsByTenantAndId(tenantId, newsId)

  if (!news) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Berita tidak ditemukan pada tenant ini.'
    })
  }
}

async function ensureParentComment(
  tenantId: string,
  newsId: string,
  parentId: string | null
) {
  if (!parentId) return

  const parent = await findNewsCommentById(tenantId, parentId)

  if (!parent || parent.news_id !== newsId) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Parent komentar tidak valid untuk berita ini.'
    })
  }
}

export function mapNewsCommentRow(row: NewsCommentRow): NewsCommentItem {
  const likesCount = Number(row.likes_count || 0)
  const dislikesCount = Number(row.dislikes_count || 0)

  return {
    id: row.id,
    tenantId: row.tenant_id,
    newsId: row.news_id,
    targetId: row.news_id,
    parentId: row.parent_id,

    authorName: row.author_name,
    authorEmail: row.author_email,
    authorPhone: row.author_phone,

    name: row.author_name,
    email: row.author_email,

    content: row.content,
    comment: row.content,

    likesCount,
    dislikesCount,
    likes: likesCount,
    dislikes: dislikesCount,

    status: row.status,

    ipAddress: row.ip_address,
    userAgent: row.user_agent,

    approvedAt: toTimestamp(row.approved_at),
    approvedBy: row.approved_by,

    metadata: parseJson(row.metadata, {}),

    createdAt: toRequiredTimestamp(row.created_at),
    updatedAt: toRequiredTimestamp(row.updated_at)
  }
}

export async function getTenantNewsCommentList(params: NewsCommentListParams) {
  const result = await findNewsCommentList({
    ...params,
    status: normalizeListStatus(params.status)
  })

  return {
    data: result.rows.map(mapNewsCommentRow),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getTenantNewsCommentDetail(tenantId: string, id: string) {
  const row = await findNewsCommentById(tenantId, id)

  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Komentar tidak ditemukan.'
    })
  }

  return {
    data: mapNewsCommentRow(row)
  }
}

export async function getTenantNewsCommentStats(tenantId: string) {
  const rows = await findNewsCommentStats(tenantId)
  const byNewsId: Record<string, any> = {}
  const total = {
    total: 0,
    pending: 0,
    approved: 0,
    rejected: 0,
    spam: 0,
    hidden: 0
  }

  for (const row of rows) {
    const item = {
      newsId: row.news_id,
      total: Number(row.total || 0),
      pending: Number(row.pending || 0),
      approved: Number(row.approved || 0),
      rejected: Number(row.rejected || 0),
      spam: Number(row.spam || 0),
      hidden: Number(row.hidden || 0)
    }

    byNewsId[row.news_id] = item

    total.total += item.total
    total.pending += item.pending
    total.approved += item.approved
    total.rejected += item.rejected
    total.spam += item.spam
    total.hidden += item.hidden
  }

  return {
    data: {
      ...total,
      byNewsId
    }
  }
}

export async function createTenantNewsComment(
  tenantId: string,
  payload: CreateNewsCommentPayload,
  requestMetadata: RequestMetadata = {}
) {
  const newsId = cleanString(payload.newsId)

  if (!newsId) {
    throw createError({
      statusCode: 422,
      statusMessage: 'ID berita wajib diisi.'
    })
  }

  await ensureNewsBelongsToTenant(tenantId, newsId)

  const parentId = cleanNullableString(payload.parentId)
  await ensureParentComment(tenantId, newsId, parentId)

  const authorName = resolveAuthorName(payload)
  const authorEmail = resolveAuthorEmail(payload)
  const content = resolveContent(payload)

  assertAuthorName(authorName)
  assertAuthorEmail(authorEmail)
  assertContent(content)

  const status = normalizeStatus(payload.status, 'pending')
  const approvedAt = status === 'approved' ? toMysqlDateTime(new Date()) : null

  const id = await insertNewsComment({
    id: createUuid(),
    tenantId,
    newsId,
    parentId,
    authorName,
    authorEmail,
    authorPhone: resolveAuthorPhone(payload),
    content,
    likesCount: 0,
    dislikesCount: 0,
    status,
    ipAddress: requestMetadata.ipAddress || null,
    userAgent: requestMetadata.userAgent || null,
    approvedAt,
    approvedBy: null,
    metadata: stringifyJson(payload.metadata)
  })

  const row = await findNewsCommentById(tenantId, id)

  return {
    data: row ? mapNewsCommentRow(row) : null
  }
}

export async function updateTenantNewsComment(
  tenantId: string,
  id: string,
  payload: UpdateNewsCommentPayload
) {
  const existing = await findNewsCommentById(tenantId, id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Komentar tidak ditemukan.'
    })
  }

  const hasAuthorName = typeof payload.authorName !== 'undefined' || typeof payload.name !== 'undefined'
  const hasAuthorEmail = typeof payload.authorEmail !== 'undefined' || typeof payload.email !== 'undefined'
  const hasAuthorPhone = typeof payload.authorPhone !== 'undefined' || typeof payload.phone !== 'undefined'
  const hasContent = typeof payload.content !== 'undefined' || typeof payload.comment !== 'undefined'
  const hasParentId = typeof payload.parentId !== 'undefined'
  const hasStatus = typeof payload.status !== 'undefined'

  const authorName = hasAuthorName ? resolveAuthorName(payload) : undefined
  const authorEmail = hasAuthorEmail ? resolveAuthorEmail(payload) : undefined
  const authorPhone = hasAuthorPhone ? resolveAuthorPhone(payload) : undefined
  const content = hasContent ? resolveContent(payload) : undefined
  const parentId = hasParentId ? cleanNullableString(payload.parentId) : undefined
  const status = hasStatus ? normalizeStatus(payload.status, existing.status) : undefined

  if (typeof authorName !== 'undefined') assertAuthorName(authorName)
  if (typeof authorEmail !== 'undefined') assertAuthorEmail(authorEmail)
  if (typeof content !== 'undefined') assertContent(content)

  if (typeof parentId !== 'undefined') {
    if (parentId === id) {
      throw createError({
        statusCode: 422,
        statusMessage: 'Komentar tidak bisa menjadi parent untuk dirinya sendiri.'
      })
    }

    await ensureParentComment(tenantId, existing.news_id, parentId)
  }

  const approvedAt = typeof payload.approvedAt !== 'undefined'
    ? toMysqlDateTime(payload.approvedAt)
    : status === 'approved' && !existing.approved_at
      ? toMysqlDateTime(new Date())
      : undefined

  await updateNewsCommentById(
    tenantId,
    id,
    {
      parentId,
      authorName,
      authorEmail,
      authorPhone,
      content,
      likesCount: typeof payload.likesCount !== 'undefined'
        ? normalizeCount(payload.likesCount)
        : undefined,
      dislikesCount: typeof payload.dislikesCount !== 'undefined'
        ? normalizeCount(payload.dislikesCount)
        : undefined,
      status,
      approvedAt,
      approvedBy: typeof payload.approvedBy !== 'undefined'
        ? cleanNullableString(payload.approvedBy)
        : undefined,
      metadata: typeof payload.metadata !== 'undefined'
        ? stringifyJson(payload.metadata)
        : undefined
    }
  )

  const row = await findNewsCommentById(tenantId, id)

  return {
    data: row ? mapNewsCommentRow(row) : null
  }
}

export async function deleteTenantNewsComment(tenantId: string, id: string) {
  const affectedRows = await softDeleteNewsCommentById(tenantId, id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Komentar tidak ditemukan.'
    })
  }

  return {
    message: 'Komentar berhasil dihapus.'
  }
}
