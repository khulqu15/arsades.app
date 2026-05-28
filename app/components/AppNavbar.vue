<template>
    <header class="fixed inset-x-0 top-0 z-50 border-t-4 border-slate-900 bg-white/90 shadow-sm backdrop-blur-2xl">
        <nav class="mx-auto flex h-[60px] max-w-7xl items-center justify-between gap-4 px-4 sm:px-6 lg:px-8">
            <!-- Brand -->
            <NuxtLink to="/" class="flex min-w-0 items-center gap-3">
                <div class="grid h-10 w-10 shrink-0 place-items-center overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
                    <img :src="appLogo" :alt="appName" class="h-8 w-8 object-contain" />
                </div>
                <div class="min-w-0 leading-tight">
                    <p class="truncate text-[15px] font-black text-slate-900">
                        {{ appName }}
                    </p>
                    <p class="hidden truncate text-xs font-medium text-slate-500 sm:block">
                        Kecamatan Purwosari, Kab. Pasuruan
                    </p>
                </div>
            </NuxtLink>
            <!-- Desktop Menu -->
            <div class="hidden items-center gap-1 lg:flex">
                <NuxtLink v-for="item in mainLinks" :key="item.label" :to="item.href" class="rounded-xl px-3 py-2 text-sm font-semibold text-slate-600 transition hover:bg-slate-100 hover:text-slate-950">
                    {{ item.label }}
                </NuxtLink>
                <!-- Mega Menu Lembaga -->
                <div class="group/lembaga relative inline-flex">
                    <button type="button" class="inline-flex items-center gap-1.5 rounded-xl bg-slate-100 px-3 py-2 text-sm font-semibold text-slate-800 transition hover:bg-slate-200">
                        Lembaga
                        <Icon icon="lucide:chevron-down" class="h-4 w-4 transition group-hover/lembaga:rotate-180" />
                    </button>
                    <div class="pointer-events-none invisible fixed left-1/2 top-16 z-50 w-[min(1120px,calc(100vw-2rem))] -translate-x-1/2 translate-y-2 pt-3 opacity-0 transition duration-200 group-hover/lembaga:pointer-events-auto group-hover/lembaga:visible group-hover/lembaga:translate-y-0 group-hover/lembaga:opacity-100">
                        <div class="overflow-hidden rounded-[1.4rem] border border-slate-200 bg-white/95 p-5 shadow-2xl shadow-slate-900/10 backdrop-blur-2xl">
                            <div class="mb-4 flex items-center justify-between gap-4 border-b border-slate-100 pb-4">
                                <div>
                                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                                        Kelembagaan Desa
                                    </p>
                                    <h3 class="mt-1 text-lg font-black text-slate-950">
                                        Struktur Lembaga & Organisasi Desa
                                    </h3>
                                </div>
                                <NuxtLink
                                to="/institutions"
                                class="hidden rounded-xl border border-slate-200 bg-white px-3 py-2 text-xs font-black text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 md:inline-flex"
                                >
                                    Semua
                                </NuxtLink>
                            </div>
                            <div class="grid gap-x-8 gap-y-2 md:grid-cols-2 xl:grid-cols-3">
                            <!-- Loading Placeholder -->
                            <template v-if="institutionsPending">
                                <div
                                v-for="item in 12"
                                :key="`institution-skeleton-${item}`"
                                class="flex items-start gap-3 rounded-2xl p-3"
                                >
                                <div class="mt-0.5 h-9 w-9 shrink-0 animate-pulse rounded-xl bg-slate-100"></div>

                                <div class="min-w-0 flex-1">
                                    <div class="h-4 w-24 animate-pulse rounded-full bg-slate-100"></div>
                                    <div class="mt-2 h-3 w-40 animate-pulse rounded-full bg-slate-100"></div>
                                </div>
                                </div>
                            </template>

                            <!-- Data Institution -->
                            <template v-else-if="lembagaLinks.length">
                                <NuxtLink
                                v-for="item in lembagaLinks"
                                :key="item.href"
                                :to="item.href"
                                class="group/item flex items-start gap-3 rounded-2xl p-3 transition hover:bg-blue-50"
                                >
                                <div class="mt-0.5 grid h-9 w-9 shrink-0 place-items-center overflow-hidden rounded-xl bg-slate-50 text-slate-600 transition group-hover/item:bg-blue-600 group-hover/item:text-white">
                                    <img
                                    v-if="item.logoUrl"
                                    :src="item.logoUrl"
                                    :alt="item.label"
                                    class="h-full w-full object-cover"
                                    @error="hideBrokenImage"
                                    >
                                    <Icon
                                    v-else
                                    :icon="item.icon || 'solar:buildings-2-bold-duotone'"
                                    class="h-4 w-4"
                                    />
                                </div>

                                <div class="min-w-0">
                                    <p class="text-sm font-black uppercase tracking-[0.02em] text-slate-800 group-hover/item:text-blue-700">
                                    {{ item.label }}
                                    </p>
                                    <p class="mt-1 line-clamp-1 text-sm text-slate-500">
                                    {{ item.desc }}
                                    </p>
                                </div>
                                </NuxtLink>
                            </template>

                            <!-- Empty State -->
                            <div
                                v-else
                                class="col-span-full rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-5 text-center"
                            >
                                <Icon icon="solar:buildings-2-bold-duotone" class="mx-auto h-8 w-8 text-slate-400" />
                                <p class="mt-2 text-sm font-black text-slate-700">
                                Belum ada data lembaga
                                </p>
                                <p class="mt-1 text-xs font-medium text-slate-500">
                                Data kelembagaan akan tampil otomatis setelah ditambahkan dari dashboard.
                                </p>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Dropdown Fasilitas -->
                <div class="group/fasilitas relative inline-flex">
                    <button
                        type="button"
                        class="inline-flex items-center gap-1.5 rounded-xl px-3 py-2 text-sm font-semibold text-slate-600 transition hover:bg-slate-100 hover:text-slate-950"
                    >
                        Fasilitas
                        <Icon
                        icon="lucide:chevron-down"
                        class="h-4 w-4 transition group-hover/fasilitas:rotate-180"
                        />
                    </button>

                    <div class="invisible absolute left-0 top-[calc(100%+0.5rem)] z-50 w-[22rem] translate-y-2 rounded-[1.4rem] border border-slate-200 bg-white/95 p-3 opacity-0 shadow-2xl shadow-slate-900/10 backdrop-blur-2xl transition duration-200 group-hover/fasilitas:visible group-hover/fasilitas:translate-y-0 group-hover/fasilitas:opacity-100">
                        <div class="mb-2 flex items-center justify-between gap-3 border-b border-slate-100 px-2 pb-3">
                        <div>
                            <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                            Fasilitas Desa
                            </p>
                        </div>

                        <NuxtLink
                            to="/facilities"
                            class="rounded-xl border border-slate-200 bg-white px-3 py-2 text-xs font-black text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                        >
                            Semua
                        </NuxtLink>
                        </div>

                        <!-- Loading Placeholder -->
                        <template v-if="facilitiesPending">
                        <div
                            v-for="item in 8"
                            :key="`facility-skeleton-${item}`"
                            class="flex items-center gap-3 rounded-2xl px-3 py-3"
                        >
                            <div class="h-9 w-9 shrink-0 animate-pulse rounded-xl bg-slate-100"></div>

                            <div class="min-w-0 flex-1">
                            <div class="h-4 w-28 animate-pulse rounded-full bg-slate-100"></div>
                            <div class="mt-2 h-3 w-36 animate-pulse rounded-full bg-slate-100"></div>
                            </div>
                        </div>
                        </template>

                        <!-- Data Facilities -->
                        <template v-else-if="fasilitasLinks.length">
                            <NuxtLink
                                v-for="item in fasilitasLinks"
                                :key="item.href"
                                :to="item.href"
                                class="group/item flex items-start gap-3 rounded-2xl px-3 py-3 text-sm font-semibold text-slate-600 transition hover:bg-blue-50 hover:text-blue-700"
                            >
                                <div class="mt-0.5 grid h-9 w-9 shrink-0 place-items-center overflow-hidden rounded-xl bg-slate-50 text-slate-500 transition group-hover/item:bg-blue-600 group-hover/item:text-white">
                                    <img
                                        v-if="item.imageUrl"
                                        :src="item.imageUrl"
                                        :alt="item.label"
                                        class="h-full w-full object-cover"
                                        @error="hideBrokenImage"
                                    >

                                    <Icon
                                        v-else
                                        :icon="item.icon || 'solar:map-point-wave-bold-duotone'"
                                        class="h-4 w-4"
                                    />
                                </div>

                                <div class="min-w-0">
                                    <p class="truncate text-sm font-black text-slate-800 group-hover/item:text-blue-700">
                                        {{ item.label }}
                                    </p>
                                    <p class="mt-1 line-clamp-1 text-xs font-medium text-slate-500">
                                        {{ item.desc }}
                                    </p>
                                </div>
                            </NuxtLink>
                        </template>

                        <!-- Empty State -->
                        <div
                        v-else
                        class="rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-5 text-center"
                        >
                        <Icon icon="solar:map-point-wave-bold-duotone" class="mx-auto h-8 w-8 text-slate-400" />
                        <p class="mt-2 text-sm font-black text-slate-700">
                            Belum ada data fasilitas
                        </p>
                        <p class="mt-1 text-xs font-medium text-slate-500">
                            Data fasilitas akan tampil otomatis setelah ditambahkan dari dashboard.
                        </p>
                        </div>

                        <div class="mt-2 border-t border-slate-100 px-2 pt-3">
                        <NuxtLink
                            to="/facilities"
                            class="inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
                        >
                            Lihat Semua Fasilitas
                            <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
                        </NuxtLink>
                        </div>
                    </div>
                </div>
                <!-- Dropdown Potensi -->
                <div class="group/potensi relative inline-flex">
                    <button
                        type="button"
                        class="inline-flex items-center gap-1.5 rounded-xl px-3 py-2 text-sm font-semibold text-slate-600 transition hover:bg-slate-100 hover:text-slate-950"
                    >
                        Potensi
                        <Icon
                        icon="lucide:chevron-down"
                        class="h-4 w-4 transition group-hover/potensi:rotate-180"
                        />
                    </button>

                    <div class="invisible absolute left-0 top-[calc(100%+0.5rem)] z-50 w-[24rem] translate-y-2 rounded-[1.4rem] border border-slate-200 bg-white/95 p-3 opacity-0 shadow-2xl shadow-slate-900/10 backdrop-blur-2xl transition duration-200 group-hover/potensi:visible group-hover/potensi:translate-y-0 group-hover/potensi:opacity-100">
                        <div class="mb-2 flex items-center justify-between gap-3 border-b border-slate-100 px-2 pb-3">
                        <div>
                            <p class="text-xs font-black uppercase tracking-[0.16em] text-emerald-600">
                            Potensi Desa
                            </p>
                        </div>

                        <NuxtLink
                            to="/potentials"
                            class="rounded-xl border border-slate-200 bg-white px-3 py-2 text-xs font-black text-slate-600 transition hover:border-emerald-200 hover:bg-emerald-50 hover:text-emerald-700"
                        >
                            Semua
                        </NuxtLink>
                        </div>

                        <!-- Loading Placeholder -->
                        <template v-if="potentialsPending">
                        <div
                            v-for="item in 8"
                            :key="`potential-skeleton-${item}`"
                            class="flex items-center gap-3 rounded-2xl px-3 py-3"
                        >
                            <div class="h-9 w-9 shrink-0 animate-pulse rounded-xl bg-slate-100"></div>

                            <div class="min-w-0 flex-1">
                            <div class="h-4 w-28 animate-pulse rounded-full bg-slate-100"></div>
                            <div class="mt-2 h-3 w-36 animate-pulse rounded-full bg-slate-100"></div>
                            </div>
                        </div>
                        </template>

                        <!-- Data Potentials -->
                        <template v-else-if="potensiLinks.length">
                        <NuxtLink
                            v-for="item in potensiLinks"
                            :key="item.href"
                            :to="item.href"
                            class="group/item flex items-start gap-3 rounded-2xl px-3 py-3 text-sm font-semibold text-slate-600 transition hover:bg-emerald-50 hover:text-emerald-700"
                        >
                            <div class="mt-0.5 grid h-9 w-9 shrink-0 place-items-center overflow-hidden rounded-xl bg-slate-50 text-slate-500 transition group-hover/item:bg-emerald-600 group-hover/item:text-white">
                            <img
                                v-if="item.imageUrl"
                                :src="item.imageUrl"
                                :alt="item.label"
                                class="h-full w-full object-cover"
                                @error="hideBrokenImage"
                            >

                            <Icon
                                v-else
                                :icon="item.icon || 'solar:leaf-bold-duotone'"
                                class="h-4 w-4"
                            />
                            </div>

                            <div class="min-w-0">
                            <p class="truncate text-sm font-black text-slate-800 group-hover/item:text-emerald-700">
                                {{ item.label }}
                            </p>
                            <p class="mt-1 line-clamp-1 text-xs font-medium text-slate-500">
                                {{ item.desc }}
                            </p>
                            </div>
                        </NuxtLink>
                        </template>

                        <!-- Empty State -->
                        <div
                        v-else
                        class="rounded-2xl border border-dashed border-slate-200 bg-slate-50 p-5 text-center"
                        >
                        <Icon icon="solar:leaf-bold-duotone" class="mx-auto h-8 w-8 text-slate-400" />
                        <p class="mt-2 text-sm font-black text-slate-700">
                            Belum ada data potensi
                        </p>
                        <p class="mt-1 text-xs font-medium text-slate-500">
                            Data potensi akan tampil otomatis setelah ditambahkan dari dashboard.
                        </p>
                        </div>

                        <div class="mt-2 border-t border-slate-100 px-2 pt-3">
                        <NuxtLink
                            to="/potentials"
                            class="inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-emerald-600 px-4 py-3 text-sm font-black text-white shadow-lg shadow-emerald-600/20 transition hover:bg-emerald-700"
                        >
                            Lihat Semua Potensi
                            <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
                        </NuxtLink>
                        </div>
                    </div>
                </div>
                <NuxtLink v-for="item in rightLinks" :key="item.label" :to="item.href" class="rounded-xl px-3 py-2 text-sm font-semibold text-slate-600 transition hover:bg-slate-100 hover:text-slate-950">
                    {{ item.label }}
                </NuxtLink>
            </div>
            <!-- CTA -->
            <!-- <div class="hidden items-center gap-2 lg:flex">
                <NuxtLink to="/layanan/surat" class="inline-flex h-10 items-center justify-center rounded-xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700">
                    Ajukan Surat
                </NuxtLink>
            </div> -->
            <!-- Mobile Toggle -->
            <button id="martopuro-mobile-toggle" type="button" class="hs-collapse-toggle grid h-10 w-10 place-items-center rounded-xl border border-slate-200 bg-white text-slate-700 transition hover:bg-slate-100 lg:hidden" aria-expanded="false" aria-controls="martopuro-mobile-menu"
                aria-label="Toggle navigation" data-hs-collapse="#martopuro-mobile-menu">
                <Icon icon="lucide:menu" class="block h-5 w-5 hs-collapse-open:hidden" />
                <Icon icon="lucide:x" class="hidden h-5 w-5 hs-collapse-open:block" />
            </button>
        </nav>
        <!-- Mobile Menu -->
        <!-- <div id="martopuro-mobile-menu" class="hs-collapse hidden border-t border-slate-100 bg-white/95 px-4 pb-4 pt-2 backdrop-blur-2xl lg:hidden" aria-labelledby="martopuro-mobile-toggle">
            <div class="mx-auto grid max-w-7xl gap-2">
                <NuxtLink v-for="item in mobileLinks" :key="item.label" :to="item.href" class="flex items-center justify-between rounded-xl px-3 py-3 text-sm font-bold text-slate-700 transition hover:bg-blue-50 hover:text-blue-700">
                    <span>{{ item.label }}</span>
                    <Icon icon="lucide:chevron-right" class="h-4 w-4" />
                </NuxtLink>
                <NuxtLink to="/layanan/surat" class="mt-2 inline-flex h-11 items-center justify-center rounded-xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700">
                    Ajukan Surat
                </NuxtLink>
            </div>
        </div> -->
    </header>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Icon } from '@iconify/vue'
import { useRequestURL, useRuntimeConfig, useFetch } from "nuxt/app"
import { useAppApi } from '~/composables/useAppApi'

type NavItem = {
  label: string
  href: string
  icon?: string
  desc?: string
  logoUrl?: string
  imageUrl?: string
}

type InstitutionItem = {
  id: string
  title: string
  subtitle: string | null
  slug: string
  icon: string | null
  logoUrl: string | null
  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number
}

type InstitutionListResponse = {
  data: InstitutionItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}


type FacilityType =
  | 'health'
  | 'market'
  | 'education'
  | 'sport'
  | 'emergency'
  | 'transport'
  | 'water'
  | 'public_service'
  | 'office'
  | 'worship'
  | 'tourism'
  | 'security'
  | 'custom'

type FacilityItem = {
  id: string
  facilityType: FacilityType
  title: string
  subtitle: string | null
  slug: string
  icon: string | null
  logoUrl: string | null
  imageUrl: string | null
  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number
  metadata?: Record<string, any>
}

type FacilityListResponse = {
  data: FacilityItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type PotentialType =
  | 'agriculture'
  | 'livestock'
  | 'fishery'
  | 'umkm'
  | 'tourism'
  | 'culture'
  | 'natural_resource'
  | 'human_resource'
  | 'industry'
  | 'creative_economy'
  | 'food'
  | 'craft'
  | 'custom'

type PotentialItem = {
  id: string
  potentialType: PotentialType
  title: string
  subtitle: string | null
  slug: string
  icon: string | null
  logoUrl: string | null
  imageUrl: string | null
  marketReach?: string | null
  productionCapacity?: string | null
  productionUnit?: string | null
  status: 'active' | 'inactive'
  isFeatured: boolean
  sortOrder: number
  metadata?: Record<string, any>
}

type PotentialListResponse = {
  data: PotentialItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

const config = useRuntimeConfig()

const appName = computed(() => {
    return String(config.public.appName || config.public.clientDisplayName || 'Desa Martopuro')
})
const appLogo = computed(() => {
    return String(config.public.appLogo || 'https://martopuro.sencra.io/martopuro-logo.png')
})
  
const mainLinks: NavItem[] = [{
        label: 'Profil',
        href: '/profile'
    },
    {
        label: 'Berita',
        href: '/news'
    }
]
const requestUrl = useRequestURL()

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const { tenantApiUrl } = useAppApi()

const tenantSlug = computed(() => {
  const envClient = String(config.public.clientName || 'martopuro')
    .trim()
    .toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const institutionsApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, `/institutions`)
})

const {
  data: institutionsResponse,
  pending: institutionsPending
} = useFetch<InstitutionListResponse>(institutionsApiUrl, {
  key: computed(() => `navbar-institutions-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 12,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 12,
      total: 0,
      totalPages: 1
    }
  })
})

function detailUrl(basePath: '/institutions' | '/facilities' | '/potentials', slug: string) {
  const cleanSlug = String(slug || '').trim()

  if (!cleanSlug) return basePath

  return `${basePath}?detail=${encodeURIComponent(cleanSlug)}`
}

const lembagaLinks = computed<NavItem[]>(() => {
  return (institutionsResponse.value?.data || [])
    .slice(0, 12)
    .map((item) => ({
      label: item.title,
      href: detailUrl('/institutions', item.slug),
      icon: item.icon || 'solar:buildings-2-bold-duotone',
      logoUrl: item.logoUrl || '',
      desc: item.subtitle || 'Informasi lembaga desa'
    }))
})

function hideBrokenImage(event: Event) {
  const target = event.target as HTMLImageElement
  target.style.display = 'none'
}

function getFacilityTypeIcon(type: FacilityType) {
  const map: Record<FacilityType, string> = {
    health: 'lucide:hospital',
    market: 'lucide:store',
    education: 'lucide:school',
    sport: 'lucide:trophy',
    emergency: 'lucide:ambulance',
    transport: 'lucide:car',
    water: 'lucide:droplets',
    public_service: 'lucide:clipboard-list',
    office: 'lucide:building-2',
    worship: 'lucide:landmark',
    tourism: 'lucide:map-pin',
    security: 'lucide:shield-check',
    custom: 'lucide:layers'
  }

  return map[type] || 'lucide:layers'
}

function facilityTypeLabel(type: FacilityType) {
  const map: Record<FacilityType, string> = {
    health: 'Kesehatan',
    market: 'Pasar',
    education: 'Pendidikan',
    sport: 'Olahraga',
    emergency: 'Darurat',
    transport: 'Transportasi',
    water: 'Air Bersih',
    public_service: 'Pelayanan Publik',
    office: 'Kantor',
    worship: 'Tempat Ibadah',
    tourism: 'Wisata',
    security: 'Keamanan',
    custom: 'Fasilitas Desa'
  }

  return map[type] || 'Fasilitas Desa'
}

function getFacilityImage(item: FacilityItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  return item.imageUrl || metadataImages[0] || item.logoUrl || ''
}

function getPotentialTypeIcon(type: PotentialType) {
  const map: Record<PotentialType, string> = {
    agriculture: 'lucide:wheat',
    livestock: 'lucide:cow',
    fishery: 'lucide:fish',
    umkm: 'lucide:store',
    tourism: 'lucide:map-pin',
    culture: 'lucide:landmark',
    natural_resource: 'lucide:mountain',
    human_resource: 'lucide:users',
    industry: 'lucide:factory',
    creative_economy: 'lucide:palette',
    food: 'lucide:utensils',
    craft: 'lucide:gem',
    custom: 'lucide:layers'
  }

  return map[type] || 'lucide:layers'
}

function potentialTypeLabel(type: PotentialType) {
  const map: Record<PotentialType, string> = {
    agriculture: 'Pertanian',
    livestock: 'Peternakan',
    fishery: 'Perikanan',
    umkm: 'UMKM',
    tourism: 'Wisata',
    culture: 'Budaya',
    natural_resource: 'Sumber Daya Alam',
    human_resource: 'Sumber Daya Manusia',
    industry: 'Industri',
    creative_economy: 'Ekonomi Kreatif',
    food: 'Kuliner',
    craft: 'Kerajinan',
    custom: 'Potensi Desa'
  }

  return map[type] || 'Potensi Desa'
}

function getPotentialImage(item: PotentialItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  return item.imageUrl || metadataImages[0] || item.logoUrl || ''
}

const facilitiesApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/facilities')
})

const {
  data: facilitiesResponse,
  pending: facilitiesPending
} = useFetch<FacilityListResponse>(facilitiesApiUrl, {
  key: computed(() => `navbar-facilities-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 8,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 8,
      total: 0,
      totalPages: 1
    }
  })
})

const fasilitasLinks = computed<NavItem[]>(() => {
  return (facilitiesResponse.value?.data || [])
    .slice(0, 8)
    .map((item) => ({
      label: item.title,
      href: detailUrl('/facilities', item.slug),
      icon: item.icon || getFacilityTypeIcon(item.facilityType),
      imageUrl: getFacilityImage(item),
      desc:
        item.subtitle ||
        facilityTypeLabel(item.facilityType)
    }))
})

const potentialsApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/potentials')
})

const {
  data: potentialsResponse,
  pending: potentialsPending
} = useFetch<PotentialListResponse>(potentialsApiUrl, {
  key: computed(() => `navbar-potentials-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 8,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 8,
      total: 0,
      totalPages: 1
    }
  })
})

const potensiLinks = computed<NavItem[]>(() => {
  return (potentialsResponse.value?.data || [])
    .slice(0, 8)
    .map((item) => ({
      label: item.title,
      href: detailUrl('/potentials', item.slug),
      icon: item.icon || getPotentialTypeIcon(item.potentialType),
      imageUrl: getPotentialImage(item),
      desc:
        item.subtitle ||
        item.marketReach ||
        potentialTypeLabel(item.potentialType)
    }))
})

const rightLinks: NavItem[] = [{
        label: 'Status Desa',
        href: '/status'
    },
    {
        label: 'APBDes',
        href: '/apbd'
    }
]
const mobileLinks = computed<NavItem[]>(() => {
  return [
    ...mainLinks,
    {
      label: 'Lembaga',
      href: '/institutions'
    },
    {
      label: 'Fasilitas',
      href: '/facilities'
    },
    {
      label: 'Potensi',
      href: '/potentials'
    },
    ...rightLinks
  ]
})
</script>