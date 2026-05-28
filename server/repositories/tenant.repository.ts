import type { RowDataPacket } from 'mysql2/promise'
import { dbQuery } from '../utils/mysql'

export type TenantRow = RowDataPacket & {
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
}

export async function findTenantBySlug(slug: string) {
  const rows = await dbQuery<TenantRow[]>(
    `
      SELECT
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
        status
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

export async function findTenantByDomain(domain: string) {
  const rows = await dbQuery<TenantRow[]>(
    `
      SELECT
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
        status
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