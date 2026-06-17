<template>
  <section
    id="news-hero"
    class="relative isolate overflow-hidden bg-white py-10 text-slate-950 sm:py-12"
    aria-label="Berita terbaru"
  >
    <div class="pointer-events-none absolute inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-28 top-0 h-80 w-80 rounded-full bg-blue-200/45 blur-3xl"></div>
      <div class="absolute right-0 top-20 h-96 w-96 rounded-full bg-sky-200/35 blur-3xl"></div>
      <div class="absolute left-1/2 top-24 h-72 w-72 -translate-x-1/2 rounded-full bg-white/80 blur-3xl"></div>
    </div>

    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="mb-5 flex flex-col gap-4 rounded-[2rem] border border-slate-200 bg-white/90 p-4 shadow-sm backdrop-blur-xl sm:p-5 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.16em] text-blue-600 ring-1 ring-blue-100">
            <Icon icon="solar:news-bold-duotone" class="h-4 w-4" />
            Berita Desa
          </span>

          <h2 class="mt-3 text-2xl font-black leading-tight tracking-tight text-slate-950 sm:text-3xl lg:text-4xl">
            Kabar Terbaru {{ tenantDisplayName }}
          </h2>

          <p class="mt-2 max-w-2xl text-sm font-semibold leading-7 text-slate-500 sm:text-base">
            Informasi terbaru seputar pelayanan, kegiatan, pengumuman, dan perkembangan desa dalam satu tampilan ringkas.
          </p>
        </div>

        <NuxtLink
          :to="newsListHref"
          class="inline-flex h-11 shrink-0 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
        >
          Lihat Semua Berita
          <Icon icon="solar:arrow-right-up-bold-duotone" class="h-5 w-5" />
        </NuxtLink>
      </div>

      <!-- Category tabs -->
      <div class="mb-5 overflow-x-auto rounded-[1.5rem] border border-slate-200 bg-white/90 px-3 pt-3 shadow-sm backdrop-blur-xl">
        <div class="inline-flex min-w-max items-center gap-2 text-sm font-bold text-slate-500">
          <button
            v-for="tab in categoryTabs"
            :key="tab.value"
            type="button"
            class="relative inline-flex items-center gap-2 rounded-t-2xl px-3 pb-3 pt-2 transition"
            :class="activeCategory === tab.value
              ? 'bg-blue-50 text-blue-700'
              : 'hover:bg-blue-50/70 hover:text-blue-600'"
            @click="setActiveCategory(tab.value)"
          >
            <span>{{ tab.label }}</span>

            <span
              class="grid h-5 min-w-5 place-items-center rounded-full px-1.5 text-[10px] font-black"
              :class="activeCategory === tab.value
                ? 'bg-blue-600 text-white'
                : 'bg-slate-100 text-slate-500'"
            >
              {{ tab.count }}
            </span>

            <span
              v-if="activeCategory === tab.value"
              class="absolute inset-x-2 -bottom-px h-0.5 rounded-full bg-blue-600"
            ></span>
          </button>
        </div>
      </div>

      <!-- Loading -->
      <div
        v-if="isLoading"
        class="grid gap-5 lg:grid-cols-[minmax(0,1fr)_390px]"
      >
        <div class="overflow-hidden rounded-[2rem] border border-slate-200 bg-white p-3 shadow-sm">
          <div class="h-[470px] animate-pulse rounded-[1.6rem] bg-slate-100"></div>
          <div class="mt-4 h-5 w-64 animate-pulse rounded-full bg-slate-100"></div>
          <div class="mt-3 h-8 w-4/5 animate-pulse rounded-full bg-slate-100"></div>
          <div class="mt-3 h-4 w-full animate-pulse rounded-full bg-slate-100"></div>
          <div class="mt-2 h-4 w-2/3 animate-pulse rounded-full bg-slate-100"></div>
        </div>

        <div class="space-y-4">
          <div
            v-for="item in 3"
            :key="item"
            class="grid grid-cols-[118px_minmax(0,1fr)] gap-3 rounded-[1.7rem] border border-slate-200 bg-white p-3 shadow-sm"
          >
            <div class="h-24 animate-pulse rounded-2xl bg-slate-100"></div>
            <div class="py-1">
              <div class="h-4 w-24 animate-pulse rounded-full bg-slate-100"></div>
              <div class="mt-3 h-4 w-full animate-pulse rounded-full bg-slate-100"></div>
              <div class="mt-2 h-4 w-4/5 animate-pulse rounded-full bg-slate-100"></div>
              <div class="mt-4 h-3 w-2/3 animate-pulse rounded-full bg-slate-100"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Error -->
      <div
        v-else-if="errorMessage"
        class="rounded-[2rem] border border-red-200 bg-red-50 p-6 text-center shadow-sm"
      >
        <div class="mx-auto grid h-12 w-12 place-items-center rounded-2xl bg-white text-red-600 shadow-sm">
          <Icon icon="solar:danger-circle-bold-duotone" class="h-6 w-6" />
        </div>
        <p class="mt-3 text-sm font-bold leading-6 text-red-700">
          {{ errorMessage }}
        </p>
        <button
          type="button"
          class="mt-4 inline-flex h-10 items-center justify-center rounded-2xl bg-red-600 px-4 text-sm font-black text-white transition hover:bg-red-700"
          @click="refresh"
        >
          Muat ulang
        </button>
      </div>

      <!-- Empty -->
      <div
        v-else-if="!filteredArticles.length"
        class="rounded-[2rem] border border-dashed border-slate-300 bg-white p-8 text-center shadow-sm"
      >
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-blue-50 text-blue-600">
          <Icon icon="solar:news-bold-duotone" class="h-7 w-7" />
        </div>
        <h3 class="mt-4 text-base font-black text-slate-950">
          Belum ada berita
        </h3>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-slate-500">
          Berita dari {{ tenantDisplayName }} akan tampil otomatis setelah dipublikasikan.
        </p>
      </div>

      <!-- Content -->
      <template v-else-if="heroArticle">
        <div class="grid gap-5 lg:grid-cols-[minmax(0,1fr)_390px]">
          <!-- Left hero -->
          <article class="rounded-[2rem] border border-slate-200 bg-white p-6 shadow-sm transition hover:-translate-y-0.5 hover:shadow-xl hover:shadow-blue-950/5">
            <NuxtLink
              :to="heroArticle.href"
              class="group block"
            >
              <div class="relative overflow-hidden rounded-[1.6rem] bg-slate-100">
                <img
                  :src="heroArticle.image"
                  :alt="heroArticle.title"
                  class="h-[300px] w-full object-cover transition duration-700 group-hover:scale-[1.03] sm:h-[360px] lg:h-[430px]"
                  @error="onArticleImageError"
                >
                <div class="absolute inset-0 bg-gradient-to-t from-slate-950/40 via-transparent to-transparent"></div>
                <span class="absolute left-4 top-4 rounded-full bg-white/90 px-3 py-1.5 text-xs font-black text-blue-600 shadow-sm backdrop-blur">
                  {{ heroArticle.category }}
                </span>
              </div>

              <div class="mt-4 flex flex-wrap items-center gap-3 text-sm">
                <div class="inline-flex items-center gap-2 text-slate-700">
                  <div class="grid h-7 w-7 place-items-center rounded-full bg-blue-100 text-blue-600">
                    <Icon icon="solar:user-rounded-bold-duotone" class="h-4 w-4" />
                  </div>
                  <span class="font-semibold">{{ heroArticle.author }}</span>
                </div>

                <span class="text-slate-300">|</span>

                <span class="font-semibold text-blue-600">
                  {{ heroArticle.category }}
                </span>

                <span class="text-slate-300">|</span>

                <span class="font-medium text-slate-500">
                  {{ heroArticle.timeLabel }}
                </span>
              </div>

              <h2 class="mt-4 max-w-4xl text-3xl font-black leading-tight tracking-tight text-slate-950 sm:text-4xl">
                {{ heroArticle.title }}
              </h2>

              <p class="mt-4 max-w-3xl text-sm leading-7 text-slate-600 sm:text-[15px]">
                {{ heroArticle.excerpt }}
              </p>

              <div class="mt-4 inline-flex items-center gap-2 text-sm font-black text-blue-600 transition group-hover:gap-3">
                Baca selengkapnya
                <Icon icon="solar:arrow-right-up-bold-duotone" class="h-4 w-4" />
              </div>
            </NuxtLink>
          </article>

          <!-- Right column -->
          <aside class="space-y-4">
            <div class="rounded-[2rem] border border-slate-200 bg-white p-3 shadow-sm">
              <div class="flex items-center justify-between px-2 pb-3 pt-2">
                <div>
                  <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                    Pilihan Lain
                  </p>
                  <h3 class="mt-1 text-lg font-black text-slate-950">
                    Berita Terkini
                  </h3>
                </div>

                <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                  <Icon icon="solar:trending-up-bold-duotone" class="h-5 w-5" />
                </div>
              </div>

              <div class="space-y-3">
                <button
                  v-for="item in sideArticles"
                  :key="item.id"
                  type="button"
                  class="group grid w-full grid-cols-[118px_minmax(0,1fr)] gap-3 rounded-[1.5rem] border border-slate-100 p-2 text-left transition hover:border-blue-200 hover:bg-blue-50/40"
                  @click="setHeroArticle(item.id)"
                >
                  <div class="overflow-hidden rounded-2xl bg-slate-100">
                    <img
                      :src="item.image"
                      :alt="item.title"
                      class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                      @error="onArticleImageError"
                    >
                  </div>

                  <div class="min-w-0 py-1">
                    <h3 class="line-clamp-3 text-[15px] font-black leading-6 text-slate-950 group-hover:text-blue-700">
                      {{ item.title }}
                    </h3>

                    <div class="mt-3 flex flex-wrap items-center gap-2 text-[11px]">
                      <span class="inline-flex items-center gap-1 text-slate-600">
                        <span class="h-1.5 w-1.5 rounded-full bg-blue-600"></span>
                        {{ item.author }}
                      </span>

                      <span class="text-slate-300">|</span>

                      <span class="font-semibold text-blue-600">
                        {{ item.category }}
                      </span>
                    </div>
                  </div>
                </button>
              </div>
            </div>

            <div class="rounded-[2rem] border border-slate-200 bg-white p-4 shadow-sm">
              <div class="flex items-center justify-between gap-3">
                <div>
                  <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                    Statistik Berita
                  </p>
                  <h3 class="mt-1 text-2xl font-black text-slate-950">
                    News counts
                  </h3>
                </div>

                <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                  <Icon icon="solar:chart-square-bold-duotone" class="h-6 w-6" />
                </div>
              </div>

              <div class="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-1 xl:grid-cols-2">
                <div class="rounded-[1.4rem] border border-blue-100 bg-blue-50 p-4">
                  <p class="text-xs font-bold uppercase tracking-[0.14em] text-blue-600">
                    Total Berita
                  </p>
                  <div class="mt-2 flex items-end gap-2">
                    <span class="text-3xl font-black leading-none text-slate-950">
                      {{ animatedTotalCount }}
                    </span>
                    <span class="pb-1 text-xs font-semibold text-slate-500">
                      artikel
                    </span>
                  </div>
                  <p class="mt-2 text-xs font-medium leading-5 text-slate-600">
                    Semua berita aktif dari {{ tenantDisplayName }}.
                  </p>
                </div>

                <div class="rounded-[1.4rem] border border-slate-200 bg-slate-50 p-4">
                  <p class="text-xs font-bold uppercase tracking-[0.14em] text-blue-600">
                    Kategori Aktif
                  </p>
                  <div class="mt-2 flex items-end gap-2">
                    <span class="text-3xl font-black leading-none text-slate-950">
                      {{ animatedCategoryCount }}
                    </span>
                    <span class="pb-1 text-xs font-semibold text-slate-500">
                      kategori
                    </span>
                  </div>
                  <p class="mt-2 text-xs font-medium leading-5 text-slate-600">
                    Kategori berita yang sedang terisi saat ini.
                  </p>
                </div>
              </div>
            </div>
          </aside>
        </div>

        <!-- Horizontal news -->
        <section
          v-if="horizontalArticles.length"
          class="mt-6 rounded-[2rem] border border-slate-200 bg-white/90 p-4 shadow-sm backdrop-blur-xl"
        >
          <div class="mb-4 flex items-center justify-between gap-4">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                Berita Lainnya
              </p>
              <h3 class="mt-1 text-xl font-black text-slate-950">
                8 News Lain
              </h3>
            </div>

            <NuxtLink
              :to="newsListHref"
              class="hidden h-10 shrink-0 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-4 text-sm font-black text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 sm:inline-flex"
            >
              Lihat Semua
              <Icon icon="solar:arrow-right-up-bold-duotone" class="h-4 w-4" />
            </NuxtLink>
          </div>

          <div class="scrollbar-hide -mx-1 flex snap-x gap-4 overflow-x-auto px-1 pb-2">
            <NuxtLink
              v-for="item in horizontalArticles"
              :key="`horizontal-${item.id}`"
              :to="item.href"
              class="group w-[265px] shrink-0 snap-start overflow-hidden rounded-[1.6rem] border border-slate-200 bg-white p-2 shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-950/5 sm:w-[290px]"
            >
              <div class="relative h-40 overflow-hidden rounded-[1.2rem] bg-slate-100">
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
                <div class="flex items-center gap-2 text-[11px] font-semibold text-slate-500">
                  <Icon icon="solar:user-rounded-bold-duotone" class="h-4 w-4 text-blue-600" />
                  <span class="truncate">{{ item.author }}</span>
                </div>

                <h4 class="mt-2 line-clamp-2 text-base font-black leading-6 text-slate-950 transition group-hover:text-blue-700">
                  {{ item.title }}
                </h4>

                <p class="mt-2 line-clamp-2 text-xs font-medium leading-5 text-slate-500">
                  {{ item.excerpt }}
                </p>

                <div class="mt-3 flex items-center justify-between text-xs font-black text-blue-600">
                  <span>{{ item.timeLabel }}</span>
                  <Icon icon="solar:arrow-right-up-bold-duotone" class="h-4 w-4" />
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
import { Icon } from '@iconify/vue'
import { computed, onMounted, ref, watch } from 'vue'
import { useRuntimeConfig, useFetch } from '#imports'
import { useAppApi } from '~/composables/useAppApi'

type RawNews = Record<string, any>

type NewsItem = {
  id: string
  title: string
  slug: string
  excerpt: string
  image: string
  category: string
  publishedAt: string
  timeLabel: string
  href: string
  author: string
}

const props = withDefaults(defineProps<{
  tenantSlug?: string
  tenantName?: string
  logoUrl?: string
  viewAllHref?: string
  detailQueryKey?: string
  fallbackImage?: string
}>(), {
  tenantSlug: '',
  tenantName: '',
  logoUrl: '',
  viewAllHref: '/news',
  detailQueryKey: 'detail',
  fallbackImage: '/assets/images/profile.png'
})

const runtime = useRuntimeConfig()
const publicRuntime = computed(() => runtime.public as Record<string, unknown>)
const { tenantApiUrl } = useAppApi()

const ALL_CATEGORY_VALUE = '__all__'
const activeCategory = ref(ALL_CATEGORY_VALUE)
const heroArticleId = ref('')
const animatedTotalCount = ref(0)
const animatedCategoryCount = ref(0)

const resolvedTenantSlug = computed(() => {
  const fromProps = String(props.tenantSlug || '').trim().toLowerCase()
  if (fromProps) return fromProps

  return String(publicRuntime.value.clientName || 'martopuro')
    .trim()
    .toLowerCase()
})

const tenantDisplayName = computed(() => {
  if (props.tenantName?.trim()) return props.tenantName.trim()

  return String(
    publicRuntime.value.clientDisplayName ||
      publicRuntime.value.appName ||
      publicRuntime.value.siteName ||
      resolvedTenantSlug.value ||
      'Martopuro'
  )
})

const authorLabel = computed(() => `Admin Desa ${tenantDisplayName.value}`)
const newsListHref = computed(() => normalizeHref(props.viewAllHref || '/news'))
const newsApiUrl = computed(() => tenantApiUrl(resolvedTenantSlug.value, '/news'))

const buildNonce = Date.now()

const {
  data: newsResponse,
  pending,
  error,
  refresh
} = await useFetch(newsApiUrl, {
  key: computed(() => `news-hero-${resolvedTenantSlug.value}-${buildNonce}`),
  server: true,
  immediate: true,
  query: computed(() => ({
    status: 'published',
    limit: 24,
    sort: 'newest',
    _t: buildNonce
  })),
  watch: [resolvedTenantSlug],
  default: () => ({
    data: []
  })
})

watch(resolvedTenantSlug, () => {
  activeCategory.value = ALL_CATEGORY_VALUE
  heroArticleId.value = ''
})

const isLoading = computed(() => Boolean(pending.value))

const rawNewsItems = computed<RawNews[]>(() => {
  return extractNewsArray(newsResponse.value)
})

const allArticles = computed<NewsItem[]>(() => {
  return rawNewsItems.value
    .map((item) => mapArticle(item))
    .filter((item) => item.title && item.slug)
})

const categoryTabs = computed(() => {
  const counter = new Map<string, number>()

  for (const item of allArticles.value) {
    const category = normalizeCategoryLabel(item.category)
    counter.set(category, (counter.get(category) || 0) + 1)
  }

  const tabs = Array.from(counter.entries())
    .sort((a, b) => {
      if (b[1] !== a[1]) return b[1] - a[1]
      return a[0].localeCompare(b[0])
    })
    .map(([label, count]) => ({
      label,
      value: normalizeCategoryValue(label),
      count
    }))

  return [
    {
      label: 'Semua',
      value: ALL_CATEGORY_VALUE,
      count: allArticles.value.length
    },
    ...tabs
  ]
})

const filteredArticles = computed<NewsItem[]>(() => {
  if (activeCategory.value === ALL_CATEGORY_VALUE) {
    return allArticles.value
  }

  return allArticles.value.filter((item) => {
    return normalizeCategoryValue(item.category) === activeCategory.value
  })
})

const heroArticle = computed(() => {
  if (!filteredArticles.value.length) return null

  const found = filteredArticles.value.find((item) => item.id === heroArticleId.value)
  return found || filteredArticles.value[0]
})

const sideArticles = computed(() => {
  return filteredArticles.value
    .filter((item) => item.id !== heroArticle.value?.id)
    .slice(0, 2)
})

const horizontalArticles = computed(() => {
  const usedIds = new Set<string>()

  if (heroArticle.value?.id) usedIds.add(heroArticle.value.id)

  for (const item of sideArticles.value) {
    usedIds.add(item.id)
  }

  const preferred = filteredArticles.value.filter((item) => !usedIds.has(item.id))
  const fallback = allArticles.value.filter((item) => !usedIds.has(item.id))

  return dedupeArticles([...preferred, ...fallback]).slice(0, 8)
})

const categoriesCount = computed(() => {
  return new Set(
    allArticles.value
      .map((item) => normalizeCategoryValue(item.category))
      .filter(Boolean)
  ).size
})

const errorMessage = computed(() => {
  if (!error.value) return ''

  const payload = error.value as {
    statusMessage?: string
    message?: string
  }

  return payload.statusMessage || payload.message || 'Berita belum bisa dimuat saat ini. Silakan coba lagi.'
})

watch(
  filteredArticles,
  (items) => {
    if (!items.length) {
      heroArticleId.value = ''
      animateCounter(animatedTotalCount, 0)
      animateCounter(animatedCategoryCount, categoriesCount.value)
      return
    }

    const heroStillExists = items.some((item) => item.id === heroArticleId.value)

    if (!heroStillExists) {
      heroArticleId.value = items[0].id
    }

    animateCounter(animatedTotalCount, items.length)
    animateCounter(animatedCategoryCount, categoriesCount.value)
  },
  { immediate: true }
)

watch(
  allArticles,
  () => {
    const categoryStillExists = categoryTabs.value.some((tab) => tab.value === activeCategory.value)

    if (!categoryStillExists) {
      activeCategory.value = ALL_CATEGORY_VALUE
    }
  },
  { immediate: true }
)

function setActiveCategory(value: string) {
  activeCategory.value = value
}

function setHeroArticle(id: string) {
  heroArticleId.value = id
}

function extractNewsArray(value: any): RawNews[] {
  if (Array.isArray(value)) return value

  if (Array.isArray(value?.data)) return value.data
  if (Array.isArray(value?.items)) return value.items
  if (Array.isArray(value?.results)) return value.results
  if (Array.isArray(value?.news)) return value.news

  if (Array.isArray(value?.data?.data)) return value.data.data
  if (Array.isArray(value?.data?.items)) return value.data.items
  if (Array.isArray(value?.data?.results)) return value.data.results
  if (Array.isArray(value?.data?.news)) return value.data.news

  if (Array.isArray(value?.payload)) return value.payload
  if (Array.isArray(value?.payload?.data)) return value.payload.data
  if (Array.isArray(value?.response?.data)) return value.response.data

  return []
}

function mapArticle(item: RawNews): NewsItem {
  const title = cleanString(item.title || item.name, 'Tanpa Judul')
  const slug = cleanString(item.slug || item.code || item.id || makeSlug(title), makeSlug(title))
  const id = cleanString(item.id || item.uuid || item._id || slug || cryptoRandomId(), cryptoRandomId())
  const excerpt = cleanExcerpt(
    item.excerpt ||
      item.summary ||
      item.description ||
      item.descriptionCard ||
      item.description_card ||
      item.content ||
      item.descriptionContent ||
      item.description_content ||
      'Berita terbaru desa tersedia untuk dibaca lebih lanjut.'
  )
  const image = extractImage(item) || props.fallbackImage
  const category = extractCategory(item)
  const publishedAt = cleanString(
    item.publishedAt ||
      item.published_at ||
      item.createdAt ||
      item.created_at ||
      item.updatedAt ||
      item.updated_at ||
      new Date().toISOString()
  )

  return {
    id,
    title,
    slug,
    excerpt,
    image,
    category,
    publishedAt,
    timeLabel: formatTimeLabel(publishedAt),
    href: buildDetailHref(slug),
    author: authorLabel.value
  }
}

function extractImage(item: RawNews) {
  const candidates = [
    item.cover,
    item.coverUrl,
    item.cover_url,
    item.coverImage,
    item.cover_image,
    item.image,
    item.imageUrl,
    item.image_url,
    item.thumbnail,
    item.thumbnailUrl,
    item.thumbnail_url,
    item.featuredImage,
    item.featured_image,
    item.media?.url,
    item.media?.secure_url,
    item.media?.secureUrl,
    item.media?.path,
    item.image?.url,
    item.image?.secure_url,
    item.image?.secureUrl,
    item.cover?.url,
    item.cover?.secure_url,
    item.cover?.secureUrl,
    item.files?.[0]?.url,
    item.files?.[0]?.secure_url,
    item.files?.[0]?.secureUrl,
    item.attachments?.[0]?.url,
    item.attachments?.[0]?.secure_url,
    item.attachments?.[0]?.secureUrl
  ]

  for (const candidate of candidates) {
    const image = cleanString(candidate)
    if (image) return image
  }

  return ''
}

function extractCategory(item: RawNews) {
  if (typeof item.category === 'string' && item.category.trim()) {
    return item.category.trim()
  }

  if (typeof item.category?.name === 'string' && item.category.name.trim()) {
    return item.category.name.trim()
  }

  if (typeof item.category?.title === 'string' && item.category.title.trim()) {
    return item.category.title.trim()
  }

  if (typeof item.categoryName === 'string' && item.categoryName.trim()) {
    return item.categoryName.trim()
  }

  if (typeof item.category_name === 'string' && item.category_name.trim()) {
    return item.category_name.trim()
  }

  if (Array.isArray(item.categories) && item.categories.length) {
    const first = item.categories[0]

    if (typeof first === 'string') return first
    if (typeof first?.name === 'string') return first.name
    if (typeof first?.title === 'string') return first.title
  }

  return 'Berita Desa'
}

function buildDetailHref(slug: string) {
  const cleanSlug = String(slug || '').trim()
  const baseHref = normalizeHref(props.viewAllHref || '/news')

  if (!cleanSlug) return baseHref

  return `${baseHref}?${encodeURIComponent(props.detailQueryKey)}=${encodeURIComponent(cleanSlug)}`
}

function normalizeHref(value: string) {
  const href = String(value || '').trim()

  if (!href) return '/news'

  return href.startsWith('/') ? href : `/${href}`
}

function cleanString(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function cleanExcerpt(value: unknown) {
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
    .slice(0, 190)
}

function makeSlug(value: string) {
  return String(value || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '') || cryptoRandomId()
}

function formatTimeLabel(value: string) {
  const date = new Date(value)

  if (Number.isNaN(date.getTime())) {
    return 'Hari ini'
  }

  const now = new Date()
  const diff = now.getTime() - date.getTime()
  const oneDay = 1000 * 60 * 60 * 24

  if (diff >= 0 && diff < oneDay) {
    return date.toLocaleTimeString('id-ID', {
      hour: '2-digit',
      minute: '2-digit'
    })
  }

  return date.toLocaleDateString('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  })
}

function onArticleImageError(event: Event) {
  const target = event.target as HTMLImageElement | null

  if (!target || target.src.endsWith(props.fallbackImage)) return

  target.src = props.fallbackImage
}

function animateCounter(target: { value: number }, endValue: number, duration = 900) {
  const safeEndValue = Math.max(0, Number(endValue || 0))

  if (typeof window === 'undefined' || typeof window.requestAnimationFrame !== 'function') {
    target.value = safeEndValue
    return
  }

  const startValue = Number(target.value || 0)
  const startTime = window.performance.now()

  function step(now: number) {
    const progress = Math.min((now - startTime) / duration, 1)
    const eased = 1 - Math.pow(1 - progress, 3)

    target.value = Math.round(startValue + (safeEndValue - startValue) * eased)

    if (progress < 1) {
      window.requestAnimationFrame(step)
    }
  }

  window.requestAnimationFrame(step)
}

function dedupeArticles(items: NewsItem[]) {
  const map = new Map<string, NewsItem>()

  for (const item of items) {
    const key = String(item.slug || item.id || item.title).toLowerCase()
    if (!key || map.has(key)) continue

    map.set(key, item)
  }

  return Array.from(map.values())
}

function normalizeCategoryLabel(value: string) {
  const label = String(value || '').trim()

  if (!label) return 'Berita Desa'

  return label
}

function normalizeCategoryValue(value: string) {
  return normalizeCategoryLabel(value)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function cryptoRandomId() {
  return Math.random().toString(36).slice(2, 11)
}

onMounted(() => {
  refresh()
})
</script>

<style scoped>
.bg-size-\[38px_38px\] {
  background-size: 38px 38px;
}

.scrollbar-hide {
  scrollbar-width: none;
}

.scrollbar-hide::-webkit-scrollbar {
  display: none;
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
