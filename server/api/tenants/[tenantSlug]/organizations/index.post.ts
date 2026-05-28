import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantOrganization } from '../../../../services/organization.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantOrganization(tenant.id, body)
})