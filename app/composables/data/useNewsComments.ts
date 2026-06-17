import type {
  CreateNewsCommentPayload,
  NewsCommentItem,
  NewsCommentListResponse,
  NewsCommentStatsResponse,
  NewsCommentStatus,
  UpdateNewsCommentPayload
} from '../../../types/news-comment'
import { useAppApi } from '../useAppApi'

type LoadCommentOptions = {
  tenantSlug: string
  newsId?: string
  status?: NewsCommentStatus | 'all'
  q?: string
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'popular'
}

export function useNewsComments() {
  const { tenantApiUrl } = useAppApi()

  function commentsUrl(tenantSlug: string) {
    return tenantApiUrl(tenantSlug, '/news-comments')
  }

  function statsUrl(tenantSlug: string) {
    return tenantApiUrl(tenantSlug, '/news-comments/stats')
  }

  async function listComments(options: LoadCommentOptions) {
    return await $fetch<NewsCommentListResponse>(commentsUrl(options.tenantSlug), {
      query: {
        newsId: options.newsId,
        status: options.status || 'approved',
        q: options.q,
        page: options.page || 1,
        limit: options.limit || 100,
        sort: options.sort || 'newest'
      }
    })
  }

  async function getStats(tenantSlug: string) {
    return await $fetch<NewsCommentStatsResponse>(statsUrl(tenantSlug))
  }

  async function createComment(
    tenantSlug: string,
    payload: CreateNewsCommentPayload
  ) {
    const response = await $fetch<{ data: NewsCommentItem }>(commentsUrl(tenantSlug), {
      method: 'POST',
      body: payload
    })

    return response.data
  }

  async function updateComment(
    tenantSlug: string,
    id: string,
    payload: UpdateNewsCommentPayload
  ) {
    const response = await $fetch<{ data: NewsCommentItem }>(`${commentsUrl(tenantSlug)}/${id}`, {
      method: 'PUT',
      body: payload
    })

    return response.data
  }

  async function deleteComment(tenantSlug: string, id: string) {
    return await $fetch<{ message: string }>(`${commentsUrl(tenantSlug)}/${id}`, {
      method: 'DELETE'
    })
  }

  return {
    commentsUrl,
    statsUrl,
    listComments,
    getStats,
    createComment,
    updateComment,
    deleteComment
  }
}
