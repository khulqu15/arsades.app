import type { Tenant } from '../../types/news'
import {
  findTenantByDomain,
  findTenantBySlug,
  type TenantRow
} from '../repositories/tenant.repository'

function mapTenant(row: TenantRow): Tenant {
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
    status: row.status
  }
}

export async function resolveTenantBySlug(tenantSlug: string) {
  const tenant = await findTenantBySlug(tenantSlug)

  if (!tenant) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan atau tidak aktif.'
    })
  }

  return mapTenant(tenant)
}

export async function resolveTenantFromEvent(event: any) {
  const tenantSlug = getRouterParam(event, 'tenantSlug')

  if (tenantSlug) {
    return resolveTenantBySlug(tenantSlug)
  }

  const host = getHeader(event, 'host')?.split(':')[0]

  if (host) {
    const tenant = await findTenantByDomain(host)

    if (tenant) {
      return mapTenant(tenant)
    }
  }

  throw createError({
    statusCode: 400,
    statusMessage: 'Tenant tidak valid.'
  })
}