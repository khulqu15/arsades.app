<template>
  <main
    class="relative min-h-screen overflow-hidden bg-slate-50 text-slate-900"
    :style="themeVars"
  >
    <!-- Toast -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
        enter-to-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-to-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
      >
        <div
          v-if="toast.show"
          class="fixed right-4 top-4 z-[9999] w-[calc(100%-2rem)] max-w-sm"
        >
          <div
            class="rounded-3xl border bg-white/95 p-4 shadow-[0_24px_80px_rgba(15,23,42,0.16)] backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-emerald-200' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success'
                  ? 'bg-emerald-100 text-emerald-700'
                  : 'bg-red-100 text-red-700'"
              >
                <Icon
                  :icon="toast.type === 'success'
                    ? 'solar:check-circle-bold-duotone'
                    : 'solar:danger-circle-bold-duotone'"
                  class="h-6 w-6"
                />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-sm font-black text-slate-950">
                  {{ toast.title }}
                </p>
                <p class="mt-1 text-sm font-semibold leading-6 text-slate-500">
                  {{ toast.message }}
                </p>
              </div>

              <button
                type="button"
                class="grid h-8 w-8 shrink-0 place-items-center rounded-xl text-slate-400 transition hover:bg-slate-100 hover:text-slate-700"
                @click="closeToast"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Background Decoration -->
    <div class="pointer-events-none absolute inset-0">
      <div class="absolute -left-24 top-10 h-72 w-72 rounded-full bg-[var(--brand-soft)] blur-3xl"></div>
      <div class="absolute -right-24 bottom-10 h-80 w-80 rounded-full bg-[var(--brand-soft)] blur-3xl"></div>
      <div class="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-slate-200 to-transparent"></div>
    </div>

    <section class="relative mx-auto grid min-h-screen w-full max-w-7xl items-center gap-8 px-4 py-8 sm:px-6 lg:grid-cols-[1.05fr_0.95fr] lg:px-8">
      <!-- Left Content -->
      <aside class="hidden lg:block">
        <div class="relative overflow-hidden rounded-[2.25rem] border border-white/80 bg-white/80 p-8 shadow-[0_24px_80px_rgba(15,23,42,0.08)] backdrop-blur-xl">
          <div class="absolute right-6 top-6 rounded-full border border-slate-200 bg-white px-4 py-2 text-xs font-black uppercase tracking-[0.18em] text-slate-500">
            {{ profile.badge }}
          </div>

          <div class="grid h-16 w-16 place-items-center rounded-[1.35rem] text-white shadow-lg shadow-slate-200">
            <img
              v-if="profile.logo && !logoError"
              :src="profile.logo"
              :alt="profile.name"
              class="h-10 w-10 rounded-xl object-contain"
              @error="logoError = true"
            >
            <span v-else class="text-2xl font-black">
              {{ profile.initial }}
            </span>
          </div>

          <div class="mt-5">
            <p class="text-sm font-black uppercase tracking-[0.18em] text-[var(--brand)]">
              {{ profile.name }}
            </p>
            <h1 class="mt-2 text-3xl font-black tracking-tight text-slate-950">
              {{ profile.headline }}
            </h1>
          </div>

          <p class="mt-6 max-w-2xl text-base leading-8 text-slate-600">
            {{ profile.description }}
          </p>

        </div>
      </aside>

      <!-- Login Card -->
      <section class="mx-auto w-full max-w-md">
        <!-- Mobile Brand -->
        <div class="mb-6 flex items-center justify-between lg:hidden">
          <NuxtLink
            to="/"
            class="inline-flex items-center gap-3 rounded-2xl bg-white px-3 py-2 shadow-sm ring-1 ring-slate-200"
          >
            <div class="grid h-10 w-10 place-items-center rounded-xl text-white">
              <img
                v-if="profile.logo && !logoError"
                :src="profile.logo"
                :alt="profile.name"
                class="h-7 w-7 rounded-lg object-contain"
                @error="logoError = true"
              >
              <span v-else class="text-base font-black">
                {{ profile.initial }}
              </span>
            </div>

            <div>
              <p class="text-xs font-black uppercase tracking-[0.12em] text-[var(--brand)]">
                {{ profile.name }}
              </p>
              <p class="text-xs font-bold text-slate-500">
                {{ profile.mobileLabel }}
              </p>
            </div>
          </NuxtLink>
        </div>

        <div class="rounded-[2.25rem] border border-white/90 bg-white/90 p-6 shadow-[0_24px_80px_rgba(15,23,42,0.10)] backdrop-blur-xl sm:p-8">
          <div class="text-center">
            <NuxtLink
              to="/"
              class="mx-auto grid h-16 w-16 place-items-center rounded-[1.35rem] text-white shadow-lg shadow-slate-200 transition hover:scale-[1.03]"
            >
              <img
                v-if="profile.logo && !logoError"
                :src="profile.logo"
                :alt="profile.name"
                class="h-10 w-10 rounded-xl object-contain"
                @error="logoError = true"
              >
              <span v-else class="text-2xl font-black">
                {{ profile.initial }}
              </span>
            </NuxtLink>

            <p class="mt-5 text-xs font-black uppercase tracking-[0.18em] text-[var(--brand)]">
              {{ profile.name }}
            </p>

            <h1 class="mt-2 text-3xl font-black tracking-tight text-slate-950">
              Masuk Dashboard
            </h1>
          </div>

          <form class="mt-8 space-y-5" @submit.prevent="submit">
            <!-- Email -->
            <div>
              <label for="email" class="mb-2 block text-sm font-black text-slate-700">
                Email
              </label>

              <div class="relative">
                <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-slate-400">
                  <Icon icon="solar:letter-bold-duotone" class="h-5 w-5" />
                </div>

                <input
                  id="email"
                  v-model.trim="form.email"
                  type="email"
                  autocomplete="email"
                  required
                  placeholder="admin@email.com"
                  class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                >
              </div>

              <p v-if="validationTouched && !isEmailValid" class="mt-2 text-xs font-bold text-red-600">
                Format email belum valid.
              </p>
            </div>

            <!-- Password -->
            <div>
              <div class="mb-2 flex items-center justify-between gap-3">
                <label for="password" class="block text-sm font-black text-slate-700">
                  Password
                </label>

                <button
                  type="button"
                  class="inline-flex items-center gap-1.5 text-xs font-black text-[var(--brand)] transition hover:opacity-80"
                  @click="showPassword = !showPassword"
                >
                  <Icon
                    :icon="showPassword ? 'solar:eye-closed-bold-duotone' : 'solar:eye-bold-duotone'"
                    class="h-4 w-4"
                  />
                  {{ showPassword ? 'Sembunyikan' : 'Tampilkan' }}
                </button>
              </div>

              <div class="relative">
                <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-slate-400">
                  <Icon icon="solar:lock-keyhole-bold-duotone" class="h-5 w-5" />
                </div>

                <input
                  id="password"
                  v-model="form.password"
                  :type="showPassword ? 'text' : 'password'"
                  autocomplete="current-password"
                  required
                  minlength="8"
                  placeholder="Minimal 8 karakter"
                  class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                >
              </div>

              <p v-if="validationTouched && !isPasswordValid" class="mt-2 text-xs font-bold text-red-600">
                Password minimal 8 karakter.
              </p>
            </div>

            <!-- Error -->
            <div
              v-if="visibleError"
              class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold leading-6 text-red-700"
            >
              {{ visibleError }}
            </div>

            <!-- Button -->
            <button
              type="submit"
              :disabled="pending || !canSubmit"
              class="group inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-[var(--brand)] px-5 py-3.5 text-sm font-black text-white shadow-lg shadow-slate-200 transition hover:-translate-y-0.5 hover:bg-[var(--brand-dark)] disabled:cursor-not-allowed disabled:translate-y-0 disabled:opacity-60"
            >
              <Icon
                :icon="pending ? 'solar:refresh-bold-duotone' : 'solar:login-3-bold-duotone'"
                class="h-5 w-5"
                :class="pending ? 'animate-spin' : ''"
              />

              <span>{{ pending ? 'Memproses...' : 'Masuk Sekarang' }}</span>

              <Icon
                v-if="!pending"
                icon="solar:arrow-right-linear"
                class="h-5 w-5 transition group-hover:translate-x-0.5"
              />
            </button>
          </form>

          <div class="mt-6 text-center">
            <p class="text-sm font-semibold text-slate-500">
              Belum punya akun?
              <NuxtLink
                to="/register"
                class="font-black text-[var(--brand)] hover:opacity-80"
              >
                Daftar
              </NuxtLink>
            </p>

            <NuxtLink
              to="/"
              class="mt-4 inline-flex items-center justify-center gap-2 text-xs font-black uppercase tracking-[0.14em] text-slate-400 transition hover:text-slate-600"
            >
              <Icon icon="solar:home-2-bold-duotone" class="h-4 w-4" />
              Kembali ke Home
            </NuxtLink>
          </div>
        </div>

        <p class="mt-6 text-center text-xs font-semibold leading-6 text-slate-400">
          © {{ currentYear }} {{ profile.name }}. Sistem login terlindungi untuk akses dashboard.
        </p>
      </section>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, reactive, ref, unref } from 'vue'
import {
  navigateTo,
  useHead,
  useRequestURL,
  useRuntimeConfig,
  useSeoMeta
} from 'nuxt/app'
import { useAuth } from '../composables/data/useAuth'

// definePageMeta({
//   middleware: 'guest'
// })

type TenantMode = 'obayan' | 'martopuro'
type ToastType = 'success' | 'error'

type TenantFeature = {
  title: string
  description: string
  icon: string
}

type TenantProfile = {
  mode: TenantMode
  name: string
  initial: string
  badge: string
  mobileLabel: string
  workspace: string
  headline: string
  description: string
  loginDescription: string
  logo: string
  favicon: string
  brand: string
  brandDark: string
  brandSoft: string
  brandRing: string
  features: TenantFeature[]
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

const { login, pending, errorMessage } = useAuth()

const showPassword = ref(false)
const validationTouched = ref(false)
const localError = ref('')
const logoError = ref(false)

const form = reactive({
  email: '',
  password: ''
})

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

let toastTimer: ReturnType<typeof setTimeout> | null = null

const currentYear = new Date().getFullYear()

const profile = computed<TenantProfile>(() => {
    const logo = String(runtime.public.appLogo || '/assets/images/logo-martopuro.png')
    const favicon = String(
      runtime.public.appFavicon ||
      runtime.public.favicon ||
      logo ||
      '/assets/images/logo-martopuro.png'
    )

    return {
      mode: 'martopuro',
      name: String(runtime.public.clientDisplayName || 'Desa Martopuro'),
      initial: 'M',
      badge: 'Village Portal',
      mobileLabel: 'Portal Desa',
      workspace: 'Dashboard Desa Martopuro',
      headline: 'Portal Digital Desa yang rapi, cepat, dan mudah dikelola.',
      description:
        'Kelola informasi desa, berita, agenda, layanan surat, data masyarakat, dan publikasi resmi melalui satu dashboard yang aman dan nyaman digunakan perangkat desa.',
      loginDescription:
        'Masuk untuk mengelola konten website desa, informasi publik, berita, dan layanan digital masyarakat.',
      logo,
      favicon,
      brand: '#2563eb',
      brandDark: '#1d4ed8',
      brandSoft: '#eff6ff',
      brandRing: 'rgba(37, 99, 235, 0.14)',
      features: [
        {
          title: 'Manajemen Website Desa',
          description:
            'Update profil desa, berita, agenda, fasilitas, lembaga, dan informasi publik secara terstruktur.',
          icon: 'solar:window-frame-bold-duotone'
        },
        {
          title: 'Layanan Digital Warga',
          description:
            'Siap dikembangkan untuk pengajuan surat online, arsip administrasi, dan kebutuhan pelayanan desa.',
          icon: 'solar:document-add-bold-duotone'
        },
        {
          title: 'Akses Admin Aman',
          description:
            'Akun diverifikasi berdasarkan tenant aktif sehingga dashboard dapat dipakai lebih aman dan terpisah.',
          icon: 'solar:shield-check-bold-duotone'
        }
      ]
    }
})

const themeVars = computed<Record<string, string>>(() => ({
  '--brand': profile.value.brand,
  '--brand-dark': profile.value.brandDark,
  '--brand-soft': profile.value.brandSoft,
  '--brand-ring': profile.value.brandRing
}))

const isEmailValid = computed(() => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email.trim())
})

const isPasswordValid = computed(() => {
  return form.password.length >= 8
})

const canSubmit = computed(() => {
  return isEmailValid.value && isPasswordValid.value
})

const visibleError = computed(() => {
  return localError.value || String(unref(errorMessage) || '')
})

const faviconHref = computed(() => {
  return normalizeAssetUrl(profile.value.favicon)
})

useSeoMeta({
  title: () => `Login Dashboard · ${profile.value.name}`,
  description: () => profile.value.loginDescription,
  ogTitle: () => `Login Dashboard · ${profile.value.name}`,
  ogDescription: () => profile.value.loginDescription,
  robots: 'noindex, nofollow',
  applicationName: () => profile.value.name,
  appleMobileWebAppTitle: () => profile.value.name
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      key: 'favicon',
      rel: 'icon',
      type: getFaviconType(faviconHref.value),
      href: faviconHref.value
    },
    {
      key: 'shortcut-icon',
      rel: 'shortcut icon',
      href: faviconHref.value
    },
    {
      key: 'apple-touch-icon',
      rel: 'apple-touch-icon',
      href: faviconHref.value
    }
  ],
  meta: [
    {
      key: 'theme-color',
      name: 'theme-color',
      content: profile.value.brand
    }
  ]
}))

async function submit() {
  validationTouched.value = true
  localError.value = ''

  if (!canSubmit.value || unref(pending)) {
    const message = !isEmailValid.value
      ? 'Format email belum valid.'
      : 'Password minimal 8 karakter.'

    localError.value = message

    showToast(
      'error',
      'Login Gagal',
      message
    )

    return
  }

  try {
    await login({
      email: form.email.trim().toLowerCase(),
      password: form.password
    })

    if (!unref(errorMessage)) {
      showToast(
        'success',
        'Login Berhasil',
        'Akun berhasil diverifikasi. Anda akan diarahkan ke dashboard.'
      )

      await wait(700)
      await navigateTo('/app')
    }
  } catch (error: any) {
    const message =
      error?.data?.statusMessage ||
      error?.data?.message ||
      error?.statusMessage ||
      error?.message ||
      'Login gagal. Periksa kembali email dan password Anda.'

    localError.value = message

    showToast(
      'error',
      'Login Gagal',
      message
    )
  }
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

function wait(ms: number) {
    return new Promise((resolve) => setTimeout(resolve, ms))
}

function normalizeAssetUrl(value: string) {
    const cleanValue = String(value || '').trim()

    if (!cleanValue) return '/favicon.png'
    if (/^https?:\/\//i.test(cleanValue)) return cleanValue
    if (cleanValue.startsWith('/')) return cleanValue

    return `/${cleanValue}`
}

function getFaviconType(value: string) {
    const cleanValue = value.split('?')[0]?.toLowerCase() || ''

    if (cleanValue.endsWith('.svg')) return 'image/svg+xml'
    if (cleanValue.endsWith('.png')) return 'image/png'
    if (cleanValue.endsWith('.jpg') || cleanValue.endsWith('.jpeg')) return 'image/jpeg'
    if (cleanValue.endsWith('.ico')) return 'image/x-icon'

    return 'image/png'
}
</script>