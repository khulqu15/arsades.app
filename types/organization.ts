export type UUID = string

export type OrganizationType =
  | 'government'
  | 'village_government'
  | 'bumdes'
  | 'youth'
  | 'women'
  | 'community'
  | 'religious'
  | 'education'
  | 'health'
  | 'umkm'
  | 'tourism'
  | 'culture'
  | 'security'
  | 'custom'

export type OrganizationStatus = 'active' | 'inactive'

export type OrganizationItem = {
  id: UUID
  tenantId: UUID
  parentId: UUID | null

  organizationType: OrganizationType

  name: string
  displayName: string
  slug: string

  shortDescription: string | null
  description: string | null

  logoUrl: string | null
  coverUrl: string | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  address: string | null
  latitude: number | null
  longitude: number | null

  contact: Record<string, any>
  addressConfig: Record<string, any>
  social: Record<string, any>
  operationalHours: Record<string, any>
  metadata: Record<string, any>

  status: OrganizationStatus
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type OrganizationListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type OrganizationListResponse = {
  data: OrganizationItem[]
  meta: OrganizationListMeta
}

export type OrganizationDetailResponse = {
  data: OrganizationItem
}

export type CreateOrganizationPayload = {
  parentId?: UUID | null
  organizationType?: OrganizationType

  name: string
  displayName?: string
  slug?: string

  shortDescription?: string
  description?: string

  logoUrl?: string | null
  coverUrl?: string | null

  email?: string | null
  phone?: string | null
  whatsapp?: string | null
  websiteUrl?: string | null

  address?: string | null
  latitude?: number | null
  longitude?: number | null

  contact?: Record<string, any>
  addressConfig?: Record<string, any>
  social?: Record<string, any>
  operationalHours?: Record<string, any>
  metadata?: Record<string, any>

  status?: OrganizationStatus
  isFeatured?: boolean
  sortOrder?: number
}

export type UpdateOrganizationPayload = Partial<CreateOrganizationPayload>