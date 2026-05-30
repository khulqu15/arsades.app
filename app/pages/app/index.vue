<!-- /pages/app/index.vue -->
<template>
  <main class="min-h-full bg-slate-50 text-slate-950" :style="themeVars">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-32 top-0 h-80 w-80 rounded-full bg-blue-100/80 blur-3xl"></div>
      <div class="absolute right-0 top-20 h-104 w-104 rounded-full bg-sky-100/70 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-80 w-80 rounded-full bg-cyan-100/60 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-[0.38]"></div>
    </div>

    <div class="mx-auto space-y-4 p-3 sm:p-5 lg:p-6">
      <section class="overflow-hidden rounded-[1.75rem] border border-slate-200/80 bg-white/90 shadow-sm backdrop-blur-xl">
        <div class="relative p-4 sm:p-5 lg:p-6">
          <div class="pointer-events-none absolute -right-20 -top-24 h-72 w-72 rounded-full bg-blue-100 blur-3xl"></div>
          <div class="pointer-events-none absolute -bottom-28 left-1/4 h-72 w-72 rounded-full bg-cyan-50 blur-3xl"></div>

          <div class="relative grid gap-5 lg:grid-cols-[1fr_auto] lg:items-center">
            <div class="flex min-w-0 items-start gap-3 sm:gap-4">
              <div class="flex h-14 w-14 shrink-0 items-center justify-center overflow-hidden rounded-[1.35rem] border border-slate-200 bg-white p-2 shadow-sm sm:h-16 sm:w-16">
                <img
                  v-if="brandLogo && !logoError"
                  :src="brandLogo"
                  :alt="appName"
                  class="h-full w-full object-contain"
                  @error="logoError = true"
                >
                <Icon v-else icon="lucide:landmark" class="h-8 w-8 text-blue-600" />
              </div>

              <div class="min-w-0">
                <div class="flex flex-wrap items-center gap-2">
                  <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-2.5 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                    <Icon icon="lucide:building-2" class="h-3.5 w-3.5" />
                    Arsades Desa
                  </span>
                  <span class="inline-flex items-center gap-1.5 rounded-full border border-slate-200 bg-slate-50 px-2.5 py-1 text-[11px] font-bold text-slate-500">
                    <Icon icon="lucide:calendar-days" class="h-3.5 w-3.5" />
                    {{ todayLabel }}
                  </span>
                </div>

                <h1 class="mt-3 text-2xl font-black tracking-tight text-slate-950 sm:text-3xl lg:text-4xl">
                  Dashboard Data Desa {{ cleanVillageName }}
                </h1>

                <p class="mt-2 max-w-3xl text-sm font-medium leading-6 text-slate-500 sm:text-[15px]">
                  Ringkasan berita, organisasi, fasilitas, potensi, dan lembaga dalam satu tampilan yang rapi, padat, dan siap dipakai untuk evaluasi konten publik.
                </p>
              </div>
            </div>

            <div class="flex flex-wrap items-center gap-2 lg:justify-end">
              <button
                type="button"
                class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-4 text-sm font-black text-slate-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                @click="refreshDashboard"
              >
                <Icon icon="lucide:refresh-cw" class="h-4 w-4" :class="pending ? 'animate-spin' : ''" />
                Perbarui
              </button>

              <NuxtLink
                to="/"
                class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
              >
                <Icon icon="lucide:external-link" class="h-4 w-4" />
                Lihat Website
              </NuxtLink>
            </div>
          </div>
        </div>
      </section>

      <section v-if="visibleFetchErrors.length" class="rounded-[1.5rem] border border-amber-200 bg-amber-50/90 p-4 text-sm font-bold leading-6 text-amber-800 shadow-sm">
        <div class="flex items-start gap-3">
          <Icon icon="lucide:circle-alert" class="mt-0.5 h-5 w-5 shrink-0" />
          <div>
            <p>Beberapa data belum berhasil dimuat.</p>
            <p class="mt-1 text-xs font-semibold text-amber-700">
              {{ visibleFetchErrors.join(' · ') }}
            </p>
          </div>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-5">
        <article
          v-for="card in summaryCards"
          :key="card.label"
          class="group rounded-[1.5rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="flex items-start justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-slate-400">
                {{ card.label }}
              </p>
              <p class="mt-2 text-2xl font-black tracking-tight text-slate-950">
                {{ card.value }}
              </p>
            </div>

            <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
              <Icon :icon="card.icon" class="h-5 w-5" />
            </div>
          </div>

          <p class="mt-3 text-xs font-semibold leading-5 text-slate-500">
            {{ card.description }}
          </p>
        </article>
      </section>

      <section class="grid gap-4 lg:grid-cols-[0.9fr_1.1fr]">
        <article class="rounded-[1.75rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm sm:p-5">
          <div class="flex items-start justify-between gap-4">
            <div>
              <p class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                <Icon icon="lucide:badge-check" class="h-3.5 w-3.5" />
                Kesimpulan
              </p>
              <h2 class="mt-3 text-xl font-black tracking-tight text-slate-950">
                {{ conclusion.title }}
              </h2>
              <p class="mt-2 text-sm font-medium leading-6 text-slate-500">
                {{ conclusion.description }}
              </p>
            </div>

            <div class="relative grid h-24 w-24 shrink-0 place-items-center">
              <svg viewBox="0 0 100 100" class="h-24 w-24 -rotate-90">
                <circle cx="50" cy="50" r="42" fill="none" stroke="rgb(226 232 240)" stroke-width="10" />
                <circle
                  cx="50"
                  cy="50"
                  r="42"
                  fill="none"
                  stroke="#2563eb"
                  stroke-linecap="round"
                  stroke-width="10"
                  :stroke-dasharray="`${scoreDash} 264`"
                />
              </svg>
              <div class="absolute text-center">
                <p class="text-xl font-black text-slate-950">{{ completionScore }}%</p>
                <p class="text-[10px] font-black uppercase tracking-[0.14em] text-slate-400">siap</p>
              </div>
            </div>
          </div>

          <div class="mt-4 rounded-[1.35rem] border border-blue-100 bg-blue-50/70 p-4">
            <div class="flex items-start gap-3">
              <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                <Icon :icon="topSuggestion.icon" class="h-5 w-5" />
              </div>
              <div>
                <p class="text-sm font-black text-slate-950">
                  {{ topSuggestion.title }}
                </p>
                <p class="mt-1 text-sm font-medium leading-6 text-slate-600">
                  {{ topSuggestion.description }}
                </p>
              </div>
            </div>
          </div>
        </article>

        <article class="rounded-[1.75rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm sm:p-5">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                Fokus Perbaikan
              </p>
              <h2 class="mt-1 text-lg font-black tracking-tight text-slate-950">
                Prioritas berikutnya
              </h2>
            </div>
          </div>

          <div class="mt-4 grid gap-2">
            <NuxtLink
              v-for="action in priorityActions"
              :key="action.title"
              :to="action.href"
              class="group flex items-center gap-3 rounded-[1.25rem] border border-slate-200 bg-white p-3 transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50"
            >
              <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-slate-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
                <Icon :icon="action.icon" class="h-5 w-5" />
              </div>
              <div class="min-w-0 flex-1">
                <p class="truncate text-sm font-black text-slate-950">
                  {{ action.title }}
                </p>
                <p class="truncate text-xs font-semibold text-slate-500">
                  {{ action.description }}
                </p>
              </div>
              <Icon icon="lucide:arrow-up-right" class="h-4 w-4 text-slate-300 transition group-hover:text-blue-600" />
            </NuxtLink>
          </div>
        </article>
      </section>

      <section>
        <div class="mb-3 flex items-end justify-between gap-3">
          <div>
            <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
              Modul Data
            </p>
            <h2 class="mt-1 text-xl font-black tracking-tight text-slate-950">
              Distribusi Konten Publik
            </h2>
          </div>

          <p class="hidden text-xs font-bold text-slate-400 sm:block">
            Tenant: {{ tenantSlug }}
          </p>
        </div>

        <div class="grid gap-3 sm:grid-cols-2 xl:grid-cols-5">
          <article
            v-for="module in moduleSummaries"
            :key="module.key"
            class="group rounded-[1.5rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
          >
            <div class="flex items-start justify-between gap-3">
              <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
                <Icon :icon="module.icon" class="h-5 w-5" />
              </div>
              <span
                class="rounded-full px-2.5 py-1 text-[10px] font-black"
                :class="module.total > 0 ? 'bg-emerald-50 text-emerald-700' : 'bg-amber-50 text-amber-700'"
              >
                {{ module.total > 0 ? 'Terisi' : 'Kosong' }}
              </span>
            </div>

            <h3 class="mt-4 text-base font-black text-slate-950">
              {{ module.label }}
            </h3>

            <div class="mt-2 flex items-end gap-2">
              <p class="text-3xl font-black tracking-tight text-slate-950">
                {{ numberFormat(module.total) }}
              </p>
              <p class="pb-1 text-xs font-bold text-slate-400">
                data
              </p>
            </div>

            <div class="mt-4 grid grid-cols-3 gap-2">
              <div class="rounded-2xl bg-slate-50 p-2">
                <p class="text-[10px] font-black uppercase text-slate-400">Aktif</p>
                <p class="mt-1 text-sm font-black text-slate-950">{{ numberFormat(module.active) }}</p>
              </div>
              <div class="rounded-2xl bg-slate-50 p-2">
                <p class="text-[10px] font-black uppercase text-slate-400">Utama</p>
                <p class="mt-1 text-sm font-black text-slate-950">{{ numberFormat(module.featured) }}</p>
              </div>
              <div class="rounded-2xl bg-slate-50 p-2">
                <p class="text-[10px] font-black uppercase text-slate-400">Media</p>
                <p class="mt-1 text-sm font-black text-slate-950">{{ numberFormat(module.withMedia) }}</p>
              </div>
            </div>

            <div class="mt-4 h-2 overflow-hidden rounded-full bg-slate-100">
              <div
                class="h-full rounded-full bg-blue-600 transition-all duration-500"
                :style="{ width: `${module.distributionPercent}%` }"
              ></div>
            </div>

            <div class="mt-4 grid grid-cols-2 gap-2">
              <NuxtLink
                :to="module.adminHref"
                class="inline-flex h-9 items-center justify-center rounded-2xl bg-slate-950 px-3 text-xs font-black text-white transition hover:-translate-y-0.5 hover:bg-blue-600"
              >
                Kelola
              </NuxtLink>
              <NuxtLink
                :to="module.publicHref"
                class="inline-flex h-9 items-center justify-center rounded-2xl border border-slate-200 bg-white px-3 text-xs font-black text-slate-700 transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              >
                Publik
              </NuxtLink>
            </div>
          </article>
        </div>
      </section>

      <section class="grid gap-4 lg:grid-cols-[1.15fr_1.0fr]">
        <article class="rounded-[1.75rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm sm:p-5">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                Update Terbaru
              </p>
              <h2 class="mt-1 text-lg font-black tracking-tight text-slate-950">
                Data terakhir diperbarui
              </h2>
            </div>

            <NuxtLink
              to="/app/news"
              class="hidden rounded-2xl border border-slate-200 bg-white px-3 py-2 text-xs font-black text-slate-600 transition hover:bg-blue-50 hover:text-blue-700 sm:inline-flex"
            >
              Kelola Konten
            </NuxtLink>
          </div>

          <div v-if="pending" class="mt-4 grid gap-3">
            <div v-for="item in 5" :key="item" class="h-20 animate-pulse rounded-[1.25rem] bg-slate-100"></div>
          </div>

          <div v-else-if="latestItems.length" class="mt-4 grid gap-2">
            <article
              v-for="item in latestItems"
              :key="item.id"
              class="group flex items-center gap-3 rounded-[1.25rem] border border-slate-200 bg-white p-2.5 transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50/60"
            >
              <div class="h-14 w-14 shrink-0 overflow-hidden rounded-2xl bg-blue-50">
                <img
                  v-if="item.image"
                  :src="item.image"
                  :alt="item.title"
                  class="h-full w-full object-cover"
                >
                <div v-else class="grid h-full w-full place-items-center text-blue-600">
                  <Icon :icon="item.icon" class="h-6 w-6" />
                </div>
              </div>

              <div class="min-w-0 flex-1">
                <div class="flex flex-wrap items-center gap-2">
                  <span class="rounded-full bg-blue-50 px-2 py-0.5 text-[10px] font-black text-blue-700">
                    {{ item.moduleLabel }}
                  </span>
                  <span class="text-[11px] font-semibold text-slate-400">
                    {{ formatDate(item.date) }}
                  </span>
                </div>

                <h3 class="mt-1 truncate text-sm font-black text-slate-950">
                  {{ item.title }}
                </h3>
                <p class="truncate text-xs font-semibold text-slate-500">
                  {{ item.description || 'Belum ada ringkasan.' }}
                </p>
              </div>

              <div class="hidden shrink-0 gap-1 sm:flex">
                <NuxtLink
                  :to="item.adminHref"
                  class="grid h-9 w-9 place-items-center rounded-2xl bg-white text-slate-500 shadow-sm ring-1 ring-slate-200 transition hover:bg-blue-600 hover:text-white"
                  aria-label="Kelola"
                >
                  <Icon icon="lucide:pencil" class="h-4 w-4" />
                </NuxtLink>
                <NuxtLink
                  :to="item.publicHref"
                  class="grid h-9 w-9 place-items-center rounded-2xl bg-white text-slate-500 shadow-sm ring-1 ring-slate-200 transition hover:bg-blue-600 hover:text-white"
                  aria-label="Buka publik"
                >
                  <Icon icon="lucide:external-link" class="h-4 w-4" />
                </NuxtLink>
              </div>
            </article>
          </div>

          <div v-else class="mt-4 rounded-[1.5rem] border border-dashed border-slate-300 bg-slate-50 p-8 text-center">
            <Icon icon="lucide:database" class="mx-auto h-10 w-10 text-slate-300" />
            <p class="mt-3 text-sm font-black text-slate-700">Belum ada data yang terbaca.</p>
            <p class="mt-1 text-xs font-semibold text-slate-500">Coba tekan Perbarui atau cek tenant aktif: {{ tenantSlug }}.</p>
          </div>
        </article>

        <aside class="rounded-[1.75rem] border border-slate-200/80 bg-white/90 p-4 shadow-sm sm:p-5">
          <div>
            <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
              Catatan Data
            </p>
            <h2 class="mt-1 text-lg font-black tracking-tight text-slate-950">
              Kondisi tiap modul
            </h2>
          </div>

          <div class="mt-4 grid gap-2">
            <NuxtLink
              v-for="note in dataNotes"
              :key="note.title"
              :to="note.href"
              class="group flex items-start gap-3 rounded-[1.25rem] border p-3 transition hover:-translate-y-0.5"
              :class="note.tone === 'good'
                ? 'border-emerald-100 bg-emerald-50/60 hover:bg-emerald-50'
                : 'border-amber-100 bg-amber-50/60 hover:bg-amber-50'"
            >
              <div
                class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl bg-white shadow-sm"
                :class="note.tone === 'good' ? 'text-emerald-600' : 'text-amber-600'"
              >
                <Icon :icon="note.icon" class="h-4.5 w-4.5" />
              </div>

              <div class="min-w-0">
                <p class="text-sm font-black text-slate-950">
                  {{ note.title }}
                </p>
                <p class="mt-0.5 line-clamp-2 text-xs font-semibold leading-5 text-slate-500">
                  {{ note.description }}
                </p>
              </div>
            </NuxtLink>
          </div>
        </aside>
      </section>
    </div>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, ref } from 'vue'
import {
  useAsyncData,
  useHead,
  useRequestURL,
  useRuntimeConfig,
  useSeoMeta
} from 'nuxt/app'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Dashboard'
  }
})

type ModuleKey = 'news' | 'organizations' | 'facilities' | 'potentials' | 'institutions'

type DashboardItem = {
  id?: string | number
  title?: string | null
  name?: string | null
  displayName?: string | null
  subtitle?: string | null
  excerpt?: string | null
  shortDescription?: string | null
  description?: string | null
  contentHtml?: string | null
  content?: string | { html?: string; json?: any } | null
  slug?: string | null
  status?: string | null
  publishStatus?: string | null
  visibility?: string | null
  isFeatured?: boolean | number | string | null
  featured?: boolean | number | string | null
  isPinned?: boolean | number | string | null
  imageUrl?: string | null
  coverUrl?: string | null
  cover?: string | null
  logoUrl?: string | null
  thumbnailUrl?: string | null
  metadata?: Record<string, any> | null
  createdAt?: string | number | null
  updatedAt?: string | number | null
  publishedAt?: string | number | null
}

type CollectionResponse = {
  data?: DashboardItem[] | CollectionResponse | Record<string, any>
  items?: DashboardItem[]
  rows?: DashboardItem[]
  records?: DashboardItem[]
  results?: DashboardItem[]
  meta?: {
    total?: number
    page?: number
    limit?: number
    totalPages?: number
  }
  pagination?: {
    total?: number
  }
  total?: number
  [key: string]: any
}

type ModuleConfig = {
  key: ModuleKey
  label: string
  singular: string
  endpoint: string
  publicHref: string
  adminHref: string
  icon: string
}

type ModuleFetchResult = {
  key: ModuleKey
  total: number
  items: DashboardItem[]
  error?: string
}

type LatestItem = {
  id: string
  moduleKey: ModuleKey
  moduleLabel: string
  title: string
  description: string
  slug: string
  image: string
  icon: string
  date: number
  adminHref: string
  publicHref: string
}

type NoteItem = {
  title: string
  description: string
  href: string
  icon: string
  tone: 'good' | 'warning'
}

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const logoError = ref(false)

const { tenantApiUrl } = useAppApi()

const modules: ModuleConfig[] = [
  {
    key: 'news',
    label: 'Berita',
    singular: 'berita',
    endpoint: '/news',
    publicHref: '/news',
    adminHref: '/app/news',
    icon: 'lucide:newspaper'
  },
  {
    key: 'organizations',
    label: 'Organisasi',
    singular: 'organisasi',
    endpoint: '/organizations',
    publicHref: '/organizations',
    adminHref: '/app/organizations',
    icon: 'lucide:users-round'
  },
  {
    key: 'facilities',
    label: 'Fasilitas',
    singular: 'fasilitas',
    endpoint: '/facilities',
    publicHref: '/facilities',
    adminHref: '/app/facilities',
    icon: 'lucide:building-2'
  },
  {
    key: 'potentials',
    label: 'Potensi',
    singular: 'potensi',
    endpoint: '/potentials',
    publicHref: '/potentials',
    adminHref: '/app/potentials',
    icon: 'lucide:sprout'
  },
  {
    key: 'institutions',
    label: 'Lembaga',
    singular: 'lembaga',
    endpoint: '/institutions',
    publicHref: '/institutions',
    adminHref: '/app/institutions',
    icon: 'lucide:landmark'
  }
]

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const tenantSlug = computed(() => {
  const envClient = String(config.public.clientName || config.public.tenantSlug || 'martopuro')
    .trim()
    .toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const appName = computed(() => {
  return String(
    config.public.appName ||
    config.public.clientDisplayName ||
    config.public.siteName ||
    'Arsades'
  )
})

const cleanVillageName = computed(() => {
  return String(
    config.public.clientDisplayName ||
    config.public.siteName ||
    config.public.clientName ||
    'Desa'
  )
    .replace(/^desa\s+/i, '')
    .trim()
})

const brandLogo = computed(() => {
  if (logoError.value) return ''

  return normalizeAssetUrl(
    String(
      config.public.appLogo ||
      config.public.appLogoUrl ||
      config.public.logoUrl ||
      config.public.logo ||
      config.public.siteLogo ||
      '/logo.png'
    )
  )
})

const todayLabel = computed(() => {
  return new Intl.DateTimeFormat('id-ID', {
    weekday: 'long',
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(new Date())
})

const themeVars = computed<Record<string, string>>(() => ({
  '--brand': '#2563eb',
  '--brand-dark': '#1d4ed8',
  '--brand-soft': '#eff6ff'
}))

const {
  data: dashboardData,
  pending,
  refresh
} = await useAsyncData<Record<ModuleKey, ModuleFetchResult>>(
  'arsades-dashboard-summary-fixed',
  async () => {
    const results = await Promise.all(
      modules.map((module) => fetchModuleData(module))
    )

    return results.reduce<Record<ModuleKey, ModuleFetchResult>>((acc, result) => {
      acc[result.key] = result
      return acc
    }, createEmptyDashboardData())
  },
  {
    watch: [tenantSlug],
    default: () => createEmptyDashboardData()
  }
)

const moduleSummaries = computed(() => {
  const totalAll = modules.reduce((sum, module) => {
    return sum + getModuleTotal(module.key)
  }, 0)

  return modules.map((module) => {
    const result = dashboardData.value?.[module.key] || {
      key: module.key,
      total: 0,
      items: []
    }

    const items = result.items || []
    const total = Number(result.total || items.length || 0)
    const active = items.filter(isActiveItem).length
    const featured = items.filter(isFeaturedItem).length
    const withMedia = items.filter((item) => Boolean(getItemImage(item))).length
    const distributionPercent = totalAll > 0 ? Math.max(5, Math.round((total / totalAll) * 100)) : 0

    return {
      ...module,
      total,
      active,
      featured,
      withMedia,
      distributionPercent,
      error: result.error || ''
    }
  })
})

const overall = computed(() => {
  return moduleSummaries.value.reduce(
    (acc, module) => {
      acc.total += module.total
      acc.active += module.active
      acc.featured += module.featured
      acc.withMedia += module.withMedia
      acc.nonEmptyModules += module.total > 0 ? 1 : 0

      return acc
    },
    {
      total: 0,
      active: 0,
      featured: 0,
      withMedia: 0,
      nonEmptyModules: 0
    }
  )
})

const completionScore = computed(() => {
  if (overall.value.total === 0) return 0

  const moduleFillScore = (overall.value.nonEmptyModules / modules.length) * 44
  const activeScore = (overall.value.active / Math.max(overall.value.total, 1)) * 34
  const mediaScore = (overall.value.withMedia / Math.max(overall.value.total, 1)) * 22

  return Math.min(100, Math.round(moduleFillScore + activeScore + mediaScore))
})

const scoreDash = computed(() => {
  return Math.round((completionScore.value / 100) * 264)
})

const summaryCards = computed(() => [
  {
    label: 'Total Data',
    value: numberFormat(overall.value.total),
    description: 'Jumlah seluruh data publik dari lima modul utama.',
    icon: 'lucide:database'
  },
  {
    label: 'Data Aktif',
    value: numberFormat(overall.value.active),
    description: 'Data yang siap tampil atau dianggap aktif untuk publik.',
    icon: 'lucide:circle-check-big'
  },
  {
    label: 'Unggulan',
    value: numberFormat(overall.value.featured),
    description: 'Konten yang ditandai penting untuk lebih ditonjolkan.',
    icon: 'lucide:sparkles'
  },
  {
    label: 'Bergambar',
    value: numberFormat(overall.value.withMedia),
    description: 'Data yang sudah memiliki gambar, logo, atau media utama.',
    icon: 'lucide:image'
  },
  {
    label: 'Kesiapan',
    value: `${completionScore.value}%`,
    description: 'Skor ringkas berdasarkan kelengkapan, status, dan media.',
    icon: 'lucide:gauge'
  }
])

const conclusion = computed(() => {
  const score = completionScore.value

  if (overall.value.total === 0) {
    return {
      title: 'Data belum terbaca di dashboard.',
      description:
        'Dashboard sekarang memakai tenant dan format respons yang lebih fleksibel. Tekan Perbarui, lalu pastikan endpoint modul sudah dapat diakses dari dashboard admin.'
    }
  }

  if (score >= 82) {
    return {
      title: 'Data publik desa sudah sangat siap.',
      description:
        'Mayoritas modul sudah terisi, aktif, dan memiliki media pendukung. Fokus berikutnya adalah menjaga update rutin dan memilih konten unggulan.'
    }
  }

  if (score >= 62) {
    return {
      title: 'Data publik desa sudah cukup baik.',
      description:
        'Beberapa modul utama sudah terisi. Lengkapi gambar, status aktif, dan konten unggulan agar website terlihat lebih profesional.'
    }
  }

  return {
    title: 'Data publik desa perlu dilengkapi.',
    description:
      'Masih ada modul yang kosong, belum aktif, atau belum memiliki media. Prioritaskan modul dengan data paling sedikit terlebih dahulu.'
  }
})

const topSuggestion = computed(() => {
  const emptyModule = moduleSummaries.value.find((module) => module.total === 0)

  if (emptyModule) {
    return {
      title: `Lengkapi data ${emptyModule.label.toLowerCase()}.`,
      description: `${emptyModule.label} belum memiliki data yang terbaca. Tambahkan atau pastikan data ${emptyModule.singular} sudah tersimpan pada tenant ${tenantSlug.value}.`,
      icon: emptyModule.icon
    }
  }

  const lowMedia = moduleSummaries.value
    .filter((module) => module.total > 0)
    .sort((a, b) => a.withMedia / Math.max(a.total, 1) - b.withMedia / Math.max(b.total, 1))[0]

  if (lowMedia && lowMedia.withMedia < lowMedia.total) {
    return {
      title: `Tambahkan gambar pada ${lowMedia.label.toLowerCase()}.`,
      description: 'Data yang memiliki gambar utama terlihat lebih menarik, mudah dipercaya, dan lebih siap tampil di halaman publik.',
      icon: 'lucide:image-plus'
    }
  }

  return {
    title: 'Pertahankan kualitas data.',
    description: 'Data utama sudah terlihat rapi. Lanjutkan dengan pembaruan berita berkala dan pilih konten unggulan untuk halaman publik.',
    icon: 'lucide:badge-check'
  }
})

const priorityActions = computed(() => {
  const actions = moduleSummaries.value
    .filter((module) => module.total === 0 || module.withMedia < module.total || module.featured === 0)
    .slice(0, 4)
    .map((module) => ({
      title: `Kelola ${module.label}`,
      description:
        module.total === 0
          ? `Tambahkan data ${module.singular} pertama.`
          : module.withMedia < module.total
            ? 'Lengkapi gambar utama dan ringkasan.'
            : 'Tandai data penting sebagai unggulan.',
      href: module.adminHref,
      icon: module.icon
    }))

  if (actions.length) return actions

  return [
    {
      title: 'Tambah berita terbaru',
      description: 'Jaga website desa tetap hidup dengan update rutin.',
      href: '/app/news',
      icon: 'lucide:newspaper'
    },
    {
      title: 'Periksa halaman publik',
      description: 'Pastikan semua tampilan sudah nyaman dibaca warga.',
      href: '/',
      icon: 'lucide:external-link'
    }
  ]
})

const latestItems = computed<LatestItem[]>(() => {
  return modules
    .flatMap((module) => {
      const items = dashboardData.value?.[module.key]?.items || []

      return items.map((item, index) => {
        const slug = String(item.slug || item.id || '').trim()

        return {
          id: `${module.key}-${String(item.id || slug || index)}`,
          moduleKey: module.key,
          moduleLabel: module.label,
          title: getItemTitle(item),
          description: getItemDescription(item),
          slug,
          image: getItemImage(item),
          icon: module.icon,
          date: getItemDate(item),
          adminHref: module.adminHref,
          publicHref: slug ? `${module.publicHref}?detail=${encodeURIComponent(slug)}` : module.publicHref
        }
      })
    })
    .sort((a, b) => b.date - a.date)
    .slice(0, 8)
})

const dataNotes = computed<NoteItem[]>(() => {
  const notes: NoteItem[] = []

  for (const module of moduleSummaries.value) {
    if (module.total === 0) {
      notes.push({
        title: `${module.label} masih kosong`,
        description: `Tambahkan data ${module.singular} agar halaman publik tidak kosong.`,
        href: module.adminHref,
        icon: 'lucide:plus-circle',
        tone: 'warning'
      })
      continue
    }

    if (module.active === 0) {
      notes.push({
        title: `${module.label} belum aktif`,
        description: `Ada data ${module.singular}, tetapi belum ada yang aktif untuk publik.`,
        href: module.adminHref,
        icon: 'lucide:circle-alert',
        tone: 'warning'
      })
      continue
    }

    if (module.withMedia < Math.ceil(module.total * 0.5)) {
      notes.push({
        title: `Gambar ${module.label.toLowerCase()} perlu ditambah`,
        description: 'Minimal separuh data sebaiknya memiliki gambar agar tampilan publik lebih menarik.',
        href: module.adminHref,
        icon: 'lucide:image-plus',
        tone: 'warning'
      })
      continue
    }

    notes.push({
      title: `${module.label} sudah rapi`,
      description: `${numberFormat(module.active)} data aktif dan siap ditampilkan ke publik.`,
      href: module.adminHref,
      icon: 'lucide:check-circle-2',
      tone: 'good'
    })
  }

  return notes
})

const visibleFetchErrors = computed(() => {
  return moduleSummaries.value
    .filter((module) => module.error)
    .map((module) => `${module.label}: ${module.error}`)
})

async function fetchModuleData(module: ModuleConfig): Promise<ModuleFetchResult> {
  const url = tenantApiUrl(tenantSlug.value, module.endpoint)
  const queryCandidates = [
    {
      limit: 200,
      page: 1,
      sort: 'newest'
    },
    {
      limit: 200,
      page: 1,
      sort: 'sort_order'
    },
    {
      limit: 200,
      page: 1,
      status: 'all',
      sort: 'newest'
    },
    {
      limit: 200,
      page: 1,
      status: 'active',
      sort: 'newest'
    },
    {
      limit: 200,
      page: 1,
      status: 'published',
      sort: 'newest'
    }
  ]

  let best: ModuleFetchResult = {
    key: module.key,
    total: 0,
    items: []
  }

  let lastError = ''

  for (const query of queryCandidates) {
    try {
      const response = await $fetch<CollectionResponse | DashboardItem[]>(url, {
        query
      })

      const items = normalizeResponseItems(response, module.key)
      const total = normalizeResponseTotal(response, items.length)

      if (items.length > best.items.length || total > best.total) {
        best = {
          key: module.key,
          total,
          items
        }
      }

      if (items.length || total) break
    } catch (error: any) {
      lastError = error?.data?.message || error?.message || 'Data belum dapat dimuat.'
    }
  }

  if (best.items.length || best.total) return best

  return {
    ...best,
    error: lastError
  }
}

function createEmptyDashboardData() {
  return modules.reduce<Record<ModuleKey, ModuleFetchResult>>((acc, module) => {
    acc[module.key] = {
      key: module.key,
      total: 0,
      items: []
    }

    return acc
  }, {} as Record<ModuleKey, ModuleFetchResult>)
}

function normalizeResponseItems(response: CollectionResponse | DashboardItem[] | null | undefined, moduleKey: ModuleKey) {
  if (Array.isArray(response)) return response

  const candidatePaths = [
    response?.data,
    (response?.data as any)?.data,
    (response?.data as any)?.items,
    (response?.data as any)?.rows,
    (response?.data as any)?.records,
    (response?.data as any)?.results,
    (response?.data as any)?.[moduleKey],
    response?.items,
    response?.rows,
    response?.records,
    response?.results,
    response?.[moduleKey]
  ]

  for (const candidate of candidatePaths) {
    if (Array.isArray(candidate)) return candidate as DashboardItem[]
  }

  return []
}

function normalizeResponseTotal(response: CollectionResponse | DashboardItem[] | null | undefined, fallback: number) {
  if (Array.isArray(response)) return response.length

  const nestedData = response?.data as any

  return Number(
    response?.meta?.total ??
    nestedData?.meta?.total ??
    response?.pagination?.total ??
    nestedData?.pagination?.total ??
    response?.total ??
    nestedData?.total ??
    fallback
  )
}

function getModuleTotal(key: ModuleKey) {
  const result = dashboardData.value?.[key]

  if (!result) return 0

  return Number(result.total || result.items.length || 0)
}

function isActiveItem(item: DashboardItem) {
  const status = String(item.status || item.publishStatus || item.visibility || '')
    .trim()
    .toLowerCase()

  if (!status) return true

  return ['active', 'published', 'publish', 'live', 'public', 'enabled', 'true'].includes(status)
}

function isFeaturedItem(item: DashboardItem) {
  return item.isFeatured === true ||
    item.featured === true ||
    item.isPinned === true ||
    item.isFeatured === 1 ||
    item.featured === 1 ||
    item.isPinned === 1 ||
    item.isFeatured === 'true' ||
    item.featured === 'true' ||
    item.isPinned === 'true'
}

function getItemTitle(item: DashboardItem) {
  return String(item.title || item.displayName || item.name || 'Tanpa Judul').trim()
}

function getItemDescription(item: DashboardItem) {
  const contentValue =
    typeof item.content === 'string'
      ? item.content
      : item.content?.html || ''

  return plainText(
    item.excerpt ||
    item.subtitle ||
    item.shortDescription ||
    item.description ||
    item.contentHtml ||
    contentValue ||
    ''
  ).slice(0, 150)
}

function getItemImage(item: DashboardItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  return String(
    item.coverUrl ||
    item.imageUrl ||
    item.cover ||
    item.thumbnailUrl ||
    metadataImages?.[0] ||
    item.logoUrl ||
    ''
  ).trim()
}

function getItemDate(item: DashboardItem) {
  const value = item.updatedAt || item.publishedAt || item.createdAt || 0

  if (typeof value === 'number') {
    return value > 0 && value < 1_000_000_000_000 ? value * 1000 : value
  }

  const parsed = new Date(value).getTime()

  return Number.isFinite(parsed) ? parsed : 0
}

function formatDate(value?: number) {
  if (!value) return 'Belum ada tanggal'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(new Date(value))
}

function plainText(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, ' ')
    .replace(/<iframe[\s\S]*?>[\s\S]*?<\/iframe>/gi, ' ')
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

function numberFormat(value: number) {
  return new Intl.NumberFormat('id-ID').format(Number(value || 0))
}

function normalizeAssetUrl(value: string) {
  const cleanValue = String(value || '').trim()

  if (!cleanValue) return '/logo.png'
  if (/^https?:\/\//i.test(cleanValue)) return cleanValue
  if (cleanValue.startsWith('/')) return cleanValue

  return `/${cleanValue}`
}

function refreshDashboard() {
  refresh()
}

useSeoMeta({
  title: () => `Dashboard Arsades · ${appName.value}`,
  description: () => `Ringkasan data website desa ${cleanVillageName.value}: berita, organisasi, fasilitas, potensi, dan lembaga.`,
  ogTitle: () => `Dashboard Arsades · ${appName.value}`,
  ogDescription: () => `Ringkasan data website desa ${cleanVillageName.value}: berita, organisasi, fasilitas, potensi, dan lembaga.`,
  robots: 'noindex, nofollow',
  themeColor: '#2563eb'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  meta: [
    {
      name: 'theme-color',
      content: '#2563eb'
    }
  ]
}))
</script>

<style scoped>
.bg-grid {
  background-size: 40px 40px;
  background-image:
    linear-gradient(to right, rgb(226 232 240 / 0.8) 1px, transparent 1px),
    linear-gradient(to bottom, rgb(226 232 240 / 0.8) 1px, transparent 1px);
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
