import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantComplaintDetail } from '../../../../services/complaint.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID pengaduan wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantComplaintDetail(tenant.id, id)
})
