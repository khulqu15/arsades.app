import type {
  CreateOrganizationPayload,
  OrganizationItem,
  OrganizationListResponse,
  OrganizationStatus,
  OrganizationType,
  UpdateOrganizationPayload
} from '../../../types/organization'
import { useAppApi } from '../useAppApi'

export function useOrganizationsSQL() {
  const runtime = useRuntimeConfig()

  const tenantSlug = computed(() => {
    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const q = ref('')
  const selectedType = ref<OrganizationType | 'all'>('all')
  const selectedStatus = ref<OrganizationStatus | 'all'>('active')
  const featuredOnly = ref(false)
  const page = ref(1)
  const limit = ref(20)
  const sort = ref<'newest' | 'oldest' | 'name' | 'sort_order'>('sort_order')

  const { tenantApiUrl } = useAppApi()

  const apiUrl = computed(() => {
    return tenantApiUrl(tenantSlug.value, '/organizations')
  })

  const {
    data,
    pending,
    error,
    refresh
  } = useFetch<OrganizationListResponse>(apiUrl, {
    key: computed(() => `tenant-organizations-${tenantSlug.value}`),
    query: computed(() => ({
      q: q.value || undefined,
      type: selectedType.value === 'all' ? undefined : selectedType.value,
      status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
      featured: featuredOnly.value ? 'true' : undefined,
      page: page.value,
      limit: limit.value,
      sort: sort.value
    })),
    watch: [
      tenantSlug,
      q,
      selectedType,
      selectedStatus,
      featuredOnly,
      page,
      limit,
      sort
    ],
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

  const organizations = computed<OrganizationItem[]>((() => {
    return data.value?.data || []
  }) as any)

  const featuredOrganizations = computed(() => {
    return organizations.value.filter((item) => item.isFeatured)
  })

  const meta = computed(() => {
    return data.value?.meta || {
      page: 1,
      limit: 20,
      total: 0,
      totalPages: 1
    }
  })

  async function safeRefresh() {
    try {
      await refresh()
    } catch (err) {
      console.warn('[organizations] refresh failed after mutation:', err)
    }
  }

  async function createOrganization(payload: CreateOrganizationPayload) {
    const response = await $fetch<{ data: OrganizationItem }>(apiUrl.value, {
      method: 'POST',
      body: payload
    })

    await safeRefresh()

    return response.data
  }

  async function updateOrganization(id: string, payload: UpdateOrganizationPayload) {
    const response = await $fetch<{ data: OrganizationItem }>(`${apiUrl.value}/${id}`, {
      method: 'PUT',
      body: payload
    })

    await safeRefresh()

    return response.data
  }

  async function deleteOrganization(id: string) {
    const response = await $fetch<{ message?: string } | null>(`${apiUrl.value}/${id}`, {
      method: 'DELETE'
    })

    await safeRefresh()

    return response || {
      message: 'Data berhasil dihapus.'
    }
  }

  function resetFilters() {
    q.value = ''
    selectedType.value = 'all'
    selectedStatus.value = 'active'
    featuredOnly.value = false
    page.value = 1
    sort.value = 'sort_order'
  }

  return {
    tenantSlug,

    q,
    selectedType,
    selectedStatus,
    featuredOnly,
    page,
    limit,
    sort,

    organizations,
    featuredOrganizations,
    meta,

    pending,
    error,
    refresh,
    safeRefresh,

    createOrganization,
    updateOrganization,
    deleteOrganization,
    resetFilters
  }
}