export type UUID = string

export type NewsCommentStatus =
  | 'pending'
  | 'approved'
  | 'rejected'
  | 'spam'
  | 'hidden'

export type NewsCommentItem = {
  id: UUID
  tenantId: UUID
  newsId: UUID
  targetId: UUID
  parentId: UUID | null

  authorName: string
  authorEmail: string
  authorPhone: string | null

  name: string
  email: string

  content: string
  comment: string

  likesCount: number
  dislikesCount: number
  likes: number
  dislikes: number

  status: NewsCommentStatus

  ipAddress: string | null
  userAgent: string | null

  approvedAt: number | null
  approvedBy: UUID | null

  metadata: Record<string, any>

  createdAt: number
  updatedAt: number
}

export type NewsCommentListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type NewsCommentListResponse = {
  data: NewsCommentItem[]
  meta: NewsCommentListMeta
}

export type NewsCommentDetailResponse = {
  data: NewsCommentItem
}

export type NewsCommentStatsItem = {
  newsId: UUID
  total: number
  pending: number
  approved: number
  rejected: number
  spam: number
  hidden: number
}

export type NewsCommentStatsResponse = {
  data: {
    total: number
    pending: number
    approved: number
    rejected: number
    spam: number
    hidden: number
    byNewsId: Record<UUID, NewsCommentStatsItem>
  }
}

export type CreateNewsCommentPayload = {
  newsId: UUID
  parentId?: UUID | null

  authorName?: string
  authorEmail?: string
  authorPhone?: string | null

  name?: string
  email?: string
  phone?: string | null

  content?: string
  comment?: string

  status?: NewsCommentStatus
  metadata?: Record<string, any>
}

export type UpdateNewsCommentPayload = Partial<Omit<CreateNewsCommentPayload, 'newsId'>> & {
  likesCount?: number
  dislikesCount?: number
  approvedAt?: string | number | Date | null
  approvedBy?: UUID | null
}
