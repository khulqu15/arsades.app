<template>
  <section
    id="kontak"
    ref="wrapEl"
    aria-label="Kontak Desa Martopuro"
    class="relative isolate overflow-hidden bg-slate-50 py-20 text-slate-950 sm:py-24"
  >
    <!-- Background -->
    <div class="pointer-events-none absolute inset-0 -z-10">
      <div class="absolute inset-0 bg-[linear-linear(to_right,#e2e8f0_1px,transparent_1px),linear-linear(to_bottom,#e2e8f0_1px,transparent_1px)] bg-size-[44px_44px] opacity-45"></div>
      <div
        ref="bg1"
        class="absolute -left-40 top-0 h-[520px] w-[520px] rounded-full bg-blue-200/45 blur-3xl will-change-transform"
      ></div>
      <div
        ref="bg2"
        class="absolute -right-40 bottom-0 h-[520px] w-[520px] rounded-full bg-cyan-200/55 blur-3xl will-change-transform"
      ></div>
      <div class="absolute left-1/2 top-1/2 h-[360px] w-[360px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-white/80 blur-3xl"></div>
    </div>

    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="mb-10 flex flex-col gap-5 md:flex-row md:items-end md:justify-between">
        <div>
          <div class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.16em] text-blue-700">
            <ClientOnly>
              <Icon icon="lucide:map-pin" class="h-4 w-4" />
            </ClientOnly>
            Kontak Resmi Desa
          </div>

          <h2 class="mt-4 max-w-3xl text-3xl font-black tracking-tight text-slate-950 sm:text-4xl lg:text-5xl">
            Hubungi Pemerintah Desa Martopuro
          </h2>

          <p class="mt-4 max-w-2xl text-base leading-8 text-slate-600">
            Gunakan kanal resmi berikut untuk kebutuhan layanan administrasi, informasi desa,
            agenda kegiatan, dan komunikasi dengan perangkat desa.
          </p>
        </div>

        <a
          :href="directionsHref"
          target="_blank"
          rel="noopener"
          class="group inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white/85 px-4 text-sm font-black text-slate-700 shadow-sm backdrop-blur-xl transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
        >
          Petunjuk Arah
          <ClientOnly>
            <Icon icon="lucide:arrow-up-right" class="h-4 w-4 transition group-hover:translate-x-0.5 group-hover:-translate-y-0.5" />
          </ClientOnly>
        </a>
      </div>

      <div class="grid gap-6 lg:grid-cols-[0.92fr_1.08fr]">
        <!-- Left Info -->
        <div class="space-y-5">
          <!-- Office summary -->
          <article class="overflow-hidden rounded-4xl border border-slate-200 bg-white/85 p-5 shadow-sm backdrop-blur-2xl sm:p-6">
            <div class="flex items-start gap-4">
              <div class="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <ClientOnly>
                  <Icon icon="lucide:landmark" class="h-6 w-6" />
                </ClientOnly>
              </div>

              <div class="min-w-0">
                <p class="text-lg font-black text-slate-950">
                  {{ officeName }}
                </p>
                <p class="mt-1 text-sm leading-6 text-slate-500">
                  {{ officeSubtitle }}
                </p>

                <div class="mt-4 flex flex-wrap gap-2">
                  <span
                    v-for="badge in badges"
                    :key="badge"
                    class="rounded-full border border-blue-100 bg-blue-50 px-3 py-1 text-xs font-black text-blue-700"
                  >
                    {{ badge }}
                  </span>
                </div>
              </div>
            </div>
          </article>

          <!-- Contact cards -->
          <div class="grid gap-4 sm:grid-cols-2">
            <article
              v-for="item in contactCards"
              :key="item.label"
              class="group rounded-[1.75rem] border border-slate-200 bg-white/80 p-5 shadow-sm backdrop-blur-2xl transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
            >
              <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
                  <ClientOnly>
                    <Icon :icon="item.icon" class="h-5 w-5" />
                  </ClientOnly>
                </div>

                <div class="min-w-0">
                  <p class="text-sm font-black text-slate-950">
                    {{ item.label }}
                  </p>
                  <p class="mt-1 line-clamp-3 text-sm leading-6 text-slate-500">
                    {{ item.value }}
                  </p>

                  <div class="mt-3 flex flex-wrap gap-2">
                    <a
                      v-if="item.href"
                      :href="item.href"
                      :target="item.external ? '_blank' : undefined"
                      :rel="item.external ? 'noopener' : undefined"
                      class="inline-flex h-8 items-center gap-1.5 rounded-xl border border-slate-200 bg-white px-3 text-xs font-black text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                    >
                      <ClientOnly>
                        <Icon :icon="item.actionIcon" class="h-3.5 w-3.5" />
                      </ClientOnly>
                      {{ item.actionLabel }}
                    </a>

                    <button
                      type="button"
                      class="inline-flex h-8 items-center gap-1.5 rounded-xl border border-slate-200 bg-white px-3 text-xs font-black text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                      @click="copy(item.value)"
                    >
                      <ClientOnly>
                        <Icon icon="lucide:copy" class="h-3.5 w-3.5" />
                      </ClientOnly>
                      Salin
                    </button>
                  </div>
                </div>
              </div>
            </article>
          </div>

          <Transition
            enter-active-class="transition duration-200 ease-out"
            enter-from-class="opacity-0 translate-y-1"
            enter-to-class="opacity-100 translate-y-0"
            leave-active-class="transition duration-150 ease-in"
            leave-from-class="opacity-100 translate-y-0"
            leave-to-class="opacity-0 translate-y-1"
          >
            <div
              v-if="feedback"
              class="rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm font-bold text-emerald-700"
            >
              {{ feedback }}
            </div>
          </Transition>
        </div>

        <!-- Right Map -->
        <div>
          <div
            ref="mapCard"
            class="relative min-h-[520px] overflow-hidden rounded-4xl border border-slate-200 bg-white shadow-[0_30px_90px_-50px_rgba(15,23,42,0.6)] will-change-transform"
          >
            <div class="absolute left-4 top-4 z-20 inline-flex items-center gap-2 rounded-full border border-white/20 bg-slate-950/55 px-3 py-1.5 text-xs font-black text-white shadow-lg backdrop-blur-xl">
              <ClientOnly>
                <Icon icon="lucide:map" class="h-4 w-4" />
              </ClientOnly>
              Lokasi Kantor Desa Martopuro
            </div>

            <ClientOnly>
              <iframe
                class="absolute inset-0 h-full w-full"
                style="border: 0"
                loading="lazy"
                allowfullscreen
                referrerpolicy="no-referrer-when-downgrade"
                :src="mapSrc"
              />
            </ClientOnly>

            <div class="pointer-events-none absolute inset-0 bg-linear-to-t from-slate-950/30 via-transparent to-transparent"></div>

            <!-- Floating card -->
            <div class="absolute bottom-4 left-4 right-4 z-20 rounded-3xl border border-white/20 bg-white/92 p-4 shadow-2xl shadow-slate-900/15 backdrop-blur-2xl sm:left-auto sm:w-[360px]">
              <div class="flex items-start gap-3">
                <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                  <ClientOnly>
                    <Icon icon="lucide:navigation" class="h-5 w-5" />
                  </ClientOnly>
                </div>

                <div class="min-w-0">
                  <p class="text-sm font-black text-slate-950">
                    {{ officeName }}
                  </p>
                  <p class="mt-1 line-clamp-2 text-xs leading-5 text-slate-500">
                    {{ address }}
                  </p>

                  <div class="mt-3 flex flex-wrap gap-2">
                    <a
                      :href="directionsHref"
                      target="_blank"
                      rel="noopener"
                      class="inline-flex h-9 items-center gap-2 rounded-xl bg-blue-600 px-3 text-xs font-black text-white transition hover:bg-blue-700"
                    >
                      <ClientOnly>
                        <Icon icon="lucide:navigation" class="h-3.5 w-3.5" />
                      </ClientOnly>
                      Buka Maps
                    </a>

                    <button
                      type="button"
                      class="inline-flex h-9 items-center gap-2 rounded-xl border border-slate-200 bg-white px-3 text-xs font-black text-slate-600 transition hover:bg-blue-50 hover:text-blue-700"
                      @click="copy(address)"
                    >
                      <ClientOnly>
                        <Icon icon="lucide:copy" class="h-3.5 w-3.5" />
                      </ClientOnly>
                      Salin Alamat
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Quick actions -->
          <div class="mt-4 grid gap-3 sm:grid-cols-3">
            <a
              v-for="action in quickActions"
              :key="action.label"
              :href="action.href"
              :target="action.external ? '_blank' : undefined"
              :rel="action.external ? 'noopener' : undefined"
              class="group inline-flex items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white/80 px-4 py-3 text-sm font-black text-slate-700 shadow-sm backdrop-blur-xl transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            >
              <ClientOnly>
                <Icon :icon="action.icon" class="h-4 w-4 transition group-hover:scale-110" />
              </ClientOnly>
              {{ action.label }}
            </a>
          </div>

                    <!-- Service hours -->
          <article class="rounded-4xl border mt-4 border-slate-200 bg-white/80 p-5 shadow-sm backdrop-blur-2xl sm:p-6">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-base font-black text-slate-950">
                  Jam Pelayanan Kantor Desa
                </p>
                <p class="mt-1 text-sm leading-6 text-slate-500">
                  Jadwal layanan dapat berubah mengikuti agenda resmi desa dan hari libur nasional.
                </p>
              </div>

              <div class="hidden h-12 w-12 shrink-0 place-items-center rounded-2xl bg-emerald-50 text-emerald-600 sm:grid">
                <ClientOnly>
                  <Icon icon="lucide:clock-3" class="h-5 w-5" />
                </ClientOnly>
              </div>
            </div>

            <div class="mt-5 grid gap-3 sm:grid-cols-2">
              <div
                v-for="hour in serviceHours"
                :key="hour.day"
                class="rounded-2xl border border-slate-100 bg-slate-50 p-4"
              >
                <p class="text-sm font-black text-slate-800">
                  {{ hour.day }}
                </p>
                <p class="mt-1 text-sm font-semibold text-slate-500">
                  {{ hour.time }}
                </p>
              </div>
            </div>
          </article>

        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import { Icon } from '@iconify/vue'
import { useRuntimeConfig } from 'nuxt/app'

type ContactHeroProps = {
  officeName?: string
  officeSubtitle?: string
  address?: string
  email?: string
  phone?: string
  waIntl?: string
  mapEmbedSrc?: string
  mapsQuery?: string
}

const props = defineProps<ContactHeroProps>()
const config = useRuntimeConfig()

const wrapEl = ref<HTMLElement | null>(null)
const bg1 = ref<HTMLElement | null>(null)
const bg2 = ref<HTMLElement | null>(null)
const mapCard = ref<HTMLElement | null>(null)
const feedback = ref('')

const officeName = computed(() => {
  return props.officeName || String(config.public.contactOfficeName || 'Kantor Desa Martopuro')
})

const officeSubtitle = computed(() => {
  return props.officeSubtitle || String(config.public.contactOfficeSubtitle || 'Pemerintah Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan')
})

const address = computed(() => {
  return props.address || String(config.public.contactAddress || 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur')
})

const email = computed(() => {
  return props.email || String(config.public.contactEmail || 'team.sencra@gmail.com')
})

const phone = computed(() => {
  return props.phone || String(config.public.contactPhone || '0343-591234')
})

const waIntl = computed(() => {
  return props.waIntl || String(config.public.waIntl || config.public.whatsappIntl || '089563836')
})

const mapsQuery = computed(() => {
  return props.mapsQuery || String(config.public.mapsQuery || address.value)
})

const mapSrc = computed(() => {
  if (props.mapEmbedSrc) return props.mapEmbedSrc

  const query = encodeURIComponent(mapsQuery.value)

  return `https://www.google.com/maps?q=${query}&output=embed`
})

const directionsHref = computed(() => {
  return `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(mapsQuery.value)}`
})

const badges = ['Pelayanan Publik', 'Informasi Desa', 'Administrasi Warga']

const serviceHours = [
  {
    day: 'Senin–Jumat',
    time: '08.00–15.00 WIB'
  },
  {
    day: 'Sabtu, Minggu & Libur Nasional',
    time: 'Menyesuaikan pengumuman resmi'
  }
]

const contactCards = computed(() => {
  const items = [
    {
      label: 'Alamat Kantor',
      value: address.value,
      icon: 'lucide:map-pin',
      href: directionsHref.value,
      actionLabel: 'Arah',
      actionIcon: 'lucide:navigation',
      external: true,
      show: true
    },
    {
      label: 'Email Resmi',
      value: email.value,
      icon: 'lucide:mail',
      href: email.value ? `mailto:${email.value}` : '',
      actionLabel: 'Email',
      actionIcon: 'lucide:send',
      external: false,
      show: Boolean(email.value)
    },
    {
      label: 'Telepon Kantor',
      value: phone.value,
      icon: 'lucide:phone-call',
      href: phone.value ? `tel:${phone.value}` : '',
      actionLabel: 'Panggil',
      actionIcon: 'lucide:phone',
      external: false,
      show: Boolean(phone.value)
    },
    {
      label: 'WhatsApp Layanan',
      value: waIntl.value ? `+${waIntl.value}` : '',
      icon: 'lucide:message-circle',
      href: waIntl.value ? `https://wa.me/${waIntl.value}` : '',
      actionLabel: 'Chat',
      actionIcon: 'lucide:message-circle',
      external: true,
      show: Boolean(waIntl.value)
    }
  ]

  return items.filter((item) => item.show)
})

const quickActions = computed(() => {
  const actions = [
    {
      label: 'Petunjuk Arah',
      href: directionsHref.value,
      icon: 'lucide:navigation',
      external: true,
      show: true
    },
    {
      label: 'Kirim Email',
      href: email.value ? `mailto:${email.value}` : '',
      icon: 'lucide:mail',
      external: false,
      show: Boolean(email.value)
    },
    {
      label: 'Chat WhatsApp',
      href: waIntl.value ? `https://wa.me/${waIntl.value}?text=${encodeURIComponent('Halo Admin Desa Martopuro, saya ingin bertanya terkait layanan desa.')}` : '',
      icon: 'lucide:message-circle',
      external: true,
      show: Boolean(waIntl.value)
    }
  ]

  return actions.filter((item) => item.show)
})

let raf = 0
let mx = 0.5
let my = 0.5
let scrollY = 0

function copy(value: string) {
  if (!value) return

  if (typeof navigator !== 'undefined' && navigator.clipboard) {
    navigator.clipboard.writeText(value)
    feedback.value = 'Data berhasil disalin.'
    window.setTimeout(() => {
      feedback.value = ''
    }, 1600)
  }
}

function handleMouseMove(event: MouseEvent) {
  if (!wrapEl.value) return

  const rect = wrapEl.value.getBoundingClientRect()
  mx = (event.clientX - rect.left) / rect.width
  my = (event.clientY - rect.top) / rect.height
}

function handleScroll() {
  scrollY = window.scrollY || 0
}

function loop() {
  const dx = mx - 0.5
  const dy = my - 0.5

  if (bg1.value) {
    bg1.value.style.transform = `translate3d(${dx * -24}px, ${dy * -20}px, 0) scale(1.05)`
  }

  if (bg2.value) {
    bg2.value.style.transform = `translate3d(${dx * 18}px, ${dy * 18}px, 0) scale(1.04)`
  }

  if (mapCard.value) {
    const tiltX = dy * 2.5
    const tiltY = dx * -2.5
    mapCard.value.style.transform = `translateY(${scrollY * -0.015}px) rotateX(${tiltX}deg) rotateY(${tiltY}deg)`
  }

  raf = requestAnimationFrame(loop)
}

onMounted(() => {
  if (typeof window === 'undefined') return

  window.addEventListener('mousemove', handleMouseMove, { passive: true })
  window.addEventListener('scroll', handleScroll, { passive: true })

  loop()
})

onBeforeUnmount(() => {
  if (typeof window !== 'undefined') {
    window.removeEventListener('mousemove', handleMouseMove)
    window.removeEventListener('scroll', handleScroll)
  }

  cancelAnimationFrame(raf)
})
</script>

<style scoped>
.bg-size-\[44px_44px\] {
  background-size: 44px 44px;
}
</style>