import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantInstitutionList } from '../../../../services/institution.service'
import type { InstitutionStatus } from '../../../../../types/institution'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)

  return await getTenantInstitutionList({
    tenantId: tenant.id,
    q: typeof query.q === 'string' ? query.q : undefined,
    status: typeof query.status === 'string'
      ? query.status as InstitutionStatus | 'all'
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