import type { CreateUserPayload, UserItem } from '../../../types/rbac'
import { useAppApi } from '../useAppApi'

type AuthResponse = {
  data: UserItem
  message: string
  token?: string
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

  const user = useState<UserItem | null>('auth:user', () => null)
  const pending = ref(false)
  const errorMessage = ref('')

  const isLoggedIn = computed(() => Boolean(user.value))
  const roles = computed(() => user.value?.roles || [])
  const permissions = computed(() => user.value?.permissions || [])

  const token = useState<string | null>('auth:token', () => {
    if (import.meta.client) {
      return localStorage.getItem('auth_token')
    }

    return null
  })

  function getAuthHeaders(optionsHeaders?: FetchOptions['headers']) {
    const headers: Record<string, string> = {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }

    if (token.value) {
      headers.Authorization = `Bearer ${token.value}`
    }

    return {
      ...headers,
      ...(optionsHeaders as Record<string, string> || {})
    }
  }

  async function authFetch<T>(
    path: string,
    options: FetchOptions = {}
  ) {
    return await $fetch<T>(authEndpoint(path), {
      ...options,

      // IMPORTANT:
      // Jangan pakai credentials: 'include'
      // karena backend sedang memakai Access-Control-Allow-Origin: *

      headers: getAuthHeaders(options.headers)
    })
  }

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

      if (response.token) {
        token.value = response.token

        if (import.meta.client) {
          localStorage.setItem('auth_token', response.token)
        }
      }

      if (import.meta.client) {
        localStorage.setItem('auth_user', JSON.stringify(response.data))
      }

      return response.data
    } catch (error: any) {
      errorMessage.value =
        error?.data?.statusMessage ||
        error?.data?.message ||
        error?.statusMessage ||
        error?.message ||
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

      if (response.token) {
        token.value = response.token

        if (import.meta.client) {
          localStorage.setItem('auth_token', response.token)
        }
      }

      if (import.meta.client) {
        localStorage.setItem('auth_user', JSON.stringify(response.data))
      }

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
    } catch {
      // ignore logout API error
    } finally {
      user.value = null
      token.value = null

      if (import.meta.client) {
        localStorage.removeItem('auth_token')
        localStorage.removeItem('auth_user')
      }

      await navigateTo('/login')
    }
  }

  return {
    tenantSlug,
    authPath,

    user,
    token,
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