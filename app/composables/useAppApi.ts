export function useAppApi() {
  const runtime = useRuntimeConfig()

  const apiBaseUrl = computed(() => {
    return String(runtime.public.apiBaseUrl || '')
      .trim()
      .replace(/\/+$/, '')
  })

  const apiRemoteEnabled = computed(() => {
    return Boolean(apiBaseUrl.value)
  })

  function apiUrl(path: string) {
    const normalizedPath = path.startsWith('/') ? path : `/${path}`

    if (!apiBaseUrl.value) {
      return normalizedPath
    }

    return `${apiBaseUrl.value}${normalizedPath}`
  }

  function tenantApiUrl(tenantSlug: string, path: string) {
    const normalizedPath = path.startsWith('/') ? path : `/${path}`

    return apiUrl(`/api/tenants/${tenantSlug}${normalizedPath}`)
  }

  return {
    apiRemoteEnabled,
    apiBaseUrl,
    apiUrl,
    tenantApiUrl
  }
}