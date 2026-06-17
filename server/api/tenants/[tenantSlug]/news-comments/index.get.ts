import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantNewsCommentList } from '../../../../services/news-comment.service'
import type { NewsCommentStatus } from '../../../../../types/news-comment'

function resolveParentId(value: unknown) {
  if (typeof value !== 'string') return undefined

  const text = value.trim()

  if (!text) return undefined
  if (text === 'root' || text === 'null') return null

  return text
}

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  return await getTenantNewsCommentList({
    tenantId: tenant.id,
    newsId: typeof query.newsId === 'string' ? query.newsId : undefined,
    parentId: resolveParentId(query.parentId),
    status: typeof query.status === 'string'
      ? query.status as NewsCommentStatus | 'all'
      : 'approved',
    q: typeof query.q === 'string' ? query.q : undefined,
    page: Number(query.page || 1),
    limit: Number(query.limit || 20),
    sort: typeof query.sort === 'string'
      ? query.sort as any
      : 'newest'
  })
})
