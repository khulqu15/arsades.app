export type UUID = string

export type ComplaintServiceType = 'aduan' | 'laporan' | 'pengajuan'
export type ComplaintPriority = 'low' | 'normal' | 'high' | 'urgent'
export type ComplaintStatus =
  | 'new'
  | 'in_review'
  | 'in_progress'
  | 'resolved'
  | 'rejected'
  | 'closed'
export type ComplaintSourceType = 'public_form' | 'admin' | 'api' | 'import'

export type ComplaintItem = {
  id: UUID
  tenantId: UUID

  publicCode: string | null

  serviceType: ComplaintServiceType
  serviceLabel: string

  title: string | null
  message: string

  reporterName: string
  reporterEmail: string
  reporterPhone: string | null

  name: string
  email: string
  phone: string | null

  address: string | null
  latitude: number | null
  longitude: number | null

  attachments: any[]
  attachmentConfig: Record<string, any>

  priority: ComplaintPriority
  status: ComplaintStatus

  assignedTo: UUID | null

  responseText: string | null
  responseAt: number | null
  resolvedAt: number | null
  closedAt: number | null

  sourceType: ComplaintSourceType

  metadata: Record<string, any>

  createdAt: number
  updatedAt: number
}

export type ComplaintListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type ComplaintListResponse = {
  data: ComplaintItem[]
  meta: ComplaintListMeta
}

export type ComplaintDetailResponse = {
  data: ComplaintItem
}

export type CreateComplaintPayload = {
  publicCode?: string | null

  serviceType?: ComplaintServiceType | string
  service?: ComplaintServiceType | string

  title?: string | null
  message: string

  reporterName?: string
  reporterEmail?: string
  reporterPhone?: string | null

  name?: string
  email?: string
  phone?: string | null

  address?: string | null
  latitude?: number | null
  longitude?: number | null

  attachments?: any[]
  attachmentConfig?: Record<string, any>

  priority?: ComplaintPriority
  status?: ComplaintStatus

  assignedTo?: UUID | null

  responseText?: string | null
  responseAt?: string | number | Date | null
  resolvedAt?: string | number | Date | null
  closedAt?: string | number | Date | null

  sourceType?: ComplaintSourceType

  metadata?: Record<string, any>
}

export type UpdateComplaintPayload = Partial<CreateComplaintPayload>
