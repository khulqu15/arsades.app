<template>
  <section
    id="warta"
    aria-label="Warta terbaru"
    class="relative isolate overflow-hidden bg-slate-50 py-14 text-slate-950 sm:py-16"
  >
    <div class="pointer-events-none absolute inset-0 -z-10">
      <div class="absolute inset-0 bg-[linear-gradient(to_right,#e2e8f0_1px,transparent_1px),linear-gradient(to_bottom,#e2e8f0_1px,transparent_1px)] bg-size-[42px_42px] opacity-35"></div>
      <div class="absolute -left-36 top-0 h-96 w-96 rounded-full bg-blue-200/45 blur-3xl"></div>
      <div class="absolute -right-32 bottom-0 h-96 w-96 rounded-full bg-sky-200/45 blur-3xl"></div>
      <div class="absolute left-1/2 top-24 h-72 w-72 -translate-x-1/2 rounded-full bg-white/80 blur-3xl"></div>
    </div>

    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="mb-6 rounded-[2rem] border border-slate-200 bg-white/85 p-4 shadow-sm backdrop-blur-xl sm:p-5">
        <div class="flex flex-col gap-5 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-4">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm sm:h-16 sm:w-16">
              <img
                v-if="logoUrl"
                :src="logoUrl"
                :alt="`${clientDisplayName} logo`"
                class="h-10 w-10 object-contain sm:h-12 sm:w-12"
              >
              <ClientOnly v-else>
                <Icon icon="lucide:newspaper" class="h-7 w-7 text-blue-600" />
              </ClientOnly>
            </div>

            <div class="min-w-0">
              <div class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                <ClientOnly>
                  <Icon icon="lucide:sparkles" class="h-3.5 w-3.5" />
                </ClientOnly>
                {{ c.eyebrow }}
              </div>

              <h2 class="mt-3 max-w-3xl text-2xl font-black leading-tight tracking-tight text-slate-950 sm:text-3xl lg:text-4xl">
                {{ c.title }}
              </h2>

              <p class="mt-2 max-w-2xl text-sm font-medium leading-7 text-slate-500 sm:text-base">
                {{ c.subtitle }}
              </p>
            </div>
          </div>

          <NuxtLink
            :to="c.viewAllHref"
            class="inline-flex h-11 shrink-0 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
          >
            {{ c.viewAllLabel }}
            <ClientOnly>
              <Icon icon="lucide:arrow-up-right" class="h-4 w-4" />
            </ClientOnly>
          </NuxtLink>
        </div>
      </div>

      <section v-if="pending" class="grid gap-4 lg:grid-cols-[minmax(0,1fr)_360px]">
        <div class="h-[390px] animate-pulse rounded-[2rem] border border-slate-200 bg-white p-3 shadow-sm">
          <div class="h-full rounded-[1.5rem] bg-slate-100"></div>
        </div>
        <div class="hidden rounded-[2rem] border border-slate-200 bg-white p-3 shadow-sm lg:block">
          <div v-for="item in 4" :key="item" class="mb-3 grid grid-cols-[84px_minmax(0,1fr)] gap-3 rounded-3xl border border-slate-100 p-2 last:mb-0">
            <div class="h-20 animate-pulse rounded-2xl bg-slate-100"></div>
            <div class="py-1">
              <div class="h-3 w-20 animate-pulse rounded-full bg-slate-100"></div>
              <div class="mt-3 h-4 w-full animate-pulse rounded-full bg-slate-100"></div>
              <div class="mt-2 h-3 w-2/3 animate-pulse rounded-full bg-slate-100"></div>
            </div>
          </div>
        </div>
      </section>

      <section v-else-if="errorMessage" class="rounded-[2rem] border border-red-200 bg-red-50 p-6 text-center shadow-sm">
        <div class="mx-auto grid h-12 w-12 place-items-center rounded-2xl bg-white text-red-600 shadow-sm">
          <ClientOnly>
            <Icon icon="lucide:triangle-alert" class="h-6 w-6" />
          </ClientOnly>
        </div>
        <p class="mt-3 text-sm font-bold leading-6 text-red-700">
          {{ errorMessage }}
        </p>
        <button
          type="button"
          class="mt-4 inline-flex h-10 items-center justify-center rounded-2xl bg-red-600 px-4 text-sm font-black text-white transition hover:bg-red-700"
          @click="refresh()"
        >
          Muat Ulang
        </button>
      </section>

      <section v-else-if="!articles.length" class="rounded-[2rem] border border-dashed border-slate-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-blue-50 text-blue-600">
          <ClientOnly>
            <Icon icon="lucide:newspaper" class="h-7 w-7" />
          </ClientOnly>
        </div>
        <h3 class="mt-4 text-base font-black text-slate-950">
          Belum ada warta.
        </h3>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-slate-500">
          Berita terbaru untuk {{ clientDisplayName }} akan tampil otomatis setelah dipublikasikan.
        </p>
      </section>

      <template v-else-if="activeArticle">
        <div class="grid gap-4 lg:grid-cols-[minmax(0,1fr)_360px]">
          <article class="group overflow-hidden rounded-[2rem] border border-slate-200 bg-white p-2 shadow-sm transition hover:-translate-y-0.5 hover:shadow-xl hover:shadow-blue-950/5">
            <NuxtLink :to="activeArticle.href" class="grid min-h-[390px] overflow-hidden rounded-[1.5rem] bg-slate-950 lg:grid-cols-[1.05fr_0.95fr]">
              <div class="relative min-h-[260px] overflow-hidden lg:min-h-[390px]">
                <img
                  :src="activeArticle.image"
                  :alt="activeArticle.title"
                  class="h-full w-full object-cover transition duration-700 group-hover:scale-105"
                  @error="onArticleImageError"
                >
                <div class="absolute inset-0 bg-gradient-to-t from-slate-950/50 via-transparent to-transparent lg:bg-gradient-to-r lg:from-transparent lg:to-slate-950/55"></div>
                <span class="absolute left-4 top-4 rounded-full bg-white/90 px-3 py-1.5 text-xs font-black text-blue-600 shadow-sm backdrop-blur">
                  {{ activeArticle.category }}
                </span>
              </div>

              <div class="flex flex-col justify-between p-5 text-white sm:p-7">
                <div>
                  <div class="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/10 px-3 py-1 text-xs font-bold text-white/80 backdrop-blur">
                    <ClientOnly>
                      <Icon icon="lucide:calendar-days" class="h-3.5 w-3.5 text-blue-200" />
                    </ClientOnly>
                    {{ activeArticle.date }}
                  </div>

                  <h3 class="mt-4 text-2xl font-black leading-tight tracking-tight sm:text-3xl lg:text-4xl">
                    {{ activeArticle.title }}
                  </h3>

                  <p class="mt-4 line-clamp-3 text-sm font-medium leading-7 text-white/72 sm:text-base">
                    {{ activeArticle.excerpt }}
                  </p>
                </div>

                <div class="mt-6 flex flex-wrap items-center gap-3">
                  <span class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-white px-4 text-sm font-black text-slate-950 transition group-hover:bg-blue-50 group-hover:text-blue-700">
                    Baca Selengkapnya
                    <ClientOnly>
                      <Icon icon="lucide:arrow-up-right" class="h-4 w-4" />
                    </ClientOnly>
                  </span>

                  <span class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-white/15 bg-white/10 px-4 text-sm font-bold text-white/85 backdrop-blur">
                    {{ readTimeLabel(activeArticle.readTime) }}
                  </span>
                </div>
              </div>
            </NuxtLink>
          </article>

          <aside v-if="sideArticles.length" class="rounded-[2rem] border border-slate-200 bg-white/90 p-3 shadow-sm backdrop-blur-xl">
            <div class="flex items-center justify-between px-2 py-2">
              <div>
                <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                  Pilihan Lain
                </p>
                <h3 class="mt-1 text-base font-black text-slate-950">
                  Berita Terkini
                </h3>
              </div>
              <ClientOnly>
                <Icon icon="lucide:trending-up" class="h-5 w-5 text-blue-600" />
              </ClientOnly>
            </div>

            <div class="mt-2 space-y-2">
              <button
                v-for="item in sideArticles"
                :key="item.id"
                type="button"
                class="group grid w-full grid-cols-[78px_minmax(0,1fr)] gap-3 rounded-3xl border p-2 text-left transition hover:-translate-y-0.5"
                :class="activeArticle.id === item.id ? 'border-blue-200 bg-blue-50' : 'border-slate-100 bg-white hover:border-blue-200 hover:bg-blue-50/60'"
                @click="setArticleById(item.id)"
              >
                <div class="h-20 overflow-hidden rounded-2xl bg-slate-100">
                  <img
                    :src="item.image"
                    :alt="item.title"
                    class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                    @error="onArticleImageError"
                  >
                </div>
                <div class="min-w-0 py-1">
                  <div class="flex min-w-0 items-center gap-2">
                    <span class="truncate rounded-full bg-slate-100 px-2 py-0.5 text-[10px] font-black text-blue-600">
                      {{ item.category }}
                    </span>
                    <span class="shrink-0 text-[10px] font-bold text-slate-400">
                      {{ item.date }}
                    </span>
                  </div>
                  <h4 class="mt-2 line-clamp-2 text-sm font-black leading-5 text-slate-950 group-hover:text-blue-700">
                    {{ item.title }}
                  </h4>
                  <p class="mt-1 line-clamp-1 text-xs font-medium text-slate-500">
                    {{ item.excerpt }}
                  </p>
                </div>
              </button>
            </div>
          </aside>
        </div>

        <section v-if="latestArticles.length" class="mt-6">
          <div class="mb-3 flex items-center justify-between gap-4">
            <div>
              <h3 class="text-lg font-black text-slate-950">
                Warta Lainnya
              </h3>
              <p class="mt-1 text-sm font-medium text-slate-500">
                Ringkas, mudah dipindai, dan langsung menuju detail berita.
              </p>
            </div>
          </div>

          <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <NuxtLink
              v-for="item in latestArticles"
              :key="`latest-${item.id}`"
              :to="item.href"
              class="group overflow-hidden rounded-[1.65rem] border border-slate-200 bg-white p-2 shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-950/5"
            >
              <div class="relative h-36 overflow-hidden rounded-[1.2rem] bg-slate-100">
                <img
                  :src="item.image"
                  :alt="item.title"
                  class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                  @error="onArticleImageError"
                >
                <span class="absolute left-3 top-3 rounded-full bg-white/90 px-2.5 py-1 text-[10px] font-black text-blue-600 shadow-sm backdrop-blur">
                  {{ item.category }}
                </span>
              </div>
              <div class="p-3">
                <p class="text-xs font-bold text-slate-400">
                  {{ item.date }}
                </p>
                <h4 class="mt-2 line-clamp-2 text-sm font-black leading-5 text-slate-950 transition group-hover:text-blue-700">
                  {{ item.title }}
                </h4>
                <div class="mt-3 flex items-center justify-between text-xs font-black text-blue-600">
                  <span>Baca Berita</span>
                  <ClientOnly>
                    <Icon icon="lucide:arrow-up-right" class="h-4 w-4" />
                  </ClientOnly>
                </div>
              </div>
            </NuxtLink>
          </div>
        </section>
      </template>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import { Icon } from '@iconify/vue'
import { useFetch, useRuntimeConfig } from 'nuxt/app'
import { useAppApi } from '~/composables/useAppApi'

type NewsStatus = 'draft' | 'published' | 'archived'

type NewsItem = {
  id: number | string
  tenantId?: number | string
  title: string
  slug: string
  descriptionCard?: string | null
  descriptionContent?: string | null
  excerpt?: string | null
  cover?: string | null
  coverUrl?: string | null
  imageUrl?: string | null
  category?: string | null
  categorySlug?: string | null
  categoryId?: number | string | null
  tags?: string[]
  tagSlugs?: string[]
  status: NewsStatus
  readTime?: number | null
  publishedAt?: number | string | null
  createdAt?: number | string | null
  updatedAt?: number | string | null
}

type NewsListResponse = {
  data: NewsItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type BlogArticle = {
  id: string
  title: string
  excerpt: string
  image: string
  category: string
  date: string
  href: string
  slug?: string
  readTime?: number | null
}

type BlogHeroProps = {
  eyebrow?: string
  title?: string
  subtitle?: string
  viewAllLabel?: string
  viewAllHref?: string
  articles?: BlogArticle[]
  latest?: BlogArticle[]
}

const props = defineProps<BlogHeroProps>()

const runtime = useRuntimeConfig()
const publicRuntime = computed(() => runtime.public as Record<string, unknown>)
const fallbackImage = '/assets/images/profile.png'

const tenantSlug = computed(() => {
  return String(publicRuntime.value.clientName || 'martopuro')
    .trim()
    .toLowerCase()
})

const clientDisplayName = computed(() => {
  return String(
    publicRuntime.value.clientDisplayName ||
    publicRuntime.value.appName ||
    publicRuntime.value.siteName ||
    tenantSlug.value ||
    'Martopuro'
  )
})

const logoUrl = computed(() => {
  return String(
    publicRuntime.value.appLogo ||
    publicRuntime.value.logoUrl ||
    publicRuntime.value.clientLogo ||
    publicRuntime.value.siteLogo ||
    publicRuntime.value.faviconUrl ||
    ''
  ).trim()
})

const { tenantApiUrl } = useAppApi()

const newsApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/news'))

const {
  data: newsResponse,
  pending,
  error,
  refresh
} = useFetch<NewsListResponse>(newsApiUrl, {
  key: computed(() => `tenant-news-hero-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'published',
    limit: 12,
    sort: 'newest'
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

const activeIndex = ref(0)

const c = computed(() => ({
  eyebrow: props.eyebrow || `Warta ${clientDisplayName.value}`,
  title: props.title || 'Kabar Terbaru Desa dalam Satu Tampilan Ringkas',
  subtitle:
    props.subtitle ||
    `Ikuti informasi terbaru dari ${clientDisplayName.value}, mulai dari pelayanan publik, kegiatan warga, UMKM, pendidikan, hingga agenda desa.`,
  viewAllLabel: props.viewAllLabel || 'Lihat Semua Berita',
  viewAllHref: normalizeNewsListHref(props.viewAllHref || '/news')
}))

const errorMessage = computed(() => {
  if (!error.value) return ''

  const err = error.value as {
    statusMessage?: string
    message?: string
  }

  return err.statusMessage || err.message || 'Gagal mengambil data warta dari server.'
})

const newsItems = computed(() => newsResponse.value?.data || [])

const articlesFromApi = computed<BlogArticle[]>(() => {
  return newsItems.value.map((item) => mapNewsToArticle(item))
})

const articles = computed<BlogArticle[]>(() => {
  const source = props.articles?.length ? props.articles : articlesFromApi.value
  return dedupeArticles(source.map((item) => normalizeArticle(item))).slice(0, 8)
})

const activeArticle = computed(() => {
  return articles.value[activeIndex.value] || articles.value[0] || null
})

const activeArticleId = computed(() => activeArticle.value?.id || '')

const sideArticles = computed(() => {
  return articles.value
    .filter((item) => item.id !== activeArticleId.value)
    .slice(0, 4)
})

const latestSource = computed<BlogArticle[]>(() => {
  const source = props.latest?.length ? props.latest : articles.value
  return dedupeArticles(source.map((item) => normalizeArticle(item)))
})

const latestArticles = computed<BlogArticle[]>(() => {
  const usedIds = new Set<string>()

  if (activeArticleId.value) usedIds.add(activeArticleId.value)

  for (const item of sideArticles.value) {
    usedIds.add(item.id)
  }

  return latestSource.value
    .filter((item) => !usedIds.has(item.id))
    .slice(0, 4)
})

watch(articles, (items) => {
  if (!items.length) {
    activeIndex.value = 0
    return
  }

  if (activeIndex.value > items.length - 1) {
    activeIndex.value = 0
  }
})

function mapNewsToArticle(item: NewsItem): BlogArticle {
  const slug = String(item.slug || item.id || '').trim()

  return {
    id: String(item.id || slug),
    title: item.title || 'Tanpa Judul',
    excerpt: item.excerpt || item.descriptionCard || plainText(item.descriptionContent || '').slice(0, 150) || 'Belum ada deskripsi.',
    image: String(item.cover || item.coverUrl || item.imageUrl || fallbackImage),
    category: item.category || 'Umum',
    date: formatDate(item.publishedAt || item.createdAt),
    href: buildNewsDetailHref(slug),
    slug,
    readTime: item.readTime || null
  }
}

function normalizeArticle(item: BlogArticle): BlogArticle {
  const slug = item.slug || extractSlugFromHref(item.href) || item.id

  return {
    ...item,
    id: String(item.id || slug || item.title),
    slug,
    href: buildNewsDetailHref(slug),
    image: item.image || fallbackImage,
    category: item.category || 'Umum',
    excerpt: item.excerpt || 'Belum ada deskripsi.',
    readTime: item.readTime || null
  }
}

function dedupeArticles(items: BlogArticle[]) {
  const map = new Map<string, BlogArticle>()

  for (const item of items) {
    const key = String(item.slug || item.id || item.href || item.title)
      .trim()
      .toLowerCase()

    if (!key) continue
    if (map.has(key)) continue

    map.set(key, item)
  }

  return Array.from(map.values())
}

function buildNewsDetailHref(slug?: string) {
  const cleanSlug = String(slug || '').trim()

  if (!cleanSlug) return '/news'

  return `/news?detail=${encodeURIComponent(cleanSlug)}`
}

function normalizeNewsListHref(href: string) {
  const cleanHref = String(href || '').trim()

  if (!cleanHref) return '/news'
  if (cleanHref === '/news') return '/news'

  const legacySlug = extractSlugFromHref(cleanHref)

  if (legacySlug) return buildNewsDetailHref(legacySlug)

  return cleanHref
}

function extractSlugFromHref(href?: string) {
  const cleanHref = String(href || '').trim()

  if (!cleanHref) return ''

  if (cleanHref.includes('?')) {
    const query = cleanHref.split('?')[1] || ''
    const params = new URLSearchParams(query)
    return params.get('detail') || params.get('news') || ''
  }

  const match = cleanHref.match(/\/news\/([^/?#]+)/)
  return match?.[1] ? decodeURIComponent(match[1]) : ''
}

function formatDate(value?: number | string | null) {
  if (!value) return '-'

  const date = typeof value === 'number'
    ? new Date(value)
    : new Date(String(value))

  if (Number.isNaN(date.getTime())) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(date)
}

function setArticleById(id: string) {
  const index = articles.value.findIndex((item) => item.id === id)

  if (index >= 0) {
    activeIndex.value = index
  }
}

function readTimeLabel(value?: number | null) {
  const minutes = Number(value || 0)

  if (!minutes) return 'Bacaan singkat'

  return `${minutes} menit baca`
}

function onArticleImageError(event: Event) {
  const target = event.target as HTMLImageElement | null

  if (!target || target.src.endsWith(fallbackImage)) return

  target.src = fallbackImage
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
</script>

<style scoped>
.bg-size-\[42px_42px\] {
  background-size: 42px 42px;
}

.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
