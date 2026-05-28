import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantOrganizationList } from '../../../../services/organization.service'
import type { OrganizationStatus, OrganizationType } from '../../../../../types/organization'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  return await getTenantOrganizationList({
    tenantId: tenant.id,
    q: typeof query.q === 'string' ? query.q : undefined,
    organizationType: typeof query.type === 'string'
      ? query.type as OrganizationType | 'all'
      : 'all',
    status: typeof query.status === 'string'
      ? query.status as OrganizationStatus | 'all'
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