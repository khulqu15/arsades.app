export type UUID = string

export type FacilityType =
  | 'health'
  | 'market'
  | 'education'
  | 'sport'
  | 'emergency'
  | 'transport'
  | 'water'
  | 'public_service'
  | 'office'
  | 'worship'
  | 'tourism'
  | 'security'
  | 'custom'

export type FacilityStatus = 'active' | 'inactive'

export type FacilityItem = {
  id: UUID
  tenantId: UUID

  facilityType: FacilityType

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logoUrl: string | null
  imageUrl: string | null

  contentHtml: string | null
  contentJson: any | null

  address: string | null
  latitude: number | null
  longitude: number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  contact: Record<string, any>
  operationalHours: Record<string, any>
  metadata: Record<string, any>

  status: FacilityStatus
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type FacilityListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type FacilityListResponse = {
  data: FacilityItem[]
  meta: FacilityListMeta
}

export type FacilityDetailResponse = {
  data: FacilityItem
}

export type CreateFacilityPayload = {
  facilityType?: FacilityType

  title: string
  subtitle?: string | null
  slug?: string

  icon?: string | null
  logoUrl?: string | null
  imageUrl?: string | null

  contentHtml?: string | null
  contentJson?: any | null

  address?: string | null
  latitude?: number | null
  longitude?: number | null

  email?: string | null
  phone?: string | null
  whatsapp?: string | null
  websiteUrl?: string | null

  contact?: Record<string, any>
  operationalHours?: Record<string, any>
  metadata?: Record<string, any>

  status?: FacilityStatus
  isFeatured?: boolean
  sortOrder?: number
}

export type UpdateFacilityPayload = Partial<CreateFacilityPayload>