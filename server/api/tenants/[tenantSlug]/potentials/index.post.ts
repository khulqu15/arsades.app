import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantPotential } from '../../../../services/potential.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantPotential(tenant.id, body)
})