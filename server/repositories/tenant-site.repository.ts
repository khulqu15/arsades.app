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