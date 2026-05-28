import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { updateTenantFacility } from '../../../../services/facility.service'

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
  const body = await readBody(event)

  return await updateTenantFacility(tenant.id, id, body)
})