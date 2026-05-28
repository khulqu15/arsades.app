import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { deleteTenantFacility } from '../../../../services/facility.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID facility wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await deleteTenantFacility(tenant.id, id)
})