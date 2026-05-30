import type { TenantSiteConfig } from '../../types/tenant-site'
import {
  findTenantSiteByDomain,
  findTenantSiteBySlug,
  findTenantSiteById,
  createTenantSite,
  updateTenantSiteById,
  softDeleteTenantSiteById,
  type TenantSiteRow,
  type TenantSiteWriteInput
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

function cleanString(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function cleanNullableString(value: unknown) {
  const text = String(value || '').trim()
  return text || null
}

function cleanSlug(value: unknown) {
  return String(value || '')
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function normalizeObject(value: unknown, fallback: Record<string, any> = {}) {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return fallback
  return value as Record<string, any>
}

function normalizeArray(value: unknown, fallback: any[] = []) {
  return Array.isArray(value) ? value : fallback
}

function mergeObject(...items: unknown[]) {
  return items.reduce<Record<string, any>>((result, item) => {
    if (!item || typeof item !== 'object' || Array.isArray(item)) return result

    return {
      ...result,
      ...(item as Record<string, any>)
    }
  }, {})
}

function normalizeTenantType(value: unknown): TenantSiteConfig['tenantType'] {
  const allowed = ['village', 'school', 'pesantren', 'company', 'custom']
  const text = String(value || 'custom').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteConfig['tenantType'] : 'custom'
}

function normalizeSubscriptionPlan(value: unknown): TenantSiteConfig['subscription']['plan'] {
  const allowed = ['free', 'basic', 'pro', 'enterprise', 'custom']
  const text = String(value || 'basic').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteConfig['subscription']['plan'] : 'basic'
}

function normalizeSubscriptionStatus(value: unknown): TenantSiteConfig['subscription']['status'] {
  const allowed = ['trialing', 'active', 'past_due', 'paused', 'canceled', 'expired']
  const text = String(value || 'active').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteConfig['subscription']['status'] : 'active'
}

function buildTenantSiteInput(
  body: any,
  fallbackSlug: string,
  current?: TenantSiteConfig | null
): TenantSiteWriteInput {
  const subscription = {
    ...(current?.subscription || {}),
    ...(body?.subscription || {})
  }

  return {
    name: cleanString(body?.name ?? current?.name, current?.displayName || fallbackSlug),
    displayName: cleanString(
      body?.displayName ?? current?.displayName ?? body?.name ?? current?.name,
      current?.name || fallbackSlug
    ),
    slug: cleanSlug(body?.slug || current?.slug || fallbackSlug),
    tenantType: normalizeTenantType(body?.tenantType ?? current?.tenantType),
    domain: cleanNullableString(body?.domain ?? current?.domain),
    siteUrl: cleanNullableString(body?.siteUrl ?? current?.siteUrl),
    logoUrl: cleanNullableString(body?.logoUrl ?? current?.logoUrl),
    faviconUrl: cleanNullableString(body?.faviconUrl ?? current?.faviconUrl),
    ogImageUrl: cleanNullableString(body?.ogImageUrl ?? current?.ogImageUrl),
    primaryColor: cleanNullableString(body?.primaryColor ?? current?.primaryColor),
    description: cleanNullableString(body?.description ?? current?.description),
    status: body?.status === 'inactive' ? 'inactive' : current?.status || 'active',

    subscription: {
      plan: normalizeSubscriptionPlan(subscription.plan),
      status: normalizeSubscriptionStatus(subscription.status),
      startedAt: subscription.startedAt ?? null,
      endsAt: subscription.endsAt ?? null,
      trialEndsAt: subscription.trialEndsAt ?? null,
      config: normalizeObject(subscription.config)
    },

    features: mergeObject(current?.features, body?.features),
    metadata: mergeObject(current?.metadata, body?.metadata),
    theme: mergeObject(current?.theme, body?.theme),
    seo: mergeObject(current?.seo, body?.seo),
    hero: mergeObject(current?.hero, body?.hero),
    contact: mergeObject(current?.contact, body?.contact),
    statistic: mergeObject(current?.statistic, body?.statistic),
    culture: mergeObject(current?.culture, body?.culture),
    warta: mergeObject(current?.warta, body?.warta),
    footer: mergeObject(current?.footer, body?.footer),
    navigation: normalizeArray(body?.navigation, current?.navigation || []),
    social: mergeObject(current?.social, body?.social)
  }
}

function ensureTenantSlugMatch(row: TenantSiteRow | null, tenantSlug: string) {
  if (!row) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant site tidak ditemukan.'
    })
  }

  if (cleanSlug(row.slug) !== cleanSlug(tenantSlug)) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant site tidak sesuai dengan tenant slug.'
    })
  }

  return row
}

export async function createTenantSiteFromEvent(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))

  if (!tenantSlug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Tenant slug tidak valid.'
    })
  }

  const existing = await findTenantSiteBySlug(tenantSlug)

  if (existing) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Tenant site sudah tersedia.'
    })
  }

  const body = await readBody(event)
  const payload = buildTenantSiteInput(body, tenantSlug, null)
  const created = await createTenantSite(payload)

  if (!created) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Tenant site gagal dibuat.'
    })
  }

  setResponseStatus(event, 201)

  return {
    data: mapTenantSite(created)
  }
}

export async function updateTenantSiteFromEvent(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))

  if (!tenantSlug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Tenant slug tidak valid.'
    })
  }

  const currentRow = await findTenantSiteBySlug(tenantSlug)

  if (!currentRow) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan atau tidak aktif.'
    })
  }

  const body = await readBody(event)
  const current = mapTenantSite(currentRow)
  const payload = buildTenantSiteInput(body, tenantSlug, current)
  const updated = await updateTenantSiteById(currentRow.id, payload)

  if (!updated) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Tenant site gagal diperbarui.'
    })
  }

  return {
    data: mapTenantSite(updated)
  }
}

export async function getTenantSiteByIdFromEvent(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))
  const id = String(getRouterParam(event, 'id') || '').trim()

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID tenant site tidak valid.'
    })
  }

  const row = ensureTenantSlugMatch(await findTenantSiteById(id), tenantSlug)

  return {
    data: mapTenantSite(row)
  }
}

export async function updateTenantSiteByIdFromEvent(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))
  const id = String(getRouterParam(event, 'id') || '').trim()

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID tenant site tidak valid.'
    })
  }

  const currentRow = ensureTenantSlugMatch(await findTenantSiteById(id), tenantSlug)
  const current = mapTenantSite(currentRow)
  const body = await readBody(event)
  const payload = buildTenantSiteInput(body, tenantSlug, current)
  const updated = await updateTenantSiteById(id, payload)

  if (!updated) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Tenant site gagal diperbarui.'
    })
  }

  return {
    data: mapTenantSite(updated)
  }
}

export async function deleteTenantSiteByIdFromEvent(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))
  const id = String(getRouterParam(event, 'id') || '').trim()

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID tenant site tidak valid.'
    })
  }

  ensureTenantSlugMatch(await findTenantSiteById(id), tenantSlug)

  const deleted = await softDeleteTenantSiteById(id)

  if (!deleted) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Tenant site gagal dihapus.'
    })
  }

  return {
    data: mapTenantSite(deleted)
  }
}