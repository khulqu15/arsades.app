import { getTenantSiteFromEvent } from '../../../services/tenant-site.service'
import { getTenantVisitorStats } from '../../../services/public-dashboard.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return {
    data: await getTenantVisitorStats(tenant.id)
  }
})