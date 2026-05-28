import { getTenantSiteFromEvent } from '../../../../../services/tenant-site.service'
import { getTenantInstitutionBySlug } from '../../../../../services/institution.service'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')

  if (!slug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Slug institution wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantInstitutionBySlug(tenant.id, slug)
})