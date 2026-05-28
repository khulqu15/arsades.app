<template>
  <main
    class="relative min-h-screen overflow-hidden bg-slate-50 text-slate-900"
    :style="themeVars"
  >
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
    <!-- Background -->
    <div class="pointer-events-none absolute inset-0">
      <div class="absolute -left-24 top-10 h-80 w-80 rounded-full bg-[var(--brand-soft)] blur-3xl"></div>
      <div class="absolute -right-24 bottom-10 h-96 w-96 rounded-full bg-[var(--brand-soft)] blur-3xl"></div>
      <div class="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-slate-200 to-transparent"></div>
    </div>

    <section class="relative mx-auto grid min-h-screen w-full max-w-7xl items-center gap-8 px-4 py-8 sm:px-6 lg:grid-cols-[0.9fr_1.1fr] lg:px-8">

      <!-- Register Card -->
      <section class="mx-auto w-full max-w-2xl">
        <div class="rounded-[2.25rem] border border-white/90 bg-white/90 p-5 shadow-[0_24px_80px_rgba(15,23,42,0.10)] backdrop-blur-xl sm:p-8">
          <!-- Header -->
          <div class="flex flex-col gap-5 sm:flex-row sm:items-center sm:justify-between">
            <div class="flex items-center gap-4">
              <NuxtLink
                to="/"
                class="grid h-14 w-14 place-items-center rounded-[1.25rem] text-white shadow-lg shadow-slate-200 transition hover:scale-[1.03]"
              >
                <img
                  v-if="profile.logo && !logoError"
                  :src="profile.logo"
                  :alt="profile.name"
                  class="h-9 w-9 rounded-xl object-contain"
                  @error="logoError = true"
                >
                <span v-else class="text-xl font-black">
                  {{ profile.initial }}
                </span>
              </NuxtLink>

              <div>
                <p class="text-xs font-black uppercase tracking-[0.18em] text-[var(--brand)]">
                  {{ profile.name }}
                </p>
                <h1 class="mt-1 text-2xl font-black tracking-tight text-slate-950">
                  Buat Akun Baru
                </h1>
              </div>
            </div>

            <NuxtLink
              to="/login"
              class="inline-flex items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-4 py-2.5 text-sm font-black text-slate-600 transition hover:border-[var(--brand)] hover:text-[var(--brand)]"
            >
              <Icon icon="solar:login-3-bold-duotone" class="h-5 w-5" />
              Login
            </NuxtLink>
          </div>

          <!-- Stepper -->
          <div class="mt-8">
            <div class="mb-4 flex items-center justify-between">
              <p class="text-xs font-black uppercase tracking-[0.18em] text-slate-400">
                Step {{ currentStep }} dari {{ steps.length }}
              </p>

              <p class="text-xs font-black text-[var(--brand)]">
                {{ progressPercent }}%
              </p>
            </div>

            <div class="h-2 overflow-hidden rounded-full bg-slate-100">
              <div
                class="h-full rounded-full transition-all duration-300"
                :style="{ width: `${progressPercent}%` }"
              ></div>
            </div>

            <div class="mt-5 grid gap-3 sm:grid-cols-3">
              <button
                v-for="step in steps"
                :key="step.value"
                type="button"
                class="rounded-2xl border p-4 text-left transition"
                :class="step.value === currentStep
                  ? 'border-[var(--brand)] bg-[var(--brand-soft)] ring-4 ring-[var(--brand-ring)]'
                  : step.value < currentStep
                    ? 'border-emerald-200 bg-emerald-50'
                    : 'border-slate-200 bg-white'"
                @click="goToStep(step.value)"
              >
                <div class="flex items-center justify-between gap-3">
                  <div
                    class="grid h-10 w-10 place-items-center rounded-xl"
                    :class="step.value === currentStep
                      ? 'bg-white text-[var(--brand)]'
                      : step.value < currentStep
                        ? 'bg-white text-emerald-600'
                        : 'bg-slate-100 text-slate-400'"
                  >
                    <Icon
                      :icon="step.value < currentStep ? 'solar:check-circle-bold-duotone' : step.icon"
                      class="h-5 w-5"
                    />
                  </div>

                  <span
                    class="text-xs font-black"
                    :class="step.value === currentStep ? 'text-[var(--brand)]' : 'text-slate-400'"
                  >
                    0{{ step.value }}
                  </span>
                </div>

                <p class="mt-3 text-sm font-black text-slate-950">
                  {{ step.title }}
                </p>
                <p class="mt-1 text-xs font-semibold leading-5 text-slate-500">
                  {{ step.description }}
                </p>
              </button>
            </div>
          </div>

          <!-- Form -->
          <form class="mt-8" @submit.prevent="submit">
            <!-- Step 1 -->
            <div v-if="currentStep === 1" class="space-y-5">
              <div class="rounded-[1.75rem] border border-slate-200 bg-slate-50 p-5">
                <div class="flex items-start gap-4">
                  <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-[var(--brand)] shadow-sm">
                    <Icon icon="solar:user-id-bold-duotone" class="h-5 w-5" />
                  </div>

                  <div>
                    <h2 class="text-base font-black text-slate-950">
                      Informasi Akun
                    </h2>
                    <p class="mt-1 text-sm leading-6 text-slate-500">
                      Isi identitas dasar akun yang akan digunakan untuk masuk ke dashboard.
                    </p>
                  </div>
                </div>
              </div>

              <div>
                <label for="name" class="mb-2 block text-sm font-black text-slate-700">
                  Nama Lengkap
                </label>

                <div class="relative">
                  <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-slate-400">
                    <Icon icon="solar:user-rounded-bold-duotone" class="h-5 w-5" />
                  </div>

                  <input
                    id="name"
                    v-model.trim="form.name"
                    type="text"
                    autocomplete="name"
                    placeholder="Contoh: Admin Martopuro"
                    class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                  >
                </div>

                <p v-if="validationTouched && !isNameValid" class="mt-2 text-xs font-bold text-red-600">
                  Nama minimal 3 karakter.
                </p>
              </div>

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
                    placeholder="admin@email.com"
                    class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                  >
                </div>

                <p v-if="validationTouched && !isEmailValid" class="mt-2 text-xs font-bold text-red-600">
                  Format email belum valid.
                </p>
              </div>
            </div>

            <!-- Step 2 -->
            <div v-if="currentStep === 2" class="space-y-5">
              <div class="rounded-[1.75rem] border border-slate-200 bg-slate-50 p-5">
                <div class="flex items-start gap-4">
                  <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-[var(--brand)] shadow-sm">
                    <Icon icon="solar:shield-user-bold-duotone" class="h-5 w-5" />
                  </div>

                  <div>
                    <h2 class="text-base font-black text-slate-950">
                      Pilih Role Akun
                    </h2>
                    <p class="mt-1 text-sm leading-6 text-slate-500">
                      Role menentukan hak akses user di dalam dashboard.
                    </p>
                  </div>
                </div>
              </div>

              <div class="grid gap-3 sm:grid-cols-2">
                <button
                  v-for="role in visibleRoles"
                  :key="role.value"
                  type="button"
                  class="rounded-2xl border p-4 text-left transition"
                  :class="form.roleCode === role.value
                    ? 'border-[var(--brand)] bg-[var(--brand-soft)] ring-4 ring-[var(--brand-ring)]'
                    : 'border-slate-200 bg-white hover:border-[var(--brand)]'"
                  @click="form.roleCode = role.value"
                >
                  <div class="flex items-center justify-between gap-3">
                    <div class="grid h-11 w-11 place-items-center rounded-xl bg-white text-[var(--brand)] shadow-sm">
                      <Icon :icon="role.icon" class="h-5 w-5" />
                    </div>

                    <div
                      v-if="role.value === 'super_admin'"
                      class="rounded-full bg-amber-100 px-2.5 py-1 text-[10px] font-black uppercase tracking-[0.12em] text-amber-700"
                    >
                      Dev Only
                    </div>
                  </div>

                  <p class="mt-3 text-sm font-black text-slate-950">
                    {{ role.label }}
                  </p>
                  <p class="mt-1 text-xs font-semibold leading-5 text-slate-500">
                    {{ role.description }}
                  </p>
                </button>
              </div>

              <div
                v-if="!isDevVersion"
                class="rounded-2xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm font-bold leading-6 text-amber-700"
              >
                Role Super Admin disembunyikan karena aplikasi tidak berjalan dalam mode dev version.
              </div>
            </div>

            <!-- Step 3 -->
            <div v-if="currentStep === 3" class="space-y-5">
              <div class="rounded-[1.75rem] border border-slate-200 bg-slate-50 p-5">
                <div class="flex items-start gap-4">
                  <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-[var(--brand)] shadow-sm">
                    <Icon icon="solar:lock-password-bold-duotone" class="h-5 w-5" />
                  </div>

                  <div>
                    <h2 class="text-base font-black text-slate-950">
                      Keamanan Akun
                    </h2>
                    <p class="mt-1 text-sm leading-6 text-slate-500">
                      Buat password yang aman untuk melindungi akses dashboard.
                    </p>
                  </div>
                </div>
              </div>

              <div class="grid gap-5 sm:grid-cols-2">
                <div>
                  <div class="mb-2 flex items-center justify-between gap-3">
                    <label for="password" class="block text-sm font-black text-slate-700">
                      Password
                    </label>

                    <button
                      type="button"
                      class="inline-flex items-center gap-1.5 text-xs font-black text-[var(--brand)] hover:opacity-80"
                      @click="showPassword = !showPassword"
                    >
                      <Icon
                        :icon="showPassword ? 'solar:eye-closed-bold-duotone' : 'solar:eye-bold-duotone'"
                        class="h-4 w-4"
                      />
                      {{ showPassword ? 'Hide' : 'Show' }}
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
                      autocomplete="new-password"
                      placeholder="Minimal 8 karakter"
                      class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                    >
                  </div>
                </div>

                <div>
                  <label for="confirmPassword" class="mb-2 block text-sm font-black text-slate-700">
                    Konfirmasi Password
                  </label>

                  <div class="relative">
                    <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-slate-400">
                      <Icon icon="solar:lock-keyhole-bold-duotone" class="h-5 w-5" />
                    </div>

                    <input
                      id="confirmPassword"
                      v-model="form.confirmPassword"
                      :type="showPassword ? 'text' : 'password'"
                      autocomplete="new-password"
                      placeholder="Ulangi password"
                      class="block w-full rounded-2xl border border-slate-200 bg-white py-3.5 pl-12 pr-4 text-sm font-semibold text-slate-800 outline-none transition placeholder:text-slate-400 focus:border-[var(--brand)] focus:ring-4 focus:ring-[var(--brand-ring)]"
                    >
                  </div>
                </div>
              </div>

              <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                <div class="grid gap-2 sm:grid-cols-2">
                  <PasswordRule label="Minimal 8 karakter" :valid="passwordRules.minLength" />
                  <PasswordRule label="Mengandung huruf" :valid="passwordRules.hasLetter" />
                  <PasswordRule label="Mengandung angka" :valid="passwordRules.hasNumber" />
                  <PasswordRule label="Password sama" :valid="passwordRules.isMatch" />
                </div>
              </div>

              <div class="rounded-[1.5rem] border border-slate-200 bg-white p-5">
                <p class="text-sm font-black text-slate-950">
                  Review Akun
                </p>

                <div class="mt-4 grid gap-3 text-sm">
                  <div class="flex items-center justify-between gap-4">
                    <span class="font-semibold text-slate-500">Nama</span>
                    <span class="font-black text-slate-900">{{ form.name || '-' }}</span>
                  </div>

                  <div class="flex items-center justify-between gap-4">
                    <span class="font-semibold text-slate-500">Email</span>
                    <span class="font-black text-slate-900">{{ form.email || '-' }}</span>
                  </div>

                  <div class="flex items-center justify-between gap-4">
                    <span class="font-semibold text-slate-500">Role</span>
                    <span class="font-black text-[var(--brand)]">{{ selectedRoleLabel }}</span>
                  </div>

                  <div class="flex items-center justify-between gap-4">
                    <span class="font-semibold text-slate-500">Tenant</span>
                    <span class="font-black text-slate-900">{{ tenantSlug }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Error -->
            <div
              v-if="visibleError"
              class="mt-5 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold leading-6 text-red-700"
            >
              {{ visibleError }}
            </div>

            <!-- Navigation -->
            <div class="mt-8 flex flex-col-reverse gap-3 sm:flex-row sm:items-center sm:justify-between">
              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-5 py-3 text-sm font-black text-slate-600 transition hover:border-slate-300 hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-50"
                :disabled="currentStep === 1 || pending"
                @click="prevStep"
              >
                <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                Kembali
              </button>

              <button
                v-if="currentStep < steps.length"
                type="button"
                class="inline-flex items-center justify-center bg-[var(--brand)] gap-2 rounded-2xl px-5 py-3 text-sm font-black text-white shadow-lg shadow-slate-200 transition hover:-translate-y-0.5 hover:bg-[var(--brand-dark)] disabled:cursor-not-allowed disabled:translate-y-0 disabled:opacity-60"
                @click="nextStep"
              >
                Lanjutkan
                <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
              </button>

              <button
                v-else
                type="submit"
                :disabled="pending || !canSubmit"
                class="inline-flex items-center justify-center gap-2 bg-[var(--brand)] rounded-2xl px-5 py-3 text-sm font-black text-white shadow-lg shadow-slate-200 transition hover:-translate-y-0.5 hover:bg-[var(--brand-dark)] disabled:cursor-not-allowed disabled:translate-y-0 disabled:opacity-60"
              >
                <Icon
                  :icon="pending ? 'solar:refresh-bold-duotone' : 'solar:user-plus-rounded-bold-duotone'"
                  class="h-5 w-5"
                  :class="pending ? 'animate-spin' : ''"
                />
                {{ pending ? 'Membuat akun...' : 'Buat Akun' }}
              </button>
            </div>
          </form>
        </div>

        <p class="mt-6 text-center text-xs font-semibold leading-6 text-slate-400">
          © {{ currentYear }} {{ profile.name }}. Register akun mengikuti tenant aktif.
        </p>
      </section>
    </section>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, reactive, ref, unref, watch } from 'vue'
import {
  navigateTo,
  useHead,
  useRequestURL,
  useRuntimeConfig,
  useSeoMeta
} from 'nuxt/app'
import type { CreateUserPayload } from '../../types/rbac'
import { useAuth } from '../composables/data/useAuth'

definePageMeta({
  middleware: 'guest'
})

type RegisterRoleCode = 'user' | 'admin' | 'super_admin'

type RoleOption = {
  label: string
  value: RegisterRoleCode
  description: string
  icon: string
  devOnly?: boolean
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()

const { register, pending, errorMessage, tenantSlug } = useAuth()

const currentStep = ref(1)
const validationTouched = ref(false)
const showPassword = ref(false)
const localError = ref('')
const logoError = ref(false)
type ToastType = 'success' | 'error'

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

let toastTimer: ReturnType<typeof setTimeout> | null = null

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

const currentYear = new Date().getFullYear()

const form = reactive({
  name: '',
  email: '',
  roleCode: 'user' as RegisterRoleCode,
  password: '',
  confirmPassword: ''
})

const steps = [
  {
    value: 1,
    title: 'Akun',
    description: 'Nama dan email',
    icon: 'solar:user-id-bold-duotone'
  },
  {
    value: 2,
    title: 'Role',
    description: 'Hak akses user',
    icon: 'solar:shield-user-bold-duotone'
  },
  {
    value: 3,
    title: 'Password',
    description: 'Keamanan akun',
    icon: 'solar:lock-password-bold-duotone'
  }
]

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const isDevVersion = computed(() => {
  const value = runtime.public.devVersion

  return (
    value === true ||
    String(value).toLowerCase() === 'true' ||
    String(value) === '1'
  )
})

const isMartopuro = computed(() => {
  const clientName = String(runtime.public.clientName || '').toLowerCase()

  return hostname.value.includes('martopuro') || clientName.includes('martopuro')
})

const profile = computed(() => {
  if (isMartopuro.value) {
    return {
      name: String(runtime.public.clientDisplayName || 'Desa Martopuro'),
      initial: 'M',
      badge: 'Village Portal',
      logo: String(runtime.public.appLogo || '/assets/images/logo-martopuro.png'),
      description:
        'Register akun untuk admin desa, operator, atau user internal yang akan mengelola informasi desa, berita, layanan, dan data digital Desa Martopuro.',
      brand: '#2563eb',
      brandDark: '#1d4ed8',
      brandSoft: '#eff6ff',
      brandRing: 'rgba(37, 99, 235, 0.14)'
    }
  }

  return {
    name: String(runtime.public.clientDisplayName || 'Obayan'),
    initial: 'O',
    badge: 'Education Platform',
    logo: String(runtime.public.appLogo || '/logo.png'),
    description:
      'Register akun untuk mengakses dashboard Obayan, mulai dari pengelolaan website, tenant, akademik, konten, hingga konfigurasi sistem.',
    brand: '#58cc02',
    brandDark: '#46a302',
    brandSoft: '#f0fdf4',
    brandRing: 'rgba(88, 204, 2, 0.16)'
  }
})

const themeVars = computed<Record<string, string>>(() => ({
  '--brand': profile.value.brand,
  '--brand-dark': profile.value.brandDark,
  '--brand-soft': profile.value.brandSoft,
  '--brand-ring': profile.value.brandRing
}))

const roleOptions = computed<RoleOption[]>(() => [
  {
    label: 'User',
    value: 'user',
    description: 'Akses dasar untuk pengguna umum atau akun operasional biasa.',
    icon: 'solar:user-rounded-bold-duotone'
  },
  {
    label: 'Admin',
    value: 'admin',
    description: 'Akses pengelolaan dashboard, konten, dan data tenant.',
    icon: 'solar:shield-check-bold-duotone'
  },
  {
    label: 'Super Admin',
    value: 'super_admin',
    description: 'Akses tertinggi untuk development, testing, dan konfigurasi global.',
    icon: 'solar:crown-star-bold-duotone',
    devOnly: true
  }
])

const visibleRoles = computed(() => {
  return roleOptions.value.filter((role) => {
    if (role.devOnly) return isDevVersion.value
    return true
  })
})

const selectedRoleLabel = computed(() => {
  return roleOptions.value.find((role) => role.value === form.roleCode)?.label || 'User'
})

const features = computed(() => [
  {
    title: 'Step by Step Register',
    description:
      'Form dibuat bertahap agar user tidak merasa berat saat membuat akun baru.',
    icon: 'solar:checklist-minimalistic-bold-duotone'
  },
  {
    title: 'Tenant Based Register',
    description:
      `Akun otomatis mengikuti tenant aktif dari runtime config: ${tenantSlug.value}.`,
    icon: 'solar:layers-bold-duotone'
  },
  {
    title: 'Development Safe Mode',
    description:
      'Super Admin hanya tersedia ketika DEV_VERSION aktif, sehingga lebih aman untuk production.',
    icon: 'solar:shield-warning-bold-duotone'
  }
])

const isNameValid = computed(() => form.name.trim().length >= 3)
const isEmailValid = computed(() => isValidEmail(form.email))

const passwordRules = computed(() => {
  return {
    minLength: form.password.length >= 8,
    hasLetter: /[a-zA-Z]/.test(form.password),
    hasNumber: /[0-9]/.test(form.password),
    isMatch:
      form.password.length > 0 &&
      form.confirmPassword.length > 0 &&
      form.password === form.confirmPassword
  }
})

const isPasswordStepValid = computed(() => {
  return (
    passwordRules.value.minLength &&
    passwordRules.value.hasLetter &&
    passwordRules.value.hasNumber &&
    passwordRules.value.isMatch
  )
})

const canSubmit = computed(() => {
  return (
    isNameValid.value &&
    isEmailValid.value &&
    Boolean(form.roleCode) &&
    isPasswordStepValid.value
  )
})

const progressPercent = computed(() => {
  return Math.round((currentStep.value / steps.length) * 100)
})

const visibleError = computed(() => {
  return localError.value || String(unref(errorMessage) || '')
})

watch(isDevVersion, (value) => {
  if (!value && form.roleCode === 'super_admin') {
    form.roleCode = 'user'
  }
}, {
  immediate: true
})

useSeoMeta({
  title: () => `Register Account · ${profile.value.name}`,
  description: () => `Buat akun dashboard ${profile.value.name}.`,
  ogTitle: () => `Register Account · ${profile.value.name}`,
  ogDescription: () => `Buat akun dashboard ${profile.value.name}.`,
  robots: 'noindex, nofollow'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  meta: [
    {
      name: 'theme-color',
      content: profile.value.brand
    }
  ]
}))

function validateCurrentStep() {
  validationTouched.value = true
  localError.value = ''

  if (currentStep.value === 1) {
    if (!isNameValid.value) {
      localError.value = 'Nama minimal 3 karakter.'
      return false
    }

    if (!isEmailValid.value) {
      localError.value = 'Format email belum valid.'
      return false
    }

    return true
  }

  if (currentStep.value === 2) {
    if (!form.roleCode) {
      localError.value = 'Silakan pilih role akun terlebih dahulu.'
      return false
    }

    if (form.roleCode === 'super_admin' && !isDevVersion.value) {
      localError.value = 'Role Super Admin hanya tersedia pada DEV_VERSION.'
      return false
    }

    return true
  }

  if (currentStep.value === 3) {
    if (!isPasswordStepValid.value) {
      localError.value = 'Password belum memenuhi semua ketentuan.'
      return false
    }

    return true
  }

  return true
}

function nextStep() {
  if (!validateCurrentStep()) return

  validationTouched.value = false
  localError.value = ''
  currentStep.value = Math.min(currentStep.value + 1, steps.length)
}

function prevStep() {
  validationTouched.value = false
  localError.value = ''
  currentStep.value = Math.max(currentStep.value - 1, 1)
}

function goToStep(step: number) {
  if (step <= currentStep.value) {
    validationTouched.value = false
    localError.value = ''
    currentStep.value = step
    return
  }

  nextStep()
}

async function submit() {
  localError.value = ''

  if (!validateCurrentStep()) return
  if (!canSubmit.value || unref(pending)) return

  if (form.roleCode === 'super_admin' && !isDevVersion.value) {
    localError.value = 'Role Super Admin hanya tersedia pada DEV_VERSION.'

    showToast(
      'error',
      'Registrasi Ditolak',
      'Role Super Admin hanya tersedia pada mode development.'
    )

    return
  }

  try {
    const payload = {
      name: form.name.trim(),
      email: form.email.trim().toLowerCase(),
      password: form.password,
      roleCodes: [form.roleCode],
      status: 'active'
    } as unknown as CreateUserPayload

    await register(payload, {
      autoLogin: false
    })

    showToast(
      'success',
      'Registrasi Berhasil',
      'Akun berhasil dibuat. Silakan login menggunakan email dan password Anda.'
    )

    await wait(900)
    await navigateTo('/login')
  } catch (error: any) {
    const message =
      error?.data?.statusMessage ||
      error?.data?.message ||
      error?.statusMessage ||
      error?.message ||
      'Registrasi gagal. Periksa kembali data yang diisi.'

    localError.value = message

    showToast(
      'error',
      'Registrasi Gagal',
      message
    )
  }
}

function isValidEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())
}

const PasswordRule = defineComponent({
  props: {
    label: {
      type: String,
      required: true
    },
    valid: {
      type: Boolean,
      required: true
    }
  },
  setup(props) {
    return () =>
      h('div', {
        class: 'flex items-center gap-2 text-xs font-bold'
      }, [
        h(Icon, {
          icon: props.valid
            ? 'solar:check-circle-bold-duotone'
            : 'solar:minus-circle-bold-duotone',
          class: [
            'h-5 w-5',
            props.valid ? 'text-emerald-600' : 'text-slate-300'
          ]
        }),

        h('span', {
          class: props.valid ? 'text-slate-700' : 'text-slate-400'
        }, props.label)
      ])
  }
})
</script>