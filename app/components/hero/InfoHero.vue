<template>
  <section
    id="statistik-desa"
    aria-label="Statistik Desa dan APBDes"
    class="relative isolate overflow-hidden bg-slate-50 py-20 text-slate-950 sm:py-24"
  >
    <!-- Background -->
    <div class="pointer-events-none absolute inset-0 -z-10">
      <div class="absolute inset-0 bg-[linear-linear(to_right,#e2e8f0_1px,transparent_1px),linear-linear(to_bottom,#e2e8f0_1px,transparent_1px)] bg-size-[44px_44px] opacity-40"></div>
      <div class="absolute -right-36 bottom-0 h-[520px] w-[520px] rounded-full bg-blue-200/50 blur-3xl"></div>
    </div>

    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="mb-8 flex flex-col gap-5 md:flex-row md:items-end md:justify-between">
        <div>
          <div class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.16em] text-blue-700">
            <ClientOnly>
              <Icon icon="lucide:bar-chart-3" class="h-4 w-4" />
            </ClientOnly>
            {{ c.eyebrow }}
          </div>

          <h2 class="mt-4 max-w-3xl text-3xl font-black tracking-tight text-slate-950 sm:text-4xl lg:text-5xl">
            {{ c.title }}
          </h2>

          <p class="mt-4 max-w-2xl text-base leading-8 text-slate-600">
            {{ c.subtitle }}
          </p>
        </div>

        <a
          :href="c.ctaHref"
          class="group inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-4 text-sm font-black text-slate-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
        >
          {{ c.ctaLabel }}
          <ClientOnly>
            <Icon icon="lucide:arrow-up-right" class="h-4 w-4 transition group-hover:translate-x-0.5 group-hover:-translate-y-0.5" />
          </ClientOnly>
        </a>
      </div>

      <div class="grid gap-5 lg:grid-cols-[370px_minmax(0,1fr)]">
        <!-- Left Column -->
        <div class="space-y-5">
          <!-- Visitor Card -->
          <article class="overflow-hidden rounded-4xl border border-slate-200 bg-white/90 p-5 shadow-sm backdrop-blur-xl">
            <div class="flex items-start justify-between gap-4">
              <div class="flex items-center gap-3">
                <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                  <ClientOnly>
                    <Icon icon="lucide:activity" class="h-5 w-5" />
                  </ClientOnly>
                </div>

                <div>
                  <h3 class="text-base font-black text-slate-950">
                    Statistik Pengunjung
                  </h3>
                  <p class="mt-1 text-xs font-semibold text-slate-400">
                    Dipantau secara realtime
                  </p>
                </div>
              </div>

              <span class="rounded-full bg-emerald-50 px-3 py-1 text-xs font-black text-emerald-700">
                realtime
              </span>
            </div>

            <div class="mt-5 space-y-3">
              <div
                v-for="item in c.visitors"
                :key="item.label"
                class="flex items-center justify-between gap-3"
              >
                <span class="text-sm font-semibold text-slate-500">
                  {{ item.label }}
                </span>

                <div class="flex items-center gap-2">
                  <span class="text-sm font-black text-slate-950">
                    {{ item.value }}
                  </span>

                  <span
                    v-if="item.badge"
                    class="rounded-full bg-emerald-50 px-2 py-0.5 text-[10px] font-black text-emerald-700"
                  >
                    {{ item.badge }}
                  </span>
                </div>
              </div>
            </div>

            <div class="mt-5">
              <div class="mb-2 flex items-center justify-between text-xs font-bold text-slate-400">
                <span>Perbandingan hari ini</span>
                <span>{{ c.visitorGrowth }}</span>
              </div>

              <div class="h-2 overflow-hidden rounded-full bg-slate-100">
                <div
                  class="h-full rounded-full bg-linear-to-r from-blue-600 to-cyan-400"
                  :style="{ width: c.visitorProgress }"
                ></div>
              </div>
            </div>
          </article>

          <!-- Aparatur Card -->
          <article class="overflow-hidden rounded-4xl border border-slate-200 bg-white/90 p-5 shadow-sm backdrop-blur-xl">
            <div class="flex items-center justify-between gap-4">
              <div class="flex items-center gap-3">
                <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                  <ClientOnly>
                    <Icon icon="lucide:users-round" class="h-5 w-5" />
                  </ClientOnly>
                </div>

                <div>
                  <h3 class="text-base font-black text-slate-950">
                    Aparatur Desa
                  </h3>
                  <p class="mt-1 text-xs font-semibold text-slate-400">
                    Profil perangkat aktif
                  </p>
                </div>
              </div>

              <a
                :href="c.officialsHref"
                class="text-xs font-black text-slate-400 transition hover:text-blue-600"
              >
                Lihat semua
              </a>
            </div>

            <div v-if="activeOfficial" class="mt-5 grid gap-4 sm:grid-cols-[130px_minmax(0,1fr)] lg:grid-cols-1 xl:grid-cols-[130px_minmax(0,1fr)]">
              <div class="relative overflow-hidden rounded-3xl bg-slate-100">
                <img
                  v-if="activeOfficial.image"
                  :src="activeOfficial.image"
                  :alt="activeOfficial.name"
                  class="h-48 w-full object-cover sm:h-44 lg:h-52 xl:h-44"
                />
                <div
                  v-else
                  class="flex h-48 w-full items-center justify-center bg-slate-100 text-blue-600 sm:h-44 lg:h-52 xl:h-44"
                >
                  <ClientOnly>
                    <Icon :icon="activeOfficial.icon || 'solar:user-rounded-bold-duotone'" class="h-14 w-14" />
                  </ClientOnly>
                </div>

                <div class="absolute inset-x-0 bottom-0 bg-linear-to-t from-slate-950/70 to-transparent p-3">
                  <span class="rounded-full bg-white/90 px-2.5 py-1 text-[10px] font-black text-blue-700">
                    {{ activeOfficial.status }}
                  </span>
                </div>
              </div>

              <div class="min-w-0">
                <p class="text-lg font-black text-slate-950">
                  {{ activeOfficial.name }}
                </p>
                <p class="mt-1 text-sm font-semibold text-slate-500">
                  {{ activeOfficial.role }}
                </p>

                <p class="mt-4 line-clamp-3 text-sm leading-7 text-slate-500">
                  {{ activeOfficial.description }}
                </p>

                <div class="mt-5 flex items-center gap-2">
                  <button
                    type="button"
                    class="grid h-10 w-10 place-items-center rounded-full border border-slate-200 bg-white text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                    @click="prevOfficial"
                  >
                    <ClientOnly>
                      <Icon icon="lucide:chevron-left" class="h-4 w-4" />
                    </ClientOnly>
                  </button>

                  <button
                    type="button"
                    class="grid h-10 w-10 place-items-center rounded-full border border-slate-200 bg-white text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                    @click="nextOfficial"
                  >
                    <ClientOnly>
                      <Icon icon="lucide:chevron-right" class="h-4 w-4" />
                    </ClientOnly>
                  </button>

                  <div class="ml-2 flex items-center gap-1">
                    <button
                      v-for="(_, index) in officials"
                      :key="index"
                      type="button"
                      class="h-2 rounded-full transition"
                      :class="officialIndex === index ? 'w-8 bg-blue-600' : 'w-2 bg-slate-300 hover:bg-blue-300'"
                      @click="officialIndex = index"
                    ></button>
                  </div>
                </div>
              </div>
            </div>
          </article>
        </div>

        <!-- Right APBDes -->
        <article class="overflow-hidden rounded-4xl border border-slate-200 bg-white/90 p-5 shadow-sm backdrop-blur-xl sm:p-6">
          <div class="flex flex-col gap-4 xl:flex-row xl:items-center xl:justify-between">
            <div class="flex items-center gap-3">
              <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <ClientOnly>
                  <Icon icon="lucide:landmark" class="h-5 w-5" />
                </ClientOnly>
              </div>

              <div>
                <h3 class="text-base font-black text-slate-950">
                  {{ c.budgetTitle }}
                </h3>
                <p class="mt-1 text-xs font-semibold text-slate-400">
                  {{ c.budgetSubtitle }}
                </p>
              </div>
            </div>

            <div class="inline-flex rounded-2xl border border-slate-200 bg-slate-50 p-1">
              <button
                v-for="tab in tabs"
                :key="tab.key"
                type="button"
                class="rounded-xl px-3 py-2 text-xs font-black transition"
                :class="activeTab === tab.key
                  ? 'bg-white text-blue-700 shadow-sm'
                  : 'text-slate-500 hover:text-blue-700'"
                @click="activeTab = tab.key"
              >
                {{ tab.label }}
              </button>
            </div>
          </div>

          <!-- Budget Summary -->
          <div class="mt-7 grid gap-4 md:grid-cols-3">
            <div
              v-for="item in c.budgetSummary"
              :key="item.label"
              class="rounded-3xl border border-slate-200 bg-slate-50 p-4"
            >
              <div class="flex items-center gap-4">
                <div class="relative grid h-24 w-24 shrink-0 place-items-center">
                  <svg class="h-24 w-24 -rotate-90" viewBox="0 0 100 100">
                    <circle
                      cx="50"
                      cy="50"
                      r="40"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="10"
                      class="text-slate-200"
                    />
                    <circle
                      cx="50"
                      cy="50"
                      r="40"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="10"
                      stroke-linecap="round"
                      class="text-blue-600"
                      :stroke-dasharray="circleDash"
                      :stroke-dashoffset="circleOffset(item.percent)"
                    />
                  </svg>

                  <div class="absolute text-center">
                    <p class="text-lg font-black text-slate-950">
                      {{ item.percent }}%
                    </p>
                    <p class="text-[10px] font-bold uppercase text-slate-400">
                      realisasi
                    </p>
                  </div>
                </div>

                <div class="min-w-0">
                  <p class="text-sm font-black text-slate-950">
                    {{ item.label }}
                  </p>
                  <p class="mt-1 text-xs leading-5 text-slate-500">
                    {{ item.realization }}
                  </p>
                  <p class="text-xs leading-5 text-slate-400">
                    dari {{ item.budget }}
                  </p>

                  <div class="mt-3 h-2 overflow-hidden rounded-full bg-slate-200">
                    <div
                      class="h-full rounded-full bg-blue-600"
                      :style="{ width: `${Math.min(item.percent, 100)}%` }"
                    ></div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Budget Lists -->
          <div class="mt-7 grid gap-5 xl:grid-cols-2">
            <div v-if="activeTab === 'overview' || activeTab === 'income'">
              <div class="mb-3 flex items-center justify-between">
                <h4 class="text-sm font-black text-slate-950">
                  Pendapatan per Sumber
                </h4>
                <span class="text-xs font-bold text-blue-600">
                  {{ c.incomeItems.length }} sumber
                </span>
              </div>

              <div class="space-y-3">
                <BudgetItemCard
                  v-for="item in c.incomeItems"
                  :key="item.label"
                  :item="item"
                />
              </div>
            </div>

            <div v-if="activeTab === 'overview' || activeTab === 'expense'">
              <div class="mb-3 flex items-center justify-between">
                <h4 class="text-sm font-black text-slate-950">
                  Belanja per Bidang
                </h4>
                <span class="text-xs font-bold text-blue-600">
                  {{ c.expenseItems.length }} bidang
                </span>
              </div>

              <div class="space-y-3">
                <BudgetItemCard
                  v-for="item in c.expenseItems"
                  :key="item.label"
                  :item="item"
                />
              </div>
            </div>
          </div>

          <div class="mt-6 rounded-2xl border border-blue-100 bg-blue-50 p-4 text-xs leading-6 text-blue-700">
            <strong>Catatan:</strong>
            {{ c.note }}
          </div>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed, defineComponent, h, ref, watch } from 'vue'
import { Icon } from '@iconify/vue'
import { useAppApi } from '~/composables/useAppApi'

type VisitorItem = {
  label: string
  value: string
  badge?: string
}

type OfficialItem = {
  name: string
  role: string
  status: string
  image: string
  icon?: string
  description: string
}

type BudgetSummaryItem = {
  label: string
  percent: number
  realization: string
  budget: string
}

type BudgetListItem = {
  label: string
  realization: string
  budget: string
  percent: number
}

type InfoHeroProps = {
  eyebrow?: string
  title?: string
  subtitle?: string
  ctaLabel?: string
  ctaHref?: string
  officialsHref?: string
  budgetYear?: number
  officialsLimit?: number
}

type PublicMetricItem = {
  id: string
  metricGroup: string
  metricKey: string
  label: string
  description: string | null
  valueDecimal: number | null
  valueText: string | null
  valueUnit: string | null
  comparisonValue: number | null
  comparisonUnit: string | null
  comparisonDirection: 'up' | 'down' | 'same' | null
  periodType: string
  icon: string | null
  color: string | null
  metadata: Record<string, any>
  sortOrder: number
  updatedAt: number
}

type VillageOfficialItem = {
  id: string
  name: string
  slug: string
  positionTitle: string
  positionCode: string | null
  shortDescription: string | null
  contentHtml: string | null
  photoUrl: string | null
  icon: string | null
  attendanceStatus: 'present' | 'away' | 'leave' | 'inactive' | 'unknown'
  attendanceLabel: string | null
  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number
}

type BudgetLineType = 'revenue' | 'expense' | 'financing'

type BudgetLineItemApi = {
  id: string
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
}

type BudgetSummaryApi = {
  type: BudgetLineType
  label: string
  budgetAmount: number
  realizedAmount: number
  realizationPercent: number
}

type VillageBudgetPeriodItem = {
  id: string
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
  summary: BudgetSummaryApi[]
  revenueLines: BudgetLineItemApi[]
  expenseLines: BudgetLineItemApi[]
  financingLines: BudgetLineItemApi[]
}

type PublicDashboardResponse = {
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

const props = defineProps<InfoHeroProps>()

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

const officialIndex = ref(0)
const activeTab = ref<'overview' | 'income' | 'expense'>('overview')

const tabs = [
  {
    key: 'overview',
    label: 'Ringkas'
  },
  {
    key: 'income',
    label: 'Pendapatan'
  },
  {
    key: 'expense',
    label: 'Belanja'
  }
] as const

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro')
    .trim()
    .toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const { tenantApiUrl } = useAppApi()

const activeYear = computed(() => {
  return Number(props.budgetYear || new Date().getFullYear())
})

const publicDashboardApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/public-dashboard')
})

const {
  data: publicDashboardResponse,
  pending: publicDashboardPending,
  error: publicDashboardError,
  refresh: refreshPublicDashboard
} = await useFetch<PublicDashboardResponse>(publicDashboardApiUrl, {
  key: computed(() => `public-dashboard-${tenantSlug.value}-${activeYear.value}`),
  query: computed(() => ({
    year: activeYear.value,
    officialsLimit: Number(props.officialsLimit || 10)
  })),
  watch: [tenantSlug, activeYear],
  default: () => ({
    data: {
      visitorStats: {
        title: 'Statistik Pengunjung',
        subtitle: 'Dipantau secara realtime',
        realtime: true,
        today: 0,
        yesterday: 0,
        total: 0,
        comparisonPercent: 0,
        metrics: []
      },
      officials: {
        title: 'Aparatur Desa',
        subtitle: 'Profil perangkat aktif',
        items: []
      },
      budget: null
    }
  })
})

const dashboard = computed(() => publicDashboardResponse.value?.data)
const visitorStats = computed(() => dashboard.value?.visitorStats)
const dashboardOfficials = computed(() => dashboard.value?.officials)
const dashboardBudget = computed(() => dashboard.value?.budget || null)

const c = computed(() => {
  return {
    eyebrow: props.eyebrow || 'Statistik Desa',
    title: props.title || `Ringkasan Kinerja & APBDes ${activeYear.value}`,
    subtitle:
      props.subtitle ||
      'Pantau statistik layanan, data aparatur, dan ringkasan APBDes secara ringkas, transparan, dan mudah dipahami masyarakat.',
    ctaLabel: props.ctaLabel || 'Lihat APBDes Lengkap',
    ctaHref: props.ctaHref || '/apbd',

    visitorGrowth: formatGrowth(visitorStats.value?.comparisonPercent || 0),
    visitorProgress: visitorProgress.value,
    visitors: mappedVisitors.value,

    officialsHref: props.officialsHref || '/profile',
    officials: mappedOfficials.value,

    budgetTitle: dashboardBudget.value?.title || `APBDes ${activeYear.value}`,
    budgetSubtitle:
      dashboardBudget.value?.subtitle ||
      'Realisasi dibandingkan anggaran',

    budgetSummary: mappedBudgetSummary.value,
    incomeItems: mappedRevenueLines.value,
    expenseItems: mappedExpenseLines.value,

    note:
      dashboardBudget.value?.notes ||
      'Data APBDes akan tampil setelah tersedia pada database public-dashboard.'
  }
})

const officials = computed(() => c.value.officials)

const activeOfficial = computed(() => {
  return officials.value[officialIndex.value] || officials.value[0] || null
})

const mappedVisitors = computed<VisitorItem[]>(() => {
  const stats = visitorStats.value

  if (!stats) return []

  if (stats.metrics?.length) {
    return stats.metrics
      .slice()
      .sort((a, b) => Number(a.sortOrder || 0) - Number(b.sortOrder || 0))
      .map((item) => {
        const value =
          item.metadata?.display ||
          item.valueText ||
          formatCompactNumber(item.valueDecimal || 0)

        const isToday = item.metricKey === 'today_visitors'

        return {
          label: item.label,
          value,
          badge:
            isToday && stats.comparisonPercent
              ? formatGrowth(stats.comparisonPercent)
              : undefined
        }
      })
  }

  return [
    {
      label: 'Hari ini',
      value: formatCompactNumber(stats.today),
      badge: stats.comparisonPercent
        ? formatGrowth(stats.comparisonPercent)
        : undefined
    },
    {
      label: 'Kemarin',
      value: formatCompactNumber(stats.yesterday)
    },
    {
      label: 'Jumlah pengunjung',
      value: formatCompactNumber(stats.total)
    }
  ]
})

const visitorProgress = computed(() => {
  const today = Number(visitorStats.value?.today || 0)
  const yesterday = Number(visitorStats.value?.yesterday || 0)

  if (!today && !yesterday) return '0%'

  const total = today + yesterday
  const percent = total ? (today / total) * 100 : 0

  return `${clampPercent(percent)}%`
})

const mappedOfficials = computed<OfficialItem[]>(() => {
  const items = dashboardOfficials.value?.items || []

  return items.map((item) => ({
    name: item.name,
    role: item.positionTitle,
    status: item.attendanceLabel || attendanceLabel(item.attendanceStatus),
    image: item.photoUrl || '',
    icon: item.icon || 'solar:user-rounded-bold-duotone',
    description:
      item.shortDescription ||
      plainText(item.contentHtml || '') ||
      'Profil aparatur desa aktif.'
  }))
})

const mappedBudgetSummary = computed<BudgetSummaryItem[]>(() => {
  const items = dashboardBudget.value?.summary || []

  return items.map((item) => ({
    label: item.label,
    percent: clampPercent(item.realizationPercent),
    realization: formatCurrency(item.realizedAmount),
    budget: formatCurrency(item.budgetAmount)
  }))
})

const mappedRevenueLines = computed<BudgetListItem[]>(() => {
  return mapBudgetLines(dashboardBudget.value?.revenueLines || [])
})

const mappedExpenseLines = computed<BudgetListItem[]>(() => {
  return mapBudgetLines(dashboardBudget.value?.expenseLines || [])
})

const circleDash = 251.2

watch(officials, (items) => {
  if (!items.length) {
    officialIndex.value = 0
    return
  }

  if (officialIndex.value > items.length - 1) {
    officialIndex.value = 0
  }
})

function mapBudgetLines(items: BudgetLineItemApi[]): BudgetListItem[] {
  return items
    .slice()
    .sort((a, b) => Number(a.sortOrder || 0) - Number(b.sortOrder || 0))
    .map((item) => ({
      label: item.title,
      realization: formatCurrency(item.realizedAmount),
      budget: formatCurrency(item.budgetAmount),
      percent: clampPercent(item.realizationPercent)
    }))
}

function circleOffset(percent: number) {
  const value = clampPercent(percent)
  return circleDash - (circleDash * value) / 100
}

function nextOfficial() {
  if (!officials.value.length) return

  officialIndex.value = (officialIndex.value + 1) % officials.value.length
}

function prevOfficial() {
  if (!officials.value.length) return

  officialIndex.value =
    officialIndex.value === 0
      ? officials.value.length - 1
      : officialIndex.value - 1
}

function formatCurrency(value: number) {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: dashboardBudget.value?.currencyCode || 'IDR',
    maximumFractionDigits: 0
  }).format(Number(value || 0))
}

function formatCompactNumber(value: number) {
  return new Intl.NumberFormat('id-ID').format(Number(value || 0))
}

function formatGrowth(value: number) {
  const number = Number(value || 0)

  if (!number) return '0%'

  const sign = number > 0 ? '+' : ''

  return `${sign}${new Intl.NumberFormat('id-ID', {
    maximumFractionDigits: 1
  }).format(number)}%`
}

function clampPercent(value: number) {
  const number = Number(value || 0)

  if (Number.isNaN(number)) return 0

  return Math.max(0, Math.min(Math.round(number), 100))
}

function attendanceLabel(value: VillageOfficialItem['attendanceStatus']) {
  const map: Record<VillageOfficialItem['attendanceStatus'], string> = {
    present: 'Hadir',
    away: 'Di luar',
    leave: 'Cuti',
    inactive: 'Tidak aktif',
    unknown: 'Aktif'
  }

  return map[value] || 'Aktif'
}

function plainText(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim()
}

const BudgetItemCard = defineComponent({
  name: 'BudgetItemCard',
  props: {
    item: {
      type: Object,
      required: true
    }
  },
  setup(componentProps) {
    return () => {
      const item = componentProps.item as BudgetListItem
      const percent = clampPercent(item.percent)

      return h(
        'div',
        {
          class:
            'rounded-[1.35rem] border border-slate-200 bg-white p-4 transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-900/5'
        },
        [
          h('div', { class: 'flex items-start justify-between gap-3' }, [
            h('div', { class: 'min-w-0' }, [
              h('p', { class: 'truncate text-sm font-black text-slate-700' }, item.label),
              h('p', { class: 'mt-2 text-xs font-semibold text-slate-400' }, `Anggaran: ${item.budget}`)
            ]),
            h('p', { class: 'shrink-0 text-sm font-black text-slate-950' }, item.realization)
          ]),
          h('div', { class: 'mt-3 h-2 overflow-hidden rounded-full bg-slate-200' }, [
            h('div', {
              class: 'h-full rounded-full bg-blue-600',
              style: {
                width: `${percent}%`
              }
            })
          ])
        ]
      )
    }
  }
})
</script>

<style scoped>
.bg-size-\[44px_44px\] {
  background-size: 44px 44px;
}
</style>