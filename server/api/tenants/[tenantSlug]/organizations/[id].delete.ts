import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { deleteTenantOrganization } from '../../../../services/organization.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID organisasi wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await deleteTenantOrganization(tenant.id, id)
})