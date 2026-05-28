export type UUID = string

export type TenantStatus = 'active' | 'inactive'
export type TenantType = 'village' | 'school' | 'pesantren' | 'company' | 'custom'

export type TenantSubscriptionPlan =
  | 'free'
  | 'basic'
  | 'pro'
  | 'enterprise'
  | 'custom'

export type TenantSubscriptionStatus =
  | 'trialing'
  | 'active'
  | 'past_due'
  | 'paused'
  | 'canceled'
  | 'expired'

export type TenantSubscription = {
  plan: TenantSubscriptionPlan
  status: TenantSubscriptionStatus
  startedAt: number | null
  endsAt: number | null
  trialEndsAt: number | null
  isActive: boolean
  isPro: boolean
  config: Record<string, any>
}

export type TenantSiteFeatures = {
  news?: boolean
  onlineLetter?: boolean
  finance?: boolean
  letterC?: boolean
  [key: string]: any
}

export type TenantSiteConfig = {
  id: UUID
  name: string
  displayName: string
  slug: string
  tenantType: TenantType
  domain: string | null
  siteUrl: string | null
  logoUrl: string | null
  faviconUrl: string | null
  ogImageUrl: string | null
  primaryColor: string | null
  description: string | null
  status: TenantStatus

  subscription: TenantSubscription
  features: TenantSiteFeatures

  theme: Record<string, any>
  seo: Record<string, any>
  hero: Record<string, any>
  contact: Record<string, any>
  statistic: Record<string, any>
  culture: Record<string, any>
  warta: Record<string, any>
  footer: Record<string, any>
  navigation: any[]
  social: Record<string, any>
  metadata: Record<string, any>
}

export type TenantSiteResponse = {
  data: TenantSiteConfig
}