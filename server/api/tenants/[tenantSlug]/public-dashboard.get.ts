import { getTenantSiteFromEvent } from '../../../services/tenant-site.service'
import { getTenantPublicDashboard } from '../../../services/public-dashboard.service'

function toSafeInt(value: unknown, fallback: number, min: number, max: number) {
  const number = Number(value)

  if (!Number.isFinite(number)) return fallback

  return Math.min(Math.max(Math.trunc(number), min), max)
}

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  const year = query.year
    ? toSafeInt(query.year, new Date().getFullYear(), 2000, 2100)
    : undefined

  const officialsLimit = toSafeInt(query.officialsLimit, 10, 1, 50)

  return await getTenantPublicDashboard(tenant.id, {
    year,
    officialsLimit
  })
})