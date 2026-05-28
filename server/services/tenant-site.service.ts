import type { TenantSiteConfig } from '../../types/tenant-site'
import {
  findTenantSiteByDomain,
  findTenantSiteBySlug,
  type TenantSiteRow
} from '../repositories/tenant-site.repository'

function parseJson<T = any>(value: unknown, fallback: T): T {
  if (!value) return fallback

  if (typeof value === 'object') {
    return value as T
  }

  if (typeof value === 'string') {
    try {
      return JSON.parse(value) as T
    } catch {
      return fallback
    }
  }

  return fallback
}

function toTimestamp(value: unknown) {
  if (!value) return null
  const time = new Date(value as any).getTime()
  return Number.isNaN(time) ? null : time
}

function isSubscriptionActive(status: string, endsAt: number | null) {
  const validStatus = ['trialing', 'active'].includes(status)
  if (!validStatus) return false
  if (!endsAt) return true
  return endsAt >= Date.now()
}

function resolveIsPro(plan: string, status: string, endsAt: number | null, features: Record<string, any>) {
  const active = isSubscriptionActive(status, endsAt)
  if (!active) return false
  if (features?.onlineLetter === true) return true
  return ['pro', 'enterprise'].includes(plan)
}

function mapTenantSite(row: TenantSiteRow): TenantSiteConfig {
  const features = parseJson(row.feature_config, {})
  const subscriptionConfig = parseJson(row.subscription_config, {})

  const plan = row.subscription_plan || 'basic'
  const subscriptionStatus = row.subscription_status || 'active'

  const startedAt = toTimestamp(row.subscription_started_at)
  const endsAt = toTimestamp(row.subscription_ends_at)
  const trialEndsAt = toTimestamp(row.trial_ends_at)

  const isActive = isSubscriptionActive(subscriptionStatus, endsAt)
  const isPro = resolveIsPro(plan, subscriptionStatus, endsAt, features)

  return {
    id: row.id,
    name: row.name,
    displayName: row.display_name || row.name,
    slug: row.slug,
    tenantType: row.tenant_type,
    domain: row.domain,
    siteUrl: row.site_url,
    logoUrl: row.logo_url,
    faviconUrl: row.favicon_url,
    ogImageUrl: row.og_image_url,
    primaryColor: row.primary_color,
    description: row.description,
    status: row.status,

    subscription: {
      plan,
      status: subscriptionStatus,
      startedAt,
      endsAt,
      trialEndsAt,
      isActive,
      isPro,
      config: subscriptionConfig
    },

    features,

    metadata: parseJson(row.metadata, {}),
    theme: parseJson(row.theme_config, {}),
    seo: parseJson(row.seo_config, {}),
    hero: parseJson(row.hero_config, {}),
    contact: parseJson(row.contact_config, {}),
    statistic: parseJson(row.statistic_config, {}),
    culture: parseJson(row.culture_config, {}),
    warta: parseJson(row.warta_config, {}),
    footer: parseJson(row.footer_config, {}),
    navigation: parseJson(row.navigation_config, []),
    social: parseJson(row.social_config, {})
  }
}

export async function getTenantSiteBySlug(slug: string) {
  const tenant = await findTenantSiteBySlug(slug)

  if (!tenant) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan atau tidak aktif.'
    })
  }

  return {
    data: mapTenantSite(tenant)
  }
}

export async function getTenantSiteFromEvent(event: any) {
  const tenantSlug = getRouterParam(event, 'tenantSlug')

  if (tenantSlug) {
    return getTenantSiteBySlug(tenantSlug)
  }

  const host = getHeader(event, 'host')?.split(':')[0]

  if (host) {
    const tenant = await findTenantSiteByDomain(host)

    if (tenant) {
      return {
        data: mapTenantSite(tenant)
      }
    }
  }

  throw createError({
    statusCode: 400,
    statusMessage: 'Tenant tidak valid.'
  })
}