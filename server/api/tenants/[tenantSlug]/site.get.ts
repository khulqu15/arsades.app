import { getTenantSiteFromEvent } from '../../../services/tenant-site.service'

export default defineEventHandler(async (event) => {
  return getTenantSiteFromEvent(event)
})