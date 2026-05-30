import type { RowDataPacket } from 'mysql2/promise'
import { dbQuery } from '../utils/mysql'

export type TenantSiteRow = RowDataPacket & {
  id: string
  name: string
  display_name: string | null
  slug: string
  tenant_type: 'village' | 'school' | 'pesantren' | 'company' | 'custom'
  domain: string | null
  site_url: string | null
  logo_url: string | null
  favicon_url: string | null
  og_image_url: string | null
  primary_color: string | null
  description: string | null
  status: 'active' | 'inactive'

  metadata: unknown
  theme_config: unknown
  seo_config: unknown
  hero_config: unknown
  contact_config: unknown
  statistic_config: unknown
  culture_config: unknown
  warta_config: unknown
  footer_config: unknown
  navigation_config: unknown
  social_config: unknown

  subscription_plan: 'free' | 'basic' | 'pro' | 'enterprise' | 'custom'
  subscription_status: 'trialing' | 'active' | 'past_due' | 'paused' | 'canceled' | 'expired'
  subscription_started_at: Date | string | null
  subscription_ends_at: Date | string | null
  trial_ends_at: Date | string | null
  subscription_config: unknown
  feature_config: unknown
}

const tenantSiteColumns = `
  id,
  name,
  display_name,
  slug,
  tenant_type,
  domain,
  site_url,
  logo_url,
  favicon_url,
  og_image_url,
  primary_color,
  description,
  status,
  metadata,
  theme_config,
  seo_config,
  hero_config,
  contact_config,
  statistic_config,
  culture_config,
  warta_config,
  footer_config,
  navigation_config,
  social_config,
  subscription_plan,
  subscription_status,
  subscription_started_at,
  subscription_ends_at,
  trial_ends_at,
  subscription_config,
  feature_config
`

export async function findTenantSiteBySlug(slug: string) {
  const rows = await dbQuery<TenantSiteRow[]>(
    `
      SELECT ${tenantSiteColumns}
      FROM tenants
      WHERE slug = ?
      AND status = 'active'
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [slug]
  )

  return rows[0] || null
}

export async function findTenantSiteByDomain(domain: string) {
  const rows = await dbQuery<TenantSiteRow[]>(
    `
      SELECT ${tenantSiteColumns}
      FROM tenants
      WHERE domain = ?
      AND status = 'active'
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [domain]
  )

  return rows[0] || null
}

export type TenantSiteWriteInput = {
  id?: string
  name?: string
  displayName?: string
  slug?: string
  tenantType?: 'village' | 'school' | 'pesantren' | 'company' | 'custom'
  domain?: string | null
  siteUrl?: string | null
  logoUrl?: string | null
  faviconUrl?: string | null
  ogImageUrl?: string | null
  primaryColor?: string | null
  description?: string | null
  status?: 'active' | 'inactive'

  metadata?: Record<string, any>
  theme?: Record<string, any>
  seo?: Record<string, any>
  hero?: Record<string, any>
  contact?: Record<string, any>
  statistic?: Record<string, any>
  culture?: Record<string, any>
  warta?: Record<string, any>
  footer?: Record<string, any>
  navigation?: any[]
  social?: Record<string, any>

  subscription?: {
    plan?: 'free' | 'basic' | 'pro' | 'enterprise' | 'custom'
    status?: 'trialing' | 'active' | 'past_due' | 'paused' | 'canceled' | 'expired'
    startedAt?: number | string | Date | null
    endsAt?: number | string | Date | null
    trialEndsAt?: number | string | Date | null
    config?: Record<string, any>
  }

  features?: Record<string, any>
}

function jsonValue(value: unknown, fallback: any) {
  if (value === undefined || value === null) return JSON.stringify(fallback)
  return JSON.stringify(value)
}

function nullable(value: unknown) {
  const text = String(value || '').trim()
  return text || null
}

function cleanText(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function cleanSlug(value: unknown) {
  return String(value || '')
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function toDate(value: unknown) {
  if (!value) return null

  if (value instanceof Date) {
    return Number.isNaN(value.getTime()) ? null : value
  }

  if (typeof value === 'number') {
    const date = new Date(value)
    return Number.isNaN(date.getTime()) ? null : date
  }

  const date = new Date(value as any)
  return Number.isNaN(date.getTime()) ? null : date
}

function normalizeTenantType(value: unknown): TenantSiteRow['tenant_type'] {
  const allowed = ['village', 'school', 'pesantren', 'company', 'custom']
  const text = String(value || 'custom').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteRow['tenant_type'] : 'custom'
}

function normalizeSubscriptionPlan(value: unknown): TenantSiteRow['subscription_plan'] {
  const allowed = ['free', 'basic', 'pro', 'enterprise', 'custom']
  const text = String(value || 'basic').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteRow['subscription_plan'] : 'basic'
}

function normalizeSubscriptionStatus(value: unknown): TenantSiteRow['subscription_status'] {
  const allowed = ['trialing', 'active', 'past_due', 'paused', 'canceled', 'expired']
  const text = String(value || 'active').trim().toLowerCase()
  return allowed.includes(text) ? text as TenantSiteRow['subscription_status'] : 'active'
}

function normalizeWriteInput(input: TenantSiteWriteInput) {
  const subscription = input.subscription || {}

  return {
    id: input.id || crypto.randomUUID(),
    name: cleanText(input.name, 'Website'),
    display_name: cleanText(input.displayName || input.name, 'Website'),
    slug: cleanSlug(input.slug),
    tenant_type: normalizeTenantType(input.tenantType),
    domain: nullable(input.domain),
    site_url: nullable(input.siteUrl),
    logo_url: nullable(input.logoUrl),
    favicon_url: nullable(input.faviconUrl),
    og_image_url: nullable(input.ogImageUrl),
    primary_color: nullable(input.primaryColor),
    description: nullable(input.description),
    status: input.status === 'inactive' ? 'inactive' : 'active',

    metadata: jsonValue(input.metadata, {}),
    theme_config: jsonValue(input.theme, {}),
    seo_config: jsonValue(input.seo, {}),
    hero_config: jsonValue(input.hero, {}),
    contact_config: jsonValue(input.contact, {}),
    statistic_config: jsonValue(input.statistic, {}),
    culture_config: jsonValue(input.culture, {}),
    warta_config: jsonValue(input.warta, {}),
    footer_config: jsonValue(input.footer, {}),
    navigation_config: jsonValue(Array.isArray(input.navigation) ? input.navigation : [], []),
    social_config: jsonValue(input.social, {}),

    subscription_plan: normalizeSubscriptionPlan(subscription.plan),
    subscription_status: normalizeSubscriptionStatus(subscription.status),
    subscription_started_at: toDate(subscription.startedAt),
    subscription_ends_at: toDate(subscription.endsAt),
    trial_ends_at: toDate(subscription.trialEndsAt),
    subscription_config: jsonValue(subscription.config, {}),
    feature_config: jsonValue(input.features, {})
  }
}

export async function findTenantSiteById(id: string) {
  const rows = await dbQuery<TenantSiteRow[]>(
    `
      SELECT ${tenantSiteColumns}
      FROM tenants
      WHERE id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [id]
  )

  return rows[0] || null
}

export async function findTenantSiteByIdIncludingDeleted(id: string) {
  const rows = await dbQuery<TenantSiteRow[]>(
    `
      SELECT ${tenantSiteColumns}
      FROM tenants
      WHERE id = ?
      LIMIT 1
    `,
    [id]
  )

  return rows[0] || null
}

export async function createTenantSite(input: TenantSiteWriteInput) {
  const row = normalizeWriteInput(input)

  await dbQuery(
    `
      INSERT INTO tenants (
        id,
        name,
        display_name,
        slug,
        tenant_type,
        domain,
        site_url,
        logo_url,
        favicon_url,
        og_image_url,
        primary_color,
        description,
        status,
        metadata,
        theme_config,
        seo_config,
        hero_config,
        contact_config,
        statistic_config,
        culture_config,
        warta_config,
        footer_config,
        navigation_config,
        social_config,
        subscription_plan,
        subscription_status,
        subscription_started_at,
        subscription_ends_at,
        trial_ends_at,
        subscription_config,
        feature_config,
        created_at,
        updated_at
      )
      VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?, ?,
        NOW(), NOW()
      )
    `,
    [
      row.id,
      row.name,
      row.display_name,
      row.slug,
      row.tenant_type,
      row.domain,
      row.site_url,
      row.logo_url,
      row.favicon_url,
      row.og_image_url,
      row.primary_color,
      row.description,
      row.status,

      row.metadata,
      row.theme_config,
      row.seo_config,
      row.hero_config,
      row.contact_config,
      row.statistic_config,
      row.culture_config,
      row.warta_config,
      row.footer_config,
      row.navigation_config,
      row.social_config,

      row.subscription_plan,
      row.subscription_status,
      row.subscription_started_at,
      row.subscription_ends_at,
      row.trial_ends_at,
      row.subscription_config,
      row.feature_config
    ]
  )

  return findTenantSiteById(row.id)
}

export async function updateTenantSiteById(id: string, input: TenantSiteWriteInput) {
  const row = normalizeWriteInput({
    ...input,
    id
  })

  await dbQuery(
    `
      UPDATE tenants
      SET
        name = ?,
        display_name = ?,
        slug = ?,
        tenant_type = ?,
        domain = ?,
        site_url = ?,
        logo_url = ?,
        favicon_url = ?,
        og_image_url = ?,
        primary_color = ?,
        description = ?,
        status = ?,
        metadata = ?,
        theme_config = ?,
        seo_config = ?,
        hero_config = ?,
        contact_config = ?,
        statistic_config = ?,
        culture_config = ?,
        warta_config = ?,
        footer_config = ?,
        navigation_config = ?,
        social_config = ?,
        subscription_plan = ?,
        subscription_status = ?,
        subscription_started_at = ?,
        subscription_ends_at = ?,
        trial_ends_at = ?,
        subscription_config = ?,
        feature_config = ?,
        updated_at = NOW()
      WHERE id = ?
      AND deleted_at IS NULL
    `,
    [
      row.name,
      row.display_name,
      row.slug,
      row.tenant_type,
      row.domain,
      row.site_url,
      row.logo_url,
      row.favicon_url,
      row.og_image_url,
      row.primary_color,
      row.description,
      row.status,

      row.metadata,
      row.theme_config,
      row.seo_config,
      row.hero_config,
      row.contact_config,
      row.statistic_config,
      row.culture_config,
      row.warta_config,
      row.footer_config,
      row.navigation_config,
      row.social_config,

      row.subscription_plan,
      row.subscription_status,
      row.subscription_started_at,
      row.subscription_ends_at,
      row.trial_ends_at,
      row.subscription_config,
      row.feature_config,

      id
    ]
  )

  return findTenantSiteById(id)
}

export async function softDeleteTenantSiteById(id: string) {
  await dbQuery(
    `
      UPDATE tenants
      SET
        status = 'inactive',
        deleted_at = NOW(),
        updated_at = NOW()
      WHERE id = ?
      AND deleted_at IS NULL
    `,
    [id]
  )

  return findTenantSiteByIdIncludingDeleted(id)
}