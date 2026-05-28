import type { RowDataPacket } from 'mysql2/promise'
import { dbQuery } from '../utils/mysql'

export type PublicMetricRow = RowDataPacket & {
  id: string
  tenant_id: string

  metric_group: string
  metric_key: string

  label: string
  description: string | null

  value_decimal: string | number | null
  value_text: string | null
  value_unit: string | null

  comparison_value: string | number | null
  comparison_unit: string | null
  comparison_direction: 'up' | 'down' | 'same' | null

  period_type: 'realtime' | 'daily' | 'weekly' | 'monthly' | 'yearly' | 'custom'

  icon: string | null
  color: string | null

  metadata: unknown

  sort_order: number
  updated_at: Date | string
}

export type VillageOfficialRow = RowDataPacket & {
  id: string
  tenant_id: string

  name: string
  slug: string

  position_title: string
  position_code: string | null

  short_description: string | null
  content_html: string | null
  content_json: unknown

  photo_url: string | null
  icon: string | null

  phone: string | null
  whatsapp: string | null
  email: string | null

  attendance_status: 'present' | 'away' | 'leave' | 'inactive' | 'unknown'
  attendance_label: string | null

  term_start: string | Date | null
  term_end: string | Date | null

  social_config: unknown
  metadata: unknown

  status: 'active' | 'inactive'
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export type BudgetPeriodRow = RowDataPacket & {
  id: string
  tenant_id: string

  budget_year: number

  title: string
  subtitle: string | null

  currency_code: string

  legal_basis: string | null
  source_name: string | null
  source_url: string | null

  notes: string | null

  metadata: unknown

  status: 'draft' | 'published' | 'archived'
  is_current: number

  created_at: Date | string
  updated_at: Date | string
}

export type BudgetLineRow = RowDataPacket & {
  id: string
  budget_period_id: string
  parent_id: string | null

  line_type: 'revenue' | 'expense' | 'financing'

  line_group: string | null
  line_code: string | null

  title: string
  slug: string
  description: string | null

  budget_amount: string | number
  realized_amount: string | number

  unit: string | null

  icon: string | null
  color: string | null

  metadata: unknown

  status: 'active' | 'inactive'
  is_featured: number
  sort_order: number

  created_at: Date | string
  updated_at: Date | string
}

export async function findPublicMetricsByGroup(
  tenantId: string,
  metricGroup: string
) {
  const rows = await dbQuery<PublicMetricRow[]>(
    `
      SELECT
        id,
        tenant_id,
        metric_group,
        metric_key,
        label,
        description,
        value_decimal,
        value_text,
        value_unit,
        comparison_value,
        comparison_unit,
        comparison_direction,
        period_type,
        icon,
        color,
        metadata,
        sort_order,
        updated_at
      FROM tenant_public_metrics
      WHERE tenant_id = ?
      AND metric_group = ?
      AND status = 'active'
      AND deleted_at IS NULL
      ORDER BY sort_order ASC, created_at ASC
    `,
    [tenantId, metricGroup]
  )

  return rows
}

export async function findVillageOfficials(tenantId: string, limit = 10) {
  const safeLimit = Math.min(
    Math.max(Number.isFinite(Number(limit)) ? Math.trunc(Number(limit)) : 10, 1),
    50
  )

  const rows = await dbQuery<VillageOfficialRow[]>(
    `
      SELECT
        id,
        tenant_id,
        name,
        slug,
        position_title,
        position_code,
        short_description,
        content_html,
        content_json,
        photo_url,
        icon,
        phone,
        whatsapp,
        email,
        attendance_status,
        attendance_label,
        term_start,
        term_end,
        social_config,
        metadata,
        status,
        is_featured,
        sort_order,
        created_at,
        updated_at
      FROM village_officials
      WHERE tenant_id = ?
      AND status = 'active'
      AND deleted_at IS NULL
      ORDER BY is_featured DESC, sort_order ASC, created_at ASC
      LIMIT ${safeLimit}
    `,
    [tenantId]
  )

  return rows
}

export async function findVillageBudgetPeriodByYear(
  tenantId: string,
  year: number
) {
  const rows = await dbQuery<BudgetPeriodRow[]>(
    `
      SELECT
        id,
        tenant_id,
        budget_year,
        title,
        subtitle,
        currency_code,
        legal_basis,
        source_name,
        source_url,
        notes,
        metadata,
        status,
        is_current,
        created_at,
        updated_at
      FROM village_budget_periods
      WHERE tenant_id = ?
      AND budget_year = ?
      AND status = 'published'
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, year]
  )

  return rows[0] || null
}

export async function findCurrentVillageBudgetPeriod(tenantId: string) {
  const rows = await dbQuery<BudgetPeriodRow[]>(
    `
      SELECT
        id,
        tenant_id,
        budget_year,
        title,
        subtitle,
        currency_code,
        legal_basis,
        source_name,
        source_url,
        notes,
        metadata,
        status,
        is_current,
        created_at,
        updated_at
      FROM village_budget_periods
      WHERE tenant_id = ?
      AND is_current = 1
      AND status = 'published'
      AND deleted_at IS NULL
      ORDER BY budget_year DESC
      LIMIT 1
    `,
    [tenantId]
  )

  return rows[0] || null
}

export async function findBudgetLinesByPeriodId(budgetPeriodId: string) {
  const rows = await dbQuery<BudgetLineRow[]>(
    `
      SELECT
        id,
        budget_period_id,
        parent_id,
        line_type,
        line_group,
        line_code,
        title,
        slug,
        description,
        budget_amount,
        realized_amount,
        unit,
        icon,
        color,
        metadata,
        status,
        is_featured,
        sort_order,
        created_at,
        updated_at
      FROM village_budget_lines
      WHERE budget_period_id = ?
      AND status = 'active'
      AND deleted_at IS NULL
      ORDER BY line_type ASC, sort_order ASC, created_at ASC
    `,
    [budgetPeriodId]
  )

  return rows
}