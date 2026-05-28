<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950" :style="themeVars">
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
          <span class="text-neutral-950">Status Desa</span>
        </nav>

        <div class="grid gap-8 lg:grid-cols-[1fr_390px] lg:items-end">
          <div>
            <div class="mb-5 inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
              <Icon icon="solar:pulse-2-bold-duotone" class="h-4 w-4" />
              Status Realtime
            </div>

            <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
              Status Layanan &
              <span class="block bg-gradient-to-r from-blue-600 via-cyan-500 to-emerald-500 bg-clip-text text-transparent">
                Aktivitas Desa
              </span>
            </h1>

            <p class="mt-5 max-w-3xl text-base font-semibold leading-8 text-neutral-600 sm:text-lg">
              Pantau ringkasan aktivitas website, statistik pengunjung, aparatur aktif, dan status transparansi APBDes desa secara ringkas dan mudah dipahami.
            </p>

            <div class="mt-8 flex flex-wrap gap-3">
              <NuxtLink
                to="/apbd"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white shadow-lg shadow-neutral-900/10 transition hover:-translate-y-0.5 hover:bg-neutral-800"
              >
                Lihat APBD Desa
                <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
              </NuxtLink>

              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:bg-neutral-50"
                @click="refresh()"
              >
                <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
                Refresh Data
              </button>
            </div>
          </div>

          <aside class="rounded-[2.25rem] border border-neutral-200 bg-white p-5 shadow-xl shadow-neutral-900/5">
            <div class="flex items-start gap-4">
              <div class="grid h-16 w-16 shrink-0 place-items-center rounded-3xl bg-blue-50 text-blue-700">
                <Icon icon="solar:shield-check-bold-duotone" class="h-8 w-8" />
              </div>

              <div class="min-w-0">
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                  Status Sistem
                </p>
                <h2 class="mt-1 text-2xl font-black text-neutral-950">
                  {{ pending ? 'Memuat...' : 'Aktif' }}
                </h2>
                <p class="mt-1 text-sm font-bold text-neutral-500">
                  Tenant {{ tenantSlug }}
                </p>
              </div>
            </div>

            <div class="mt-5 grid gap-3">
              <StatusRow
                icon="solar:global-bold-duotone"
                label="Website"
                value="Online"
                status="success"
              />
              <StatusRow
                icon="solar:users-group-rounded-bold-duotone"
                label="Aparatur"
                :value="`${officials.length} aktif`"
                status="success"
              />
              <StatusRow
                icon="solar:wallet-money-bold-duotone"
                label="APBDes"
                :value="budget ? `Tahun ${budget.budgetYear}` : 'Belum tersedia'"
                :status="budget ? 'success' : 'warning'"
              />
            </div>
          </aside>
        </div>
      </div>
    </section>

    <section class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
      <div v-if="visibleError" class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <section v-if="pending" class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <div v-for="item in 4" :key="item" class="h-40 animate-pulse rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
          <div class="h-11 w-11 rounded-2xl bg-neutral-100"></div>
          <div class="mt-5 h-5 w-28 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <template v-else>
        <section class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <article
            v-for="card in statusCards"
            :key="card.label"
            class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm transition hover:-translate-y-0.5 hover:shadow-lg hover:shadow-neutral-900/5"
          >
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-sm font-bold text-neutral-500">{{ card.label }}</p>
                <h2 class="mt-3 text-3xl font-black text-neutral-950">{{ card.value }}</h2>
              </div>

              <div class="grid h-12 w-12 place-items-center rounded-2xl bg-blue-50 text-blue-700">
                <Icon :icon="card.icon" class="h-6 w-6" />
              </div>
            </div>

            <p class="mt-4 text-xs font-semibold leading-5 text-neutral-500">
              {{ card.description }}
            </p>

            <div class="mt-4 h-2 overflow-hidden rounded-full bg-neutral-100">
              <div
                class="h-full rounded-full bg-blue-600"
                :style="{ width: `${card.progress}%` }"
              ></div>
            </div>
          </article>
        </section>

        <section class="mt-6 grid gap-6 lg:grid-cols-[380px_1fr]">
          <aside class="space-y-6">
            <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <div class="flex items-center justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                    Statistik
                  </p>
                  <h2 class="mt-1 text-xl font-black text-neutral-950">
                    Pengunjung
                  </h2>
                  <p class="mt-1 text-sm font-semibold text-neutral-500">
                    Dipantau secara realtime
                  </p>
                </div>

                <span class="rounded-full bg-emerald-50 px-3 py-1 text-xs font-black text-emerald-700">
                  realtime
                </span>
              </div>

              <div class="mt-5 space-y-4">
                <div
                  v-for="item in visitorItems"
                  :key="item.label"
                  class="flex items-center justify-between gap-3"
                >
                  <p class="text-sm font-black text-neutral-500">{{ item.label }}</p>
                  <div class="flex items-center gap-2">
                    <p class="text-sm font-black text-neutral-950">{{ item.value }}</p>
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
                <div class="mb-2 flex items-center justify-between text-xs font-black text-neutral-400">
                  <span>Perbandingan hari ini</span>
                  <span>{{ formatGrowth(visitorStats?.comparisonPercent || 0) }}</span>
                </div>
                <div class="h-2 overflow-hidden rounded-full bg-neutral-100">
                  <div class="h-full rounded-full bg-gradient-to-r from-blue-600 to-cyan-400" :style="{ width: visitorProgress }"></div>
                </div>
              </div>
            </div>

            <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <div class="flex items-center justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                    Aparatur
                  </p>
                  <h2 class="mt-1 text-xl font-black text-neutral-950">
                    Perangkat Desa
                  </h2>
                </div>

                <NuxtLink to="/profile" class="text-xs font-black text-blue-600 hover:underline">
                  Lihat profil
                </NuxtLink>
              </div>

              <div v-if="officials.length" class="mt-5">
                <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-neutral-50">
                  <div class="flex gap-4 p-4">
                    <div class="h-28 w-24 shrink-0 overflow-hidden rounded-2xl bg-neutral-100">
                      <img
                        v-if="activeOfficial?.photoUrl"
                        :src="activeOfficial.photoUrl"
                        :alt="activeOfficial.name"
                        class="h-full w-full object-cover"
                      >
                      <div v-else class="flex h-full w-full items-center justify-center text-blue-600">
                        <Icon :icon="activeOfficial?.icon || 'solar:user-rounded-bold-duotone'" class="h-10 w-10" />
                      </div>
                    </div>

                    <div class="min-w-0 flex-1">
                      <h3 class="truncate text-lg font-black text-neutral-950">
                        {{ activeOfficial?.name }}
                      </h3>
                      <p class="mt-1 text-sm font-bold text-blue-600">
                        {{ activeOfficial?.positionTitle }}
                      </p>
                      <p class="mt-2 line-clamp-3 text-sm font-semibold leading-6 text-neutral-500">
                        {{ activeOfficial?.shortDescription || plainText(activeOfficial?.contentHtml || '') || 'Profil aparatur desa aktif.' }}
                      </p>
                    </div>
                  </div>

                  <div class="flex items-center justify-between border-t border-neutral-200 bg-white px-4 py-3">
                    <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                      {{ activeOfficial?.attendanceLabel || attendanceLabel(activeOfficial?.attendanceStatus || 'unknown') }}
                    </span>

                    <div class="flex items-center gap-2">
                      <button class="grid h-9 w-9 place-items-center rounded-xl border border-neutral-200 text-neutral-500 hover:bg-neutral-50" @click="prevOfficial">
                        <Icon icon="solar:alt-arrow-left-linear" class="h-4 w-4" />
                      </button>
                      <button class="grid h-9 w-9 place-items-center rounded-xl border border-neutral-200 text-neutral-500 hover:bg-neutral-50" @click="nextOfficial">
                        <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                </div>
              </div>

              <div v-else class="mt-5 rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-6 text-center">
                <Icon icon="solar:user-rounded-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
                <p class="mt-2 text-sm font-bold text-neutral-500">
                  Belum ada data aparatur.
                </p>
              </div>
            </div>
          </aside>

          <section class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
            <div class="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                  Status Keuangan
                </p>
                <h2 class="mt-1 text-2xl font-black text-neutral-950">
                  {{ budget?.title || `APBDes ${activeYear}` }}
                </h2>
                <p class="mt-1 text-sm font-semibold text-neutral-500">
                  {{ budget?.subtitle || 'Realisasi dibandingkan anggaran' }}
                </p>
              </div>

              <NuxtLink
                to="/apbd"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-2.5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              >
                Detail APBD
                <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
              </NuxtLink>
            </div>

            <div v-if="budget" class="mt-6 grid gap-4 md:grid-cols-3">
              <article
                v-for="item in budget.summary"
                :key="item.type"
                class="rounded-[1.75rem] border border-neutral-200 bg-neutral-50 p-5"
              >
                <div class="flex items-center gap-4">
                  <ProgressCircle :percent="item.realizationPercent" />
                  <div class="min-w-0">
                    <h3 class="font-black text-neutral-950">{{ item.label }}</h3>
                    <p class="mt-1 text-sm font-semibold text-neutral-500">
                      {{ formatCurrency(item.realizedAmount) }}
                    </p>
                    <p class="text-xs font-bold text-neutral-400">
                      dari {{ formatCurrency(item.budgetAmount) }}
                    </p>
                  </div>
                </div>
              </article>
            </div>

            <div v-else class="mt-6 rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center">
              <Icon icon="solar:wallet-money-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
              <h3 class="mt-3 text-lg font-black text-neutral-950">
                Data APBDes belum tersedia
              </h3>
              <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
                Tambahkan data APBDes melalui migration dan seeder public-dashboard.
              </p>
            </div>

            <div v-if="budget" class="mt-6 grid gap-6 lg:grid-cols-2">
              <BudgetPreviewList title="Pendapatan per Sumber" :items="budget.revenueLines.slice(0, 5)" />
              <BudgetPreviewList title="Belanja per Bidang" :items="budget.expenseLines.slice(0, 5)" />
            </div>

            <div v-if="budget?.notes" class="mt-6 rounded-[1.5rem] border border-blue-200 bg-blue-50 p-4 text-sm font-semibold leading-7 text-blue-700">
              <strong>Catatan:</strong> {{ budget.notes }}
            </div>
          </section>
        </section>
      </template>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref, watch } from 'vue'
import { useAppApi } from '../composables/useAppApi'

type PublicMetricItem = {
  id: string
  metricKey: string
  label: string
  valueDecimal: number | null
  valueText: string | null
  comparisonValue: number | null
  metadata: Record<string, any>
  sortOrder: number
}

type VillageOfficialItem = {
  id: string
  name: string
  slug: string
  positionTitle: string
  shortDescription: string | null
  contentHtml: string | null
  photoUrl: string | null
  icon: string | null
  attendanceStatus: 'present' | 'away' | 'leave' | 'inactive' | 'unknown'
  attendanceLabel: string | null
}

type BudgetLineType = 'revenue' | 'expense' | 'financing'

type BudgetLineItem = {
  id: string
  lineType: BudgetLineType
  title: string
  budgetAmount: number
  realizedAmount: number
  realizationPercent: number
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
  notes: string | null
  summary: BudgetSummaryItem[]
  revenueLines: BudgetLineItem[]
  expenseLines: BudgetLineItem[]
  financingLines: BudgetLineItem[]
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

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

const officialIndex = ref(0)
const activeYear = ref(new Date().getFullYear())

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())

const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro').trim().toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const { tenantApiUrl } = useAppApi()
const apiUrl = computed(() =>  tenantApiUrl(tenantSlug.value, `/public-dashboard`))

const { data, pending, error, refresh } = await useFetch<PublicDashboardResponse>(apiUrl, {
  key: computed(() => `status-public-dashboard-${tenantSlug.value}-${activeYear.value}`),
  query: computed(() => ({
    year: activeYear.value,
    officialsLimit: 10
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

const dashboard = computed(() => data.value?.data)
const visitorStats = computed(() => dashboard.value?.visitorStats)
const officials = computed(() => dashboard.value?.officials.items || [])
const budget = computed(() => dashboard.value?.budget || null)

const visibleError = computed(() => error.value?.message || '')

const themeVars = computed(() => ({
  '--brand': '#2563eb'
}))

const activeOfficial = computed(() => officials.value[officialIndex.value] || null)

const visitorItems = computed(() => {
  const stats = visitorStats.value

  if (!stats) return []

  if (stats.metrics.length) {
    return stats.metrics
      .slice()
      .sort((a, b) => Number(a.sortOrder || 0) - Number(b.sortOrder || 0))
      .map((item) => ({
        label: item.label,
        value: item.metadata?.display || item.valueText || formatNumber(item.valueDecimal || 0),
        badge: item.metricKey === 'today_visitors' ? formatGrowth(stats.comparisonPercent) : ''
      }))
  }

  return [
    { label: 'Hari ini', value: formatNumber(stats.today), badge: formatGrowth(stats.comparisonPercent) },
    { label: 'Kemarin', value: formatNumber(stats.yesterday), badge: '' },
    { label: 'Jumlah pengunjung', value: formatNumber(stats.total), badge: '' }
  ]
})

const visitorProgress = computed(() => {
  const today = Number(visitorStats.value?.today || 0)
  const yesterday = Number(visitorStats.value?.yesterday || 0)
  const total = today + yesterday

  if (!total) return '0%'

  return `${clamp((today / total) * 100)}%`
})

const statusCards = computed(() => {
  const summary = budget.value?.summary || []

  const revenue = summary.find((item) => item.type === 'revenue')
  const expense = summary.find((item) => item.type === 'expense')

  return [
    {
      label: 'Pengunjung Hari Ini',
      value: formatNumber(visitorStats.value?.today || 0),
      description: `Naik/turun ${formatGrowth(visitorStats.value?.comparisonPercent || 0)} dibanding periode sebelumnya.`,
      icon: 'solar:pulse-2-bold-duotone',
      progress: clamp(Number(visitorStats.value?.comparisonPercent || 0) + 50)
    },
    {
      label: 'Total Pengunjung',
      value: formatNumber(visitorStats.value?.total || 0),
      description: 'Jumlah seluruh kunjungan website yang tercatat.',
      icon: 'solar:users-group-rounded-bold-duotone',
      progress: 90
    },
    {
      label: 'Aparatur Aktif',
      value: formatNumber(officials.value.length),
      description: 'Data perangkat desa yang aktif ditampilkan.',
      icon: 'solar:user-id-bold-duotone',
      progress: officials.value.length ? 100 : 0
    },
    {
      label: 'Realisasi APBDes',
      value: `${clamp(((revenue?.realizationPercent || 0) + (expense?.realizationPercent || 0)) / 2)}%`,
      description: 'Rata-rata realisasi pendapatan dan belanja.',
      icon: 'solar:wallet-money-bold-duotone',
      progress: clamp(((revenue?.realizationPercent || 0) + (expense?.realizationPercent || 0)) / 2)
    }
  ]
})

watch(officials, (items) => {
  if (!items.length || officialIndex.value > items.length - 1) {
    officialIndex.value = 0
  }
})

useSeoMeta({
  title: () => `Status Desa · ${tenantSlug.value}`,
  description: 'Status layanan desa, statistik pengunjung, aparatur aktif, dan ringkasan APBDes.',
  robots: 'index, follow'
})

function nextOfficial() {
  if (!officials.value.length) return
  officialIndex.value = (officialIndex.value + 1) % officials.value.length
}

function prevOfficial() {
  if (!officials.value.length) return
  officialIndex.value = officialIndex.value === 0 ? officials.value.length - 1 : officialIndex.value - 1
}

function formatCurrency(value: number) {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: budget.value?.currencyCode || 'IDR',
    maximumFractionDigits: 0
  }).format(Number(value || 0))
}

function formatNumber(value: number) {
  return new Intl.NumberFormat('id-ID').format(Number(value || 0))
}

function formatGrowth(value: number) {
  const number = Number(value || 0)
  const sign = number > 0 ? '+' : ''

  return `${sign}${new Intl.NumberFormat('id-ID', {
    maximumFractionDigits: 1
  }).format(number)}%`
}

function clamp(value: number) {
  const number = Number(value || 0)
  if (Number.isNaN(number)) return 0
  return Math.max(0, Math.min(Math.round(number), 100))
}

function plainText(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
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

const StatusRow = defineComponent({
  props: {
    icon: { type: String, required: true },
    label: { type: String, required: true },
    value: { type: String, required: true },
    status: { type: String, default: 'success' }
  },
  setup(props) {
    return () => h('div', {
      class: 'flex items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3'
    }, [
      h('div', { class: 'grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm' }, [
        h(Icon, { icon: props.icon, class: 'h-5 w-5' })
      ]),
      h('div', { class: 'min-w-0 flex-1' }, [
        h('p', { class: 'text-xs font-black uppercase tracking-[0.12em] text-neutral-400' }, props.label),
        h('p', { class: 'mt-0.5 truncate text-sm font-black text-neutral-800' }, props.value)
      ]),
      h('span', {
        class: [
          'h-2.5 w-2.5 rounded-full',
          props.status === 'success' ? 'bg-emerald-500' : 'bg-amber-500'
        ]
      })
    ])
  }
})

const BudgetPreviewList = defineComponent({
  props: {
    title: { type: String, required: true },
    items: { type: Array as () => BudgetLineItem[], required: true }
  },
  setup(props) {
    return () => h('div', {}, [
      h('div', { class: 'mb-3 flex items-center justify-between gap-3' }, [
        h('h3', { class: 'text-base font-black text-neutral-950' }, props.title),
        h('span', { class: 'text-xs font-black text-blue-600' }, `${props.items.length} data`)
      ]),
      h('div', { class: 'space-y-3' }, props.items.map((item) => h('div', {
        class: 'rounded-[1.35rem] border border-neutral-200 bg-white p-4'
      }, [
        h('div', { class: 'flex items-start justify-between gap-3' }, [
          h('div', { class: 'min-w-0' }, [
            h('p', { class: 'truncate text-sm font-black text-neutral-700' }, item.title),
            h('p', { class: 'mt-1 text-xs font-semibold text-neutral-400' }, `Anggaran: ${new Intl.NumberFormat('id-ID', {
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
            style: { width: `${clamp(item.realizationPercent)}%` }
          })
        ])
      ])))
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

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>