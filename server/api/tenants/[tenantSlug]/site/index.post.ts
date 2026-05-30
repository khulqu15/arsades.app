import { createTenantSiteFromEvent } from '~~/server/services/tenant-site.service'

export default defineEventHandler(async (event) => {
  return await createTenantSiteFromEvent(event)
})