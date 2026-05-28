import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantInstitution } from '../../../../services/institution.service'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantInstitution(tenant.id, body)
})