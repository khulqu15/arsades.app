import { getTenantSiteFromEvent } from '../../../services/tenant-site.service'
import { getTenantVillageBudget } from '../../../services/public-dashboard.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)
  const year = query.year ? Number(query.year) : undefined

  return {
    data: await getTenantVillageBudget(tenant.id, year)
  }
})