import type {
  BudgetLineItem,
  BudgetLineType,
  BudgetSummaryItem,
  PublicMetricItem,
  VillageBudgetPeriodItem,
  VillageOfficialItem
} from '../../types/public-dashboard'

import {
  findBudgetLinesByPeriodId,
  findCurrentVillageBudgetPeriod,
  findPublicMetricsByGroup,
  findVillageBudgetPeriodByYear,
  findVillageOfficials,
  type BudgetLineRow,
  type BudgetPeriodRow,
  type PublicMetricRow,
  type VillageOfficialRow
} from '../repositories/public-dashboard.repository'

function parseJson<T = any>(value: unknown, fallback: T): T {
  if (!value) return fallback

  if (typeof value === 'object') return value as T

  if (typeof value === 'string') {
    try {
      return JSON.parse(value) as T
    } catch {
      return fallback
    }
  }

  return fallback
}

function toNumber(value: unknown, fallback = 0) {
  if (value === null || typeof value === 'undefined') return fallback

  const number = Number(value)

  return Number.isNaN(number) ? fallback : number
}

function toTimestamp(value: Date | string | null | undefined) {
  if (!value) return Date.now()

  const time = new Date(value).getTime()

  return Number.isNaN(time) ? Date.now() : time
}

function toDateOnly(value: string | Date | null) {
  if (!value) return null

  const date = new Date(value)

  if (Number.isNaN(date.getTime())) return null

  return date.toISOString().slice(0, 10)
}

function calculatePercent(realized: number, budget: number) {
  if (!budget) return 0

  return Number(((realized / budget) * 100).toFixed(2))
}

function mapPublicMetric(row: PublicMetricRow): PublicMetricItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,

    metricGroup: row.metric_group,
    metricKey: row.metric_key,

    label: row.label,
    description: row.description,

    valueDecimal:
      row.value_decimal === null
        ? null
        : toNumber(row.value_decimal),

    valueText: row.value_text,
    valueUnit: row.value_unit,

    comparisonValue:
      row.comparison_value === null
        ? null
        : toNumber(row.comparison_value),

    comparisonUnit: row.comparison_unit,
    comparisonDirection: row.comparison_direction,

    periodType: row.period_type,

    icon: row.icon,
    color: row.color,

    metadata: parseJson(row.metadata, {}),

    sortOrder: Number(row.sort_order || 0),
    updatedAt: toTimestamp(row.updated_at)
  }
}

function mapOfficial(row: VillageOfficialRow): VillageOfficialItem {
  return {
    id: row.id,
    tenantId: row.tenant_id,

    name: row.name,
    slug: row.slug,

    positionTitle: row.position_title,
    positionCode: row.position_code,

    shortDescription: row.short_description,
    contentHtml: row.content_html,
    contentJson: parseJson(row.content_json, null),

    photoUrl: row.photo_url,
    icon: row.icon,

    phone: row.phone,
    whatsapp: row.whatsapp,
    email: row.email,

    attendanceStatus: row.attendance_status,
    attendanceLabel: row.attendance_label,

    termStart: toDateOnly(row.term_start),
    termEnd: toDateOnly(row.term_end),

    social: parseJson(row.social_config, {}),
    metadata: parseJson(row.metadata, {}),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

function mapBudgetLine(row: BudgetLineRow): BudgetLineItem {
  const budgetAmount = toNumber(row.budget_amount)
  const realizedAmount = toNumber(row.realized_amount)

  return {
    id: row.id,
    budgetPeriodId: row.budget_period_id,
    parentId: row.parent_id,

    lineType: row.line_type,

    lineGroup: row.line_group,
    lineCode: row.line_code,

    title: row.title,
    slug: row.slug,
    description: row.description,

    budgetAmount,
    realizedAmount,
    realizationPercent: calculatePercent(realizedAmount, budgetAmount),

    unit: row.unit,

    icon: row.icon,
    color: row.color,

    metadata: parseJson(row.metadata, {}),

    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),

    createdAt: toTimestamp(row.created_at),
    updatedAt: toTimestamp(row.updated_at)
  }
}

function createBudgetSummary(lines: BudgetLineItem[]): BudgetSummaryItem[] {
  const labels: Record<BudgetLineType, string> = {
    revenue: 'Pendapatan',
    expense: 'Belanja',
    financing: 'Pembiayaan'
  }

  const types: BudgetLineType[] = ['revenue', 'expense', 'financing']

  return types.map((type) => {
    const filtered = lines.filter((item) => item.lineType === type)

    const budgetAmount = filtered.reduce(
      (total, item) => total + item.budgetAmount,
      0
    )

    const realizedAmount = filtered.reduce(
      (total, item) => total + item.realizedAmount,
      0
    )

    return {
      type,
      label: labels[type],
      budgetAmount,
      realizedAmount,
      realizationPercent: calculatePercent(realizedAmount, budgetAmount)
    }
  })
}

function mapBudgetPeriod(
  period: BudgetPeriodRow,
  lines: BudgetLineItem[]
): VillageBudgetPeriodItem {
  return {
    id: period.id,
    tenantId: period.tenant_id,

    budgetYear: Number(period.budget_year),

    title: period.title,
    subtitle: period.subtitle,

    currencyCode: period.currency_code,

    legalBasis: period.legal_basis,
    sourceName: period.source_name,
    sourceUrl: period.source_url,

    notes: period.notes,

    metadata: parseJson(period.metadata, {}),

    status: period.status,
    isCurrent: Boolean(period.is_current),

    summary: createBudgetSummary(lines),

    revenueLines: lines.filter((item) => item.lineType === 'revenue'),
    expenseLines: lines.filter((item) => item.lineType === 'expense'),
    financingLines: lines.filter((item) => item.lineType === 'financing'),

    createdAt: toTimestamp(period.created_at),
    updatedAt: toTimestamp(period.updated_at)
  }
}

export async function getTenantVisitorStats(tenantId: string) {
  const rows = await findPublicMetricsByGroup(
    tenantId,
    'visitor_statistics'
  )

  const metrics = rows.map(mapPublicMetric)

  const today = metrics.find((item) => item.metricKey === 'today_visitors')
  const yesterday = metrics.find((item) => item.metricKey === 'yesterday_visitors')
  const total = metrics.find((item) => item.metricKey === 'total_visitors')

  return {
    title: 'Statistik Pengunjung',
    subtitle: 'Dipantau secara realtime',
    realtime: true,
    today: toNumber(today?.valueDecimal),
    yesterday: toNumber(yesterday?.valueDecimal),
    total: toNumber(total?.valueDecimal),
    comparisonPercent: toNumber(today?.comparisonValue),
    metrics
  }
}

export async function getTenantOfficials(tenantId: string, limit = 10) {
  const safeLimit = Math.min(
    Math.max(Number.isFinite(Number(limit)) ? Math.trunc(Number(limit)) : 10, 1),
    50
  )

  const rows = await findVillageOfficials(tenantId, safeLimit)

  return {
    title: 'Aparatur Desa',
    subtitle: 'Profil perangkat aktif',
    items: rows.map(mapOfficial)
  }
}

export async function getTenantVillageBudget(
  tenantId: string,
  year?: number
) {
  const period = year
    ? await findVillageBudgetPeriodByYear(tenantId, year)
    : await findCurrentVillageBudgetPeriod(tenantId)

  if (!period) return null

  const lineRows = await findBudgetLinesByPeriodId(period.id)
  const lines = lineRows.map(mapBudgetLine)

  return mapBudgetPeriod(period, lines)
}

export async function getTenantPublicDashboard(
  tenantId: string,
  options?: {
    year?: number
    officialsLimit?: number
  }
) {
  const [visitorStats, officials, budget] = await Promise.all([
    getTenantVisitorStats(tenantId),
    getTenantOfficials(tenantId, options?.officialsLimit || 10),
    getTenantVillageBudget(tenantId, options?.year)
  ])

  return {
    data: {
      visitorStats,
      officials,
      budget
    }
  }
}