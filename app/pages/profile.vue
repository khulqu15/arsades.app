<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-40 top-0 h-[520px] w-[520px] rounded-full bg-blue-100/80 blur-3xl"></div>
      <div class="absolute -right-40 top-24 h-[520px] w-[520px] rounded-full bg-sky-100/70 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[420px] w-[420px] rounded-full bg-blue-50 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <section v-if="pending" class="mx-auto max-w-6xl px-4 pb-14 pt-28 sm:px-6 lg:px-8">
      <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
        <div class="grid animate-pulse gap-6 lg:grid-cols-[1fr_320px]">
          <div>
            <div class="h-5 w-40 rounded-full bg-neutral-100"></div>
            <div class="mt-5 h-14 w-4/5 rounded-2xl bg-neutral-100"></div>
            <div class="mt-4 h-4 w-full rounded-full bg-neutral-100"></div>
            <div class="mt-3 h-4 w-3/4 rounded-full bg-neutral-100"></div>
            <div class="mt-7 flex gap-3">
              <div class="h-11 w-36 rounded-2xl bg-neutral-100"></div>
              <div class="h-11 w-32 rounded-2xl bg-neutral-100"></div>
            </div>
          </div>
          <div class="h-72 rounded-[1.75rem] bg-neutral-100"></div>
        </div>
      </div>
    </section>

    <section v-else class="relative pt-24 sm:pt-28">
      <div class="mx-auto max-w-6xl px-4 pb-12 sm:px-6 lg:px-8">
        <nav class="mb-5 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
          <NuxtLink to="/" class="transition hover:text-blue-600">
            Beranda
          </NuxtLink>
          <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
          <span class="text-neutral-950">Profil</span>
        </nav>

        <section class="overflow-hidden rounded-[2.25rem] border border-neutral-200/80 bg-white/90 shadow-[0_30px_90px_-60px_rgba(15,23,42,0.55)] backdrop-blur-xl">
          <div class="grid lg:grid-cols-[1fr_340px]">
            <div class="relative p-5 sm:p-8 lg:p-10">
              <div class="pointer-events-none absolute -left-20 -top-20 h-60 w-60 rounded-full bg-blue-100 blur-3xl"></div>
              <div class="relative">
                <div class="mb-5 flex flex-wrap items-center gap-2">
                  <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-600 ring-1 ring-blue-100">
                    <Icon :icon="profileBadgeIcon" class="h-4 w-4" />
                    {{ tenantTypeLabel }}
                  </span>

                  <span class="rounded-full border border-neutral-200 bg-white px-3 py-1.5 text-xs font-black text-neutral-500">
                    {{ tenant?.slug || tenantSlug }}
                  </span>
                </div>

                <h1 class="max-w-3xl text-4xl font-black leading-[1.04] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
                  Profil
                  <span class="block bg-gradient-to-r from-blue-600 via-sky-500 to-cyan-400 bg-clip-text text-transparent">
                    {{ displayName }}
                  </span>
                </h1>

                <p class="mt-5 max-w-2xl text-base font-semibold leading-8 text-neutral-600 sm:text-lg">
                  {{ heroDescription }}
                </p>

                <div class="mt-7 flex flex-wrap gap-3">
                  <NuxtLink
                    to="/organizations"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
                  >
                    Lihat Organisasi
                    <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
                  </NuxtLink>

                  <a
                    v-if="mapsHref"
                    :href="mapsHref"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                  >
                    <Icon icon="solar:map-point-bold-duotone" class="h-5 w-5 text-blue-600" />
                    Lokasi
                  </a>

                  <a
                    v-if="contactWhatsappHref"
                    :href="contactWhatsappHref"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                  >
                    <Icon icon="solar:chat-round-call-bold-duotone" class="h-5 w-5 text-blue-600" />
                    Hubungi
                  </a>
                </div>
              </div>
            </div>

            <aside class="border-t border-neutral-200 bg-neutral-50/70 p-5 sm:p-6 lg:border-l lg:border-t-0">
              <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
                <div class="flex items-start gap-4">
                  <div class="grid h-24 w-24 shrink-0 place-items-center overflow-hidden rounded-[1.7rem] border border-blue-100 bg-white text-blue-600 shadow-sm">
                    <img
                      v-if="tenantLogo && !logoFailed"
                      :src="tenantLogo"
                      :alt="displayName"
                      class="h-full w-full object-contain p-2.5"
                      @error="logoFailed = true"
                    >
                    <Icon v-else :icon="profileBadgeIcon" class="h-11 w-11" />
                  </div>

                  <div class="min-w-0 flex-1 pt-1">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                      Tenant Profile
                    </p>
                    <h2 class="mt-1 line-clamp-2 text-xl font-black leading-6 text-neutral-950">
                      {{ displayName }}
                    </h2>
                    <p class="mt-2 truncate text-sm font-bold text-neutral-500">
                      {{ displayDomain }}
                    </p>
                  </div>
                </div>

                <div class="mt-5 space-y-2.5">
                  <ProfileInfoRow icon="solar:buildings-bold-duotone" label="Tipe" :value="tenantTypeLabel" />
                  <ProfileInfoRow icon="solar:global-bold-duotone" label="Website" :value="displayDomain" />
                  <ProfileInfoRow v-if="addressText" icon="solar:map-point-bold-duotone" label="Alamat" :value="addressText" />
                </div>

                <div v-if="socialLinks.length" class="mt-5 flex flex-wrap gap-2">
                  <a
                    v-for="item in socialLinks"
                    :key="item.href"
                    :href="item.href"
                    target="_blank"
                    rel="noopener"
                    class="grid h-10 w-10 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-600 transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
                    :aria-label="item.label"
                  >
                    <Icon :icon="item.icon" class="h-5 w-5" />
                  </a>
                </div>
              </div>
            </aside>
          </div>
        </section>
      </div>

      <section class="mx-auto grid max-w-6xl gap-5 px-4 pb-14 sm:px-6 lg:grid-cols-[1fr_330px] lg:px-8">
        <div class="space-y-5">
          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                  Tentang Kami
                </p>
                <h2 class="mt-2 text-2xl font-black tracking-tight text-neutral-950">
                  Mengenal {{ displayName }}
                </h2>
              </div>
              <div class="hidden h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600 sm:grid">
                <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
              </div>
            </div>

            <div class="prose-content mt-5" v-html="aboutHtml"></div>
          </article>

          <article v-if="visionText || missionText" class="grid gap-4 sm:grid-cols-2">
            <section v-if="visionText" class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
              <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <Icon icon="solar:eye-bold-duotone" class="h-5 w-5" />
              </div>
              <p class="mt-5 text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                Visi
              </p>
              <p class="mt-3 text-sm font-semibold leading-7 text-neutral-600">
                {{ visionText }}
              </p>
            </section>

            <section v-if="missionText" class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm sm:p-6">
              <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <Icon icon="solar:target-bold-duotone" class="h-5 w-5" />
              </div>
              <p class="mt-5 text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                Misi
              </p>
              <p class="mt-3 whitespace-pre-line text-sm font-semibold leading-7 text-neutral-600">
                {{ missionText }}
              </p>
            </section>
          </article>
        </div>

        <aside class="space-y-5">
          <section class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
            <p class="text-sm font-black text-neutral-950">
              Kontak Singkat
            </p>

            <div class="mt-4 space-y-3">
              <ContactLink
                v-if="contactPhone"
                icon="solar:phone-bold-duotone"
                label="Telepon"
                :value="contactPhone"
                :href="`tel:${contactPhone}`"
              />

              <ContactLink
                v-if="contactWhatsappHref"
                icon="solar:chat-round-call-bold-duotone"
                label="WhatsApp"
                :value="contactWhatsapp"
                :href="contactWhatsappHref"
              />

              <ContactLink
                v-if="contactEmail"
                icon="solar:letter-bold-duotone"
                label="Email"
                :value="contactEmail"
                :href="`mailto:${contactEmail}`"
              />

              <ContactLink
                v-if="siteUrl"
                icon="solar:global-bold-duotone"
                label="Website"
                :value="displayDomain"
                :href="siteUrl"
              />

              <div v-if="!contactPhone && !contactWhatsappHref && !contactEmail && !siteUrl" class="rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-5 text-center">
                <Icon icon="solar:phone-bold-duotone" class="mx-auto h-8 w-8 text-neutral-400" />
                <p class="mt-2 text-sm font-bold text-neutral-500">
                  Kontak belum tersedia.
                </p>
              </div>
            </div>
          </section>

          <section v-if="addressText || mapsHref" class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
            <p class="text-sm font-black text-neutral-950">
              Lokasi
            </p>
            <p v-if="addressText" class="mt-3 text-sm font-semibold leading-7 text-neutral-600">
              {{ addressText }}
            </p>

            <a
              v-if="mapsHref"
              :href="mapsHref"
              target="_blank"
              rel="noopener"
              class="mt-4 inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
            >
              <Icon icon="solar:map-point-bold-duotone" class="h-5 w-5" />
              Buka Google Maps
            </a>
          </section>
        </aside>
      </section>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref } from 'vue'
import { useAppApi } from '~/composables/useAppApi'

type TenantStatus = 'active' | 'inactive'
type TenantType = 'village' | 'school' | 'pesantren' | 'company' | 'custom'

type TenantProfile = {
  id?: string
  name?: string | null
  displayName?: string | null
  display_name?: string | null
  slug?: string | null
  tenantType?: TenantType | null
  tenant_type?: TenantType | null
  domain?: string | null
  siteUrl?: string | null
  site_url?: string | null
  logoUrl?: string | null
  logo_url?: string | null
  faviconUrl?: string | null
  ogImageUrl?: string | null
  description?: string | null
  status?: TenantStatus | string | null
  metadata?: Record<string, any> | null
  contactConfig?: Record<string, any> | null
  contact_config?: Record<string, any> | null
  seoConfig?: Record<string, any> | null
  seo_config?: Record<string, any> | null
  profileConfig?: Record<string, any> | null
  profile_config?: Record<string, any> | null
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()

const logoFailed = ref(false)

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

const fallbackTenant = computed<TenantProfile>(() => ({
  name: String(runtime.public.appName || runtime.public.siteName || 'Desa Martopuro'),
  displayName: String(runtime.public.clientDisplayName || runtime.public.appName || runtime.public.siteName || 'Desa Martopuro'),
  slug: tenantSlug.value,
  tenantType: 'village',
  siteUrl: String(runtime.public.siteUrl || requestUrl.origin || ''),
  logoUrl: String(runtime.public.appLogo || runtime.public.logoUrl || ''),
  description: String(
    runtime.public.appDescription ||
      'Profil resmi desa yang menyajikan informasi kelembagaan, layanan, potensi, dan kontak utama secara ringkas.'
  ),
  status: 'active'
}))

const {
  data: tenantResponse,
  pending,
  refresh
} = await useAsyncData(
  () => `tenant-profile-${tenantSlug.value}`,
  async () => {
    const candidatePaths = [
      '/profile',
      '/tenant',
      '/tenants/current',
      `/tenants/by-slug/${encodeURIComponent(tenantSlug.value)}`
    ]

    for (const path of candidatePaths) {
      try {
        const response = await $fetch<any>(tenantApiUrl(tenantSlug.value, path))
        const normalized = normalizeTenantResponse(response)

        if (normalized) return normalized
      } catch {}
    }

    return fallbackTenant.value
  },
  {
    watch: [tenantSlug],
    default: () => fallbackTenant.value
  }
)

const tenant = computed<TenantProfile>(() => tenantResponse.value || fallbackTenant.value)

const tenantType = computed<TenantType>(() => {
  return (tenant.value.tenantType || tenant.value.tenant_type || 'village') as TenantType
})

const tenantTypeLabel = computed(() => {
  const map: Record<TenantType, string> = {
    village: 'Desa Digital',
    school: 'Sekolah',
    pesantren: 'Pesantren',
    company: 'Perusahaan',
    custom: 'Profil'
  }

  return map[tenantType.value] || 'Profil'
})

const profileBadgeIcon = computed(() => {
  const map: Record<TenantType, string> = {
    village: 'solar:home-smile-angle-bold-duotone',
    school: 'solar:square-academic-cap-bold-duotone',
    pesantren: 'solar:moon-fog-bold-duotone',
    company: 'solar:buildings-3-bold-duotone',
    custom: 'solar:layers-bold-duotone'
  }

  return map[tenantType.value] || 'solar:layers-bold-duotone'
})

const displayName = computed(() => {
  return String(
    tenant.value.displayName ||
      tenant.value.display_name ||
      tenant.value.name ||
      runtime.public.clientDisplayName ||
      runtime.public.appName ||
      'Profil'
  )
})

const siteUrl = computed(() => {
  return normalizeUrl(
    tenant.value.siteUrl ||
      tenant.value.site_url ||
      runtime.public.siteUrl ||
      requestUrl.origin
  )
})

const displayDomain = computed(() => {
  const raw = String(tenant.value.domain || siteUrl.value || hostname.value || '')

  return raw
    .replace(/^https?:\/\//i, '')
    .replace(/^www\./i, '')
    .replace(/\/$/, '') || '-'
})

const tenantLogo = computed(() => {
  return String(
    tenant.value.logoUrl ||
      tenant.value.logo_url ||
      runtime.public.appLogo ||
      runtime.public.logoUrl ||
      ''
  ).trim()
})

const profileConfig = computed<Record<string, any>>(() => {
  return tenant.value.profileConfig || tenant.value.profile_config || tenant.value.metadata?.profile || {}
})

const contactConfig = computed<Record<string, any>>(() => {
  return tenant.value.contactConfig || tenant.value.contact_config || tenant.value.metadata?.contact || {}
})

const heroDescription = computed(() => {
  return plainText(
    profileConfig.value.heroDescription ||
      profileConfig.value.subtitle ||
      tenant.value.description ||
      fallbackTenant.value.description ||
      ''
  ).slice(0, 220)
})

const aboutHtml = computed(() => {
  const raw = profileConfig.value.aboutHtml ||
    profileConfig.value.contentHtml ||
    tenant.value.description ||
    fallbackTenant.value.description ||
    ''

  const html = String(raw).trim()

  if (/<[a-z][\s\S]*>/i.test(html)) {
    return sanitizeHtml(html)
  }

  return sanitizeHtml(`<p>${escapeHtml(html)}</p>`)
})

const visionText = computed(() => {
  return plainText(profileConfig.value.vision || tenant.value.metadata?.vision || '')
})

const missionText = computed(() => {
  const mission = profileConfig.value.mission || tenant.value.metadata?.mission || ''

  if (Array.isArray(mission)) return mission.join('\n')

  return plainText(String(mission || ''))
})

const contactPhone = computed(() => {
  return String(contactConfig.value.phone || tenant.value.metadata?.phone || '').trim()
})

const contactWhatsapp = computed(() => {
  return String(contactConfig.value.whatsapp || tenant.value.metadata?.whatsapp || contactPhone.value || '').trim()
})

const contactEmail = computed(() => {
  return String(contactConfig.value.email || tenant.value.metadata?.email || '').trim()
})

const addressText = computed(() => {
  return String(contactConfig.value.address || tenant.value.metadata?.address || '').trim()
})

const contactWhatsappHref = computed(() => {
  const number = contactWhatsapp.value.replace(/\D/g, '')

  if (!number) return ''

  return `https://wa.me/${number.startsWith('0') ? `62${number.slice(1)}` : number}`
})

const mapsHref = computed(() => {
  const lat = contactConfig.value.latitude || tenant.value.metadata?.latitude
  const lng = contactConfig.value.longitude || tenant.value.metadata?.longitude

  if (lat && lng) {
    return `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`
  }

  if (contactConfig.value.mapsUrl || tenant.value.metadata?.mapsUrl) {
    return String(contactConfig.value.mapsUrl || tenant.value.metadata?.mapsUrl)
  }

  if (addressText.value) {
    return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(addressText.value)}`
  }

  return ''
})

const socialLinks = computed(() => {
  const source = {
    ...(tenant.value.metadata?.social || {}),
    ...(contactConfig.value.social || {}),
    instagram: contactConfig.value.instagram || tenant.value.metadata?.instagram,
    facebook: contactConfig.value.facebook || tenant.value.metadata?.facebook,
    youtube: contactConfig.value.youtube || tenant.value.metadata?.youtube,
    tiktok: contactConfig.value.tiktok || tenant.value.metadata?.tiktok,
    x: contactConfig.value.x || contactConfig.value.twitter || tenant.value.metadata?.x || tenant.value.metadata?.twitter
  }

  const items = [
    buildSocialLink('Instagram', 'mdi:instagram', source.instagram, 'https://instagram.com/'),
    buildSocialLink('Facebook', 'mdi:facebook', source.facebook, 'https://facebook.com/'),
    buildSocialLink('YouTube', 'mdi:youtube', source.youtube, 'https://youtube.com/'),
    buildSocialLink('TikTok', 'ic:baseline-tiktok', source.tiktok, 'https://tiktok.com/@'),
    buildSocialLink('X', 'prime:twitter', source.x, 'https://x.com/')
  ]

  const unique = new Map<string, { label: string; icon: string; href: string }>()

  for (const item of items) {
    if (item?.href) unique.set(item.href, item)
  }

  return Array.from(unique.values())
})

const pageTitle = computed(() => `Profil · ${displayName.value}`)
const pageDescription = computed(() => heroDescription.value || `Profil ${displayName.value}`)

useSeoMeta({
  title: () => pageTitle.value,
  description: () => pageDescription.value,
  ogTitle: () => pageTitle.value,
  ogDescription: () => pageDescription.value,
  ogImage: () => tenantLogo.value || undefined,
  robots: 'index, follow'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      rel: 'canonical',
      href: `${requestUrl.origin}/profile`
    }
  ]
}))

function normalizeTenantResponse(response: any): TenantProfile | null {
  const candidate = response?.data || response?.tenant || response

  if (!candidate || typeof candidate !== 'object') return null

  return candidate as TenantProfile
}

function normalizeUrl(value?: string | null) {
  const raw = String(value || '').trim()

  if (!raw) return ''
  if (/^https?:\/\//i.test(raw)) return raw

  return `https://${raw}`
}

function buildSocialLink(label: string, icon: string, value: unknown, baseUrl: string) {
  const raw = String(value || '').trim()

  if (!raw) return null

  const href = /^https?:\/\//i.test(raw)
    ? raw
    : `${baseUrl}${raw.replace(/^@/, '')}`

  return { label, icon, href }
}

function sanitizeHtml(value: string) {
  const html = String(value || '').trim()

  if (!html) return ''

  if (typeof window !== 'undefined') {
    const doc = new DOMParser().parseFromString(html, 'text/html')

    doc.querySelectorAll('script, style, object, embed').forEach((element) => {
      element.remove()
    })

    doc.querySelectorAll('*').forEach((element) => {
      Array.from(element.attributes).forEach((attribute) => {
        const name = attribute.name.toLowerCase()
        const val = attribute.value || ''

        if (name.startsWith('on')) element.removeAttribute(attribute.name)
        if (['href', 'src'].includes(name) && /^javascript:/i.test(val)) {
          element.removeAttribute(attribute.name)
        }
      })
    })

    return doc.body.innerHTML
  }

  return html
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
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

function escapeHtml(value: string) {
  return String(value || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

const ProfileInfoRow = defineComponent({
  props: {
    icon: {
      type: String,
      required: true
    },
    label: {
      type: String,
      required: true
    },
    value: {
      type: String,
      required: true
    }
  },
  setup(props) {
    return () => h(
      'div',
      {
        class: 'flex items-center gap-3 rounded-2xl border border-neutral-100 bg-neutral-50 px-3 py-2.5'
      },
      [
        h('div', { class: 'grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-blue-50 text-blue-600' }, [
          h(Icon, { icon: props.icon, class: 'h-4.5 w-4.5' })
        ]),
        h('div', { class: 'min-w-0 flex-1' }, [
          h('p', { class: 'text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400' }, props.label),
          h('p', { class: 'mt-0.5 truncate text-sm font-black text-neutral-800' }, props.value)
        ])
      ]
    )
  }
})

const ContactLink = defineComponent({
  props: {
    icon: {
      type: String,
      required: true
    },
    label: {
      type: String,
      required: true
    },
    value: {
      type: String,
      required: true
    },
    href: {
      type: String,
      default: ''
    }
  },
  setup(props) {
    return () => {
      const children = [
        h('div', { class: 'grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600' }, [
          h(Icon, { icon: props.icon, class: 'h-5 w-5' })
        ]),
        h('div', { class: 'min-w-0 flex-1' }, [
          h('p', { class: 'text-xs font-black uppercase tracking-[0.14em] text-neutral-400' }, props.label),
          h('p', { class: 'mt-1 truncate text-sm font-bold text-neutral-800' }, props.value)
        ])
      ]

      const className = 'flex items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-3 transition hover:border-blue-200 hover:bg-blue-50'

      if (props.href) {
        return h('a', {
          href: props.href,
          target: props.href.startsWith('http') ? '_blank' : undefined,
          rel: props.href.startsWith('http') ? 'noopener' : undefined,
          class: className
        }, children)
      }

      return h('div', { class: className }, children)
    }
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

.prose-content {
  color: #404040;
  font-size: 0.97rem;
  line-height: 1.85;
}

.prose-content :deep(h2) {
  margin-top: 1.6rem;
  margin-bottom: 0.65rem;
  font-size: 1.45rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.prose-content :deep(h3) {
  margin-top: 1.25rem;
  margin-bottom: 0.55rem;
  font-size: 1.15rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.prose-content :deep(p) {
  margin: 0.85rem 0;
}

.prose-content :deep(a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.prose-content :deep(ul),
.prose-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.prose-content :deep(li) {
  margin: 0.35rem 0;
}

.prose-content :deep(blockquote) {
  margin: 1.1rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.85rem;
  background: #eff6ff;
  padding: 0.9rem 1.1rem;
  color: #404040;
}

.prose-content :deep(img) {
  margin: 1.1rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid #e5e5e5;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
