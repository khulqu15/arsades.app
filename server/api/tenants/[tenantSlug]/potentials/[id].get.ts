import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantPotentialDetail } from '../../../../services/potential.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID potensi wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantPotentialDetail(tenant.id, id)
})