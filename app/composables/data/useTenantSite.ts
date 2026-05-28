import type {
  TenantSiteConfig,
  TenantSiteResponse,
  TenantSubscription,
  TenantSiteFeatures
} from '../../../types/tenant-site'
import { useAppApi } from '../useAppApi'

type UpdateTenantSitePayload = Partial<TenantSiteConfig> & {
  tenantSlug?: string
}

type LoadTenantSiteOptions = {
  tenantSlug?: string
}

function createDefaultSubscription(): TenantSubscription {
  return {
    plan: 'free',
    status: 'active',
    startedAt: null,
    endsAt: null,
    trialEndsAt: null,
    isActive: true,
    isPro: false,
    config: {}
  }
}

function createDefaultFeatures(): TenantSiteFeatures {
  return {
    news: true,
    onlineLetter: false,
    finance: false,
    letterC: false
  }
}

function createDefaultTenantSite(tenantSlug: string): TenantSiteConfig {
  return {
    id: '',
    name: '',
    displayName: '',
    slug: tenantSlug,
    tenantType: 'custom',
    domain: null,
    siteUrl: null,
    logoUrl: null,
    faviconUrl: null,
    ogImageUrl: null,
    primaryColor: null,
    description: null,
    status: 'active',

    subscription: createDefaultSubscription(),
    features: createDefaultFeatures(),

    theme: {},
    seo: {},
    hero: {},
    contact: {},
    statistic: {},
    culture: {},
    warta: {},
    footer: {},
    navigation: [],
    social: {},
    metadata: {}
  }
}

export function useTenantSite() {
  const runtime = useRuntimeConfig()
  const { tenantApiUrl } = useAppApi()

  const overrideTenantSlug = ref('')
  const mutationPending = ref(false)
  const mutationError = ref<string | null>(null)

  const tenantSlug = computed(() => {
    if (overrideTenantSlug.value) return overrideTenantSlug.value

    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const apiUrl = computed(() => {
    return tenantApiUrl(tenantSlug.value, '/site')
  })

  const {
    data,
    pending,
    error,
    refresh
  } = useFetch<TenantSiteResponse>(apiUrl, {
    key: computed(() => `tenant-site-${tenantSlug.value}`),
    watch: [tenantSlug],
    default: () => ({
      data: createDefaultTenantSite(tenantSlug.value)
    })
  })

  const site = computed<TenantSiteConfig>(() => {
    return normalizeSite(data.value?.data, tenantSlug.value)
  })

  const subscription = computed(() => {
    return site.value.subscription
  })

  const features = computed(() => {
    return site.value.features
  })

  const isPro = computed(() => {
    return Boolean(site.value.subscription?.isPro)
  })

  const isSubscriptionActive = computed(() => {
    return Boolean(site.value.subscription?.isActive)
  })

  const isSiteActive = computed(() => {
    return site.value.status === 'active'
  })

  async function loadSite(options?: LoadTenantSiteOptions) {
    if (options?.tenantSlug) {
      overrideTenantSlug.value = cleanSlug(options.tenantSlug)
    }

    await refresh()
  }

  async function fetchSite(options?: LoadTenantSiteOptions) {
    await loadSite(options)
    return site.value
  }

  async function updateSite(payload: UpdateTenantSitePayload) {
    mutationPending.value = true
    mutationError.value = null

    try {
      if (payload.tenantSlug) {
        overrideTenantSlug.value = cleanSlug(payload.tenantSlug)
      }

      const body = normalizePayload(payload)

      try {
        const response = await $fetch<TenantSiteResponse>(apiUrl.value, {
          method: 'PUT',
          body
        })

        await refresh()
        return normalizeSite(response.data, tenantSlug.value)
      } catch {
        const response = await $fetch<TenantSiteResponse>(apiUrl.value, {
          method: 'PATCH',
          body
        })

        await refresh()
        return normalizeSite(response.data, tenantSlug.value)
      }
    } catch (err: any) {
      mutationError.value = getErrorMessage(err, 'Gagal menyimpan profil website.')
      throw err
    } finally {
      mutationPending.value = false
    }
  }

  async function saveSite(payload: UpdateTenantSitePayload) {
    return await updateSite(payload)
  }

  function resetOverrideTenant() {
    overrideTenantSlug.value = ''
  }

  function normalizeSite(value: TenantSiteConfig | undefined | null, fallbackSlug: string): TenantSiteConfig {
    const fallback = createDefaultTenantSite(fallbackSlug)

    if (!value) return fallback

    return {
      ...fallback,
      ...value,

      slug: cleanSlug(value.slug || fallbackSlug),
      name: cleanString(value.name),
      displayName: cleanString(value.displayName),
      tenantType: value.tenantType || fallback.tenantType,
      status: value.status || fallback.status,

      domain: cleanNullableString(value.domain),
      siteUrl: cleanNullableString(value.siteUrl),
      logoUrl: cleanNullableString(value.logoUrl),
      faviconUrl: cleanNullableString(value.faviconUrl),
      ogImageUrl: cleanNullableString(value.ogImageUrl),
      primaryColor: cleanNullableString(value.primaryColor),
      description: cleanNullableString(value.description),

      subscription: {
        ...createDefaultSubscription(),
        ...(value.subscription || {}),
        config: normalizeObject(value.subscription?.config)
      },

      features: {
        ...createDefaultFeatures(),
        ...(value.features || {})
      },

      theme: normalizeObject(value.theme),
      seo: normalizeObject(value.seo),
      hero: normalizeObject(value.hero),
      contact: normalizeObject(value.contact),
      statistic: normalizeObject(value.statistic),
      culture: normalizeObject(value.culture),
      warta: normalizeObject(value.warta),
      footer: normalizeObject(value.footer),
      navigation: Array.isArray(value.navigation) ? value.navigation : [],
      social: normalizeObject(value.social),
      metadata: normalizeObject(value.metadata)
    }
  }

  function normalizePayload(payload: UpdateTenantSitePayload) {
    const current = site.value
    const { tenantSlug: _tenantSlug, ...rest } = payload

    return {
      ...rest,

      name: cleanString(rest.name ?? current.name),
      displayName: cleanString(rest.displayName ?? current.displayName),
      slug: cleanSlug(rest.slug ?? current.slug ?? tenantSlug.value),

      tenantType: rest.tenantType ?? current.tenantType ?? 'custom',
      status: rest.status ?? current.status ?? 'active',

      domain: cleanNullableString(rest.domain ?? current.domain),
      siteUrl: cleanNullableString(rest.siteUrl ?? current.siteUrl),
      logoUrl: cleanNullableString(rest.logoUrl ?? current.logoUrl),
      faviconUrl: cleanNullableString(rest.faviconUrl ?? current.faviconUrl),
      ogImageUrl: cleanNullableString(rest.ogImageUrl ?? current.ogImageUrl),
      primaryColor: cleanNullableString(rest.primaryColor ?? current.primaryColor),
      description: cleanNullableString(rest.description ?? current.description),

      subscription: {
        ...createDefaultSubscription(),
        ...(current.subscription || {}),
        ...(rest.subscription || {}),
        config: normalizeObject(rest.subscription?.config ?? current.subscription?.config)
      },

      features: {
        ...createDefaultFeatures(),
        ...(current.features || {}),
        ...(rest.features || {})
      },

      theme: normalizeObject(rest.theme ?? current.theme),
      seo: normalizeObject(rest.seo ?? current.seo),
      hero: normalizeObject(rest.hero ?? current.hero),
      contact: normalizeObject(rest.contact ?? current.contact),
      statistic: normalizeObject(rest.statistic ?? current.statistic),
      culture: normalizeObject(rest.culture ?? current.culture),
      warta: normalizeObject(rest.warta ?? current.warta),
      footer: normalizeObject(rest.footer ?? current.footer),
      social: normalizeObject(rest.social ?? current.social),
      metadata: normalizeObject(rest.metadata ?? current.metadata),
      navigation: Array.isArray(rest.navigation)
        ? rest.navigation
        : Array.isArray(current.navigation)
          ? current.navigation
          : []
    }
  }

  function cleanString(value: unknown) {
    return String(value || '').trim()
  }

  function cleanNullableString(value: unknown) {
    const text = String(value || '').trim()
    return text || null
  }

  function cleanSlug(value: unknown) {
    return String(value || '')
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '')
  }

  function normalizeObject(value: unknown) {
    if (!value || typeof value !== 'object' || Array.isArray(value)) return {}
    return value as Record<string, any>
  }

  function getErrorMessage(error: any, fallback: string) {
    return (
      error?.data?.statusMessage ||
      error?.data?.message ||
      error?.statusMessage ||
      error?.message ||
      fallback
    )
  }

  return {
    tenantSlug,
    overrideTenantSlug,

    site,
    subscription,
    features,

    isPro,
    isSubscriptionActive,
    isSiteActive,

    pending,
    error,
    refresh,

    loadSite,
    fetchSite,

    mutationPending,
    mutationError,

    updateSite,
    saveSite,

    resetOverrideTenant
  }
}