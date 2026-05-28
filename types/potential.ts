export type UUID = string

export type PotentialType =
  | 'agriculture'
  | 'livestock'
  | 'fishery'
  | 'umkm'
  | 'tourism'
  | 'culture'
  | 'natural_resource'
  | 'human_resource'
  | 'industry'
  | 'creative_economy'
  | 'food'
  | 'craft'
  | 'custom'

export type PotentialStatus = 'active' | 'inactive'

export type PotentialItem = {
  id: UUID
  tenantId: UUID

  potentialType: PotentialType

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

  ownerName: string | null
  managerName: string | null

  productionCapacity: string | null
  productionUnit: string | null
  marketReach: string | null
  estimatedValue: number | null

  email: string | null
  phone: string | null
  whatsapp: string | null
  websiteUrl: string | null

  contact: Record<string, any>
  statistic: Record<string, any>
  metadata: Record<string, any>

  status: PotentialStatus
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type PotentialListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type PotentialListResponse = {
  data: PotentialItem[]
  meta: PotentialListMeta
}

export type PotentialDetailResponse = {
  data: PotentialItem
}

export type CreatePotentialPayload = {
  potentialType?: PotentialType

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

  ownerName?: string | null
  managerName?: string | null

  productionCapacity?: string | null
  productionUnit?: string | null
  marketReach?: string | null
  estimatedValue?: number | null

  email?: string | null
  phone?: string | null
  whatsapp?: string | null
  websiteUrl?: string | null

  contact?: Record<string, any>
  statistic?: Record<string, any>
  metadata?: Record<string, any>

  status?: PotentialStatus
  isFeatured?: boolean
  sortOrder?: number
}

export type UpdatePotentialPayload = Partial<CreatePotentialPayload>