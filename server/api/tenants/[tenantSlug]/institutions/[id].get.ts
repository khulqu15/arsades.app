import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantInstitutionDetail } from '../../../../services/institution.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID institution wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantInstitutionDetail(tenant.id, id)
})