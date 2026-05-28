export type UUID = string

export type MetricPeriodType =
  | 'realtime'
  | 'daily'
  | 'weekly'
  | 'monthly'
  | 'yearly'
  | 'custom'

export type MetricComparisonDirection = 'up' | 'down' | 'same'

export type PublicMetricItem = {
  id: UUID
  tenantId: UUID

  metricGroup: string
  metricKey: string

  label: string
  description: string | null

  valueDecimal: number | null
  valueText: string | null
  valueUnit: string | null

  comparisonValue: number | null
  comparisonUnit: string | null
  comparisonDirection: MetricComparisonDirection | null

  periodType: MetricPeriodType

  icon: string | null
  color: string | null

  metadata: Record<string, any>

  sortOrder: number
  updatedAt: number
}

export type OfficialAttendanceStatus =
  | 'present'
  | 'away'
  | 'leave'
  | 'inactive'
  | 'unknown'

export type VillageOfficialItem = {
  id: UUID
  tenantId: UUID

  name: string
  slug: string

  positionTitle: string
  positionCode: string | null

  shortDescription: string | null
  contentHtml: string | null
  contentJson: any | null

  photoUrl: string | null
  icon: string | null

  phone: string | null
  whatsapp: string | null
  email: string | null

  attendanceStatus: OfficialAttendanceStatus
  attendanceLabel: string | null

  termStart: string | null
  termEnd: string | null

  social: Record<string, any>
  metadata: Record<string, any>

  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type BudgetLineType = 'revenue' | 'expense' | 'financing'

export type BudgetLineItem = {
  id: UUID
  budgetPeriodId: UUID
  parentId: UUID | null

  lineType: BudgetLineType

  lineGroup: string | null
  lineCode: string | null

  title: string
  slug: string
  description: string | null

  budgetAmount: number
  realizedAmount: number
  realizationPercent: number

  unit: string | null

  icon: string | null
  color: string | null

  metadata: Record<string, any>

  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number

  createdAt: number
  updatedAt: number
}

export type BudgetSummaryItem = {
  type: BudgetLineType
  label: string
  budgetAmount: number
  realizedAmount: number
  realizationPercent: number
}

export type VillageBudgetPeriodItem = {
  id: UUID
  tenantId: UUID

  budgetYear: number

  title: string
  subtitle: string | null

  currencyCode: string

  legalBasis: string | null
  sourceName: string | null
  sourceUrl: string | null

  notes: string | null

  metadata: Record<string, any>

  status: 'draft' | 'published' | 'archived'
  isCurrent: boolean

  summary: BudgetSummaryItem[]

  revenueLines: BudgetLineItem[]
  expenseLines: BudgetLineItem[]
  financingLines: BudgetLineItem[]

  createdAt: number
  updatedAt: number
}

export type PublicDashboardResponse = {
  data: {
    visitorStats: {
      title: string
      subtitle: string
      realtime: boolean
      today: number
      yesterday: number
      total: number
      comparisonPercent: number
      metrics: PublicMetricItem[]
    }

    officials: {
      title: string
      subtitle: string
      items: VillageOfficialItem[]
    }

    budget: VillageBudgetPeriodItem | null
  }
}