<template>
    <section id="home" aria-label="Hero Desa" class="relative isolate min-h-screen overflow-hidden bg-slate-50 text-slate-900">
        <div class="pointer-events-none absolute inset-0 -z-10">
            <div class="absolute inset-0 bg-[linear-linear(to_right,#e2e8f0_1px,transparent_1px),linear-linear(to_bottom,#e2e8f0_1px,transparent_1px)] bg-size-[44px_44px] opacity-45"></div>
            <div class="absolute -left-32 -top-32 h-[520px] w-[520px] rounded-full bg-cyan-200/60 blur-3xl"></div>
            <div class="absolute -right-24 bottom-0 h-[520px] w-[520px] rounded-full bg-blue-200/60 blur-3xl"></div>
            <div class="absolute left-1/2 top-1/3 h-[360px] w-[360px] -translate-x-1/2 rounded-full bg-white/80 blur-3xl"></div>
        </div>
        <div class="mx-auto grid min-h-screen max-w-7xl items-center gap-12 px-4 py-28 sm:px-6 lg:grid-cols-[1.02fr_0.98fr] lg:px-8">
            <div class="relative z-10">
                <div class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-blue-50/90 px-3 py-1.5 text-xs font-bold text-blue-700 shadow-sm backdrop-blur">
                    <ClientOnly>
                        <Icon icon="lucide:badge-check" class="h-4 w-4" />
                    </ClientOnly>
                    {{ c.tagline }}
                </div>
                <h1 class="mt-6 max-w-3xl text-4xl font-black leading-[1.05] tracking-tight text-slate-950 sm:text-5xl lg:text-6xl">
                    {{ c.titleMain }}
                    <span class="bg-linear-to-r from-blue-600 via-sky-500 to-cyan-500 bg-clip-text text-transparent">
                        {{ c.titleHighlight }}
                    </span>
                </h1>
                <p class="mt-6 max-w-2xl text-base leading-8 text-slate-600 sm:text-lg">
                    {{ c.subtitle }}
                </p>
                <div class="mt-8 flex flex-col gap-3 sm:flex-row">
                    <a :href="c.ctaPrimary.href" class="group inline-flex h-12 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-xl shadow-blue-600/25 transition hover:-translate-y-0.5 hover:bg-blue-700">
                        {{ c.ctaPrimary.label }}
                        <ClientOnly>
                        <Icon icon="lucide:arrow-up-right" class="h-4 w-4 transition group-hover:translate-x-0.5 group-hover:-translate-y-0.5" />
                        </ClientOnly>
                    </a>
                    <a :href="c.ctaSecondary.href" class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white/80 px-5 text-sm font-black text-slate-700 shadow-sm backdrop-blur transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700">
                        <ClientOnly>
                            <Icon icon="lucide:map" class="h-4 w-4" />
                        </ClientOnly>
                        {{ c.ctaSecondary.label }}
                    </a>
                </div>

                <!-- Quick stats -->
                <div class="mt-8 grid max-w-3xl gap-3 sm:grid-cols-3">
                    <article v-for="item in c.quicks" :key="item.label" class="rounded-[1.35rem] border border-slate-200 bg-white/75 p-4 shadow-sm backdrop-blur transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-900/5">
                        <div class="flex items-start gap-3">
                            <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                                <ClientOnly>
                                    <Icon :icon="item.icon" class="h-5 w-5" />
                                </ClientOnly>
                            </div>
                            <div class="min-w-0">
                                <p class="truncate text-sm font-black text-slate-800">
                                    {{ item.label }}
                                </p>
                                <p class="mt-1 line-clamp-2 text-xs leading-5 text-slate-500">
                                    {{ item.value }}
                                </p>
                            </div>
                        </div>
                    </article>
                </div>
            </div>
            <!-- Right visual -->
            <div class="relative z-10">
                <div class="absolute -left-8 top-14 z-20 hidden rounded-[1.25rem] border border-white/80 bg-white/90 p-4 shadow-2xl shadow-slate-900/10 backdrop-blur-xl md:block">
                    <div class="flex items-center gap-3">
                        <div class="grid h-11 w-11 place-items-center rounded-2xl bg-emerald-50 text-emerald-600">
                            <ClientOnly>
                                <Icon icon="lucide:shield-check" class="h-5 w-5" />
                            </ClientOnly>
                        </div>
                        <div>
                            <p class="text-sm font-black text-slate-800">Layanan Terverifikasi</p>
                            <p class="mt-0.5 text-xs font-medium text-slate-500">Dikelola Pemerintah Desa</p>
                        </div>
                    </div>
                </div>
                <div class="absolute -bottom-8 right-0 z-20 hidden rounded-[1.25rem] border border-white/80 bg-white/90 p-4 shadow-2xl shadow-slate-900/10 backdrop-blur-xl md:block">
                    <div class="flex items-center gap-3">
                        <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                            <ClientOnly>
                                <Icon icon="lucide:clipboard-list" class="h-5 w-5" />
                            </ClientOnly>
                        </div>
                        <div>
                            <p class="text-sm font-black text-slate-800">Administrasi Online</p>
                            <p class="mt-0.5 text-xs font-medium text-slate-500">Cepat, rapi, transparan</p>
                        </div>
                    </div>
                </div>
                <div class="absolute -right-4 -top-5 z-20 hidden rounded-full border border-white/80 bg-white/90 px-4 py-2 text-xs font-black text-blue-700 shadow-xl shadow-slate-900/10 backdrop-blur-xl sm:inline-flex">
                    Portal Desa Digital
                </div>
                <div class="relative mx-auto max-w-xl">
                    <div class="absolute -inset-4 rounded-[2.5rem] bg-linear-to-br from-blue-500/15 via-cyan-400/10 to-sky-300/20 blur-2xl"></div>
                    <div class="relative overflow-hidden rounded-4xl border border-white/80 bg-white p-2 shadow-[0_30px_90px_-45px_rgba(15,23,42,0.65)]">
                        <div class="relative overflow-hidden rounded-[1.65rem]">
                            <img :src="c.bgImage" :alt="`Kantor atau potensi ${c.brand}`" class="h-[360px] w-full object-cover sm:h-[460px] lg:h-[520px]" />
                            <div class="absolute inset-x-0 bottom-0 bg-linear-to-t from-slate-950/80 via-slate-950/20 to-transparent p-5">
                                <div class="flex flex-wrap gap-2">
                                    <span v-for="stat in c.stats" :key="stat.label" class="rounded-2xl border border-white/15 bg-white/15 px-3 py-2 text-white backdrop-blur-md">
                                    <span class="block text-xs text-white/70">{{ stat.label }}</span>
                                    <span class="mt-0.5 block text-sm font-black">{{ stat.value }}</span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="pointer-events-none absolute inset-x-0 bottom-0 -z-10 h-40 bg-linear-to-t from-white to-transparent"></div>
    </section>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Icon } from '@iconify/vue'
import type { TenantSiteConfig, TenantSiteResponse } from '../../../types/tenant-site'
import { useRuntimeConfig, useRequestURL, useFetch } from 'nuxt/app'
import { useAppApi } from '~/composables/useAppApi'

type Stat = {
  label: string
  value: string
}

type Quick = {
  label: string
  value: string
  icon: string
}

type CTA = {
  label: string
  href: string
}

type Badge = {
  label: string
  icon: string
}

type HeaderHeroProps = {
  brand?: string
  bgImage?: string
  titleMain?: string
  titleHighlight?: string
  tagline?: string
  subtitle?: string
  photos?: string[]
  waIntl?: string
  ctaPrimary?: CTA
  ctaSecondary?: CTA
  ctaPPDB?: CTA
  badges?: Badge[]
  stats?: Stat[]
  quicks?: Quick[]
  searchPlaceholder?: string
  tenant?: TenantSiteConfig
}

type HeaderHeroComputed = Required<Omit<HeaderHeroProps, 'tenant'>> & {
  isPro: boolean
  subscriptionLabel: string
  subscriptionEndsLabel: string
  availableFeatures: {
    news: boolean
    onlineLetter: boolean
    finance: boolean
    letterC: boolean
  }
}

const props = defineProps<HeaderHeroProps>()

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

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

const tenantSiteApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/site')
})

const { data: tenantResponse } = useFetch<TenantSiteResponse>(tenantSiteApiUrl, {
  key: computed(() => `tenant-site-hero-${tenantSlug.value}`),
  default: () => ({
    data: null as any
  })
})

const tenant = computed<TenantSiteConfig | null>(() => {
  return props.tenant || tenantResponse.value?.data || null
})

const features = computed(() => {
  return tenant.value?.features || {}
})

const isProTenant = computed(() => {
  return Boolean(tenant.value?.subscription?.isPro)
})

const isActiveSubscription = computed(() => {
  return Boolean(tenant.value?.subscription?.isActive)
})

const onlineLetterEnabled = computed(() => {
  return Boolean(features.value?.onlineLetter && isActiveSubscription.value)
})

const financeEnabled = computed(() => {
  return Boolean(features.value?.finance && isActiveSubscription.value)
})

const letterCEnabled = computed(() => {
  return Boolean(features.value?.letterC && isActiveSubscription.value)
})

const defaults = computed<HeaderHeroComputed>(() => {
  const tenantName = tenant.value?.displayName || 'Desa Martopuro'
  const tenantDescription =
    tenant.value?.description ||
    'Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.'

  const hero = tenant.value?.hero || {}

  const ctaPrimary = resolvePrimaryCta()
  const ctaSecondary = resolveSecondaryCta()

  return {
    brand: tenantName,
    bgImage:
      hero.bgImage ||
      tenant.value?.ogImageUrl ||
      props.bgImage ||
      '/assets/images/village/martopuro-hero.jpg',

    titleMain:
      hero.titleMain ||
      'Selamat Datang di ',

    titleHighlight:
      hero.titleHighlight ||
      tenantName,

    tagline:
      hero.tagline ||
      resolveTagline(),

    subtitle:
      hero.subtitle ||
      tenantDescription,

    photos:
      Array.isArray(hero.photos) && hero.photos.length
        ? hero.photos
        : [
            '/assets/images/desa-1.jpg',
            '/assets/images/desa-2.jpg',
            '/assets/images/desa-3.jpg'
          ],

    waIntl:
      tenant.value?.contact?.waIntl ||
      '',

    ctaPrimary,
    ctaSecondary,

    ctaPPDB: {
      label: 'Daftar',
      href: '/registration'
    },

    badges:
      resolveBadges(),

    stats:
      Array.isArray(tenant.value?.statistic?.stats) && tenant.value?.statistic?.stats.length
        ? tenant.value.statistic.stats
        : resolveStats(),

    quicks:
      Array.isArray(tenant.value?.statistic?.quicks) && tenant.value?.statistic?.quicks.length
        ? tenant.value.statistic.quicks
        : resolveQuicks(),

    searchPlaceholder:
      hero.searchPlaceholder ||
      'Cari layanan, berita, agenda, UMKM...',

    isPro: isProTenant.value,

    subscriptionLabel:
      resolveSubscriptionLabel(),

    subscriptionEndsLabel:
      resolveSubscriptionEndsLabel(),

    availableFeatures: {
      news: true,
      onlineLetter: onlineLetterEnabled.value,
      finance: financeEnabled.value,
      letterC: letterCEnabled.value
    }
  }
})

const c = computed<HeaderHeroComputed>(() => {
  return {
    ...defaults.value,

    brand: props.brand || defaults.value.brand,
    bgImage: props.bgImage || defaults.value.bgImage,
    titleMain: props.titleMain || defaults.value.titleMain,
    titleHighlight: props.titleHighlight || defaults.value.titleHighlight,
    tagline: props.tagline || defaults.value.tagline,
    subtitle: props.subtitle || defaults.value.subtitle,
    photos: props.photos?.length ? props.photos : defaults.value.photos,
    waIntl: props.waIntl || defaults.value.waIntl,

    ctaPrimary: {
      ...defaults.value.ctaPrimary,
      ...(props.ctaPrimary || {})
    },

    ctaSecondary: {
      ...defaults.value.ctaSecondary,
      ...(props.ctaSecondary || {})
    },

    ctaPPDB: {
      ...defaults.value.ctaPPDB,
      ...(props.ctaPPDB || {})
    },

    badges: props.badges?.length ? props.badges : defaults.value.badges,
    stats: props.stats?.length ? props.stats : defaults.value.stats,
    quicks: props.quicks?.length ? props.quicks : defaults.value.quicks,
    searchPlaceholder: props.searchPlaceholder || defaults.value.searchPlaceholder
  }
})

function resolvePrimaryCta(): CTA {
  if (onlineLetterEnabled.value) {
    return {
      label: 'Ajukan Surat Online',
      href: '/layanan'
    }
  }

  return {
    label: 'Lihat Berita',
    href: '/news'
  }
}

function resolveSecondaryCta(): CTA {
  if (onlineLetterEnabled.value) {
    return {
      label: 'Lihat Berita',
      href: '/news'
    }
  }

  return {
    label: 'Lihat Profil Desa',
    href: '/profile'
  }
}

function resolveTagline() {
  if (!isActiveSubscription.value) {
    return 'Portal Informasi Desa'
  }

  if (isProTenant.value) {
    return 'Portal Desa Digital Pro'
  }

  return 'Portal Resmi Pemerintah Desa'
}

function resolveBadges(): Badge[] {
  const badges: Badge[] = [
    {
      label: 'Berita Desa',
      icon: 'lucide:newspaper'
    },
    {
      label: 'Agenda Desa',
      icon: 'lucide:calendar-days'
    },
    {
      label: 'Direktori UMKM',
      icon: 'lucide:store'
    }
  ]

  if (onlineLetterEnabled.value) {
    badges.unshift({
      label: 'Surat Online',
      icon: 'lucide:file-check-2'
    })
  }

  if (financeEnabled.value) {
    badges.push({
      label: 'Keuangan Desa',
      icon: 'lucide:wallet'
    })
  }

  if (letterCEnabled.value) {
    badges.push({
      label: 'Dokumen Letter C',
      icon: 'lucide:folder-check'
    })
  }

  return badges
}

function resolveStats(): Stat[] {
  const stats: Stat[] = [
    {
      label: 'Berita',
      value: 'Aktif'
    },
    {
      label: 'Agenda',
      value: 'Aktif'
    },
    {
      label: 'UMKM',
      value: '35+'
    }
  ]

  if (onlineLetterEnabled.value) {
    stats[1] = {
      label: 'Surat Online',
      value: 'Pro'
    }
  }

  return stats
}

function resolveQuicks(): Quick[] {
  const quicks: Quick[] = [
    {
      label: 'Jam Layanan Kantor',
      value: 'Senin–Jumat • 08.00–15.00',
      icon: 'lucide:clock-3'
    },
    {
      label: 'Berita Terbaru',
      value: 'Informasi resmi desa tersedia',
      icon: 'lucide:newspaper'
    },
    {
      label: 'Nomor Darurat',
      value: '112 • 0812-xxxx-xxxx',
      icon: 'lucide:phone-call'
    }
  ]

  if (onlineLetterEnabled.value) {
    quicks[1] = {
      label: 'Administrasi Online',
      value: 'Pengajuan surat warga tersedia',
      icon: 'lucide:clipboard-list'
    }
  }

  return quicks
}

function resolveSubscriptionLabel() {
  const subscription = tenant.value?.subscription

  if (!subscription) return 'Basic'

  const plan = subscription.plan?.toUpperCase() || 'BASIC'
  const status = subscription.status || 'active'

  if (!subscription.isActive) return `${plan} • Expired`

  return `${plan} • ${status}`
}

function resolveSubscriptionEndsLabel() {
  const endsAt = tenant.value?.subscription?.endsAt

  if (!endsAt) return 'Tanpa batas aktif'

  return `Aktif hingga ${new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(new Date(endsAt))}`
}
</script>

<style scoped>
    .bg-size-\[44px_44px\] {
        background-size: 44px 44px;
    }
</style>