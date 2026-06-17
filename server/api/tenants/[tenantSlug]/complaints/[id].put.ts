import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { updateTenantComplaint } from '../../../../services/complaint.service'

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
  const body = await readBody(event)

  return await updateTenantComplaint(tenant.id, id, body)
})
