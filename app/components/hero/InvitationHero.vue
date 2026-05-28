<template>
  <section
    id="culture"
    aria-label="Organisasi dan Komunitas Desa"
    class="relative isolate overflow-hidden bg-slate-50 py-20 text-slate-950 sm:py-24"
  >
    <!-- Background -->
    <div class="pointer-events-none absolute inset-0 -z-10">
      <div class="absolute inset-0 bg-grid opacity-40"></div>
      <div class="absolute -left-32 top-0 h-[480px] w-[480px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-32 bottom-0 h-[480px] w-[480px] rounded-full bg-cyan-200/60 blur-3xl"></div>
      <div class="absolute left-1/2 top-1/2 h-[340px] w-[340px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-white/80 blur-3xl"></div>
    </div>

    <div class="mx-auto grid max-w-7xl items-center gap-10 px-4 sm:px-6 lg:grid-cols-[0.92fr_1.08fr] lg:gap-14 lg:px-8">
      <!-- Left Content -->
      <div>
        <div class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-white/80 px-3 py-1.5 text-xs font-black text-blue-700 shadow-sm backdrop-blur">
          <ClientOnly>
            <Icon :icon="c.eyebrowIcon" class="h-4 w-4" />
          </ClientOnly>
          {{ c.eyebrow }}
        </div>

        <h2 class="mt-6 max-w-3xl text-4xl font-black leading-[1.08] tracking-tight text-slate-950 sm:text-5xl lg:text-6xl">
          {{ c.title }}
          <span class="bg-gradient-to-r from-blue-600 via-sky-500 to-cyan-500 bg-clip-text text-transparent">
            {{ c.highlight }}
          </span>
        </h2>

        <p class="mt-5 max-w-2xl text-base font-semibold leading-8 text-slate-600 sm:text-lg">
          {{ c.subtitle }}
        </p>

        <!-- CTA -->
        <div class="mt-8 flex flex-col gap-3 sm:flex-row sm:items-center">
          <NuxtLink
            :to="listTo"
            class="group inline-flex h-12 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-xl shadow-blue-600/25 transition hover:-translate-y-0.5 hover:bg-blue-700"
          >
            Semua Organisasi
            <ClientOnly>
              <Icon icon="lucide:arrow-right" class="h-4 w-4 transition group-hover:translate-x-0.5" />
            </ClientOnly>
          </NuxtLink>

          <NuxtLink
            v-if="activeOrganization?.slug"
            :to="organizationDetailTo(activeOrganization)"
            class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white/85 px-5 text-sm font-black text-slate-700 shadow-sm backdrop-blur transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          >
            Pelajari
            <ClientOnly>
              <Icon icon="lucide:arrow-up-right" class="h-4 w-4" />
            </ClientOnly>
          </NuxtLink>

        </div>
        <a
          v-for="link in activeExternalLinks"
          :key="`top-external-${link.href}`"
          :href="link.href"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex h-12 items-center mt-4 justify-center gap-2 rounded-2xl border border-slate-200 bg-white/85 px-5 text-sm font-black text-slate-700 shadow-sm backdrop-blur transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
        >
          {{ link.label }}
          <ClientOnly>
            <Icon :icon="link.icon" class="h-4 w-4" />
          </ClientOnly>
        </a>
      </div>

      <!-- Right Feature -->
      <div class="relative">
        <div
          class="absolute right-4 top-0 z-30 hidden rounded-full border border-blue-100 bg-white/90 px-4 py-2 text-xs font-black text-blue-700 shadow-xl shadow-slate-900/10 backdrop-blur sm:inline-flex lg:-right-4 lg:-top-8"
        >
          {{ organizationSlides.length }} Organisasi Aktif
        </div>

        <div class="relative mx-auto max-w-2xl">
          <div class="absolute left-1/2 top-1/2 h-[420px] w-[420px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-blue-200/40 blur-3xl sm:h-[520px] sm:w-[520px]"></div>

          <article
            v-if="activeOrganization"
            class="relative overflow-hidden rounded-[2.25rem] border border-white bg-white p-2 shadow-[0_30px_90px_-45px_rgba(15,23,42,0.65)]"
          >
            <div class="relative overflow-hidden rounded-[1.85rem] bg-slate-100">
              <div class="relative h-[430px] sm:h-[500px] lg:h-[560px]">
                <img
                  :src="getSafeImageSrc(activeOrganization)"
                  :alt="activeOrganization.displayName || activeOrganization.name || 'Organisasi Desa'"
                  class="absolute inset-0 h-full w-full object-cover transition duration-700"
                  @load="onImageLoad(activeOrganization)"
                  @error="onImageError($event, activeOrganization)"
                >

                <div class="pointer-events-none absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/45 to-transparent"></div>
                <div class="pointer-events-none absolute inset-0 bg-gradient-to-r from-slate-950/45 via-transparent to-transparent"></div>

                <div class="absolute left-4 top-4 z-20 flex flex-wrap gap-2">
                  <span class="rounded-full border border-white/20 bg-white/15 px-3 py-1.5 text-xs font-black text-white backdrop-blur">
                    {{ getOrganizationTypeLabel(activeOrganization.organizationType) }}
                  </span>

                  <span
                    v-if="activeOrganization.isFeatured"
                    class="rounded-full bg-blue-600 px-3 py-1.5 text-xs font-black text-white shadow-lg shadow-blue-900/20"
                  >
                    Featured
                  </span>
                </div>

                <div class="absolute inset-x-0 bottom-0 z-20 p-5 sm:p-6">
                  <div class="max-w-xl">
                    <div class="mb-4 grid h-14 w-14 place-items-center overflow-hidden rounded-2xl border border-white/20 bg-white/15 text-white backdrop-blur">
                      <img
                        v-if="activeOrganization.logoUrl && !isFailedImage(activeOrganization.logoUrl)"
                        :src="activeOrganization.logoUrl"
                        :alt="activeOrganization.displayName || activeOrganization.name || 'Logo organisasi'"
                        class="h-10 w-10 rounded-xl object-contain"
                        @load="onImageLoad(activeOrganization, activeOrganization.logoUrl)"
                        @error="onImageError($event, activeOrganization, activeOrganization.logoUrl)"
                      >
                      <ClientOnly v-else>
                        <Icon :icon="getOrganizationIcon(activeOrganization)" class="h-7 w-7" />
                      </ClientOnly>
                    </div>

                    <h3 class="text-2xl font-black leading-tight tracking-tight text-white sm:text-4xl">
                      {{ activeOrganization.displayName || activeOrganization.name }}
                    </h3>

                    <p class="mt-3 line-clamp-3 max-w-xl text-sm leading-7 text-white/80 sm:text-base">
                      {{ getOrganizationDescriptionText(activeOrganization) }}
                    </p>

                  </div>
                </div>
              </div>
            </div>

            <template v-if="hasMultipleOrganizations">
              <button
                type="button"
                class="absolute left-4 top-1/2 z-30 grid h-11 w-11 -translate-y-1/2 place-items-center rounded-full border border-white/30 bg-white/20 text-white shadow-xl backdrop-blur transition hover:bg-white hover:text-slate-950"
                aria-label="Organisasi sebelumnya"
                @click="prevOrganization"
              >
                <ClientOnly>
                  <Icon icon="lucide:chevron-left" class="h-5 w-5" />
                </ClientOnly>
              </button>

              <button
                type="button"
                class="absolute right-4 top-1/2 z-30 grid h-11 w-11 -translate-y-1/2 place-items-center rounded-full border border-white/30 bg-white/20 text-white shadow-xl backdrop-blur transition hover:bg-white hover:text-slate-950"
                aria-label="Organisasi berikutnya"
                @click="nextOrganization"
              >
                <ClientOnly>
                  <Icon icon="lucide:chevron-right" class="h-5 w-5" />
                </ClientOnly>
              </button>
            </template>
          </article>

          <!-- Minimal selector: bukan thumbnail foto, supaya tidak double-view data -->
          <div
            v-if="hasMultipleOrganizations"
            class="mt-5 grid gap-2 sm:grid-cols-2 lg:grid-cols-3"
          >
            <button
              v-for="(item, index) in compactOrganizationList"
              :key="item.id || item.slug"
              type="button"
              class="group flex items-center gap-3 rounded-2xl border bg-white/80 p-3 text-left shadow-sm backdrop-blur transition hover:-translate-y-0.5"
              :class="activeIndex === index
                ? 'border-blue-300 ring-4 ring-blue-100'
                : 'border-slate-200 hover:border-blue-200'"
              @click="setActiveOrganization(index)"
            >
              <div
                class="grid h-10 w-10 shrink-0 place-items-center rounded-xl"
                :class="activeIndex === index
                  ? 'bg-blue-600 text-white'
                  : 'bg-blue-50 text-blue-700 group-hover:bg-blue-100'"
              >
                <ClientOnly>
                  <Icon :icon="getOrganizationIcon(item)" class="h-5 w-5" />
                </ClientOnly>
              </div>

              <div class="min-w-0">
                <p class="truncate text-xs font-black text-slate-950">
                  {{ item.displayName || item.name }}
                </p>
                <p class="truncate text-[11px] font-semibold text-slate-500">
                  {{ getOrganizationTypeLabel(item.organizationType) }}
                </p>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import { Icon } from '@iconify/vue'
import type { OrganizationItem, OrganizationType } from '../../../types/organization'
import { useOrganizationsSQL } from '../../composables/data/useOrganizations'

type StatItem = {
  label: string
  value: string
}

type CtaItem = {
  label: string
  href: string
  icon?: string
}

type ExternalLinkItem = {
  label: string
  href: string
  icon: string
}

type OrganizationHeroProps = {
  eyebrow?: string
  eyebrowIcon?: string
  title?: string
  highlight?: string
  subtitle?: string
  floatingBadge?: string
  primaryCta?: CtaItem
  secondaryCta?: CtaItem
  stats?: StatItem[]
  organizations?: OrganizationItem[]
}

const props = defineProps<OrganizationHeroProps>()

const {
  organizations,
  featuredOrganizations
} = useOrganizationsSQL()

const listTo = '/organizations'
const activeIndex = ref(0)
const copied = ref(false)

const loadedImageByOrganization = ref<Record<string, string>>({})
const failedImageMap = ref<Record<string, boolean>>({})
const globalLoadedImage = ref('')
const defaultFallbackImage = '/assets/images/village/martopuro-hero.jpg'

const fallbackOrganization: OrganizationItem = {
  id: 'fallback-culture',
  tenantId: 'fallback',
  parentId: null,
  organizationType: 'culture',
  name: 'Martopuro Culture Fest',
  displayName: 'Martopuro Culture Fest',
  slug: 'martopuro-culture-fest',
  shortDescription: 'Wadah kegiatan budaya, musik, UMKM, dan kuliner lokal Martopuro.',
  description:
    'Parade seni tradisi, UMKM lokal, pentas musik, lomba warga, dan kuliner khas dalam satu perayaan meriah.',
  logoUrl: null,
  coverUrl: 'https://martopuro.sencra.io/assets/culturefest/2.JPG',
  email: null,
  phone: null,
  whatsapp: null,
  websiteUrl: 'https://instagram.com/martopuroculturefest',
  address: 'Desa Martopuro',
  latitude: null,
  longitude: null,
  contact: {},
  addressConfig: {},
  social: {
    instagram: '@martopuroculturefest'
  },
  operationalHours: {},
  metadata: {
    icon: 'lucide:sparkles',
    instagram: '@martopuroculturefest',
    images: [
      'https://martopuro.sencra.io/assets/culturefest/2.JPG'
    ]
  },
  status: 'active',
  isFeatured: true,
  sortOrder: 1,
  createdAt: Date.now(),
  updatedAt: Date.now()
}

const organizationSource = computed(() => {
  if (props.organizations?.length) return props.organizations
  if (featuredOrganizations.value.length) return featuredOrganizations.value
  return organizations.value
})

const organizationSlides = computed(() => {
  const source = organizationSource.value.length
    ? organizationSource.value
    : [fallbackOrganization]

  return dedupeOrganizations(source)
    .filter((item) => item.status === 'active')
    .sort((a, b) => {
      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)

      if (sortA !== sortB) return sortA - sortB

      return String(a.displayName || a.name || '').localeCompare(String(b.displayName || b.name || ''))
    })
})

const compactOrganizationList = computed(() => {
  return organizationSlides.value.slice(0, 6)
})

const hasMultipleOrganizations = computed(() => organizationSlides.value.length > 1)

const activeOrganization = computed(() => {
  return organizationSlides.value[activeIndex.value] || organizationSlides.value[0] || fallbackOrganization
})

const activeExternalLinks = computed<ExternalLinkItem[]>(() => {
  return activeOrganization.value
    ? resolveExternalLinks(activeOrganization.value)
    : []
})

const c = computed(() => {
  const org = activeOrganization.value
  const typeLabel = getOrganizationTypeLabel(org.organizationType)

  return {
    eyebrow: props.eyebrow || typeLabel,
    eyebrowIcon: props.eyebrowIcon || getOrganizationIcon(org),
    title: props.title || 'Organisasi & Komunitas ',
    highlight: props.highlight || 'Desa',
    subtitle:
      props.subtitle ||
      getOrganizationDescriptionText(org) ||
      'Kenali organisasi, komunitas, dan lembaga aktif yang mendukung pelayanan, budaya, ekonomi, dan kegiatan warga desa.',
    floatingBadge:
      props.floatingBadge ||
      org.displayName ||
      'Organisasi Desa',
    stats: props.stats?.length
      ? props.stats
      : resolveStats()
  }
})

watch(organizationSlides, (items) => {
  if (!items.length) {
    activeIndex.value = 0
    return
  }

  if (activeIndex.value > items.length - 1) {
    activeIndex.value = 0
  }
}, {
  immediate: true
})

function setActiveOrganization(index: number) {
  if (!organizationSlides.value.length) return
  activeIndex.value = Math.max(0, Math.min(index, organizationSlides.value.length - 1))
}

function nextOrganization() {
  if (!hasMultipleOrganizations.value) return
  activeIndex.value = (activeIndex.value + 1) % organizationSlides.value.length
}

function prevOrganization() {
  if (!hasMultipleOrganizations.value) return
  activeIndex.value =
    activeIndex.value === 0
      ? organizationSlides.value.length - 1
      : activeIndex.value - 1
}

function organizationDetailTo(item: OrganizationItem) {
  return {
    path: '/organizations',
    query: {
      detail: item.slug
    }
  }
}

function dedupeOrganizations(items: OrganizationItem[]) {
  const map = new Map<string, OrganizationItem>()

  for (const item of items) {
    const key = String(item.id || item.slug || item.name || item.displayName)
      .trim()
      .toLowerCase()

    if (!key || map.has(key)) continue
    map.set(key, item)
  }

  return Array.from(map.values())
}

function normalizeImageUrl(value: unknown) {
  return String(value || '').trim()
}

function isFailedImage(url?: string | null) {
  const normalizedUrl = normalizeImageUrl(url)
  if (!normalizedUrl) return false

  return Boolean(failedImageMap.value[normalizedUrl])
}

function getOrganizationImages(item: OrganizationItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  const images = [
    item.coverUrl,
    item.imageUrl,
    ...metadataImages,
    item.logoUrl
  ]
    .map(normalizeImageUrl)
    .filter(Boolean)
    .filter((image) => !isFailedImage(image))

  return Array.from(new Set(images))
}

function getOrganizationCover(item: OrganizationItem) {
  return (
    getOrganizationImages(item)[0] ||
    loadedImageByOrganization.value[item.id] ||
    globalLoadedImage.value ||
    defaultFallbackImage
  )
}

function getSafeImageSrc(item: OrganizationItem, image?: string | null) {
  const currentImage = normalizeImageUrl(image || getOrganizationCover(item))

  if (currentImage && !isFailedImage(currentImage)) {
    return currentImage
  }

  return (
    loadedImageByOrganization.value[item.id] ||
    globalLoadedImage.value ||
    defaultFallbackImage
  )
}

function onImageLoad(item: OrganizationItem, image?: string | null) {
  const url = normalizeImageUrl(image || getOrganizationCover(item))

  if (!url || isFailedImage(url)) return

  loadedImageByOrganization.value = {
    ...loadedImageByOrganization.value,
    [item.id]: url
  }

  if (!globalLoadedImage.value) {
    globalLoadedImage.value = url
  }
}

function onImageError(event: Event, item: OrganizationItem, image?: string | null) {
  const failedUrl = normalizeImageUrl(image || getOrganizationCover(item))

  if (failedUrl) {
    failedImageMap.value = {
      ...failedImageMap.value,
      [failedUrl]: true
    }
  }

  const target = event.target as HTMLImageElement
  const fallback =
    loadedImageByOrganization.value[item.id] ||
    globalLoadedImage.value ||
    defaultFallbackImage

  if (target && target.src !== fallback) {
    target.src = fallback
  }
}

function getOrganizationDescriptionText(item: OrganizationItem) {
  return htmlToPlainText(
    item.shortDescription ||
    item.description ||
    'Organisasi aktif yang terhubung dengan tenant desa.'
  )
}

function htmlToPlainText(value?: string | null) {
  const html = String(value || '').trim()

  if (!html) return ''

  if (typeof window !== 'undefined') {
    const doc = new DOMParser().parseFromString(html, 'text/html')

    doc.querySelectorAll('script, style, iframe, object, embed').forEach((el) => {
      el.remove()
    })

    return (doc.body.textContent || '')
      .replace(/\s+/g, ' ')
      .trim()
  }

  return html
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

function getOrganizationIcon(item: OrganizationItem) {
  const icon = item.metadata?.icon

  if (typeof icon === 'string' && icon) return icon

  const map: Record<OrganizationType, string> = {
    government: 'lucide:landmark',
    village_government: 'lucide:building-2',
    bumdes: 'lucide:briefcase-business',
    youth: 'lucide:users-round',
    women: 'lucide:heart-handshake',
    community: 'lucide:users',
    religious: 'lucide:mosque',
    education: 'lucide:graduation-cap',
    health: 'lucide:heart-pulse',
    umkm: 'lucide:store',
    tourism: 'lucide:map-pin',
    culture: 'lucide:sparkles',
    security: 'lucide:shield-check',
    custom: 'lucide:layers'
  }

  return map[item.organizationType] || 'lucide:layers'
}

function getOrganizationTypeLabel(type: OrganizationType) {
  const map: Record<OrganizationType, string> = {
    government: 'Pemerintahan',
    village_government: 'Pemerintah Desa',
    bumdes: 'BUMDes',
    youth: 'Karang Taruna',
    women: 'PKK / Perempuan',
    community: 'Komunitas',
    religious: 'Keagamaan',
    education: 'Pendidikan',
    health: 'Kesehatan',
    umkm: 'UMKM',
    tourism: 'Wisata',
    culture: 'Budaya',
    security: 'Keamanan',
    custom: 'Organisasi'
  }

  return map[type] || 'Organisasi'
}

function resolveOrganizationContact(item: OrganizationItem) {
  const social = getRecord((item as any).social)
  const metadata = getRecord(item.metadata)

  return (
    item.whatsapp ||
    item.phone ||
    item.email ||
    getString(social.instagram) ||
    getString(metadata.instagram) ||
    ''
  )
}

function resolveExternalLinks(item: OrganizationItem): ExternalLinkItem[] {
  const social = getRecord((item as any).social)
  const metadata = getRecord(item.metadata)
  const metadataSocial = getRecord(metadata.social)

  const candidates: ExternalLinkItem[] = []

  addExternalLink(candidates, {
    label: 'Website',
    href: normalizeExternalHref(item.websiteUrl),
    icon: 'lucide:globe'
  })

  addExternalLink(candidates, {
    label: getString(metadata.ctaLabel) || 'Buka Link',
    href: normalizeExternalHref(metadata.ctaHref),
    icon: resolveExternalIcon(metadata.ctaHref, 'website')
  })

  const sources: Array<[string, unknown]> = [
    ['instagram', social.instagram || metadata.instagram || metadataSocial.instagram],
    ['facebook', social.facebook || metadata.facebook || metadataSocial.facebook],
    ['youtube', social.youtube || metadata.youtube || metadataSocial.youtube],
    ['tiktok', social.tiktok || metadata.tiktok || metadataSocial.tiktok],
    ['x', social.x || social.twitter || metadata.x || metadata.twitter || metadataSocial.x || metadataSocial.twitter],
    ['linkedin', social.linkedin || metadata.linkedin || metadataSocial.linkedin]
  ]

  for (const [platform, value] of sources) {
    addExternalLink(candidates, {
      label: getExternalLabel(platform),
      href: normalizeExternalHref(value, platform),
      icon: resolveExternalIcon(value, platform)
    })
  }

  return candidates.slice(0, 4)
}

function addExternalLink(items: ExternalLinkItem[], link: ExternalLinkItem) {
  if (!link.href) return

  const duplicated = items.some((item) => item.href === link.href)

  if (duplicated) return

  items.push(link)
}

function normalizeExternalHref(value: unknown, platform?: string) {
  const raw = getString(value)

  if (!raw) return ''
  if (/^(https?:)?\/\//i.test(raw)) return raw.startsWith('//') ? `https:${raw}` : raw

  const handle = raw.replace(/^@/, '').trim()

  if (!handle) return ''

  const platformBaseUrl: Record<string, string> = {
    instagram: 'https://instagram.com/',
    facebook: 'https://facebook.com/',
    youtube: 'https://youtube.com/',
    tiktok: 'https://tiktok.com/@',
    x: 'https://x.com/',
    twitter: 'https://x.com/',
    linkedin: 'https://linkedin.com/in/'
  }

  if (platform && platformBaseUrl[platform]) {
    return `${platformBaseUrl[platform]}${handle}`
  }

  if (/^[\w.-]+\.[a-z]{2,}(\/.*)?$/i.test(raw)) {
    return `https://${raw}`
  }

  return ''
}

function resolveExternalIcon(value: unknown, fallbackPlatform = 'website') {
  const raw = getString(value).toLowerCase()
  const platform = raw.includes('instagram') ? 'instagram'
    : raw.includes('facebook') ? 'facebook'
      : raw.includes('youtube') || raw.includes('youtu.be') ? 'youtube'
        : raw.includes('tiktok') ? 'tiktok'
          : raw.includes('x.com') || raw.includes('twitter') ? 'x'
            : raw.includes('linkedin') ? 'linkedin'
              : fallbackPlatform

  const map: Record<string, string> = {
    website: 'lucide:globe',
    instagram: 'lucide:instagram',
    facebook: 'lucide:facebook',
    youtube: 'lucide:youtube',
    tiktok: 'lucide:music-2',
    x: 'lucide:twitter',
    twitter: 'lucide:twitter',
    linkedin: 'lucide:linkedin'
  }

  return map[platform] || 'lucide:external-link'
}

function getExternalLabel(platform: string) {
  const map: Record<string, string> = {
    instagram: 'Instagram',
    facebook: 'Facebook',
    youtube: 'YouTube',
    tiktok: 'TikTok',
    x: 'X / Twitter',
    twitter: 'X / Twitter',
    linkedin: 'LinkedIn'
  }

  return map[platform] || 'Buka Link'
}

function getRecord(value: unknown): Record<string, any> {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return {}
  return value as Record<string, any>
}

function getString(value: unknown) {
  return String(value || '').trim()
}

function resolveStats(): StatItem[] {
  const total = organizationSlides.value.length
  const featured = organizationSlides.value.filter((item) => item.isFeatured).length
  const types = new Set(organizationSlides.value.map((item) => item.organizationType)).size

  return [
    {
      label: 'Organisasi',
      value: `${total} Aktif`
    },
    {
      label: 'Featured',
      value: `${featured} Utama`
    },
    {
      label: 'Kategori',
      value: `${types} Jenis`
    }
  ]
}

async function copyText(value: string) {
  if (!value) return

  copied.value = true

  try {
    await navigator.clipboard.writeText(value)
  } catch {}

  window.setTimeout(() => {
    copied.value = false
  }, 1400)
}
</script>

<style scoped>
.bg-grid {
  background-size: 44px 44px;
  background-image:
    linear-gradient(to right, #e2e8f0 1px, transparent 1px),
    linear-gradient(to bottom, #e2e8f0 1px, transparent 1px);
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
