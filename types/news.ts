export type UUID = string

export type TenantStatus = 'active' | 'inactive'
export type NewsStatus = 'draft' | 'published' | 'archived'

export type Tenant = {
  id: UUID
  name: string
  displayName: string
  slug: string
  tenantType: 'village' | 'school' | 'pesantren' | 'company' | 'custom'
  domain: string | null
  siteUrl: string | null
  logoUrl: string | null
  faviconUrl: string | null
  ogImageUrl: string | null
  primaryColor: string | null
  description: string | null
  status: TenantStatus
}

export type NewsItem = {
  id: UUID
  tenantId: UUID

  title: string
  slug: string

  descriptionCard: string
  descriptionContent: string

  excerpt: string
  cover: string
  coverUrl: string | null

  category: string | null
  categorySlug: string | null
  categoryId: UUID | null

  tags: string[]
  tagSlugs: string[]

  status: NewsStatus
  readTime: number
  publishedAt: number
  createdAt: number
  updatedAt: number
}

export type NewsListResponse = {
  data: NewsItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

export type CreateNewsPayload = {
  title: string
  slug?: string

  categoryId?: UUID | null
  categorySlug?: string | null
  categoryName?: string | null

  tagNames?: string[]
  tagSlugs?: string[]

  descriptionCard?: string
  descriptionContent?: string

  coverUrl?: string | null
  status?: NewsStatus
  publishedAt?: string | null
}

export type UpdateNewsPayload = Partial<CreateNewsPayload>