<template>
  <section class="min-h-full bg-neutral-50 text-neutral-950">
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
        enter-to-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="translate-y-0 opacity-100 sm:translate-x-3 sm:translate-y-0"
        leave-to-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
      >
        <div v-if="toast.show" class="fixed right-4 top-4 z-[10000] w-[calc(100%-2rem)] max-w-sm">
          <div
            class="rounded-3xl border bg-white/95 p-4 shadow-[0_24px_80px_rgba(15,23,42,0.16)] backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-emerald-200' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success' ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-700'"
              >
                <Icon
                  :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'"
                  class="h-5 w-5"
                />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-sm font-black text-neutral-950">{{ toast.title }}</p>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">{{ toast.message }}</p>
              </div>

              <button
                type="button"
                class="grid h-8 w-8 shrink-0 place-items-center rounded-xl text-neutral-400 transition hover:bg-neutral-100 hover:text-neutral-700"
                aria-label="Tutup pemberitahuan"
                @click="closeToast"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <div class="space-y-4 p-4 sm:p-6">
      <section class="relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-20 -top-24 h-64 w-64 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -left-28 bottom-0 h-48 w-48 rounded-full bg-sky-100 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3 sm:gap-4">
            <div class="grid h-14 w-14 shrink-0 place-items-center rounded-[1.35rem] border border-blue-100 bg-blue-600 text-white shadow-sm ring-4 ring-blue-50 sm:h-16 sm:w-16">
              <Icon icon="solar:chat-round-call-bold-duotone" class="h-8 w-8" />
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:inbox-in-bold-duotone" class="h-3.5 w-3.5" />
                  Layanan Warga
                </span>

                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Pengaduan, Laporan, dan Pengajuan
              </h1>

              <p class="mt-1.5 max-w-3xl text-sm font-medium leading-6 text-neutral-500">
                Pantau pesan warga, tindak lanjuti statusnya, dan jaga respons layanan publik tetap rapi.
              </p>
            </div>
          </div>

          <button
            type="button"
            class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
            :disabled="pending"
            @click="reloadComplaints"
          >
            <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
            Refresh
          </button>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <div
          v-for="card in statsCards"
          :key="card.label"
          class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm"
        >
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">{{ card.label }}</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ card.value }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl" :class="card.iconClass">
              <Icon :icon="card.icon" class="h-6 w-6" />
            </div>
          </div>
        </div>
      </section>

      <section class="rounded-3xl border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_170px_170px_170px] lg:items-center">
          <div class="relative min-w-0">
            <Icon icon="solar:magnifer-linear" class="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-neutral-400" />
            <input
              v-model.trim="search"
              type="text"
              placeholder="Cari nama, email, kode, pesan, atau alamat..."
              class="h-12 w-full rounded-2xl border border-neutral-200 bg-neutral-50 pl-12 pr-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-600/10"
            >
          </div>

          <select v-model="selectedService" class="filter-select">
            <option value="all">Semua Layanan</option>
            <option value="aduan">Aduan</option>
            <option value="laporan">Laporan</option>
            <option value="pengajuan">Pengajuan</option>
          </select>

          <select v-model="selectedStatus" class="filter-select">
            <option value="all">Semua Status</option>
            <option value="new">Baru</option>
            <option value="in_review">Review</option>
            <option value="in_progress">Diproses</option>
            <option value="resolved">Selesai</option>
            <option value="rejected">Ditolak</option>
            <option value="closed">Ditutup</option>
          </select>

          <select v-model="selectedPriority" class="filter-select">
            <option value="all">Semua Prioritas</option>
            <option value="urgent">Urgent</option>
            <option value="high">High</option>
            <option value="normal">Normal</option>
            <option value="low">Low</option>
          </select>
        </div>
      </section>

      <div v-if="visibleError" class="rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <section v-if="pending" class="grid gap-3 lg:grid-cols-2">
        <div v-for="item in 6" :key="item" class="h-48 animate-pulse rounded-[1.75rem] border border-neutral-200 bg-white p-4">
          <div class="h-4 w-48 rounded-full bg-neutral-100"></div>
          <div class="mt-4 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <section v-else-if="pagedComplaints.length === 0" class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:inbox-line-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada pengaduan</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Data akan muncul otomatis saat warga mengirim aduan, laporan, atau pengajuan dari halaman publik.
        </p>
      </section>

      <section v-else class="grid gap-3 lg:grid-cols-2">
        <article
          v-for="item in pagedComplaints"
          :key="item.id"
          class="rounded-[1.75rem] border border-neutral-200 bg-white p-4 shadow-sm transition hover:border-blue-200 hover:shadow-lg hover:shadow-blue-900/5"
        >
          <div class="flex items-start justify-between gap-3">
            <div class="min-w-0">
              <div class="flex flex-wrap items-center gap-2">
                <span class="rounded-full px-2.5 py-1 text-[10px] font-black uppercase tracking-[0.1em]" :class="serviceClass(item.serviceType)">
                  {{ item.serviceLabel }}
                </span>
                <span class="rounded-full px-2.5 py-1 text-[10px] font-black uppercase tracking-[0.1em]" :class="statusClass(item.status)">
                  {{ statusLabel(item.status) }}
                </span>
                <span class="rounded-full bg-neutral-100 px-2.5 py-1 text-[10px] font-black uppercase tracking-[0.1em] text-neutral-600">
                  {{ priorityLabel(item.priority) }}
                </span>
              </div>

              <h3 class="mt-3 text-base font-black leading-6 text-neutral-950">
                {{ item.title || item.message.slice(0, 80) }}
              </h3>
              <p class="mt-1 text-xs font-bold text-neutral-400">
                {{ item.publicCode || item.id }} - {{ formatDate(item.createdAt) }}
              </p>
            </div>
          </div>

          <p class="mt-3 line-clamp-3 text-sm font-semibold leading-7 text-neutral-600">
            {{ item.message }}
          </p>

          <div class="mt-4 rounded-2xl bg-neutral-50 p-3">
            <p class="text-sm font-black text-neutral-950">{{ item.reporterName }}</p>
            <p class="mt-1 text-xs font-bold text-neutral-400">
              {{ item.reporterEmail }}<span v-if="item.reporterPhone"> - {{ item.reporterPhone }}</span>
            </p>
            <p v-if="item.address" class="mt-2 text-xs font-semibold leading-5 text-neutral-500">
              {{ item.address }}
            </p>
          </div>

          <div class="mt-4 flex flex-wrap gap-2 border-t border-neutral-100 pt-4">
            <button
              type="button"
              class="action-button bg-blue-50 text-blue-700 hover:bg-blue-600 hover:text-white"
              :disabled="mutatingId === item.id"
              @click="updateStatus(item, 'in_progress')"
            >
              <Icon icon="solar:play-circle-bold-duotone" class="h-4 w-4" />
              Proses
            </button>

            <button
              type="button"
              class="action-button bg-emerald-50 text-emerald-700 hover:bg-emerald-600 hover:text-white"
              :disabled="mutatingId === item.id"
              @click="updateStatus(item, 'resolved')"
            >
              <Icon icon="solar:check-circle-bold-duotone" class="h-4 w-4" />
              Selesai
            </button>

            <button
              type="button"
              class="action-button border border-neutral-200 bg-white text-neutral-600 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="openDetail(item)"
            >
              <Icon icon="solar:eye-bold-duotone" class="h-4 w-4" />
              Detail
            </button>

            <button
              type="button"
              class="action-button ml-auto border border-neutral-200 bg-white text-neutral-600 hover:border-red-200 hover:bg-red-50 hover:text-red-700"
              :disabled="mutatingId === item.id"
              @click="deleteItem(item)"
            >
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
              Hapus
            </button>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !pending" class="flex justify-center">
        <button
          type="button"
          class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          @click="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat Lainnya
        </button>
      </div>
    </div>

    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div
          v-if="selectedComplaint"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeDetail"
        >
          <section class="flex max-h-[92dvh] w-full max-w-3xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">{{ selectedComplaint.publicCode || selectedComplaint.id }}</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ selectedComplaint.title || selectedComplaint.serviceLabel }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail pengaduan"
                @click="closeDetail"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 space-y-4 overflow-y-auto p-5">
              <div class="flex flex-wrap gap-2">
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="serviceClass(selectedComplaint.serviceType)">
                  {{ selectedComplaint.serviceLabel }}
                </span>
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedComplaint.status)">
                  {{ statusLabel(selectedComplaint.status) }}
                </span>
                <span class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                  {{ priorityLabel(selectedComplaint.priority) }}
                </span>
              </div>

              <div class="rounded-2xl border border-neutral-200 p-4">
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Pesan</p>
                <p class="mt-3 whitespace-pre-line text-sm font-semibold leading-7 text-neutral-700">
                  {{ selectedComplaint.message }}
                </p>
              </div>

              <div class="grid gap-3 sm:grid-cols-2">
                <div class="rounded-2xl bg-neutral-50 p-4">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Pelapor</p>
                  <p class="mt-2 text-sm font-black text-neutral-950">{{ selectedComplaint.reporterName }}</p>
                  <p class="mt-1 text-xs font-bold text-neutral-500">{{ selectedComplaint.reporterEmail }}</p>
                  <p v-if="selectedComplaint.reporterPhone" class="mt-1 text-xs font-bold text-neutral-500">{{ selectedComplaint.reporterPhone }}</p>
                </div>

                <div class="rounded-2xl bg-neutral-50 p-4">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Waktu</p>
                  <p class="mt-2 text-sm font-black text-neutral-950">{{ formatDate(selectedComplaint.createdAt) }}</p>
                  <p v-if="selectedComplaint.address" class="mt-2 text-xs font-semibold leading-5 text-neutral-500">{{ selectedComplaint.address }}</p>
                </div>
              </div>
            </div>
          </section>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, onBeforeUnmount, reactive, ref, watch } from 'vue'
import { useHead, useRuntimeConfig, useSeoMeta } from '#imports'
import { useAppApi } from '~/composables/useAppApi'
import type {
  ComplaintItem,
  ComplaintListResponse,
  ComplaintPriority,
  ComplaintServiceType,
  ComplaintStatus
} from '../../../types/complaint'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Pengaduan'
  }
})

type ToastType = 'success' | 'error'

const runtime = useRuntimeConfig()
const { tenantApiUrl } = useAppApi()

const search = ref('')
const selectedService = ref<ComplaintServiceType | 'all'>('all')
const selectedStatus = ref<ComplaintStatus | 'all'>('all')
const selectedPriority = ref<ComplaintPriority | 'all'>('all')
const page = ref(1)
const pageSize = 12
const selectedComplaint = ref<ComplaintItem | null>(null)
const mutatingId = ref('')
let toastTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const tenantSlug = computed(() => {
  return String(runtime.public.clientName || runtime.public.tenantSlug || 'martopuro')
    .trim()
    .toLowerCase() || 'martopuro'
})

const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/complaints'))

const {
  data,
  pending,
  error,
  refresh
} = useFetch<ComplaintListResponse>(apiUrl, {
  key: computed(() => `app-complaints-${tenantSlug.value}`),
  query: computed(() => ({
    status: 'all',
    serviceType: 'all',
    priority: 'all',
    limit: 100,
    sort: 'newest'
  })),
  watch: [tenantSlug],
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

const complaints = computed(() => data.value?.data || [])

const visibleError = computed(() => {
  if (!error.value) return ''
  return getErrorMessage(error.value, 'Data pengaduan belum bisa dimuat.')
})

const filteredComplaints = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return complaints.value.filter((item) => {
    const matchKeyword = !keyword || [
      item.publicCode,
      item.title,
      item.message,
      item.reporterName,
      item.reporterEmail,
      item.reporterPhone,
      item.address,
      item.serviceLabel,
      item.status,
      item.priority
    ]
      .filter(Boolean)
      .join(' ')
      .toLowerCase()
      .includes(keyword)

    const matchService = selectedService.value === 'all' || item.serviceType === selectedService.value
    const matchStatus = selectedStatus.value === 'all' || item.status === selectedStatus.value
    const matchPriority = selectedPriority.value === 'all' || item.priority === selectedPriority.value

    return matchKeyword && matchService && matchStatus && matchPriority
  })
})

const pagedComplaints = computed(() => filteredComplaints.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedComplaints.value.length < filteredComplaints.value.length)

const totalCount = computed(() => complaints.value.length)
const newCount = computed(() => complaints.value.filter((item) => item.status === 'new').length)
const progressCount = computed(() => complaints.value.filter((item) => item.status === 'in_progress' || item.status === 'in_review').length)
const resolvedCount = computed(() => complaints.value.filter((item) => item.status === 'resolved' || item.status === 'closed').length)

const statsCards = computed(() => [
  {
    label: 'Total',
    value: totalCount.value,
    icon: 'solar:inbox-in-bold-duotone',
    iconClass: 'bg-blue-50 text-blue-600'
  },
  {
    label: 'Baru',
    value: newCount.value,
    icon: 'solar:bell-bold-duotone',
    iconClass: 'bg-amber-50 text-amber-600'
  },
  {
    label: 'Diproses',
    value: progressCount.value,
    icon: 'solar:play-circle-bold-duotone',
    iconClass: 'bg-sky-50 text-sky-600'
  },
  {
    label: 'Selesai',
    value: resolvedCount.value,
    icon: 'solar:check-circle-bold-duotone',
    iconClass: 'bg-emerald-50 text-emerald-600'
  }
])

watch([search, selectedService, selectedStatus, selectedPriority], () => {
  page.value = 1
})

onBeforeUnmount(() => {
  if (toastTimer) clearTimeout(toastTimer)
})

async function reloadComplaints() {
  await refresh()
}

async function updateStatus(item: ComplaintItem, status: ComplaintStatus) {
  mutatingId.value = item.id

  try {
    await $fetch(`${apiUrl.value}/${item.id}`, {
      method: 'PUT',
      body: {
        status
      }
    })

    showToast('success', 'Status Diupdate', `Status pengaduan menjadi ${statusLabel(status)}.`)
    await refresh()
  } catch (error) {
    showToast('error', 'Gagal Update', getErrorMessage(error, 'Status pengaduan belum bisa diupdate.'))
  } finally {
    mutatingId.value = ''
  }
}

async function deleteItem(item: ComplaintItem) {
  mutatingId.value = item.id

  try {
    await $fetch(`${apiUrl.value}/${item.id}`, {
      method: 'DELETE'
    })

    showToast('success', 'Pengaduan Dihapus', 'Data pengaduan berhasil dihapus.')
    await refresh()
  } catch (error) {
    showToast('error', 'Gagal Menghapus', getErrorMessage(error, 'Pengaduan belum bisa dihapus.'))
  } finally {
    mutatingId.value = ''
  }
}

function openDetail(item: ComplaintItem) {
  selectedComplaint.value = item
}

function closeDetail() {
  selectedComplaint.value = null
}

function serviceClass(service: ComplaintServiceType) {
  if (service === 'laporan') return 'bg-blue-50 text-blue-700 ring-1 ring-blue-100'
  if (service === 'pengajuan') return 'bg-amber-50 text-amber-700 ring-1 ring-amber-100'

  return 'bg-red-50 text-red-700 ring-1 ring-red-100'
}

function statusLabel(status: ComplaintStatus | string) {
  if (status === 'new') return 'Baru'
  if (status === 'in_review') return 'Review'
  if (status === 'in_progress') return 'Diproses'
  if (status === 'resolved') return 'Selesai'
  if (status === 'rejected') return 'Ditolak'
  if (status === 'closed') return 'Ditutup'

  return 'Baru'
}

function statusClass(status: ComplaintStatus | string) {
  if (status === 'resolved' || status === 'closed') return 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-100'
  if (status === 'in_progress' || status === 'in_review') return 'bg-blue-50 text-blue-700 ring-1 ring-blue-100'
  if (status === 'rejected') return 'bg-red-50 text-red-700 ring-1 ring-red-100'

  return 'bg-amber-50 text-amber-700 ring-1 ring-amber-100'
}

function priorityLabel(priority: ComplaintPriority | string) {
  if (priority === 'urgent') return 'Urgent'
  if (priority === 'high') return 'High'
  if (priority === 'low') return 'Low'

  return 'Normal'
}

function formatDate(value: number | string | null | undefined) {
  const time = typeof value === 'number'
    ? value
    : new Date(String(value || '')).getTime()

  if (!time || Number.isNaN(time)) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(time))
}

function getErrorMessage(error: unknown, fallback: string) {
  if (!error) return fallback
  if (typeof error === 'string') return error

  if (typeof error === 'object') {
    const payload = error as Record<string, any>
    const data = payload.data && typeof payload.data === 'object'
      ? payload.data as Record<string, any>
      : {}

    return String(data.statusMessage || data.message || payload.statusMessage || payload.message || fallback)
  }

  return fallback
}

function showToast(type: ToastType, title: string, message: string) {
  if (toastTimer) clearTimeout(toastTimer)

  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true

  toastTimer = setTimeout(() => {
    toast.show = false
  }, 3500)
}

function closeToast() {
  if (toastTimer) clearTimeout(toastTimer)
  toast.show = false
}

useSeoMeta({
  title: 'Pengaduan - Dashboard',
  description: 'Kelola aduan, laporan, dan pengajuan warga.',
  robots: 'noindex, nofollow',
  themeColor: '#2563eb'
})

useHead({
  htmlAttrs: {
    lang: 'id'
  },
  meta: [
    {
      name: 'theme-color',
      content: '#2563eb'
    }
  ]
})
</script>

<style scoped>
.filter-select {
  height: 3rem;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding-left: 1rem;
  padding-right: 1rem;
  font-size: 0.875rem;
  font-weight: 800;
  color: rgb(64 64 64);
  outline: none;
  transition: 160ms ease;
}

.filter-select:focus {
  border-color: rgb(59 130 246);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.action-button {
  display: inline-flex;
  height: 2.25rem;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  border-radius: 0.75rem;
  padding-left: 0.75rem;
  padding-right: 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  transition: 160ms ease;
}

.action-button:disabled {
  cursor: not-allowed;
  opacity: 0.55;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
