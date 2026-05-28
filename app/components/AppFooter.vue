<template>
  <div class="bg-slate-50 text-slate-950">
    <ContactHero />

    <footer
      id="footer"
      :aria-label="`Footer ${appName}`"
      class="relative isolate overflow-hidden border-t border-slate-200 bg-white/80 backdrop-blur-2xl"
    >
      <!-- Background -->
      <div class="pointer-events-none absolute inset-0 -z-10">
        <div class="absolute inset-0 bg-[linear-gradient(to_right,#e2e8f0_1px,transparent_1px),linear-gradient(to_bottom,#e2e8f0_1px,transparent_1px)] bg-size-[44px_44px] opacity-35"></div>
        <div class="absolute -left-40 top-0 h-[420px] w-[420px] rounded-full bg-blue-200/40 blur-3xl"></div>
        <div class="absolute -right-40 bottom-0 h-[420px] w-[420px] rounded-full bg-cyan-200/40 blur-3xl"></div>
      </div>

      <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <!-- Top Footer -->
        <div class="grid gap-8 lg:grid-cols-[1.1fr_1.9fr]">
          <!-- Brand Card -->
          <section class="rounded-4xl border border-slate-200 bg-white/80 p-6 shadow-sm backdrop-blur-2xl">
            <NuxtLink to="/" class="inline-flex items-center gap-3">
              <div class="grid h-13 w-13 place-items-center overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
                <img
                  :src="appLogo"
                  :alt="appName"
                  class="h-10 w-10 object-contain"
                />
              </div>

              <div>
                <p class="text-xl font-black tracking-tight text-slate-950">
                  {{ appName }}
                </p>
                <p class="mt-0.5 text-xs font-bold uppercase tracking-[0.16em] text-blue-600">
                  {{ appLocation }}
                </p>
              </div>
            </NuxtLink>

            <p class="mt-5 text-sm leading-7 text-slate-600">
              {{ footerDescription }}
            </p>

            <div class="mt-5 grid gap-3 sm:grid-cols-2">
              <div
                v-for="item in highlightCards"
                :key="item.label"
                class="rounded-2xl border border-slate-200 bg-slate-50 p-4"
              >
                <div class="flex items-center gap-3">
                  <div class="grid h-10 w-10 place-items-center rounded-xl bg-blue-50 text-blue-600">
                    <ClientOnly>
                      <Icon :icon="item.icon" class="h-4 w-4" />
                    </ClientOnly>
                  </div>

                  <div>
                    <p class="text-sm font-black text-slate-900">
                      {{ item.label }}
                    </p>
                    <p class="mt-0.5 text-xs font-semibold text-slate-500">
                      {{ item.value }}
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-6 flex flex-wrap gap-2">
              <!-- <NuxtLink
                to="/letters"
                class="inline-flex h-10 items-center justify-center gap-2 rounded-xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              >
                <ClientOnly>
                  <Icon icon="lucide:file-check-2" class="h-4 w-4" />
                </ClientOnly>
                Ajukan Surat
              </NuxtLink> -->

              <NuxtLink
                to="/profile"
                class="inline-flex h-10 items-center justify-center gap-2 rounded-xl border border-slate-200 bg-white px-4 text-sm font-black text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              >
                <ClientOnly>
                  <Icon icon="lucide:map-pin" class="h-4 w-4" />
                </ClientOnly>
                Profil Desa
              </NuxtLink>
            </div>
          </section>

          <!-- Link Sections -->
          <section class="grid gap-4 sm:grid-cols-1 xl:grid-cols-2">
            <article
              v-for="section in footerSections"
              :key="section.title"
              class="rounded-[1.75rem] border border-slate-200 bg-white/70 p-5 shadow-sm backdrop-blur-2xl transition hover:-translate-y-0.5 hover:shadow-xl hover:shadow-blue-900/5"
            >
              <div class="mb-4 flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center rounded-xl bg-blue-50 text-blue-600">
                  <ClientOnly>
                    <Icon :icon="section.icon" class="h-4 w-4" />
                  </ClientOnly>
                </div>

                <h4 class="text-sm font-black uppercase tracking-[0.08em] text-slate-900">
                  {{ section.title }}
                </h4>
              </div>

              <div class="space-y-2">
                <NuxtLink
                  v-for="item in section.items"
                  :key="`${section.title}-${item.href}-${item.label}`"
                  :to="item.href"
                  class="group flex items-center justify-between gap-3 rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-600 transition hover:bg-blue-50 hover:text-blue-700"
                >
                  <span class="inline-flex min-w-0 items-center gap-2">
                    <ClientOnly v-if="item.icon">
                      <Icon :icon="item.icon" class="h-4 w-4 shrink-0 text-slate-400 transition group-hover:text-blue-600" />
                    </ClientOnly>
                    <span class="truncate">{{ item.label }}</span>
                  </span>

                  <ClientOnly>
                    <Icon icon="lucide:chevron-right" class="h-3.5 w-3.5 shrink-0 opacity-0 transition group-hover:opacity-100" />
                  </ClientOnly>
                </NuxtLink>
              </div>
            </article>
          </section>
        </div>

        <!-- Contact Strip -->
        <div class="mt-8 rounded-4xl border border-slate-200 bg-slate-950 p-5 text-white shadow-xl shadow-slate-900/10">
          <div class="grid gap-4 md:grid-cols-[1.2fr_1fr_1fr] md:items-center">
            <div>
              <p class="text-sm font-black">
                {{ officeName }}
              </p>
              <p class="mt-1 text-sm leading-6 text-slate-300">
                {{ address }}
              </p>
            </div>

            <div class="flex flex-wrap gap-2 md:justify-center">
              <a
                :href="directionsHref"
                target="_blank"
                rel="noopener"
                class="inline-flex h-10 items-center gap-2 rounded-xl bg-white/10 px-4 text-sm font-black text-white ring-1 ring-white/10 transition hover:bg-white/15"
              >
                <ClientOnly>
                  <Icon icon="lucide:navigation" class="h-4 w-4" />
                </ClientOnly>
                Buka Maps
              </a>

              <a
                v-if="waIntl"
                :href="whatsappHref"
                target="_blank"
                rel="noopener"
                class="inline-flex h-10 items-center gap-2 rounded-xl bg-blue-600 px-4 text-sm font-black text-white transition hover:bg-blue-700"
              >
                <ClientOnly>
                  <Icon icon="lucide:message-circle" class="h-4 w-4" />
                </ClientOnly>
                WhatsApp
              </a>
            </div>

            <div class="flex items-center gap-3 md:justify-end">
              <a
                v-for="social in visibleSocialLinks"
                :key="social.label"
                :href="social.href"
                target="_blank"
                rel="noopener"
                :aria-label="social.label"
                class="grid h-10 w-10 place-items-center rounded-xl bg-white/10 text-white ring-1 ring-white/10 transition hover:bg-white hover:text-blue-700"
              >
                <ClientOnly>
                  <Icon :icon="social.icon" class="h-4 w-4" />
                </ClientOnly>
              </a>

              <span
                v-if="!visibleSocialLinks.length"
                class="text-sm font-semibold text-slate-400"
              >
                Kanal sosial media dapat ditambahkan melalui konfigurasi tenant.
              </span>
            </div>
          </div>
        </div>

        <!-- Bottom -->
        <div class="mt-8 flex flex-col gap-4 border-t border-slate-200 pt-6 md:flex-row md:items-center md:justify-between">
          <div>
            <p class="text-sm font-semibold text-slate-600">
              © {{ year }} {{ appName }}. Seluruh hak cipta dilindungi.
            </p>
            <p class="mt-1 text-xs text-slate-400">
              {{ copyrightSubtitle }}
            </p>
          </div>

          <div class="flex flex-wrap items-center gap-2">
            <NuxtLink
              v-for="link in footerBottomLinks"
              :key="link.label"
              :to="link.href"
              class="rounded-xl border border-slate-200 bg-white px-3 py-2 text-xs font-black text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            >
              {{ link.label }}
            </NuxtLink>

            <div class="hs-dropdown relative inline-flex [--placement:top-right]">
              <button
                id="footer-language-dropdown"
                type="button"
                class="hs-dropdown-toggle inline-flex h-9 items-center gap-2 rounded-xl border border-slate-200 bg-white px-3 text-xs font-black text-slate-600 transition hover:bg-slate-50"
                aria-haspopup="menu"
                aria-expanded="false"
                aria-label="Language Dropdown"
              >
                <ClientOnly>
                  <Icon :icon="selectedLanguage.icon" class="h-4 w-4 rounded-full" />
                </ClientOnly>
                {{ selectedLanguage.short }}
                <ClientOnly>
                  <Icon icon="lucide:chevron-down" class="h-3.5 w-3.5 text-slate-400" />
                </ClientOnly>
              </button>

              <div
                class="hs-dropdown-menu z-20 hidden w-48 rounded-2xl border border-slate-200 bg-white p-2 opacity-0 shadow-xl shadow-slate-900/10 transition hs-dropdown-open:block hs-dropdown-open:opacity-100"
                role="menu"
                aria-labelledby="footer-language-dropdown"
              >
                <button
                  v-for="lang in languages"
                  :key="lang.code"
                  type="button"
                  class="flex w-full items-center gap-2 rounded-xl px-3 py-2 text-left text-sm font-semibold text-slate-600 transition hover:bg-blue-50 hover:text-blue-700"
                  @click="setLanguage(lang.code)"
                >
                  <ClientOnly>
                    <Icon :icon="lang.icon" class="h-4 w-4 rounded-full" />
                  </ClientOnly>
                  {{ lang.label }}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </footer>

    <BannerSencraBanner />
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { Icon } from '@iconify/vue'
import { useRequestURL, useRuntimeConfig } from 'nuxt/app'
import ContactHero from './hero/ContactHero.vue'
import { useAppApi } from '~/composables/useAppApi'

type FooterItem = {
  label: string
  href: string
  icon?: string
}

type FooterSection = {
  title: string
  icon: string
  items: FooterItem[]
}

type Language = {
  code: string
  short: string
  label: string
  icon: string
}

type SocialLink = {
  label: string
  href: string
  icon: string
  show: boolean
}

type ApiListResponse<T> = {
  data: T[]
  meta?: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type DynamicEntity = {
  id?: string
  title?: string | null
  name?: string | null
  displayName?: string | null
  subtitle?: string | null
  shortDescription?: string | null
  description?: string | null
  slug?: string | null
  icon?: string | null
  logoUrl?: string | null
  imageUrl?: string | null
  facilityType?: string | null
  potentialType?: string | null
  status?: string | null
  metadata?: Record<string, any> | null
}

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const year = new Date().getFullYear()

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const tenantSlug = computed(() => {
  const envClient = String(config.public.clientName || 'martopuro')
    .trim()
    .toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const appName = computed(() => {
  return String(config.public.appName || config.public.clientDisplayName || 'Desa Martopuro')
})

const appLocation = computed(() => {
  return String(config.public.appLocation || config.public.clientLocation || 'Purwosari · Pasuruan')
})

const appLogo = computed(() => {
  return String(config.public.appLogo || '/assets/images/village/martopuro-logo.png')
})

const officeName = computed(() => {
  return String(config.public.officeName || `Kantor ${appName.value}`)
})

const footerDescription = computed(() => {
  return String(
    config.public.footerDescription ||
      `Portal resmi informasi dan layanan digital ${appName.value}. Menyajikan informasi desa, layanan publik, APBDes, organisasi, fasilitas, potensi lokal, dan berita kegiatan masyarakat.`
  )
})

const copyrightSubtitle = computed(() => {
  return String(
    config.public.copyrightSubtitle ||
      `Website resmi ${appName.value}.`
  )
})

const address = computed(() => {
  return String(
    config.public.contactAddress ||
      'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur'
  )
})

const mapsQuery = computed(() => {
  return String(
    config.public.mapsQuery ||
      address.value ||
      'Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan'
  )
})

const waIntl = computed(() => {
  return String(config.public.waIntl || config.public.whatsappIntl || '')
})

const directionsHref = computed(() => {
  return `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(mapsQuery.value)}`
})

const whatsappHref = computed(() => {
  return `https://wa.me/${waIntl.value}?text=${encodeURIComponent(`Halo Admin ${appName.value}, saya ingin bertanya terkait layanan.`)}`
})

const { tenantApiUrl } = useAppApi()

const organizationsApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/organization'))
const facilitiesApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/facilities'))
const potentialsApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/potentials'))

const {
  data: organizationsResponse,
  pending: organizationsPending
} = useFetch<ApiListResponse<DynamicEntity>>(organizationsApiUrl, {
  key: computed(() => `footer-organizations-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 4,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 4,
      total: 0,
      totalPages: 1
    }
  })
})

const {
  data: facilitiesResponse,
  pending: facilitiesPending
} = useFetch<ApiListResponse<DynamicEntity>>(facilitiesApiUrl, {
  key: computed(() => `footer-facilities-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 4,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 4,
      total: 0,
      totalPages: 1
    }
  })
})

const {
  data: potentialsResponse,
  pending: potentialsPending
} = useFetch<ApiListResponse<DynamicEntity>>(potentialsApiUrl, {
  key: computed(() => `footer-potentials-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'active',
    limit: 4,
    sort: 'sort_order'
  })),
  watch: [tenantSlug],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 4,
      total: 0,
      totalPages: 1
    }
  })
})

const organizationLinks = computed<FooterItem[]>(() => {
  if (organizationsPending.value) return loadingLinks('organizations')

  return mapEntityLinks(
    organizationsResponse.value?.data || [],
    '/organizations',
    'lucide:users',
    'Organisasi'
  )
})

const facilityLinks = computed<FooterItem[]>(() => {
  if (facilitiesPending.value) return loadingLinks('facilities')

  return mapEntityLinks(
    facilitiesResponse.value?.data || [],
    '/facilities',
    'lucide:map-pin',
    'Fasilitas'
  )
})

const potentialLinks = computed<FooterItem[]>(() => {
  if (potentialsPending.value) return loadingLinks('potentials')

  return mapEntityLinks(
    potentialsResponse.value?.data || [],
    '/potentials',
    'lucide:sparkles',
    'Potensi'
  )
})

const highlightCards = computed(() => [
  {
    label: 'Organisasi',
    value: `${organizationLinks.value.filter((item) => !item.href.includes('?loading=')).length} data tampil`,
    icon: 'lucide:users'
  },
  {
    label: 'Fasilitas',
    value: `${facilityLinks.value.filter((item) => !item.href.includes('?loading=')).length} data tampil`,
    icon: 'lucide:map-pin'
  },
  {
    label: 'Potensi',
    value: `${potentialLinks.value.filter((item) => !item.href.includes('?loading=')).length} data tampil`,
    icon: 'lucide:sparkles'
  },
  {
    label: 'Transparansi',
    value: 'APBDes Desa',
    icon: 'lucide:landmark'
  }
])

const footerSections = computed<FooterSection[]>(() => [
  {
    title: 'Informasi',
    icon: 'lucide:newspaper',
    items: [
      {
        label: 'Berita Desa',
        href: '/news',
        icon: 'lucide:newspaper'
      },
      {
        label: 'Profil Desa',
        href: '/profile',
        icon: 'lucide:landmark'
      },
      {
        label: 'Status Desa',
        href: '/status',
        icon: 'lucide:activity'
      },
      {
        label: 'APBD Desa',
        href: '/apbd',
        icon: 'lucide:pie-chart'
      }
    ]
  },
  {
    title: 'Organisasi',
    icon: 'lucide:users',
    items: organizationLinks.value
  },
  {
    title: 'Fasilitas',
    icon: 'lucide:map-pin',
    items: facilityLinks.value
  },
  {
    title: 'Potensi',
    icon: 'lucide:sparkles',
    items: potentialLinks.value
  }
])

const footerBottomLinks: FooterItem[] = [
  {
    label: 'Kontak',
    href: '/profile'
  },
  {
    label: 'APBD',
    href: '/apbd'
  },
  {
    label: 'Status Desa',
    href: '/status'
  },
  // {
  //   label: 'Sitemap',
  //   href: '/sitemap'
  // }
]

const socialLinks = computed<SocialLink[]>(() => {
  return [
    {
      label: 'Instagram',
      href: String(config.public.instagramUrl || ''),
      icon: 'mdi:instagram',
      show: Boolean(config.public.instagramUrl)
    },
    {
      label: 'Facebook',
      href: String(config.public.facebookUrl || ''),
      icon: 'mdi:facebook',
      show: Boolean(config.public.facebookUrl)
    },
    {
      label: 'YouTube',
      href: String(config.public.youtubeUrl || ''),
      icon: 'mdi:youtube',
      show: Boolean(config.public.youtubeUrl)
    },
    {
      label: 'TikTok',
      href: String(config.public.tiktokUrl || ''),
      icon: 'ic:baseline-tiktok',
      show: Boolean(config.public.tiktokUrl)
    }
  ]
})

const visibleSocialLinks = computed(() => {
  return socialLinks.value.filter((item) => item.show)
})

const languages = ref<Language[]>([
  {
    code: 'id',
    short: 'ID',
    label: 'Bahasa Indonesia',
    icon: 'circle-flags:id'
  },
  {
    code: 'en',
    short: 'EN',
    label: 'English',
    icon: 'circle-flags:us'
  }
])

const selectedLanguage = ref<Language>(languages.value[0]!)

function mapEntityLinks(
  rows: DynamicEntity[],
  basePath: '/organizations' | '/facilities' | '/potentials',
  fallbackIcon: string,
  fallbackLabel: string
): FooterItem[] {
  const items = rows
    .filter((item) => item.slug)
    .slice(0, 4)
    .map((item) => ({
      label: entityLabel(item, fallbackLabel),
      href: `${basePath}/${item.slug}`,
      icon: item.icon || fallbackIcon
    }))

  if (items.length) return items

  return [
    {
      label: `Lihat Semua ${fallbackLabel}`,
      href: basePath,
      icon: fallbackIcon
    }
  ]
}

function entityLabel(item: DynamicEntity, fallback: string) {
  return String(
    item.title ||
    item.name ||
    item.displayName ||
    item.subtitle ||
    item.shortDescription ||
    item.description ||
    fallback
  )
}

function loadingLinks(type: string): FooterItem[] {
  return Array.from({ length: 4 }).map((_, index) => ({
    label: `Memuat ${index + 1}`,
    href: `/${type}?loading=${index + 1}`,
    icon: 'lucide:loader-circle'
  }))
}

function setLanguage(code: string) {
  const found = languages.value.find((item) => item.code === code)

  if (!found) return

  selectedLanguage.value = found

  if (typeof window !== 'undefined') {
    localStorage.setItem(`${tenantSlug.value}-lang`, code)
  }
}

onMounted(() => {
  if (typeof window === 'undefined') return

  const saved = localStorage.getItem(`${tenantSlug.value}-lang`)
  const found = languages.value.find((item) => item.code === saved)

  if (found) {
    selectedLanguage.value = found
  }
})
</script>

<style scoped>
.bg-size-\[44px_44px\] {
  background-size: 44px 44px;
}
</style>