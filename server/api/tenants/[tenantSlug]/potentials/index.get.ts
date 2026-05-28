import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantPotentialList } from '../../../../services/potential.service'
import type { PotentialStatus, PotentialType } from '../../../../../types/potential'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  return await getTenantPotentialList({
    tenantId: tenant.id,
    q: typeof query.q === 'string' ? query.q : undefined,
    potentialType: typeof query.type === 'string'
      ? query.type as PotentialType | 'all'
      : 'all',
    status: typeof query.status === 'string'
      ? query.status as PotentialStatus | 'all'
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