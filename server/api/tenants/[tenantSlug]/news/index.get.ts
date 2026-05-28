import type { NewsStatus } from '../../../../../types/news'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { getTenantNewsList } from '../../../../services/news.service'

export default defineEventHandler(async (event) => {
  const tenant = await resolveTenantFromEvent(event)
  const query = getQuery(event)

  return getTenantNewsList({
    tenantId: tenant.id,
    q: query.q ? String(query.q) : undefined,
    categorySlug: query.category ? String(query.category) : undefined,
    tagSlug: query.tag ? String(query.tag) : undefined,
    status: query.status
      ? String(query.status) as NewsStatus | 'all'
      : 'published',
    page: query.page ? Number(query.page) : 1,
    limit: query.limit ? Number(query.limit) : 12,
    sort: query.sort
      ? String(query.sort) as 'newest' | 'oldest' | 'title'
      : 'newest'
  })
})