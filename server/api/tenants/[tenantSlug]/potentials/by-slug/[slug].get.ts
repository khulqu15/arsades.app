import { getTenantSiteFromEvent } from '../../../../../services/tenant-site.service'
import { getTenantPotentialBySlug } from '../../../../../services/potential.service'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')

  if (!slug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Slug potensi wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  return await getTenantPotentialBySlug(tenant.id, slug)
})