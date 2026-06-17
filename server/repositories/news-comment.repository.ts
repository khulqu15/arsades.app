import type { RowDataPacket } from 'mysql2/promise'
import type { NewsCommentStatus } from '../../types/news-comment'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'

export type NewsCommentRow = RowDataPacket & {
  id: string
  tenant_id: string
  news_id: string
  parent_id: string | null
  author_name: string
  author_email: string
  author_phone: string | null
  content: string
  likes_count: number
  dislikes_count: number
  status: NewsCommentStatus
  ip_address: string | null
  user_agent: string | null
  approved_at: Date | string | null
  approved_by: string | null
  metadata: unknown
  created_at: Date | string
  updated_at: Date | string
}

export type NewsCommentStatsRow = RowDataPacket & {
  news_id: string
  total: number
  pending: number
  approved: number
  rejected: number
  spam: number
  hidden: number
}

export type NewsCommentListParams = {
  tenantId: string
  newsId?: string
  parentId?: string | null
  status?: NewsCommentStatus | 'all'
  q?: string
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'popular'
}

export type NewsCommentCreateInput = {
  id: string
  tenantId: string
  newsId: string
  parentId: string | null
  authorName: string
  authorEmail: string
  authorPhone: string | null
  content: string
  likesCount: number
  dislikesCount: number
  status: NewsCommentStatus
  ipAddress: string | null
  userAgent: string | null
  approvedAt: string | null
  approvedBy: string | null
  metadata: string | null
}

export type NewsCommentUpdateInput = Partial<Omit<NewsCommentCreateInput, 'id' | 'tenantId' | 'newsId'>>

const newsCommentColumns = `
  id,
  tenant_id,
  news_id,
  parent_id,
  author_name,
  author_email,
  author_phone,
  content,
  likes_count,
  dislikes_count,
  status,
  ip_address,
  user_agent,
  approved_at,
  approved_by,
  metadata,
  created_at,
  updated_at
`

function buildWhere(params: NewsCommentListParams) {
  const where: string[] = [
    'tenant_id = ?',
    'deleted_at IS NULL'
  ]

  const values: DbParams = [params.tenantId]

  if (params.newsId) {
    where.push('news_id = ?')
    values.push(params.newsId)
  }

  if (typeof params.parentId !== 'undefined') {
    if (params.parentId === null) {
      where.push('parent_id IS NULL')
    } else {
      where.push('parent_id = ?')
      values.push(params.parentId)
    }
  }

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.q) {
    where.push(`
      (
        author_name LIKE ?
        OR author_email LIKE ?
        OR content LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

function resolveOrderBy(sort?: NewsCommentListParams['sort']) {
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'popular') return '(likes_count - dislikes_count) DESC, created_at DESC'

  return 'created_at DESC'
}

export async function findNewsCommentList(params: NewsCommentListParams) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const { whereSql, values } = buildWhere(params)
  const orderBy = resolveOrderBy(params.sort)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(*) AS total
      FROM news_comments
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<NewsCommentRow[]>(
    `
      SELECT ${newsCommentColumns}
      FROM news_comments
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

export async function findNewsCommentById(tenantId: string, id: string) {
  const rows = await dbQuery<NewsCommentRow[]>(
    `
      SELECT ${newsCommentColumns}
      FROM news_comments
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, id]
  )

  return rows[0] || null
}

export async function findNewsCommentStats(tenantId: string) {
  return await dbQuery<NewsCommentStatsRow[]>(
    `
      SELECT
        news_id,
        COUNT(*) AS total,
        SUM(status = 'pending') AS pending,
        SUM(status = 'approved') AS approved,
        SUM(status = 'rejected') AS rejected,
        SUM(status = 'spam') AS spam,
        SUM(status = 'hidden') AS hidden
      FROM news_comments
      WHERE tenant_id = ?
      AND deleted_at IS NULL
      GROUP BY news_id
    `,
    [tenantId]
  )
}

export async function insertNewsComment(input: NewsCommentCreateInput) {
  await dbExecute(
    `
      INSERT INTO news_comments (
        id,
        tenant_id,
        news_id,
        parent_id,
        author_name,
        author_email,
        author_phone,
        content,
        likes_count,
        dislikes_count,
        status,
        ip_address,
        user_agent,
        approved_at,
        approved_by,
        metadata
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.tenantId,
      input.newsId,
      input.parentId,
      input.authorName,
      input.authorEmail,
      input.authorPhone,
      input.content,
      input.likesCount,
      input.dislikesCount,
      input.status,
      input.ipAddress,
      input.userAgent,
      input.approvedAt,
      input.approvedBy,
      input.metadata
    ]
  )

  return input.id
}

export async function updateNewsCommentById(
  tenantId: string,
  id: string,
  input: NewsCommentUpdateInput
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof NewsCommentUpdateInput, string> = {
    parentId: 'parent_id',
    authorName: 'author_name',
    authorEmail: 'author_email',
    authorPhone: 'author_phone',
    content: 'content',
    likesCount: 'likes_count',
    dislikesCount: 'dislikes_count',
    status: 'status',
    ipAddress: 'ip_address',
    userAgent: 'user_agent',
    approvedAt: 'approved_at',
    approvedBy: 'approved_by',
    metadata: 'metadata'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof NewsCommentUpdateInput]

    if (typeof value === 'undefined') continue

    fields.push(`${column} = ?`)
    values.push(value as any)
  }

  if (!fields.length) return 0

  values.push(tenantId, id)

  const result = await dbExecute(
    `
      UPDATE news_comments
      SET ${fields.join(', ')}
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    values
  )

  return result.affectedRows
}

export async function softDeleteNewsCommentById(tenantId: string, id: string) {
  const result = await dbExecute(
    `
      UPDATE news_comments
      SET deleted_at = NOW()
      WHERE tenant_id = ?
      AND id = ?
      AND deleted_at IS NULL
    `,
    [tenantId, id]
  )

  return result.affectedRows
}
