import type {
  CreateUserPayload,
  RoleCode,
  RoleListResponse,
  UpdateUserPayload,
  UserItem,
  UserListResponse,
  UserStatus
} from '../../../types/rbac'

export function useUsers() {
  const runtime = useRuntimeConfig()

  const tenantSlug = computed(() => {
    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const q = ref('')
  const selectedRole = ref<RoleCode | ''>('')
  const selectedStatus = ref<UserStatus | 'all'>('all')
  const page = ref(1)
  const limit = ref(20)

  const { tenantApiUrl } = useAppApi()

  const usersApiUrl = computed(() => {
    return tenantApiUrl(tenantSlug.value, '/users')
  })

  const {
    data,
    pending,
    error,
    refresh
  } = useFetch<UserListResponse>(usersApiUrl, {
    key: computed(() => `tenant-users-${tenantSlug.value}`),
    query: computed(() => ({
      q: q.value || undefined,
      role: selectedRole.value || undefined,
      status: selectedStatus.value,
      page: page.value,
      limit: limit.value
    })),
    watch: [tenantSlug, q, selectedRole, selectedStatus, page, limit],
    default: () => ({
      data: [],
      meta: {
        page: 1,
        limit: 20,
        total: 0,
        totalPages: 1
      }
    })
  })

  const {
    data: rolesResponse,
    pending: rolesPending,
    error: rolesError,
    refresh: refreshRoles
  } = useFetch<RoleListResponse>('/api/rbac/roles', {
    key: 'rbac-roles',
    default: () => ({
      data: []
    })
  })

  const users = computed<UserItem[]>(() => {
    return data.value?.data || []
  })

  const meta = computed(() => {
    return data.value?.meta || {
      page: 1,
      limit: 20,
      total: 0,
      totalPages: 1
    }
  })

  const roles = computed(() => {
    return rolesResponse.value?.data || []
  })

  async function createUser(payload: CreateUserPayload) {
    const response = await $fetch<{ data: UserItem }>(usersApiUrl.value, {
      method: 'POST',
      body: payload
    })

    await refresh()

    return response.data
  }

  async function updateUser(id: string, payload: UpdateUserPayload) {
    const response = await $fetch<{ data: UserItem }>(`${usersApiUrl.value}/${id}`, {
      method: 'PUT',
      body: payload
    })

    await refresh()

    return response.data
  }

  async function deleteUser(id: string) {
    const response = await $fetch<{ message: string }>(`${usersApiUrl.value}/${id}`, {
      method: 'DELETE'
    })

    await refresh()

    return response
  }

  function resetFilters() {
    q.value = ''
    selectedRole.value = ''
    selectedStatus.value = 'all'
    page.value = 1
  }

  function nextPage() {
    if (page.value < meta.value.totalPages) {
      page.value += 1
    }
  }

  function prevPage() {
    if (page.value > 1) {
      page.value -= 1
    }
  }

  return {
    tenantSlug,

    q,
    selectedRole,
    selectedStatus,
    page,
    limit,

    users,
    meta,
    roles,

    pending,
    error,

    rolesPending,
    rolesError,

    refresh,
    refreshRoles,

    createUser,
    updateUser,
    deleteUser,

    resetFilters,
    nextPage,
    prevPage
  }
}