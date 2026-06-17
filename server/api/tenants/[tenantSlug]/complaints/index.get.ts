import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { getTenantComplaintList } from '../../../../services/complaint.service'
import type {
  ComplaintPriority,
  ComplaintServiceType,
  ComplaintStatus
} from '../../../../../types/complaint'

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data

  const query = getQuery(event)
  const serviceType = query.serviceType || query.service || query.type

  return await getTenantComplaintList({
    tenantId: tenant.id,
    serviceType: typeof serviceType === 'string'
      ? serviceType as ComplaintServiceType | 'all'
      : 'all',
    status: typeof query.status === 'string'
      ? query.status as ComplaintStatus | 'all'
      : 'all',
    priority: typeof query.priority === 'string'
      ? query.priority as ComplaintPriority | 'all'
      : 'all',
    assignedTo: typeof query.assignedTo === 'string'
      ? query.assignedTo
      : undefined,
    q: typeof query.q === 'string' ? query.q : undefined,
    page: Number(query.page || 1),
    limit: Number(query.limit || 20),
    sort: typeof query.sort === 'string'
      ? query.sort as any
      : 'newest'
  })
})
