import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantFacility } from '../../../../services/facility.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantFacility(tenant.id, body)
})