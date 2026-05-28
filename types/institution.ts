    export type UUID = string

export type InstitutionStatus = 'active' | 'inactive'

export type InstitutionContent = {
  html?: string
  json?: any
}

export type InstitutionItem = {
  id: UUID
  tenantId: UUID

  title: string
  subtitle: string | null
  slug: string

  icon: string | null
  logoUrl: string | null

  contentHtml: string | null
  contentJson: any | null

  status: InstitutionStatus
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type InstitutionListMeta = {
  page: number
  limit: number
  total: number
  totalPages: number
}

export type InstitutionListResponse = {
  data: InstitutionItem[]
  meta: InstitutionListMeta
}

export type InstitutionDetailResponse = {
  data: InstitutionItem
}

export type CreateInstitutionPayload = {
  title: string
  subtitle?: string | null
  slug?: string

  icon?: string | null
  logoUrl?: string | null

  contentHtml?: string | null
  contentJson?: any | null

  status?: InstitutionStatus
  isFeatured?: boolean
  sortOrder?: number
}

export type UpdateInstitutionPayload = Partial<CreateInstitutionPayload>