import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantComplaint } from '../../../../services/complaint.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantComplaint(tenant.id, body)
})
