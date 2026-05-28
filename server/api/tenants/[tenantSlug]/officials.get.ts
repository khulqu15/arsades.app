import { getTenantSiteFromEvent } from '../../../services/tenant-site.service'
import { getTenantOfficials } from '../../../services/public-dashboard.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)
  const limit = query.limit ? Number(query.limit) : 10

  return {
    data: await getTenantOfficials(tenant.id, limit)
  }
})