<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-32 top-0 h-[420px] w-[420px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-32 top-40 h-[420px] w-[420px] rounded-full bg-emerald-100 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <!-- Header -->
    <section class="relative border-b border-neutral-200 bg-white/85 pt-28 backdrop-blur-xl">
      <div class="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <nav class="mb-6 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
          <NuxtLink to="/" class="transition hover:text-neutral-950">
            Beranda
          </NuxtLink>
          <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
          <NuxtLink
            v-if="isDetailMode"
            to="/institutions"
            class="transition hover:text-neutral-950"
          >
            Kelembagaan
          </NuxtLink>
          <span v-else class="text-neutral-950">
            Kelembagaan
          </span>
          <template v-if="isDetailMode">
            <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
            <span class="max-w-[220px] truncate text-neutral-950 sm:max-w-md">
              {{ activeInstitution?.title || detailSlug }}
            </span>
          </template>
        </nav>

        <div v-if="!isDetailMode" class="grid gap-6 lg:grid-cols-[1fr_360px] lg:items-end">
          <div>
            <div class="mb-4 inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
              <Icon icon="solar:buildings-2-bold-duotone" class="h-4 w-4" />
              Kelembagaan Desa
            </div>

            <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
              Daftar Lembaga
              <span class="text-blue-600">{{ appName }}</span>
            </h1>

            <p class="mt-4 max-w-3xl text-base font-medium leading-7 text-neutral-600 sm:text-lg">
              Ringkasan lembaga, unit pelayanan, dan kelembagaan masyarakat yang mendukung pelayanan serta pembangunan desa.
            </p>
          </div>

          <aside class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
            <div class="flex items-start gap-4">
              <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl bg-blue-50 text-blue-700">
                <img
                  v-if="appLogo && !appLogoFailed"
                  :src="appLogo"
                  :alt="appName"
                  class="h-10 w-10 object-contain"
                  @error="appLogoFailed = true"
                >
                <Icon v-else icon="solar:buildings-2-bold-duotone" class="h-7 w-7" />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                  Total Lembaga
                </p>
                <p class="mt-1 text-3xl font-black text-neutral-950">
                  {{ institutions.length }}
                </p>
                <p class="mt-1 text-xs font-bold text-neutral-500">
                  Tenant {{ tenantSlug }}
                </p>
              </div>
            </div>

            <div class="mt-4 grid grid-cols-3 gap-2">
              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                  Active
                </p>
                <p class="mt-1 text-lg font-black text-neutral-950">
                  {{ activeCount }}
                </p>
              </div>

              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                  Featured
                </p>
                <p class="mt-1 text-lg font-black text-neutral-950">
                  {{ featuredCount }}
                </p>
              </div>

              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                  Logo
                </p>
                <p class="mt-1 text-lg font-black text-neutral-950">
                  {{ withLogoCount }}
                </p>
              </div>
            </div>
          </aside>
        </div>

        <div v-else class="grid gap-6 lg:grid-cols-[1fr_330px] lg:items-end">
          <div>
            <div class="mb-4 flex flex-wrap items-center gap-2">
              <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
                <Icon :icon="activeInstitution?.icon || defaultInstitutionIcon" class="h-4 w-4" />
                Kelembagaan Desa
              </span>

              <span
                v-if="activeInstitution"
                class="rounded-full px-3 py-1.5 text-xs font-black capitalize"
                :class="activeInstitution.status === 'active'
                  ? 'bg-emerald-50 text-emerald-700'
                  : 'bg-neutral-100 text-neutral-600'"
              >
                {{ activeInstitution.status }}
              </span>

              <span
                v-if="activeInstitution?.isFeatured"
                class="rounded-full bg-neutral-950 px-3 py-1.5 text-xs font-black text-white"
              >
                Featured
              </span>
            </div>

            <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
              {{ activeInstitution?.title || 'Institution tidak ditemukan' }}
            </h1>

            <p class="mt-4 max-w-3xl text-base font-medium leading-7 text-neutral-600 sm:text-lg">
              {{ activeInstitution?.subtitle || detailDescription }}
            </p>

            <div class="mt-6 flex flex-wrap gap-3">
              <NuxtLink
                to="/institutions"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white shadow-lg shadow-neutral-900/10 transition hover:-translate-y-0.5 hover:bg-neutral-800"
              >
                <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                Semua Lembaga
              </NuxtLink>

              <button
                v-if="activeInstitution"
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:bg-neutral-50"
                @click="copyCurrentLink"
              >
                <Icon :icon="copied ? 'solar:check-circle-bold-duotone' : 'solar:link-circle-bold-duotone'" class="h-5 w-5 text-blue-600" />
                {{ copied ? 'Link Disalin' : 'Salin Link' }}
              </button>
            </div>
          </div>

          <aside
            v-if="activeInstitution"
            class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
          >
            <div class="flex items-start gap-4">
              <div class="grid h-16 w-16 shrink-0 place-items-center overflow-hidden rounded-3xl bg-blue-50 text-blue-700">
                <img
                  v-if="activeInstitution.logoUrl && !detailLogoFailed"
                  :src="activeInstitution.logoUrl"
                  :alt="activeInstitution.title"
                  class="h-full w-full object-cover"
                  @error="detailLogoFailed = true"
                >
                <Icon
                  v-else
                  :icon="activeInstitution.icon || defaultInstitutionIcon"
                  class="h-8 w-8"
                />
              </div>

              <div class="min-w-0">
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                  Profil Singkat
                </p>
                <p class="mt-1 truncate text-lg font-black text-neutral-950">
                  {{ activeInstitution.title }}
                </p>
                <p class="mt-1 truncate text-xs font-bold text-neutral-500">
                  {{ activeInstitution.slug }}
                </p>
              </div>
            </div>

            <div class="mt-5 grid gap-2">
              <InfoPill label="Update" :value="formatDate(activeInstitution.updatedAt)" />
              <InfoPill label="Urutan" :value="String(activeInstitution.sortOrder || 0)" />
            </div>
          </aside>
        </div>
      </div>
    </section>

    <!-- List -->
    <section
      v-if="!isDetailMode"
      class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8"
    >
      <div class="mb-5 rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
        <div class="grid gap-3 lg:grid-cols-[1fr_170px_170px]">
          <div class="relative">
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
              <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
            </div>

            <input
              v-model.trim="q"
              type="text"
              placeholder="Cari lembaga, subtitle, slug, atau deskripsi..."
              class="input-field py-3 pl-12"
            >
          </div>

          <select v-model="selectedStatus" class="input-field">
            <option value="active">Active</option>
            <option value="all">Semua Status</option>
            <option value="inactive">Inactive</option>
          </select>

          <select v-model="sortBy" class="input-field">
            <option value="sort_order">Urutan</option>
            <option value="title">Title A-Z</option>
            <option value="newest">Terbaru</option>
            <option value="oldest">Terlama</option>
          </select>
        </div>

        <div class="mt-4 flex flex-wrap items-center justify-between gap-3">
          <p class="text-xs font-bold text-neutral-500">
            Menampilkan {{ filteredInstitutions.length }} dari {{ institutions.length }} lembaga.
          </p>

          <button
            type="button"
            class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
            @click="resetFilters"
          >
            <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
            Reset
          </button>
        </div>
      </div>

      <div
        v-if="visibleError"
        class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
      >
        {{ visibleError }}
      </div>

      <section
        v-if="pending"
        class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
      >
        <div
          v-for="item in 8"
          :key="item"
          class="h-64 animate-pulse rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
        >
          <div class="h-14 w-14 rounded-3xl bg-neutral-100"></div>
          <div class="mt-5 h-5 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
          <div class="mt-7 h-10 w-full rounded-2xl bg-neutral-100"></div>
        </div>
      </section>

      <section
        v-else-if="filteredInstitutions.length === 0"
        class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
      >
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-neutral-100 text-neutral-500">
          <Icon icon="solar:buildings-2-bold-duotone" class="h-8 w-8" />
        </div>

        <h2 class="mt-5 text-xl font-black text-neutral-950">
          Belum ada data lembaga
        </h2>

        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Data kelembagaan akan tampil otomatis setelah ditambahkan dari dashboard institution.
        </p>
      </section>

      <section
        v-else
        class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
      >
        <NuxtLink
          v-for="item in pagedInstitutions"
          :key="item.id"
          :to="institutionDetailTo(item.slug)"
          class="group rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="flex items-start justify-between gap-4">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl bg-blue-50 text-blue-700 transition group-hover:bg-blue-600 group-hover:text-white">
              <img
                v-if="item.logoUrl && !failedImages[item.id]"
                :src="item.logoUrl"
                :alt="item.title"
                class="h-full w-full object-cover"
                @error="markImageFailed(item.id)"
              >
              <Icon
                v-else
                :icon="item.icon || defaultInstitutionIcon"
                class="h-7 w-7"
              />
            </div>

            <span
              v-if="item.isFeatured"
              class="rounded-full bg-neutral-950 px-2.5 py-1 text-[10px] font-black text-white"
            >
              Featured
            </span>
          </div>

          <div class="mt-5">
            <h2 class="line-clamp-2 text-lg font-black leading-7 text-neutral-950 group-hover:text-blue-700">
              {{ item.title }}
            </h2>

            <p class="mt-2 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
              {{ item.subtitle || contentPreview(item) || 'Informasi lembaga desa.' }}
            </p>
          </div>

          <div class="mt-5 flex items-center justify-between gap-3 border-t border-neutral-100 pt-4">
            <span class="inline-flex min-w-0 items-center gap-2 truncate text-xs font-black text-neutral-500">
              <Icon
                :icon="item.icon || defaultInstitutionIcon"
                class="h-4 w-4 shrink-0 text-blue-600"
              />
              <span class="truncate">{{ item.slug }}</span>
            </span>

            <span class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl bg-neutral-50 text-neutral-500 transition group-hover:bg-blue-600 group-hover:text-white">
              <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
            </span>
          </div>
        </NuxtLink>
      </section>

      <div
        v-if="hasMore && !pending"
        class="mt-8 flex justify-center"
      >
        <button
          type="button"
          class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:bg-neutral-50"
          @click="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat Lainnya
        </button>
      </div>
    </section>

    <!-- Detail -->
    <section
      v-else
      class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8"
    >
      <section
        v-if="pending || detailPending"
        class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-6 shadow-sm"
      >
        <div class="flex animate-pulse items-start gap-5">
          <div class="h-20 w-20 rounded-3xl bg-neutral-100"></div>
          <div class="flex-1">
            <div class="h-4 w-40 rounded-full bg-neutral-100"></div>
            <div class="mt-4 h-9 w-2/3 rounded-full bg-neutral-100"></div>
            <div class="mt-4 h-4 w-full rounded-full bg-neutral-100"></div>
            <div class="mt-2 h-4 w-4/5 rounded-full bg-neutral-100"></div>
          </div>
        </div>
      </section>

      <section
        v-else-if="detailError || !activeInstitution"
        class="mx-auto max-w-3xl rounded-[2rem] border border-red-200 bg-white p-8 text-center shadow-sm"
      >
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-red-50 text-red-600">
          <Icon icon="solar:danger-circle-bold-duotone" class="h-8 w-8" />
        </div>

        <h2 class="mt-5 text-2xl font-black text-neutral-950">
          Institution tidak ditemukan
        </h2>

        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Data kelembagaan yang kamu buka belum tersedia, sudah tidak aktif, atau slug-nya tidak sesuai.
        </p>

        <NuxtLink
          to="/institutions"
          class="mt-6 inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white transition hover:bg-neutral-800"
        >
          <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
          Kembali ke Kelembagaan
        </NuxtLink>
      </section>

      <template v-else>
        <div class="grid gap-6 lg:grid-cols-[1fr_320px]">
          <article class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm">
            <div class="border-b border-neutral-200 px-5 py-4 sm:px-6">
              <div class="flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-700">
                  <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
                </div>

                <div class="min-w-0">
                  <p class="truncate text-sm font-black text-neutral-950">
                    Profil {{ activeInstitution.title }}
                  </p>
                  <p class="text-xs font-semibold text-neutral-500">
                    Informasi detail lembaga desa
                  </p>
                </div>
              </div>
            </div>

            <div class="px-5 py-6 sm:px-6">
              <div
                v-if="safeContentHtml"
                class="institution-content"
                v-html="safeContentHtml"
              ></div>

              <div
                v-else
                class="rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center"
              >
                <Icon icon="solar:document-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
                <p class="mt-3 text-sm font-bold text-neutral-500">
                  Belum ada content detail untuk institution ini.
                </p>
              </div>
            </div>
          </article>

          <aside class="space-y-4">
            <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <p class="text-sm font-black text-neutral-950">
                Ringkasan
              </p>

              <div class="mt-4 space-y-4">
                <SummaryItem label="Title" :value="activeInstitution.title" />
                <SummaryItem
                  v-if="activeInstitution.subtitle"
                  label="Subtitle"
                  :value="activeInstitution.subtitle"
                />
                <SummaryItem label="Slug" :value="activeInstitution.slug" />
                <SummaryItem label="Status" :value="activeInstitution.status" />
              </div>
            </div>

            <NuxtLink
              to="/institutions"
              class="flex items-center justify-between gap-3 rounded-[1.5rem] border border-neutral-200 bg-white p-4 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:bg-neutral-50"
            >
              <span class="inline-flex items-center gap-2">
                <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                Semua Kelembagaan
              </span>
            </NuxtLink>
          </aside>
        </div>

        <section
          v-if="relatedInstitutions.length"
          class="mt-8"
        >
          <div class="mb-4 flex items-end justify-between gap-4">
            <div>
              <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                Lembaga Terkait
              </p>
              <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                Kelembagaan lainnya
              </h2>
            </div>

            <NuxtLink
              to="/institutions"
              class="hidden rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 shadow-sm transition hover:bg-neutral-50 sm:inline-flex"
            >
              Lihat Semua
            </NuxtLink>
          </div>

          <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <NuxtLink
              v-for="item in relatedInstitutions"
              :key="item.id"
              :to="institutionDetailTo(item.slug)"
              class="group rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
            >
              <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl bg-blue-50 text-blue-700">
                  <img
                    v-if="item.logoUrl"
                    :src="item.logoUrl"
                    :alt="item.title"
                    class="h-full w-full object-cover"
                  >
                  <Icon v-else :icon="item.icon || defaultInstitutionIcon" class="h-6 w-6" />
                </div>

                <div class="min-w-0">
                  <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
                    {{ item.title }}
                  </h3>
                  <p class="mt-1 line-clamp-2 text-sm font-medium leading-6 text-neutral-500">
                    {{ item.subtitle || contentPreview(item) || 'Informasi lembaga desa.' }}
                  </p>
                </div>
              </div>
            </NuxtLink>
          </div>
        </section>
      </template>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref, watch } from 'vue'
import type { InstitutionDetailResponse, InstitutionItem, InstitutionListResponse, InstitutionStatus } from '~/types/institution'
import { useAppApi } from '~/composables/useAppApi'

const route = useRoute()
const requestUrl = useRequestURL()
const runtime = useRuntimeConfig()

const defaultInstitutionIcon = 'solar:buildings-2-bold-duotone'

const q = ref('')
const selectedStatus = ref<InstitutionStatus | 'all'>('active')
const sortBy = ref<'newest' | 'oldest' | 'title' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12
const failedImages = ref<Record<string, boolean>>({})
const appLogoFailed = ref(false)
const detailLogoFailed = ref(false)
const copied = ref(false)

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

const appName = computed(() => {
  return String(
    runtime.public.appName ||
    runtime.public.clientDisplayName ||
    runtime.public.siteName ||
    'Desa Martopuro'
  )
})

const appLogo = computed(() => {
  return String(
    runtime.public.appLogo ||
    runtime.public.logoUrl ||
    'https://martopuro.sencra.io/martopuro-logo.png'
  )
})

const detailSlug = computed(() => {
  return normalizeQueryString(route.query.detail || route.query.detai)
})

const isDetailMode = computed(() => Boolean(detailSlug.value))

const { tenantApiUrl } = useAppApi()

const apiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/institutions')
})

const {
  data,
  pending,
  error,
  refresh
} = await useFetch<InstitutionListResponse>(apiUrl, {
  key: computed(() => `institutions-page-${tenantSlug.value}-${selectedStatus.value}-${sortBy.value}`),
  query: computed(() => ({
    status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
    limit: 100,
    sort: sortBy.value
  })),
  watch: [tenantSlug, selectedStatus, sortBy],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 100,
      total: 0,
      totalPages: 1
    }
  })
})

const institutions = computed<InstitutionItem[]>(() => {
  return data.value?.data || []
})

const localDetailInstitution = computed<InstitutionItem | null>(() => {
  if (!detailSlug.value) return null

  return institutions.value.find((item) => item.slug === detailSlug.value) || null
})

const {
  data: detailResponse,
  pending: detailPending,
  error: detailError
} = await useAsyncData<InstitutionDetailResponse>(
  () => `institution-detail-query-${tenantSlug.value}-${detailSlug.value}`,
  async () => {
    if (!detailSlug.value) {
      return {
        data: null as any
      }
    }

    if (localDetailInstitution.value) {
      return {
        data: localDetailInstitution.value
      }
    }

    try {
      return await $fetch<InstitutionDetailResponse>(
        tenantApiUrl(tenantSlug.value, `/institutions/by-slug/${encodeURIComponent(detailSlug.value)}`)
      )
    } catch {
      return {
        data: null as any
      }
    }
  },
  {
    watch: [tenantSlug, detailSlug, institutions],
    default: () => ({
      data: null as any
    })
  }
)

const activeInstitution = computed<InstitutionItem | null>(() => {
  return localDetailInstitution.value || detailResponse.value?.data || null
})

const visibleError = computed(() => {
  if (!error.value) return ''

  return error.value?.message || 'Terjadi kesalahan saat memuat data kelembagaan.'
})

const filteredInstitutions = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return institutions.value
    .filter((item) => {
      if (!keyword) return true

      return [
        item.title,
        item.subtitle,
        item.slug,
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => {
      if (sortBy.value === 'title') {
        return String(a.title || '').localeCompare(String(b.title || ''))
      }

      if (sortBy.value === 'newest') {
        return Number(b.createdAt || 0) - Number(a.createdAt || 0)
      }

      if (sortBy.value === 'oldest') {
        return Number(a.createdAt || 0) - Number(b.createdAt || 0)
      }

      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)

      if (sortA !== sortB) return sortA - sortB

      return String(a.title || '').localeCompare(String(b.title || ''))
    })
})

const pagedInstitutions = computed(() => {
  return filteredInstitutions.value.slice(0, page.value * pageSize)
})

const hasMore = computed(() => {
  return pagedInstitutions.value.length < filteredInstitutions.value.length
})

const activeCount = computed(() => {
  return institutions.value.filter((item) => item.status === 'active').length
})

const featuredCount = computed(() => {
  return institutions.value.filter((item) => item.isFeatured).length
})

const withLogoCount = computed(() => {
  return institutions.value.filter((item) => Boolean(item.logoUrl)).length
})

const safeContentHtml = computed(() => {
  return sanitizeInstitutionHtml(activeInstitution.value?.contentHtml || '')
})

const detailDescription = computed(() => {
  if (!activeInstitution.value) return 'Data kelembagaan yang kamu buka belum tersedia atau slug-nya tidak sesuai.'

  return plainText(activeInstitution.value.contentHtml || '').slice(0, 180) || 'Informasi kelembagaan desa.'
})

const relatedInstitutions = computed(() => {
  const currentId = activeInstitution.value?.id

  return institutions.value
    .filter((item) => item.id !== currentId)
    .slice(0, 3)
})

const pageTitle = computed(() => {
  if (activeInstitution.value) {
    return `${activeInstitution.value.title} · Kelembagaan Desa`
  }

  return isDetailMode.value
    ? 'Institution tidak ditemukan'
    : `Kelembagaan · ${appName.value}`
})

const pageDescription = computed(() => {
  if (activeInstitution.value) {
    return activeInstitution.value.subtitle ||
      plainText(activeInstitution.value.contentHtml || '').slice(0, 160) ||
      'Informasi kelembagaan desa.'
  }

  return `Daftar lembaga dan organisasi pendukung di ${appName.value}.`
})

watch([q, selectedStatus, sortBy], () => {
  page.value = 1
})

watch(detailSlug, () => {
  detailLogoFailed.value = false
  copied.value = false
})

useSeoMeta({
  title: () => pageTitle.value,
  description: () => pageDescription.value,
  ogTitle: () => pageTitle.value,
  ogDescription: () => pageDescription.value,
  robots: 'index, follow'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      rel: 'canonical',
      href: isDetailMode.value
        ? `${requestUrl.origin}/institutions?detail=${encodeURIComponent(detailSlug.value)}`
        : `${requestUrl.origin}/institutions`
    }
  ]
}))

function institutionDetailTo(slug: string) {
  return {
    path: '/institutions',
    query: {
      detail: slug
    }
  }
}

function resetFilters() {
  q.value = ''
  selectedStatus.value = 'active'
  sortBy.value = 'sort_order'
  page.value = 1
  refresh()
}

function contentPreview(item: InstitutionItem) {
  return plainText(item.contentHtml || '').slice(0, 140)
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

function sanitizeInstitutionHtml(value: string) {
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

        if (name.startsWith('on')) {
          element.removeAttribute(attribute.name)
        }

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

function formatDate(value?: number | null) {
  if (!value) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(new Date(value))
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function normalizeQueryString(value: unknown) {
  const raw = Array.isArray(value) ? value[0] : value

  return String(raw || '')
    .trim()
    .toLowerCase()
}

async function copyCurrentLink() {
  if (!activeInstitution.value || typeof window === 'undefined') return

  const url = `${window.location.origin}/institutions?detail=${encodeURIComponent(activeInstitution.value.slug)}`

  copied.value = true

  try {
    await navigator.clipboard.writeText(url)
  } catch {}

  window.setTimeout(() => {
    copied.value = false
  }, 1400)
}

const InfoPill = defineComponent({
  props: {
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
    return () =>
      h(
        'div',
        {
          class:
            'flex items-center justify-between gap-3 rounded-2xl bg-neutral-50 px-4 py-3'
        },
        [
          h(
            'span',
            {
              class:
                'text-xs font-black uppercase tracking-[0.12em] text-neutral-400'
            },
            props.label
          ),
          h(
            'span',
            {
              class:
                'min-w-0 truncate text-right text-sm font-black text-neutral-950'
            },
            props.value
          )
        ]
      )
  }
})

const SummaryItem = defineComponent({
  props: {
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
    return () =>
      h('div', {}, [
        h(
          'p',
          {
            class:
              'text-xs font-black uppercase tracking-[0.14em] text-neutral-400'
          },
          props.label
        ),
        h(
          'p',
          {
            class:
              'mt-1 break-words text-sm font-bold leading-6 text-neutral-700'
          },
          props.value
        )
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

.input-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.input-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.institution-content {
  color: #262626;
  font-size: 1rem;
  line-height: 1.8;
}

.institution-content :deep(h2) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 1.75rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.institution-content :deep(h3) {
  margin-top: 1.5rem;
  margin-bottom: 0.65rem;
  font-size: 1.35rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.institution-content :deep(p) {
  margin: 0.9rem 0;
}

.institution-content :deep(a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.institution-content :deep(ul),
.institution-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.institution-content :deep(li) {
  margin: 0.35rem 0;
}

.institution-content :deep(blockquote) {
  margin: 1.25rem 0;
  border-left: 4px solid #171717;
  border-radius: 0.75rem;
  background: #fafafa;
  padding: 1rem 1.25rem;
  color: #525252;
}

.institution-content :deep(img) {
  margin: 1.25rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid #e5e5e5;
}

.institution-content :deep(iframe) {
  margin: 1.25rem 0;
  min-height: 420px;
  width: 100%;
  border: 0;
  border-radius: 1.25rem;
  background: #f5f5f5;
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
