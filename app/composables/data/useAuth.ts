import type { CreateUserPayload, UserItem } from '../../../types/rbac'
import { useAppApi } from '../useAppApi'

type AuthResponse = {
  data: UserItem
  message: string
}

type FetchOptions = NonNullable<Parameters<typeof $fetch>[1]>

export function useAuth() {
  const runtime = useRuntimeConfig()
  const { apiUrl } = useAppApi()

  const tenantSlug = computed(() => {
    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const authPath = computed(() => '/api')

  function authEndpoint(path: string) {
    const cleanPath = path.startsWith('/') ? path : `/${path}`

    return apiUrl(`${authPath.value}${cleanPath}`)
  }

  async function authFetch<T>(
    path: string,
    options: FetchOptions = {}
  ) {
    return await $fetch<T>(authEndpoint(path), {
      ...options,

      /**
       * Pakai ini kalau backend auth memakai cookie/session.
       * Kalau backend return token biasa, boleh hapus credentials ini.
       */
      credentials: 'include',

      headers: {
        ...(options.headers || {})
      }
    })
  }

  const user = useState<UserItem | null>('auth:user', () => null)

  const pending = ref(false)
  const errorMessage = ref('')

  const isLoggedIn = computed(() => Boolean(user.value))
  const roles = computed(() => user.value?.roles || [])
  const permissions = computed(() => user.value?.permissions || [])

  function hasRole(roleCode: string) {
    return roles.value.some((role) => role.roleCode === roleCode)
  }

  function can(permissionCode: string) {
    return permissions.value.includes(permissionCode)
  }

  async function fetchMe() {
    try {
      const response = await authFetch<{ data: UserItem }>('/me')

      user.value = response.data

      return response.data
    } catch {
      user.value = null
      return null
    }
  }

  async function login(payload: {
    email: string
    password: string
  }) {
    pending.value = true
    errorMessage.value = ''

    try {
      const response = await authFetch<AuthResponse>('/login', {
        method: 'POST',
        body: {
          ...payload,
          tenantSlug: tenantSlug.value
        }
      })

      user.value = response.data

      return response.data
    } catch (error: any) {
      errorMessage.value =
        error?.data?.statusMessage ||
        error?.data?.message ||
        error?.statusMessage ||
        'Login gagal. Periksa email dan password.'

      throw error
    } finally {
      pending.value = false
    }
  }

  async function register(payload: CreateUserPayload) {
    pending.value = true
    errorMessage.value = ''

    try {
      const response = await authFetch<AuthResponse>('/register', {
        method: 'POST',
        body: {
          ...payload,
          tenantSlug: tenantSlug.value
        }
      })

      user.value = response.data

      return response.data
    } catch (error: any) {
      errorMessage.value =
        error?.data?.statusMessage ||
        error?.data?.message ||
        error?.statusMessage ||
        'Registrasi gagal.'

      throw error
    } finally {
      pending.value = false
    }
  }

  async function logout() {
    try {
      await authFetch('/logout', {
        method: 'POST'
      })
    } finally {
      user.value = null
      await navigateTo('/login')
    }
  }

  return {
    tenantSlug,
    authPath,

    user,
    pending,
    errorMessage,

    isLoggedIn,
    roles,
    permissions,

    hasRole,
    can,

    fetchMe,
    login,
    register,
    logout
  }
}