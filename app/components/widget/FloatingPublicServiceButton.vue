<template>
  <div>
    <!-- Floating Button -->
    <button
      type="button"
      class="group fixed bottom-5 right-5 z-[70] inline-flex h-16 w-16 items-center justify-center rounded-full bg-blue-600 text-white shadow-2xl shadow-blue-600/35 transition duration-300 hover:-translate-y-1 hover:bg-blue-700 focus:outline-none focus:ring-4 focus:ring-blue-600/25 sm:bottom-7 sm:right-7"
      aria-label="Buka form aduan, laporan, dan pengajuan"
      @click="openModal"
    >
      <span class="absolute inset-0 animate-ping rounded-full bg-blue-600 opacity-40"></span>
      <span class="absolute -inset-1 rounded-full border border-blue-300/60"></span>

      <Icon
        icon="solar:chat-round-call-bold-duotone"
        class="relative h-8 w-8 transition duration-300 group-hover:scale-110"
      />

      <span class="absolute -left-36 top-1/2 hidden -translate-y-1/2 whitespace-nowrap rounded-2xl border border-blue-100 bg-white px-3 py-2 text-xs font-black text-blue-700 shadow-xl shadow-blue-950/10 sm:block">
        Aduan / Laporan
      </span>
    </button>

    <!-- Modal -->
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
          v-if="modalOpen"
          class="fixed inset-0 z-[90] overflow-y-auto bg-neutral-950/60 p-3 backdrop-blur-sm sm:p-5 lg:p-6"
          role="dialog"
          aria-modal="true"
          @click.self="closeModal"
        >
          <div class="mx-auto flex min-h-full w-full max-w-7xl items-center justify-center">
            <section class="relative flex max-h-[calc(100dvh-2rem)] w-full flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl shadow-neutral-950/20 sm:max-h-[calc(100dvh-3rem)]">
              <!-- Header -->
              <div class="relative shrink-0 overflow-hidden border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5 sm:p-6">
                <div class="pointer-events-none absolute -right-20 -top-20 h-64 w-64 rounded-full bg-blue-200/50 blur-3xl"></div>
                <div class="pointer-events-none absolute -bottom-20 left-10 h-56 w-56 rounded-full bg-sky-100 blur-3xl"></div>

                <div class="relative flex items-start justify-between gap-4">
                  <div class="min-w-0">
                    <h2 class="mt-3 text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                      Aduan, Laporan, dan Pengajuan
                    </h2>
                  </div>

                  <button
                    type="button"
                    class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 shadow-sm transition hover:bg-neutral-50 hover:text-neutral-950"
                    aria-label="Tutup modal"
                    @click="closeModal"
                  >
                    <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                  </button>
                </div>
              </div>

              <!-- Content -->
              <div class="min-h-0 flex-1 overflow-y-auto bg-white">
                <div class="grid min-h-full grid-cols-1 lg:grid-cols-2 lg:items-stretch">
                  <!-- Left Grid: Reports -->
                  <section class="relative flex flex-col overflow-hidden border-b border-neutral-200 bg-neutral-50 p-4 sm:p-6 lg:border-b-0 lg:border-r">
                    <div class="pointer-events-none absolute inset-0 bg-[linear-gradient(to_right,#dbeafe_1px,transparent_1px),linear-gradient(to_bottom,#e5e7eb_1px,transparent_1px)] bg-size-[38px_38px] opacity-60"></div>
                    <div class="pointer-events-none absolute -left-24 top-8 h-72 w-72 rounded-full bg-blue-100 blur-3xl"></div>
                    <div class="pointer-events-none absolute bottom-0 right-0 h-72 w-72 rounded-full bg-sky-100 blur-3xl"></div>

                    <div class="relative z-10 flex shrink-0 items-center justify-between gap-3">
                      <div class="min-w-0">
                        <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                          Aspirasi Warga
                        </p>
                        <h3 class="mt-1 text-xl font-black tracking-tight text-neutral-950 sm:text-2xl">
                          Laporan Warga {{ tenantName }}
                        </h3>
                      </div>

                      <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-blue-600 text-white shadow-lg shadow-blue-600/20">
                        <Icon icon="solar:users-group-rounded-bold-duotone" class="h-6 w-6" />
                      </div>
                    </div>

                    <div class="relative max-h-[60vh] z-10 mt-5 min-h-0 flex-1 overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white/50 p-3 shadow-inner shadow-neutral-950/5">
                      <div class="pointer-events-none absolute inset-x-0 top-0 z-20 h-20 bg-gradient-to-b from-white/95 to-transparent"></div>
                      <div class="pointer-events-none absolute inset-x-0 bottom-0 z-20 h-20 bg-gradient-to-t from-white/95 to-transparent"></div>

                      <div class="marquee-column space-y-4">
                        <article
                          v-for="item in visibleReports"
                          :key="item.id"
                          class="report-card group rounded-[1.65rem] border border-neutral-200 bg-white/95 p-4 shadow-sm shadow-neutral-950/5 backdrop-blur transition hover:border-blue-200 hover:shadow-xl hover:shadow-blue-950/5"
                        >
                          <div class="flex items-start gap-3">
                            <div
                              class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl text-sm font-black shadow-sm"
                              :class="serviceAvatarClass(item.service)"
                            >
                              {{ getInitials(item.name) }}
                            </div>

                            <div class="min-w-0 flex-1">
                              <div class="flex flex-wrap items-center gap-2">
                                <h4 class="truncate text-sm font-black text-neutral-950">
                                  {{ item.name }}
                                </h4>

                                <span
                                  class="rounded-full px-2.5 py-1 text-[10px] font-black uppercase tracking-[0.1em]"
                                  :class="serviceBadgeClass(item.service)"
                                >
                                  {{ item.service }}
                                </span>
                              </div>

                              <p class="mt-0.5 truncate text-xs font-semibold text-neutral-400">
                                {{ item.email }}
                              </p>

                              <p class="mt-3 line-clamp-3 text-sm font-semibold leading-7 text-neutral-600">
                                {{ item.message }}
                              </p>

                              <div class="mt-3 flex items-center justify-between gap-3 border-t border-neutral-100 pt-3">
                                <span class="text-xs font-black text-neutral-400">
                                  {{ item.time }}
                                </span>

                                <span class="inline-flex items-center gap-1 text-xs font-black text-blue-600">
                                  Diproses
                                  <Icon icon="solar:check-circle-bold-duotone" class="h-4 w-4" />
                                </span>
                              </div>
                            </div>
                          </div>
                        </article>
                      </div>
                    </div>
                  </section>

                  <!-- Right Grid: Form -->
                  <section class="flex min-h-[520px] flex-col bg-white p-4 sm:p-6 lg:min-h-[620px]">
                    <div class="shrink-0">
                      <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                        Form Layanan
                      </p>
                      <h3 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                        Kirim Pesan Warga
                      </h3>
                      <p class="mt-2 text-sm font-semibold leading-7 text-neutral-500">
                        Pilih jenis layanan, lalu tuliskan pesan dengan jelas agar admin desa mudah menindaklanjuti.
                      </p>
                    </div>

                    <form class="mt-5" @submit.prevent="submitForm">
                      <div class="grid gap-4 sm:grid-cols-2">
                        <label class="block">
                          <span class="mb-2 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
                            Nama
                          </span>
                          <input
                            v-model.trim="form.name"
                            type="text"
                            class="form-control"
                            placeholder="Nama lengkap"
                          >
                        </label>

                        <label class="block">
                          <span class="mb-2 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
                            Email
                          </span>
                          <input
                            v-model.trim="form.email"
                            type="email"
                            class="form-control"
                            placeholder="email@domain.com"
                          >
                        </label>
                      </div>

                      <label class="mt-4 block">
                        <span class="mb-2 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
                          Layanan
                        </span>
                        <select v-model="form.service" class="form-control">
                          <option value="Aduan">Aduan</option>
                          <option value="Laporan">Laporan</option>
                          <option value="Pengajuan">Pengajuan</option>
                        </select>
                      </label>

                      <label class="mt-4 block">
                        <span class="mb-2 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
                          Pesan
                        </span>

                        <textarea
                          v-model.trim="form.message"
                          rows="4"
                          class="form-textarea h-32 max-h-44 min-h-32"
                          placeholder="Tuliskan pesan, lokasi, detail masalah, atau kebutuhan layanan..."
                          maxlength="800"
                        ></textarea>

                        <div class="mt-2 flex items-center justify-between gap-3">
                          <p class="text-xs font-semibold text-neutral-400">
                            Maksimal 800 karakter
                          </p>
                          <p class="text-xs font-black text-neutral-400">
                            {{ form.message.length }}/800
                          </p>
                        </div>
                      </label>

                      <div class="mt-4 space-y-3">
                        <div
                          v-if="formError"
                          class="flex items-start gap-2 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold leading-6 text-red-700"
                        >
                          <Icon icon="solar:danger-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
                          <span>{{ formError }}</span>
                        </div>

                        <div
                          v-if="formSuccess"
                          class="flex items-start gap-2 rounded-2xl border border-blue-200 bg-blue-50 px-4 py-3 text-sm font-bold leading-6 text-blue-700"
                        >
                          <Icon icon="solar:check-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
                          <span>Pesan berhasil ditambahkan.</span>
                        </div>

                        <button
                          type="submit"
                          class="inline-flex h-12 w-full items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/25 transition hover:-translate-y-0.5 hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                          :disabled="submitting"
                        >
                          <Icon
                            :icon="submitting ? 'svg-spinners:180-ring' : 'solar:plain-bold-duotone'"
                            class="h-5 w-5"
                          />
                          {{ submitting ? 'Mengirim...' : 'Kirim Pesan' }}
                        </button>
                      </div>
                    </form>
                  </section>
                </div>
              </div>
            </section>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue'
import { useRuntimeConfig } from '#imports'
import { useComplaints } from '~/composables/data/useComplaints'
import type { ComplaintItem } from '../../../types/complaint'

type ServiceType = 'Aduan' | 'Laporan' | 'Pengajuan'

type ReportItem = {
  id: string
  name: string
  email: string
  service: ServiceType
  message: string
  time: string
}

const runtime = useRuntimeConfig()
const publicConfig = runtime.public as Record<string, unknown>
const complaints = useComplaints()

function publicString(key: string, fallback = '') {
  const value = publicConfig[key]
  return String(value ?? fallback).trim() || fallback
}

const tenantName = computed(() => {
  const clientDisplayName = publicString('clientDisplayName', '')
  const clientName = publicString('clientName', 'martopuro')

  if (clientDisplayName) return clientDisplayName

  return clientName
    .replace(/[-_]+/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase())
})

const tenantSlug = computed(() => {
  return publicString('clientName', 'martopuro')
    .toLowerCase()
    .replace(/[^a-z0-9-]+/g, '-')
    .replace(/^-+|-+$/g, '') || 'martopuro'
})

const modalOpen = ref(false)
const formError = ref('')
const formSuccess = ref(false)
const submitting = ref(false)
const loadingReports = ref(false)
const serverReports = ref<ReportItem[]>([])

const form = reactive({
  name: '',
  email: '',
  service: 'Aduan' as ServiceType,
  message: ''
})

const dummyReports = ref<ReportItem[]>([
  {
    id: 'report-001',
    name: 'Nadia Putri',
    email: 'nadia.putri@email.com',
    service: 'Laporan',
    message: 'Lampu penerangan jalan di sekitar gang belakang balai desa mati sejak dua malam terakhir.',
    time: '8 menit lalu'
  },
  {
    id: 'report-002',
    name: 'Bima Santoso',
    email: 'bima.santoso@email.com',
    service: 'Aduan',
    message: 'Ada saluran air yang tersumbat dan mulai meluap saat hujan deras di wilayah RT 03.',
    time: '18 menit lalu'
  },
  {
    id: 'report-003',
    name: 'Rara Anindya',
    email: 'rara.anindya@email.com',
    service: 'Pengajuan',
    message: 'Saya ingin mengajukan surat pengantar domisili untuk keperluan administrasi kampus.',
    time: '31 menit lalu'
  },
  {
    id: 'report-004',
    name: 'Fahmi Ramadhan',
    email: 'fahmi.ramadhan@email.com',
    service: 'Laporan',
    message: 'Jalan paving di dekat pos ronda mulai ambles dan cukup berbahaya untuk pengendara motor.',
    time: '46 menit lalu'
  },
  {
    id: 'report-005',
    name: 'Siti Lestari',
    email: 'siti.lestari@email.com',
    service: 'Aduan',
    message: 'Mohon pengecekan jadwal pengangkutan sampah karena beberapa hari ini belum terangkut.',
    time: '1 jam lalu'
  },
  {
    id: 'report-006',
    name: 'Arif Maulana',
    email: 'arif.maulana@email.com',
    service: 'Pengajuan',
    message: 'Mengajukan informasi prosedur surat keterangan usaha untuk UMKM rumahan.',
    time: '2 jam lalu'
  },
  {
    id: 'report-007',
    name: 'Dewi Kurnia',
    email: 'dewi.kurnia@email.com',
    service: 'Laporan',
    message: 'Ada pohon miring di dekat jalan utama dusun dan perlu dicek sebelum musim hujan.',
    time: '3 jam lalu'
  },
  {
    id: 'report-008',
    name: 'Rizky Aditya',
    email: 'rizky.aditya@email.com',
    service: 'Aduan',
    message: 'Suara bising dari proyek sekitar rumah berlangsung sampai malam, mohon arahan tindak lanjut.',
    time: '4 jam lalu'
  }
])

const visibleReports = computed(() => {
  const source = serverReports.value.length ? serverReports.value : dummyReports.value
  return [...source, ...source]
})

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
  loadComplaints()
})

onBeforeUnmount(() => {
  document.removeEventListener('keydown', handleKeydown)
})

function openModal() {
  modalOpen.value = true
}

function closeModal() {
  modalOpen.value = false
}

function handleKeydown(event: KeyboardEvent) {
  if (event.key === 'Escape' && modalOpen.value) {
    closeModal()
  }
}

async function loadComplaints() {
  loadingReports.value = true

  try {
    const response = await complaints.listComplaints({
      tenantSlug: tenantSlug.value,
      limit: 20,
      sort: 'newest'
    })

    serverReports.value = response.data.map(mapComplaintToReport)
  } catch {
    serverReports.value = []
  } finally {
    loadingReports.value = false
  }
}

async function submitForm() {
  formError.value = ''
  formSuccess.value = false

  const validationMessage = validateForm()

  if (validationMessage) {
    formError.value = validationMessage
    return
  }

  submitting.value = true

  try {
    const created = await complaints.createComplaint(tenantSlug.value, {
      name: form.name,
      email: form.email,
      service: form.service,
      message: form.message
    })

    const newReport = mapComplaintToReport(created)

    serverReports.value = [newReport, ...serverReports.value]
    dummyReports.value = [newReport, ...dummyReports.value]
    resetForm()
    formSuccess.value = true

    window.setTimeout(() => {
      formSuccess.value = false
    }, 1800)
  } catch (error) {
    formError.value = getErrorMessage(error, 'Pesan belum bisa dikirim. Coba beberapa saat lagi.')
  } finally {
    submitting.value = false
  }
}

function validateForm() {
  if (!form.name.trim()) return 'Nama wajib diisi.'
  if (!form.email.trim()) return 'Email wajib diisi.'
  if (!isValidEmail(form.email)) return 'Format email belum valid.'
  if (!form.service) return 'Pilih jenis layanan.'
  if (!form.message.trim()) return 'Pesan wajib diisi.'
  if (form.message.trim().length < 8) return 'Pesan terlalu singkat, tuliskan detail yang lebih jelas.'

  return ''
}

function resetForm() {
  form.name = ''
  form.email = ''
  form.service = 'Aduan'
  form.message = ''
  formError.value = ''
}

function isValidEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())
}

function getInitials(value: string) {
  const words = String(value || 'Warga')
    .trim()
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)

  return words.map((word) => word.charAt(0).toUpperCase()).join('') || 'W'
}

function serviceBadgeClass(service: ServiceType) {
  if (service === 'Aduan') return 'bg-red-50 text-red-600 ring-1 ring-red-100'
  if (service === 'Pengajuan') return 'bg-amber-50 text-amber-700 ring-1 ring-amber-100'

  return 'bg-blue-50 text-blue-700 ring-1 ring-blue-100'
}

function serviceAvatarClass(service: ServiceType) {
  if (service === 'Aduan') return 'bg-red-50 text-red-600 ring-1 ring-red-100'
  if (service === 'Pengajuan') return 'bg-amber-50 text-amber-700 ring-1 ring-amber-100'

  return 'bg-blue-50 text-blue-700 ring-1 ring-blue-100'
}

function mapComplaintToReport(item: ComplaintItem): ReportItem {
  return {
    id: item.id,
    name: item.reporterName || item.name || 'Warga',
    email: item.reporterEmail || item.email || '-',
    service: toServiceType(item.serviceType || item.serviceLabel),
    message: item.message,
    time: formatRelativeTime(item.createdAt)
  }
}

function toServiceType(value: unknown): ServiceType {
  const text = String(value || '').toLowerCase()

  if (text.includes('laporan')) return 'Laporan'
  if (text.includes('pengajuan')) return 'Pengajuan'

  return 'Aduan'
}

function formatRelativeTime(value: unknown) {
  const time = typeof value === 'number'
    ? value
    : new Date(String(value || '')).getTime()

  if (!time || Number.isNaN(time)) return 'baru saja'

  const diff = Date.now() - time
  const minute = 60 * 1000
  const hour = 60 * minute
  const day = 24 * hour

  if (diff < minute) return 'baru saja'
  if (diff < hour) return `${Math.floor(diff / minute)} menit lalu`
  if (diff < day) return `${Math.floor(diff / hour)} jam lalu`

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(new Date(time))
}

function getErrorMessage(error: unknown, fallback: string) {
  if (!error || typeof error !== 'object') return fallback

  const payload = error as Record<string, any>
  const data = payload.data && typeof payload.data === 'object'
    ? payload.data as Record<string, any>
    : {}

  return String(data.statusMessage || data.message || payload.statusMessage || payload.message || fallback)
}

</script>

<style scoped>
.bg-size-\[38px_38px\] {
  background-size: 38px 38px;
}

.marquee-column {
  animation: report-marquee 26s linear infinite;
}

.marquee-column:hover {
  animation-play-state: paused;
}

.report-card {
  transform: skewY(-1.4deg);
}

.report-card:hover {
  transform: skewY(0deg) translateY(-2px);
}

.form-control {
  display: block;
  height: 3rem;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding-left: 1rem;
  padding-right: 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: rgb(38 38 38);
  outline: none;
  transition: 180ms ease;
}

.form-control::placeholder {
  color: rgb(163 163 163);
}

.form-control:focus {
  border-color: rgb(59 130 246);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.form-textarea {
  display: block;
  width: 100%;
  resize: none;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.85rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  line-height: 1.75;
  color: rgb(38 38 38);
  outline: none;
  transition: 180ms ease;
}

.form-textarea::placeholder {
  color: rgb(163 163 163);
}

.form-textarea:focus {
  border-color: rgb(59 130 246);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

@keyframes report-marquee {
  0% {
    transform: translateY(0);
  }

  100% {
    transform: translateY(-50%);
  }
}
</style>
