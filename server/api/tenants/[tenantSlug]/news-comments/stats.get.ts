import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantNewsCommentStats } from '../../../../services/news-comment.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantNewsCommentStats(tenant.id)
})
