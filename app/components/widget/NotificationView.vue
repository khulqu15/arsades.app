<template>
  <div class="h-full flex flex-col">
      <div ref="headerEl"
      class="sticky top-0 z-10 border-b border-gray-200 dark:border-neutral-700
             bg-white/85 dark:bg-neutral-800/85 backdrop-blur supports-[backdrop-filter]:bg-white/60
             p-3 space-y-2"
    >
      <div class="flex items-center justify-between gap-2">
        <h3 class="font-semibold text-gray-800 dark:text-neutral-100">Notifikasi</h3>
        <div class="flex items-center gap-2">
          <button @click="markAllRead" class="text-xs px-2 py-1 rounded border border-gray-200 dark:border-neutral-600 hover:bg-gray-50 dark:hover:bg-neutral-700">Tandai semua</button>
          <button @click="clearAll" class="text-xs px-2 py-1 rounded border border-gray-200 dark:border-neutral-600 hover:bg-gray-50 dark:hover:bg-neutral-700">Bersihkan</button>
        </div>
      </div>

      <div class="flex flex-col gap-2">
        <div class="flex items-center gap-1 overflow-x-auto no-scrollbar -mx-1 px-1">
          <select
            v-model="activeCategory"
            class="px-2.5 py-1.5 text-xs rounded-md border border-gray-200 bg-white w-full shadow-xs
                   dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-200"
          >
            <option v-for="c in categories" :key="c.key" :value="c.key">{{ c.label }}</option>
          </select>
        </div>

        <div class="flex items-center gap-2">
          <select
            v-model="active"
            class="px-2.5 py-1.5 text-xs rounded-md border border-gray-200 bg-white shadow-xs
                   dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-200"
            title="Filter status"
          >
            <option value="all">Semua</option>
            <option value="unread">Belum dibaca</option>
          </select>

          <div class="relative grow">
            <input
              v-model="query"
              type="search"
              placeholder="Cari judul / pesan…"
              class="pl-8 pr-8 py-1.5 text-xs rounded-md border border-gray-200 bg-white shadow-xs w-full
                     focus:outline-none focus:ring-2 focus:ring-blue-500/30
                     dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-200"
            />
            <Icon icon="lucide:search" class="absolute left-2.5 top-1/2 -translate-y-1/2 size-4 text-gray-400" />
            <button
              v-if="query"
              @click="query=''"
              class="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
              title="Bersihkan"
            >
              <Icon icon="lucide:x" class="size-4" />
            </button>
          </div>
        </div>
      </div>
    </div>

    <div
      ref="listWrap"
      class="p-3 overflow-y-auto max-h-[60vh]"
      :style="listStyle"
    >
      <ul class="space-y-2">
        <li v-for="n in visible" :key="n.id"
            class="rounded-lg border p-3 flex items-start gap-3 cursor-pointer hover:bg-gray-50 dark:hover:bg-neutral-800"
            :class="[ 'border-gray-200 dark:border-neutral-700', !n.read ? 'bg-gray-100/40 dark:bg-gray-900/10' : 'bg-white dark:bg-neutral-800']"
            @click="open(n)">
          <div class="mt-1">
            <Icon :icon="n.icon" width="16" height="16" :class="n.color" />
          </div>
          <div class="min-w-0 w-full">
            <div class="flex items-center gap-2">
              <p class="font-medium text-sm text-gray-800 dark:text-neutral-100 truncate">{{ n.title }}</p>
              <span v-if="!n.read" class="inline-block w-2 h-2 rounded-full bg-blue-500"></span>
              <span class="ml-auto text-[11px] text-gray-500 dark:text-neutral-400">{{ n.time }}</span>
            </div>
            <p v-if="n.message" class="text-xs text-gray-600 dark:text-neutral-300 mt-0.5 line-clamp-2">{{ n.message }}</p>
          </div>
        </li>

        <!-- skeleton -->
        <li v-if="isInitialLoading" class="space-y-2">
          <div v-for="i in 3" :key="'s-'+i" class="animate-pulse rounded-lg border border-gray-200 dark:border-neutral-700 p-3">
            <div class="h-3 w-1/3 bg-gray-200 dark:bg-neutral-700 rounded mb-2"></div>
            <div class="h-3 w-2/3 bg-gray-200 dark:bg-neutral-700 rounded"></div>
          </div>
        </li>

        <li v-if="!isInitialLoading && !filtered.length" class="text-sm text-gray-500 dark:text-neutral-400 py-6 text-center">
          Tidak ada notifikasi.
        </li>
      </ul>

      <!-- sentinel lazyload -->
      <div ref="sentinel" class="h-8"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount, watch, watchEffect } from 'vue'
import { Icon } from '@iconify/vue'

/* ===== IMPORT composables ===== */
import { useAbsensi } from '~/composables/data/useAbsensi'
import { useAnnouncements } from '~/composables/data/useAnnouncements'
import { useFaults } from '~/composables/data/useFaults'
import { useIzin } from '~/composables/data/useIzin'
import { useKunjungan } from '~/composables/data/useKunjungan'
import { useMaskan } from '~/composables/data/useMaskan'
import { useNews } from '~/composables/data/useNews'
import { usePiket } from '~/composables/data/usePiket'
import { useRFID } from '~/composables/data/useRfid'
import { useSantri } from '~/composables/data/useSantri'
import { useWali } from '~/composables/data/useWali'

/* ===== MENU MAP (ikon + warna + href) ===== */
const menuMap = {
  absensi:     { href: '/app/absen',        icon: 'hugeicons:note-03',                                            color: 'text-blue-600',    label: 'Absensi' },
  announcement:{ href: '/app/announcement', icon: 'lucide:info',                                                   color: 'text-emerald-600', label: 'Pengumuman' },
  faults:      { href: '/app/faults',       icon: 'mingcute:fault-line',                                          color: 'text-rose-600',    label: 'Pelanggaran' },
  izin:        { href: '/app/izin',         icon: 'solar:letter-linear',                                          color: 'text-amber-600',   label: 'Perizinan' },
  kunjungan:   { href: '/app/kunjungan',    icon: 'material-symbols:parent-child-dining-outline-rounded',         color: 'text-purple-600',  label: 'Kunjungan' },
  santri:      { href: '/app/santri',       icon: 'lucide:users',                                                 color: 'text-blue-500',    label: 'Data Santri' },
  wali:        { href: '/app/wali',         icon: 'lucide:user-round',                                            color: 'text-cyan-500',    label: 'Wali' },
  maskan:      { href: '/app/maskan',       icon: 'lucide:bed',                                                   color: 'text-indigo-500',  label: 'Asrama/Kamar' },
  piket:       { href: '/app/picket',       icon: 'lucide:calendar-days',                                         color: 'text-fuchsia-500', label: 'Jadwal Piket' },
  rfid:        { href: '/app/setting-rfid', icon: 'ri:rfid-fill',                                                 color: 'text-green-600',   label: 'Registrasi RFID' },
  news:        { href: '/app/news',         icon: 'hugeicons:news',                                               color: 'text-sky-600',     label: 'Informasi' },
} as const

type NotifType = keyof typeof menuMap
type NotifItem = {
  id: string
  type: NotifType
  title: string
  message?: string
  href: string
  icon: string
  color: string
  timestamp: number
  time: string
  read: boolean
}

const notifications = ref<NotifItem[]>([])
const isInitialLoading = ref(true)

const headerEl = ref<HTMLElement | null>(null)
const headerH = ref(0)

const norm = (s?: string) => (s || '').toLowerCase().normalize('NFKD').replace(/\s+/g, ' ').trim()
const fmtTime = (ts: number) => { try { return new Date(ts).toLocaleString() } catch { return '' } }
const pickId = (x: any) => x?.id ?? x?._id ?? x?.key ?? `${Date.now()}-${Math.random().toString(36).slice(2)}`
const pickTs = (x: any) => {
  const v = x?.timestamp ?? x?.createdAt ?? x?.created_at ?? x?.time
  const n = Number(v)
  return Number.isFinite(n) ? n : Date.now()
}
const truncate = (s?: string, n = 140) => {
  const str = String(s ?? '')
  return str.length > n ? str.slice(0, n - 1) + '…' : str
}
function upsertNotifs(incoming: NotifItem[]) {
  const map = new Map<string, NotifItem>()
  for (const n of notifications.value) map.set(n.id, n)
  for (const n of incoming) map.set(n.id, n)
  const arr = Array.from(map.values())
  arr.sort((a, b) => b.timestamp - a.timestamp) // comparator valid
  notifications.value = arr
}

/* ===== Sources ===== */
const absensi = useAbsensi()
const announcements = useAnnouncements()
const faults = useFaults()
const izin = useIzin()
const kunjungan = useKunjungan()
const maskan = useMaskan()
const news = useNews()
const piket = usePiket()
const rfid = useRFID()
const santri = useSantri()
const wali = useWali()

function measureHeader() {
  headerH.value = headerEl.value?.offsetHeight ?? 0
}

function mapAbsensiLive(): NotifItem[] {
  const meta = menuMap.absensi
  const arr = Array.isArray(absensi.live?.value) ? absensi.live.value : []
  return arr.map((x: any) => ({
    id: `absensi-${pickId(x)}`,
    type: 'absensi',
    title: x?.title ?? 'Absensi Terekam',
    message: truncate(x?.message ?? x?.santri ?? x?.desc),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: false
  }))
}
function mapAnnouncements(): NotifItem[] {
  const meta = menuMap.announcement
  const rows = Array.isArray(announcements.rows?.value) ? announcements.rows.value : []
  return rows.map((x: any) => ({
    id: `announcement-${pickId(x)}`,
    type: 'announcement',
    title: x?.title ?? 'Pengumuman',
    message: truncate(x?.message ?? x?.content),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapFaults(): NotifItem[] {
  const meta = menuMap.faults
  const rows = Array.isArray(faults.rows?.value) ? faults.rows.value : []
  return rows.map((x: any) => ({
    id: `fault-${pickId(x)}`,
    type: 'faults',
    title: x?.title ?? x?.kategori ?? 'Pelanggaran',
    message: truncate(x?.deskripsi ?? x?.message),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapIzinLive(): NotifItem[] {
  const meta = menuMap.izin
  const arr = Array.isArray(izin.live?.value) ? izin.live.value : []
  return arr.map((x: any) => ({
    id: `izin-${pickId(x)}`,
    type: 'izin',
    title: x?.title ?? `Perizinan ${x?.status ?? ''}`.trim(),
    message: truncate(x?.alasan ?? x?.message),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapKunjunganLive(): NotifItem[] {
  const meta = menuMap.kunjungan
  const arr = Array.isArray(kunjungan.live?.value) ? kunjungan.live.value : []
  return arr.map((x: any) => ({
    id: `kunjungan-${pickId(x)}`,
    type: 'kunjungan',
    title: x?.title ?? 'Kunjungan',
    message: truncate(x?.visitor ?? x?.message),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapMaskan(): NotifItem[] {
  const meta = menuMap.maskan
  const rows = Array.isArray(maskan.rows?.value) ? maskan.rows.value : []
  return rows.map((x: any) => ({
    id: `maskan-${pickId(x)}`,
    type: 'maskan',
    title: x?.title ?? `Asrama/Kamar: ${x?.nama ?? x?.room ?? ''}`.trim(),
    message: truncate(x?.deskripsi ?? x?.message),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapNews(): NotifItem[] {
  const meta = menuMap.news
  const items = Array.isArray(news.items?.value) ? news.items.value : []
  return items.map((x: any) => ({
    id: `news-${pickId(x)}`,
    type: 'news',
    title: x?.title ?? 'Informasi',
    message: truncate(x?.excerpt ?? x?.message),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapPiket(): NotifItem[] {
  const meta = menuMap.piket
  const data = piket.data?.value ?? {}
  return Object.entries<any>(data).map(([key, val]) => ({
    id: `piket-${key}`,
    type: 'piket',
    title: `Jadwal Piket ${key.toUpperCase?.() ?? key}`,
    message: truncate((val?.members || []).join(', ')),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: Number(val?.timestamp ?? Date.now()), time: fmtTime(Number(val?.timestamp ?? Date.now())), read: false
  }))
}
function mapRfidEvents(): NotifItem[] {
  const meta = menuMap.rfid
  const lt = rfid.lastTap?.value
  return lt ? [{
    id: `rfid-lastTap-${pickId(lt)}`,
    type: 'rfid',
    title: 'RFID Tap Terdeteksi',
    message: truncate(`${lt?.cardId ?? ''} • ${lt?.santri ?? ''}`.trim()),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(lt), time: fmtTime(pickTs(lt)), read: false
  }] : []
}
function mapSantri(): NotifItem[] {
  const meta = menuMap.santri
  const rows = Array.isArray(santri.rows?.value) ? santri.rows.value : []
  return rows.map((x: any) => ({
    id: `santri-${pickId(x)}`,
    type: 'santri',
    title: x?.nama ? `Santri: ${x?.nama}` : 'Data Santri',
    message: truncate(x?.kelas ?? x?.maskan ?? x?.kamar),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}
function mapWali(): NotifItem[] {
  const meta = menuMap.wali
  const rows = Array.isArray(wali.rows?.value) ? wali.rows.value : []
  return rows.map((x: any) => ({
    id: `wali-${pickId(x)}`,
    type: 'wali',
    title: x?.nama ? `Wali: ${x?.nama}` : 'Data Wali',
    message: truncate(x?.nohp ?? x?.alamat),
    href: meta.href, icon: meta.icon, color: meta.color,
    timestamp: pickTs(x), time: fmtTime(pickTs(x)), read: !!x?.read
  }))
}

/* ===== Subscriptions + initial fetch ===== */
let ro: ResizeObserver | null = null
onMounted(async () => {
  try { absensi.subscribeLive?.() } catch {}
  try { announcements.subscribeAnnouncements?.() } catch {}
  try { faults.subscribeFaults?.() } catch {}
  try { izin.subscribeLive?.() } catch {}
  try { kunjungan.subscribeLive?.() } catch {}
  try { santri.subscribeSantri?.() } catch {}

  try { await maskan.fetchMaskan?.() } catch {}
  try { await news.loadNews?.() } catch {}
  try { await piket.fetchPiket?.() } catch {}
  try { await rfid.fetchBindings?.() } catch {}
  try { await wali.fetchWali?.() } catch {}

  upsertNotifs([
    ...mapAbsensiLive(),
    ...mapAnnouncements(),
    ...mapFaults(),
    ...mapIzinLive(),
    ...mapKunjunganLive(),
    ...mapSantri(),
    ...mapWali(),
    ...mapMaskan(),
    ...mapPiket(),
    ...mapNews(),
    ...mapRfidEvents(),
  ])
  isInitialLoading.value = false
  measureHeader()
  ro = new ResizeObserver(measureHeader)
  if (headerEl.value) ro.observe(headerEl.value)
  window.addEventListener('resize', measureHeader)
})

watchEffect(() => upsertNotifs(mapAbsensiLive()))
watch(() => announcements.rows?.value, () => upsertNotifs(mapAnnouncements()), { deep: true })
watch(() => faults.rows?.value,        () => upsertNotifs(mapFaults()),       { deep: true })
watch(() => izin.live?.value,          () => upsertNotifs(mapIzinLive()),     { deep: true })
watch(() => kunjungan.live?.value,     () => upsertNotifs(mapKunjunganLive()),{ deep: true })
watch(() => santri.rows?.value,        () => upsertNotifs(mapSantri()),       { deep: true })
watch(() => wali.rows?.value,          () => upsertNotifs(mapWali()),         { deep: true })
watch(() => maskan.rows?.value,        () => upsertNotifs(mapMaskan()),       { deep: true })
watch(() => piket.data?.value,         () => upsertNotifs(mapPiket()),        { deep: true })
watch(() => news.items?.value,         () => upsertNotifs(mapNews()),         { deep: true })
watch(() => rfid.lastTap?.value,       () => upsertNotifs(mapRfidEvents()),   { deep: true })

onBeforeUnmount(() => {
  announcements.unsubscribeAnnouncements?.()
  faults.unsubscribeFaults?.()
  santri.unsubscribeSantri?.()
  if (ro && headerEl.value) ro.unobserve(headerEl.value)
  ro = null
  window.removeEventListener('resize', measureHeader)
})

/* ===== Actions ===== */
function open(n: NotifItem) {
  n.read = true
  navigateTo(n.href)
}
function markAllRead() {
  notifications.value = notifications.value.map(n => ({ ...n, read: true }))
}
function clearAll() {
  notifications.value = []
}

const NAV = 0 /* px, atau 52 kalau perlu */
const listStyle = computed(() => ({
  minHeight: `calc(100dvh - ${NAV}px - ${headerH.value}px)`,
}))

const active = ref<'all' | 'unread'>('all')
const query = ref('')

const categories = [
  { key: 'all',        label: 'Semua',        types: Object.keys(menuMap) as NotifType[] },
  { key: 'rutinitas',  label: 'Rutinitas',    types: ['absensi','piket'] as NotifType[] },
  { key: 'perizinan',  label: 'Perizinan',    types: ['izin','kunjungan'] as NotifType[] },
  { key: 'kedis',      label: 'Kedisiplinan', types: ['faults'] as NotifType[] },
  { key: 'informasi',  label: 'Informasi',    types: ['announcement','news'] as NotifType[] },
  { key: 'data',       label: 'Data Master',  types: ['santri','wali','maskan'] as NotifType[] },
  { key: 'perangkat',  label: 'Perangkat',    types: ['rfid'] as NotifType[] },
] as const
type CategoryKey = typeof categories[number]['key']
const activeCategory = ref<CategoryKey>('all')

const filtered = computed<NotifItem[]>(() => {
  const q = norm(query.value)
  const allowedTypes = categories.find(c => c.key === activeCategory.value)?.types ?? []
  let base = notifications.value.filter(n => allowedTypes.includes(n.type))
  if (active.value === 'unread') base = base.filter(i => !i.read)
  if (q) base = base.filter(i => norm(i.title).includes(q) || norm(i.message).includes(q))
  return base
})

const pageStep = 20
const take = ref(pageStep)
const visible = computed(() => filtered.value.slice(0, take.value))
const sentinel = ref<HTMLElement | null>(null)
let observer: IntersectionObserver | null = null

function onIntersect(entries: IntersectionObserverEntry[]) {
  const [entry] = entries
  if (entry!.isIntersecting && take.value < filtered.value.length) {
    take.value = Math.min(take.value + pageStep, filtered.value.length)
  }
}

watch(filtered, () => {
  take.value = Math.min(pageStep, filtered.value.length)
})

onMounted(() => {
  observer = new IntersectionObserver(onIntersect, { root: null, threshold: 0.1 })
  if (sentinel.value) observer.observe(sentinel.value)
})
onBeforeUnmount(() => {
  if (observer && sentinel.value) observer.unobserve(sentinel.value)
  observer = null
})
</script>

<style scoped>
.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
</style>
