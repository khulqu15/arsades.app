import { getTenantSiteFromEvent } from '../../../../../services/tenant-site.service'
import { getTenantFacilityBySlug } from '../../../../../services/facility.service'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')

  if (!slug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Slug facility wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantFacilityBySlug(tenant.id, slug)
})