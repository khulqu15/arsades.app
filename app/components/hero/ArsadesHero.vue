<template>
  <section
    id="arsades-hero"
    aria-label="ARSADES Platform Desa Digital"
    class="relative isolate overflow-hidden bg-slate-50 text-slate-950"
  >
    <!-- Soft background -->
    <div class="pointer-events-none absolute inset-0 -z-10 overflow-hidden">
      <div class="absolute inset-0 bg-[linear-gradient(to_right,#e2e8f0_1px,transparent_1px),linear-gradient(to_bottom,#e2e8f0_1px,transparent_1px)] bg-[size:48px_48px] opacity-35"></div>
      <div class="absolute -left-32 top-10 h-[420px] w-[420px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-40 top-16 h-[460px] w-[460px] rounded-full bg-sky-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[340px] w-[340px] rounded-full bg-white blur-3xl"></div>
    </div>

    <!-- GSAP logo-inspired pattern -->
    <div
      ref="patternRoot"
      class="pointer-events-none absolute inset-0 -z-10 overflow-hidden"
      aria-hidden="true"
    >
      <span
        v-for="piece in patternPieces"
        :key="piece.id"
        class="arsades-pattern-piece absolute opacity-[0.13] mix-blend-multiply"
        :style="{
          left: piece.left,
          top: piece.top,
          width: piece.size,
          height: piece.size,
          transform: `rotate(${piece.rotate}deg) scale(${piece.scale})`
        }"
      ></span>
    </div>

    <div class="mx-auto grid max-w-7xl items-center gap-10 px-4 py-20 sm:px-6 sm:py-24 lg:grid-cols-[0.95fr_1.05fr] lg:px-8 lg:py-28">
      <!-- Left -->
      <div class="relative z-10 max-w-3xl">
        <!-- Brand badge -->
        <div class="inline-flex max-w-full items-center gap-3 rounded-3xl border border-blue-100 bg-white/85 px-3 py-2 shadow-sm shadow-slate-900/5 backdrop-blur-xl">
          <div class="grid h-11 w-11 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-blue-50 p-1.5 shadow-inner">
            <img
              v-if="resolvedLogoUrl && !logoFailed"
              :src="resolvedLogoUrl"
              :alt="brandName"
              class="h-full w-full object-contain"
              @error="logoFailed = true"
            >
            <Icon
              v-else
              icon="lucide:blocks"
              class="h-5 w-5 text-blue-600"
            />
          </div>

          <div class="min-w-0">
            <p class="truncate text-sm font-black leading-5 text-slate-950">
              Arsades
            </p>
            <p class="truncate text-[11px] font-extrabold uppercase tracking-[0.14em] text-blue-600">
              {{ c.eyebrow }}
            </p>
          </div>
        </div>

        <h1 class="mt-7 max-w-4xl text-4xl font-black leading-[1.04] tracking-[-0.05em] text-slate-950 sm:text-5xl lg:text-6xl">
          {{ c.titleStart }}
          <span class="bg-gradient-to-r from-blue-600 via-blue-500 to-sky-400 bg-clip-text text-transparent">
            {{ c.titleHighlight }}
          </span>
          {{ c.titleEnd }}
        </h1>

        <p class="mt-5 max-w-2xl text-sm font-semibold leading-7 text-slate-600 sm:text-base sm:leading-8">
          {{ c.subtitle }}
        </p>

        <!-- CTA -->
        <div class="mt-7 flex flex-col gap-3 sm:flex-row sm:items-center">
          <a
            :href="normalizedPrimaryHref"
            :target="isExternalHref(normalizedPrimaryHref) ? '_blank' : undefined"
            :rel="isExternalHref(normalizedPrimaryHref) ? 'noopener' : undefined"
            class="group inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-xl shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
          >
            {{ c.primaryCta.label }}
            <Icon icon="lucide:arrow-right" class="h-4 w-4 transition group-hover:translate-x-0.5" />
          </a>

          <a
            :href="normalizedSecondaryHref"
            :target="isExternalHref(normalizedSecondaryHref) ? '_blank' : undefined"
            :rel="isExternalHref(normalizedSecondaryHref) ? 'noopener' : undefined"
            class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white/85 px-5 text-sm font-black text-slate-700 shadow-sm shadow-slate-900/5 backdrop-blur transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          >
            {{ c.secondaryCta.label }}
            <Icon icon="lucide:send" class="h-4 w-4" />
          </a>
        </div>

      </div>

      <!-- Right mockup -->
      <div class="relative z-10">
        <div class="relative mx-auto max-w-2xl">
          <div class="absolute -inset-4 rounded-[3rem] bg-blue-200/40 blur-3xl"></div>

          <div
            ref="mockupCard"
            class="relative overflow-hidden rounded-[2rem] border border-white bg-white/90 p-3 shadow-[0_30px_90px_-45px_rgba(15,23,42,0.65)] backdrop-blur-xl sm:p-4"
          >
            <!-- Top bar -->
            <div class="flex items-center justify-between gap-3 rounded-[1.5rem] border border-slate-100 bg-slate-50/90 px-4 py-3">
              <div class="flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center overflow-hidden rounded-2xl bg-blue-600 p-1.5">
                  <img
                    v-if="resolvedLogoUrl && !mockupLogoFailed"
                    :src="resolvedLogoUrl"
                    :alt="brandName"
                    class="h-full w-full object-contain brightness-0 invert"
                    @error="mockupLogoFailed = true"
                  >
                  <Icon
                    v-else
                    icon="lucide:blocks"
                    class="h-5 w-5 text-white"
                  />
                </div>
                <div>
                  <p class="text-sm font-black text-slate-950">
                    Arsades OS
                  </p>
                  <p class="text-xs font-bold text-slate-400">
                    Village digital workspace
                  </p>
                </div>
              </div>

              <span class="hidden rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black text-blue-700 sm:inline-flex">
                {{ c.floatingBadge }}
              </span>
            </div>

            <div class="mt-4 grid gap-3 lg:grid-cols-[0.72fr_1fr]">
              <!-- Mini sidebar -->
              <aside class="rounded-[1.5rem] border border-slate-100 bg-slate-950 p-3 text-white">
                <div class="mb-4 flex items-center gap-2 px-1">
                  <span class="h-2.5 w-2.5 rounded-full bg-blue-400"></span>
                  <span class="text-xs font-black uppercase tracking-[0.16em] text-white/60">Modules</span>
                </div>

                <div class="space-y-2">
                  <button
                    v-for="feature in c.features.slice(0, 5)"
                    :key="`nav-${feature.key}`"
                    type="button"
                    class="flex w-full items-center gap-2 rounded-2xl px-3 py-2.5 text-left text-xs font-black transition"
                    :class="activeFeature === feature.key
                      ? 'bg-blue-600 text-white shadow-lg shadow-blue-950/20'
                      : 'text-white/60 hover:bg-white/10 hover:text-white'"
                    @click="activeFeature = feature.key"
                  >
                    <Icon :icon="feature.icon" class="h-4 w-4" />
                    <span class="truncate">{{ feature.label }}</span>
                  </button>
                </div>
              </aside>

              <!-- Main preview -->
              <div class="grid gap-3">
                <article class="rounded-[1.5rem] border border-slate-100 bg-gradient-to-br from-blue-600 to-blue-500 p-5 text-white shadow-lg shadow-blue-600/20">
                  <div class="flex items-start justify-between gap-4">
                    <div>
                      <p class="text-xs font-black uppercase tracking-[0.16em] text-white/65">
                        Selected module
                      </p>
                      <h3 class="mt-2 text-2xl font-black tracking-tight">
                        {{ activeFeatureData.title }}
                      </h3>
                    </div>
                    <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-white/15 backdrop-blur">
                      <Icon :icon="activeFeatureData.icon" class="h-6 w-6" />
                    </div>
                  </div>
                  <p class="mt-3 line-clamp-2 text-sm font-semibold leading-6 text-white/80">
                    {{ activeFeatureData.description }}
                  </p>
                </article>

                <div class="grid gap-3 sm:grid-cols-2">
                  <article
                    v-for="item in compactCards"
                    :key="item.label"
                    class="rounded-[1.35rem] border border-slate-100 bg-white p-4 shadow-sm"
                  >
                    <div class="flex items-center gap-3">
                      <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                        <Icon :icon="item.icon" class="h-5 w-5" />
                      </div>
                      <div class="min-w-0">
                        <p class="truncate text-sm font-black text-slate-950">
                          {{ item.label }}
                        </p>
                        <p class="truncate text-xs font-bold text-slate-400">
                          {{ item.description }}
                        </p>
                      </div>
                    </div>
                  </article>
                </div>

                <article class="rounded-[1.5rem] border border-slate-100 bg-slate-50 p-4">
                  <div class="flex items-center justify-between gap-3">
                    <div>
                      <p class="text-sm font-black text-slate-950">Berita & informasi</p>
                      <p class="mt-1 text-xs font-bold text-slate-400">Detail link mengikuti pages/news.vue</p>
                    </div>
                    <a
                      :href="normalizedNewsHref"
                      class="inline-flex h-9 shrink-0 items-center gap-2 rounded-2xl bg-white px-3 text-xs font-black text-blue-600 shadow-sm transition hover:bg-blue-50"
                    >
                      Buka
                      <Icon icon="lucide:arrow-up-right" class="h-3.5 w-3.5" />
                    </a>
                  </div>
                </article>
              </div>
            </div>
          </div>

          <div
            ref="floatingPill"
            class="absolute -bottom-5 left-4 right-4 mx-auto max-w-md rounded-[1.5rem] border border-white bg-white/95 p-3 shadow-2xl shadow-slate-900/10 backdrop-blur-xl sm:-bottom-6"
          >
            <div class="flex items-center gap-3">
              <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <Icon icon="lucide:shield-check" class="h-5 w-5" />
              </div>
              <div class="min-w-0">
                <p class="truncate text-sm font-black text-slate-950">Clean, secure, integrated</p>
                <p class="truncate text-xs font-semibold text-slate-500">Portal desa digital dengan UI modern dan alur sederhana.</p>
              </div>
            </div>
          </div>
        </div>

        <div class="h-10 lg:h-0"></div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import { Icon } from '@iconify/vue'
import { gsap } from 'gsap'

type FeatureKey = 'surat' | 'aduan' | 'apbdes' | 'umkm' | 'agenda' | string

type FeatureItem = {
  key: FeatureKey
  label: string
  icon: string
  title: string
  description: string
}

type CtaItem = {
  label: string
  href: string
}

type DashboardMetric = {
  label: string
  value: string
  icon: string
  progress: string
}

type BudgetCard = {
  label: string
  percent: string
}

type StatusItem = {
  label: string
  status: 'Selesai' | 'Proses' | 'Verifikasi' | string
}

type HeroArsadesProps = {
  eyebrow?: string
  titleStart?: string
  titleHighlight?: string
  titleEnd?: string
  subtitle?: string
  floatingBadge?: string
  logoUrl?: string
  brandName?: string
  newsHref?: string
  primaryCta?: CtaItem
  secondaryCta?: CtaItem
  features?: FeatureItem[]

  /** Kept for backward compatibility, intentionally not displayed as stats. */
  dashboardMetrics?: DashboardMetric[]
  budgetCards?: BudgetCard[]
  statusItems?: StatusItem[]
}

const props = defineProps<HeroArsadesProps>()
const runtime = useRuntimeConfig()

const logoFailed = ref(false)
const mockupLogoFailed = ref(false)
const activeFeature = ref<FeatureKey>('surat')
const patternRoot = ref<HTMLElement | null>(null)
const mockupCard = ref<HTMLElement | null>(null)
const floatingPill = ref<HTMLElement | null>(null)

let gsapContext: gsap.Context | null = null

const defaults = {
  eyebrow: 'Digital Village Platform',
  titleStart: 'Digitalisasi ',
  titleHighlight: 'layanan desa',
  titleEnd: ' yang rapi, cepat, dan mudah dipakai.',
  subtitle:
    'ARSADES menyatukan profil desa, berita, layanan surat, aduan warga, potensi lokal, fasilitas, dan organisasi dalam satu portal modern yang ringan untuk warga dan operator desa.',
  floatingBadge: 'ARSADES Ready',
  primaryCta: {
    label: 'Jelajahi Berita',
    href: '/news'
  },
  secondaryCta: {
    label: 'Hubungi Kami',
    href: '#contact'
  },
  newsHref: '/news',
  features: [
    {
      key: 'surat',
      label: 'Surat Online',
      icon: 'lucide:file-check-2',
      title: 'Pengajuan Surat Online',
      description:
        'Warga dapat mengajukan kebutuhan administrasi desa dengan alur yang lebih ringkas dan mudah dipantau.'
    },
    {
      key: 'aduan',
      label: 'Aduan Warga',
      icon: 'lucide:message-square-warning',
      title: 'Aduan Warga Terpantau',
      description:
        'Aduan, masukan, dan laporan warga tersusun dalam dashboard yang lebih transparan untuk ditindaklanjuti.'
    },
    {
      key: 'apbdes',
      label: 'Transparansi',
      icon: 'lucide:landmark',
      title: 'Informasi Desa Terbuka',
      description:
        'Informasi penting desa dapat ditampilkan secara jelas, rapi, dan mudah dipahami oleh masyarakat.'
    },
    {
      key: 'umkm',
      label: 'Potensi',
      icon: 'lucide:store',
      title: 'Potensi Lokal Terkurasi',
      description:
        'Produk UMKM, wisata, dan potensi desa dipresentasikan dengan halaman publik yang lebih menarik.'
    },
    {
      key: 'agenda',
      label: 'Agenda',
      icon: 'lucide:calendar-days',
      title: 'Agenda & Berita Desa',
      description:
        'Kegiatan desa, pengumuman, dan artikel dapat dipublikasikan dengan URL detail yang rapi dan mudah dibagikan.'
    }
  ]
}

const patternPieces = [
  { id: 1, left: '4%', top: '14%', size: '92px', rotate: -18, scale: 1 },
  { id: 2, left: '78%', top: '9%', size: '150px', rotate: 22, scale: 1.1 },
  { id: 3, left: '86%', top: '54%', size: '108px', rotate: -34, scale: 0.9 },
  { id: 4, left: '12%', top: '72%', size: '130px', rotate: 16, scale: 1 },
  { id: 5, left: '48%', top: '7%', size: '74px', rotate: 38, scale: 0.85 },
  { id: 6, left: '58%', top: '76%', size: '92px', rotate: -8, scale: 0.95 }
]

const c = computed(() => ({
  eyebrow: props.eyebrow || defaults.eyebrow,
  titleStart: props.titleStart || defaults.titleStart,
  titleHighlight: props.titleHighlight || defaults.titleHighlight,
  titleEnd: props.titleEnd || defaults.titleEnd,
  subtitle: props.subtitle || defaults.subtitle,
  floatingBadge: props.floatingBadge || defaults.floatingBadge,
  primaryCta: {
    ...defaults.primaryCta,
    ...(props.primaryCta || {})
  },
  secondaryCta: {
    ...defaults.secondaryCta,
    ...(props.secondaryCta || {})
  },
  newsHref: props.newsHref || defaults.newsHref,
  features: props.features?.length ? props.features : defaults.features
}))

const brandName = computed(() => {
  return props.brandName || String(runtime.public.appName || runtime.public.siteName || 'ARSADES')
})

const resolvedLogoUrl = computed(() => {
  return '/assets/logo.png'
})

const normalizedPrimaryHref = computed(() => normalizeNewsHref(c.value.primaryCta.href))
const normalizedSecondaryHref = computed(() => normalizeNewsHref(c.value.secondaryCta.href))
const normalizedNewsHref = computed(() => normalizeNewsHref(c.value.newsHref))

const activeFeatureData = computed(() => {
  return c.value.features.find((item) => item.key === activeFeature.value) || c.value.features[0]
})

const compactCards = computed(() => {
  return c.value.features
    .filter((item) => item.key !== activeFeature.value)
    .slice(0, 4)
    .map((item) => ({
      label: item.label,
      icon: item.icon,
      description: item.title
    }))
})

onMounted(() => {
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  if (reduceMotion) return

  gsapContext = gsap.context(() => {
    const pieces = patternRoot.value?.querySelectorAll('.arsades-pattern-piece') || []

    gsap.fromTo(
      mockupCard.value,
      { y: 18, opacity: 0, rotate: -1.5 },
      { y: 0, opacity: 1, rotate: 0, duration: 0.9, ease: 'power3.out', delay: 0.15 }
    )

    gsap.fromTo(
      floatingPill.value,
      { y: 18, opacity: 0, scale: 0.97 },
      { y: 0, opacity: 1, scale: 1, duration: 0.8, ease: 'power3.out', delay: 0.35 }
    )

    gsap.to(pieces, {
      y: (index) => (index % 2 === 0 ? -18 : 18),
      x: (index) => (index % 3 === 0 ? 12 : -10),
      rotate: (index) => (index % 2 === 0 ? '+=8' : '-=8'),
      duration: (index) => 4.5 + index * 0.35,
      repeat: -1,
      yoyo: true,
      ease: 'sine.inOut',
      stagger: 0.12
    })
  })
})

onBeforeUnmount(() => {
  gsapContext?.revert()
})

function normalizeNewsHref(value: string) {
  const href = String(value || '').trim()
  if (!href) return '/news'

  if (isExternalHref(href) || href.startsWith('#')) return href

  if (href.startsWith('/news?detail=')) return href

  if (href.startsWith('/news?news=')) {
    const slug = href.split('/news?news=')[1] || ''
    return `/news?detail=${encodeURIComponent(decodeURIComponent(slug))}`
  }

  if (href.startsWith('/news/')) {
    const slug = href.replace('/news/', '').split('?')[0]
    return slug ? `/news?detail=${encodeURIComponent(slug)}` : '/news'
  }

  return href
}

function isExternalHref(value?: string) {
  return Boolean(value && /^https?:\/\//i.test(value))
}
</script>

<style scoped>
.arsades-pattern-piece {
  border-radius: 31% 42% 34% 38%;
  background:
    linear-gradient(135deg, rgb(37 99 235), rgb(29 78 216) 52%, rgb(2 132 199));
  clip-path: polygon(
    50% 0%,
    92% 24%,
    100% 36%,
    92% 54%,
    62% 72%,
    64% 100%,
    48% 100%,
    10% 78%,
    0% 68%,
    0% 32%,
    10% 22%
  );
  filter: blur(0.2px);
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
