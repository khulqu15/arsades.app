import type {
  ComplaintItem,
  ComplaintListResponse,
  ComplaintPriority,
  ComplaintServiceType,
  ComplaintStatus,
  CreateComplaintPayload,
  UpdateComplaintPayload
} from '../../../types/complaint'
import { useAppApi } from '../useAppApi'

type LoadComplaintOptions = {
  tenantSlug: string
  serviceType?: ComplaintServiceType | 'all'
  status?: ComplaintStatus | 'all'
  priority?: ComplaintPriority | 'all'
  assignedTo?: string
  q?: string
  page?: number
  limit?: number
  sort?: 'newest' | 'oldest' | 'priority'
}

export function useComplaints() {
  const { tenantApiUrl } = useAppApi()

  function complaintsUrl(tenantSlug: string) {
    return tenantApiUrl(tenantSlug, '/complaints')
  }

  async function listComplaints(options: LoadComplaintOptions) {
    return await $fetch<ComplaintListResponse>(complaintsUrl(options.tenantSlug), {
      query: {
        serviceType: options.serviceType || 'all',
        status: options.status || 'all',
        priority: options.priority || 'all',
        assignedTo: options.assignedTo,
        q: options.q,
        page: options.page || 1,
        limit: options.limit || 100,
        sort: options.sort || 'newest'
      }
    })
  }

  async function createComplaint(
    tenantSlug: string,
    payload: CreateComplaintPayload
  ) {
    const response = await $fetch<{ data: ComplaintItem }>(complaintsUrl(tenantSlug), {
      method: 'POST',
      body: payload
    })

    return response.data
  }

  async function updateComplaint(
    tenantSlug: string,
    id: string,
    payload: UpdateComplaintPayload
  ) {
    const response = await $fetch<{ data: ComplaintItem }>(`${complaintsUrl(tenantSlug)}/${id}`, {
      method: 'PUT',
      body: payload
    })

    return response.data
  }

  async function deleteComplaint(tenantSlug: string, id: string) {
    return await $fetch<{ message: string }>(`${complaintsUrl(tenantSlug)}/${id}`, {
      method: 'DELETE'
    })
  }

  return {
    complaintsUrl,
    listComplaints,
    createComplaint,
    updateComplaint,
    deleteComplaint
  }
}
