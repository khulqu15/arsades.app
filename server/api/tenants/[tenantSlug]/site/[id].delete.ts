import { deleteTenantSiteByIdFromEvent } from '~~/server/services/tenant-site.service'

export default defineEventHandler(async (event) => {
  await deleteTenantSiteByIdFromEvent(event)
  return sendNoContent(event, 204)
})