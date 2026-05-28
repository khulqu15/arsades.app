import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { updateTenantOrganization } from '../../../../services/organization.service'

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
  const body = await readBody(event)

  return await updateTenantOrganization(tenant.id, id, body)
})