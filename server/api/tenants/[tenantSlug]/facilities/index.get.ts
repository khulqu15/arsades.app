import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantFacilityList } from '../../../../services/facility.service'
import type { FacilityStatus, FacilityType } from '../../../../../types/facility'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  return await getTenantFacilityList({
    tenantId: tenant.id,
    q: typeof query.q === 'string' ? query.q : undefined,
    facilityType: typeof query.type === 'string'
      ? query.type as FacilityType | 'all'
      : 'all',
    status: typeof query.status === 'string'
      ? query.status as FacilityStatus | 'all'
      : 'active',
    featured:
      typeof query.featured === 'string'
        ? query.featured === 'true'
        : undefined,
    page: Number(query.page || 1),
    limit: Number(query.limit || 20),
    sort: typeof query.sort === 'string'
      ? query.sort as any
      : 'sort_order'
  })
})