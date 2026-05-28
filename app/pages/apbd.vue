<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-40 top-0 h-[520px] w-[520px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-40 top-32 h-[520px] w-[520px] rounded-full bg-cyan-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[420px] w-[420px] rounded-full bg-emerald-100/60 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <section class="relative border-b border-neutral-200 bg-white/80 pt-28 backdrop-blur-xl">
      <div class="mx-auto max-w-7xl px-4 pb-10 sm:px-6 lg:px-8">
        <nav class="mb-7 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
          <NuxtLink to="/" class="transition hover:text-neutral-950">
            Beranda
          </NuxtLink>
          <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
          <span class="text-neutral-950">APBD Desa</span>
        </nav>

        <div class="grid gap-8 lg:grid-cols-[1fr_390px] lg:items-end">
          <div>
            <div class="mb-5 inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
              <Icon icon="solar:wallet-money-bold-duotone" class="h-4 w-4" />
              Transparansi Keuangan
            </div>

            <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
              APBDes
              <span class="bg-gradient-to-r from-blue-600 via-cyan-500 to-emerald-500 bg-clip-text text-transparent">
                {{ budget?.budgetYear || activeYear }}
              </span>
            </h1>

            <p class="mt-5 max-w-3xl text-base font-semibold leading-8 text-neutral-600 sm:text-lg">
              Informasi ringkas pendapatan, belanja, pembiayaan, dan realisasi anggaran desa yang disajikan transparan untuk masyarakat.
            </p>

            <div class="mt-8 flex flex-wrap gap-3">
              <button
                v-for="tab in tabs"
                :key="tab.key"
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border px-5 py-3 text-sm font-black transition"
                :class="activeTab === tab.key
                  ? 'border-blue-600 bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                  : 'border-neutral-200 bg-white text-neutral-700 shadow-sm hover:bg-neutral-50'"
                @click="activeTab = tab.key"
              >
                <Icon :icon="tab.icon" class="h-5 w-5" />
                {{ tab.label }}
              </button>
            </div>
          </div>

          <aside class="rounded-[2.25rem] border border-neutral-200 bg-white p-5 shadow-xl shadow-neutral-900/5">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                  Tahun Anggaran
                </p>
                <h2 class="mt-1 text-3xl font-black text-neutral-950">
                  {{ activeYear }}
                </h2>
                <p class="mt-1 text-sm font-bold text-neutral-500">
                  Tenant {{ tenantSlug }}
                </p>
              </div>

              <div class="grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-700">
                <Icon icon="solar:banknote-bold-duotone" class="h-7 w-7" />
              </div>
            </div>

            <div class="mt-5 grid gap-3">
              <label class="block">
                <span class="mb-2 block text-sm font-black text-neutral-700">Pilih Tahun</span>
                <input
                  v-model.number="activeYear"
                  type="number"
                  min="2000"
                  max="2100"
                  class="input-field"
                >
              </label>

              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white transition hover:bg-neutral-800"
                @click="refresh()"
              >
                <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
                Refresh Data
              </button>
            </div>
          </aside>
        </div>
      </div>
    </section>

    <section class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
      <div v-if="visibleError" class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <section v-if="pending" class="grid gap-4 lg:grid-cols-3">
        <div v-for="item in 3" :key="item" class="h-40 animate-pulse rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
          <div class="h-12 w-12 rounded-full bg-neutral-100"></div>
          <div class="mt-5 h-5 w-28 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <section v-else-if="!budget" class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm">
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-neutral-100 text-neutral-500">
          <Icon icon="solar:wallet-money-bold-duotone" class="h-8 w-8" />
        </div>
        <h2 class="mt-5 text-xl font-black text-neutral-950">
          Data APBDes belum tersedia
        </h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-semibold leading-6 text-neutral-500">
          Pastikan data `village_budget_periods` dan `village_budget_lines` sudah di-seed untuk tahun {{ activeYear }}.
        </p>
      </section>

      <template v-else>
        <section class="grid gap-4 lg:grid-cols-3">
          <article
            v-for="item in budget.summary"
            :key="item.type"
            class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
          >
            <div class="flex items-center gap-5">
              <ProgressCircle :percent="item.realizationPercent" />
              <div class="min-w-0">
                <p class="text-sm font-black text-neutral-500">{{ item.label }}</p>
                <h2 class="mt-2 text-2xl font-black text-neutral-950">
                  {{ formatCurrency(item.realizedAmount) }}
                </h2>
                <p class="mt-1 text-xs font-bold text-neutral-400">
                  dari {{ formatCurrency(item.budgetAmount) }}
                </p>
              </div>
            </div>
          </article>
        </section>

        <section class="mt-6 rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
          <div class="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                {{ activeTabLabel }}
              </p>
              <h2 class="mt-1 text-2xl font-black text-neutral-950">
                {{ budget.title }}
              </h2>
              <p class="mt-1 text-sm font-semibold text-neutral-500">
                {{ budget.subtitle || 'Realisasi dibandingkan anggaran' }}
              </p>
            </div>

            <div class="rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 text-right">
              <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                Total Anggaran
              </p>
              <p class="mt-1 text-lg font-black text-neutral-950">
                {{ formatCurrency(activeTotalBudget) }}
              </p>
            </div>
          </div>

          <div v-if="activeTab === 'summary'" class="mt-6 grid gap-6 lg:grid-cols-2">
            <BudgetList title="Pendapatan per Sumber" :items="budget.revenueLines" />
            <BudgetList title="Belanja per Bidang" :items="budget.expenseLines" />
          </div>

          <div v-else class="mt-6">
            <BudgetList :title="activeTabLabel" :items="activeLines" wide />
          </div>

          <div v-if="budget.notes" class="mt-6 rounded-[1.5rem] border border-blue-200 bg-blue-50 p-4 text-sm font-semibold leading-7 text-blue-700">
            <strong>Catatan:</strong> {{ budget.notes }}
          </div>
        </section>
      </template>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref } from 'vue'
import { useAppApi } from '../composables/useAppApi'

type BudgetLineType = 'revenue' | 'expense' | 'financing'

type BudgetLineItem = {
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

type BudgetSummaryItem = {
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
  summary: BudgetSummaryItem[]
  revenueLines: BudgetLineItem[]
  expenseLines: BudgetLineItem[]
  financingLines: BudgetLineItem[]
}

type PublicDashboardResponse = {
  data: {
    visitorStats: any
    officials: any
    budget: VillageBudgetPeriodItem | null
  }
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

const activeTab = ref<'summary' | 'revenue' | 'expense' | 'financing'>('summary')
const activeYear = ref(new Date().getFullYear())

const tabs = [
  { key: 'summary', label: 'Ringkas', icon: 'solar:pie-chart-2-bold-duotone' },
  { key: 'revenue', label: 'Pendapatan', icon: 'solar:wallet-money-bold-duotone' },
  { key: 'expense', label: 'Belanja', icon: 'solar:bill-list-bold-duotone' },
  { key: 'financing', label: 'Pembiayaan', icon: 'solar:banknote-bold-duotone' }
] as const

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())

const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro').trim().toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const { tenantApiUrl } = useAppApi()
const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/public-dashboard'))

const { data, pending, error, refresh } = await useFetch<PublicDashboardResponse>(apiUrl, {
  key: computed(() => `apbd-public-dashboard-${tenantSlug.value}-${activeYear.value}`),
  query: computed(() => ({
    year: activeYear.value,
    officialsLimit: 1
  })),
  watch: [tenantSlug, activeYear],
  default: () => ({
    data: {
      visitorStats: null,
      officials: null,
      budget: null
    }
  })
})

const budget = computed(() => data.value?.data.budget || null)
const visibleError = computed(() => error.value?.message || '')

const activeLines = computed(() => {
  if (!budget.value) return []

  if (activeTab.value === 'revenue') return budget.value.revenueLines
  if (activeTab.value === 'expense') return budget.value.expenseLines
  if (activeTab.value === 'financing') return budget.value.financingLines

  return []
})

const activeTabLabel = computed(() => {
  const map = {
    summary: 'Ringkasan APBDes',
    revenue: 'Pendapatan per Sumber',
    expense: 'Belanja per Bidang',
    financing: 'Pembiayaan Desa'
  }

  return map[activeTab.value]
})

const activeTotalBudget = computed(() => {
  if (!budget.value) return 0

  if (activeTab.value === 'summary') {
    return budget.value.summary.reduce((sum, item) => sum + item.budgetAmount, 0)
  }

  return activeLines.value.reduce((sum, item) => sum + item.budgetAmount, 0)
})

useSeoMeta({
  title: () => `APBDes ${activeYear.value} · ${tenantSlug.value}`,
  description: 'Transparansi APBDes desa: pendapatan, belanja, pembiayaan, dan realisasi anggaran.',
  robots: 'index, follow'
})

function formatCurrency(value: number) {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: budget.value?.currencyCode || 'IDR',
    maximumFractionDigits: 0
  }).format(Number(value || 0))
}

function clamp(value: number) {
  const number = Number(value || 0)
  if (Number.isNaN(number)) return 0
  return Math.max(0, Math.min(Math.round(number), 100))
}

const ProgressCircle = defineComponent({
  props: {
    percent: {
      type: Number,
      required: true
    }
  },
  setup(props) {
    return () => {
      const percent = clamp(props.percent)
      const dash = 251.2
      const offset = dash - (dash * percent) / 100

      return h('div', { class: 'relative h-20 w-20 shrink-0' }, [
        h('svg', { viewBox: '0 0 100 100', class: '-rotate-90 h-20 w-20' }, [
          h('circle', {
            cx: '50',
            cy: '50',
            r: '40',
            fill: 'none',
            stroke: '#e5e7eb',
            'stroke-width': '10'
          }),
          h('circle', {
            cx: '50',
            cy: '50',
            r: '40',
            fill: 'none',
            stroke: '#2563eb',
            'stroke-width': '10',
            'stroke-linecap': 'round',
            'stroke-dasharray': String(dash),
            'stroke-dashoffset': String(offset)
          })
        ]),
        h('div', { class: 'absolute inset-0 grid place-items-center text-center' }, [
          h('span', { class: 'text-lg font-black text-neutral-950' }, `${percent}%`)
        ])
      ])
    }
  }
})

const BudgetList = defineComponent({
  props: {
    title: { type: String, required: true },
    items: { type: Array as () => BudgetLineItem[], required: true },
    wide: { type: Boolean, default: false }
  },
  setup(props) {
    return () => h('div', {}, [
      h('div', { class: 'mb-3 flex items-center justify-between gap-3' }, [
        h('h3', { class: 'text-base font-black text-neutral-950' }, props.title),
        h('span', { class: 'text-xs font-black text-blue-600' }, `${props.items.length} data`)
      ]),
      h('div', {
        class: props.wide ? 'grid gap-3 lg:grid-cols-2' : 'space-y-3'
      }, props.items.map((item) => {
        const percent = clamp(item.realizationPercent)

        return h('div', {
          class: 'rounded-[1.35rem] border border-neutral-200 bg-white p-4 transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-900/5'
        }, [
          h('div', { class: 'flex items-start justify-between gap-3' }, [
            h('div', { class: 'min-w-0' }, [
              h('p', { class: 'truncate text-sm font-black text-neutral-700' }, item.title),
              h('p', { class: 'mt-2 text-xs font-semibold text-neutral-400' }, `Anggaran: ${new Intl.NumberFormat('id-ID', {
                style: 'currency',
                currency: 'IDR',
                maximumFractionDigits: 0
              }).format(item.budgetAmount)}`)
            ]),
            h('p', { class: 'shrink-0 text-sm font-black text-neutral-950' }, new Intl.NumberFormat('id-ID', {
              style: 'currency',
              currency: 'IDR',
              maximumFractionDigits: 0
            }).format(item.realizedAmount))
          ]),
          h('div', { class: 'mt-3 h-2 overflow-hidden rounded-full bg-neutral-100' }, [
            h('div', {
              class: 'h-full rounded-full bg-blue-600',
              style: { width: `${percent}%` }
            })
          ]),
          h('div', { class: 'mt-2 flex items-center justify-between text-[11px] font-black text-neutral-400' }, [
            h('span', {}, 'Realisasi'),
            h('span', {}, `${percent}%`)
          ])
        ])
      }))
    ])
  }
})
</script>

<style scoped>
.bg-grid {
  background-size: 44px 44px;
  background-image:
    linear-gradient(to right, #e5e7eb 1px, transparent 1px),
    linear-gradient(to bottom, #e5e7eb 1px, transparent 1px);
}

.input-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.input-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}
</style>