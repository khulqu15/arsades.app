import { updateTenantSiteByIdFromEvent } from '~~/server/services/tenant-site.service'

export default defineEventHandler(async (event) => {
  return await updateTenantSiteByIdFromEvent(event)
})