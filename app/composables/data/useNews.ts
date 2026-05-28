import type { NewsItem, NewsListResponse } from '../../../types/news'
import { useAppApi } from '../useAppApi'

type NewsStatus = 'draft' | 'published' | 'scheduled' | 'archived'

type NewsMutationPayload = {
  tenantSlug?: string
  title: string
  slug?: string
  excerpt?: string
  cover?: string
  category?: string
  categorySlug?: string
  tags?: string[]
  status?: NewsStatus
  publishedAt?: number | string | null
  readTime?: number
  content?: {
    kind?: string
    json?: any
    html?: string
  } | string | null
}

type LoadNewsOptions = {
  tenantSlug?: string
  status?: NewsStatus | 'all'
  limit?: number
  sort?: 'newest' | 'oldest' | 'title'
}

export function useNews() {
  const runtime = useRuntimeConfig()
  const route = useRoute()
  const router = useRouter()

  const overrideTenantSlug = ref('')

  const tenantSlug = computed(() => {
    if (overrideTenantSlug.value) return overrideTenantSlug.value

    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const q = ref('')
  const selectedCategory = ref('')
  const selectedTags = ref<Set<string>>(new Set())
  const sortBy = ref<'newest' | 'oldest' | 'title'>('newest')
  const statusFilter = ref<NewsStatus | 'all'>('all')

  const page = ref(1)
  const pageSize = ref(6)
  const limit = ref(100)

  const mutationPending = ref(false)
  const mutationError = ref<string | null>(null)

  const activeSlug = computed(() => {
    const value = route.query.news
    return typeof value === 'string' ? value : ''
  })

  const { tenantApiUrl } = useAppApi()

  const apiUrl = computed(() => {
    return tenantApiUrl(tenantSlug.value, '/news')
  })

  const queryParams = computed(() => ({
    status: statusFilter.value === 'all' ? undefined : normalizeApiStatus(statusFilter.value),
    limit: limit.value,
    sort: sortBy.value
  }))

  const {
    data,
    pending,
    error,
    refresh
  } = useFetch<NewsListResponse>(apiUrl, {
    key: computed(() => `tenant-news-${tenantSlug.value}-${statusFilter.value}-${sortBy.value}`),
    query: queryParams,
    watch: [tenantSlug, statusFilter, sortBy, limit],
    default: () => ({
      data: [],
      meta: {
        page: 1,
        limit: 100,
        total: 0,
        totalPages: 1
      }
    })
  })

  const items = computed<NewsItem[]>(() => data.value?.data || [])

  const isDetail = computed(() => Boolean(activeSlug.value))

  const current = computed(() => {
    if (!activeSlug.value) return null
    return items.value.find((item) => item.slug === activeSlug.value) || null
  })

  const categories = computed(() => {
    return Array.from(
      new Map(
        items.value
          .filter((item: any) => item.category)
          .map((item: any) => [
            item.categorySlug || slugify(item.category),
            item.category
          ])
      ).values()
    )
  })

  const allTags = computed(() => {
    return Array.from(
      new Set(items.value.flatMap((item: any) => item.tags || []))
    )
  })

  const filtered = computed(() => {
    let rows = [...items.value] as any[]

    const keyword = q.value.trim().toLowerCase()

    if (keyword) {
      rows = rows.filter((item) => {
        return [
          item.title,
          item.excerpt,
          item.descriptionCard,
          item.descriptionContent,
          item.category,
          ...(item.tags || [])
        ]
          .filter(Boolean)
          .join(' ')
          .toLowerCase()
          .includes(keyword)
      })
    }

    if (selectedCategory.value) {
      rows = rows.filter((item) => item.category === selectedCategory.value)
    }

    if (selectedTags.value.size) {
      rows = rows.filter((item) => {
        return item.tags?.some((tag: string) => selectedTags.value.has(tag))
      })
    }

    if (sortBy.value === 'newest') {
      rows.sort((a, b) => Number(b.publishedAt || 0) - Number(a.publishedAt || 0))
    }

    if (sortBy.value === 'oldest') {
      rows.sort((a, b) => Number(a.publishedAt || 0) - Number(b.publishedAt || 0))
    }

    if (sortBy.value === 'title') {
      rows.sort((a, b) => String(a.title || '').localeCompare(String(b.title || '')))
    }

    return rows
  })

  const paged = computed(() => {
    return filtered.value.slice(0, page.value * pageSize.value)
  })

  const hasMore = computed(() => {
    return paged.value.length < filtered.value.length
  })

  const renderedDetailHtml = computed(() => {
    const selected: any = current.value

    if (!selected) return ''

    if (selected.descriptionContent) return selected.descriptionContent

    if (selected.content?.html) return selected.content.html

    if (typeof selected.content === 'string') {
      try {
        const parsed = JSON.parse(selected.content)
        if (parsed?.html) return parsed.html
      } catch {
        return selected.content
      }
    }

    return '<p>Belum ada konten berita.</p>'
  })

  async function loadNews(options?: LoadNewsOptions) {
    if (options?.tenantSlug) {
      overrideTenantSlug.value = options.tenantSlug.trim().toLowerCase()
    }

    if (options?.status) {
      statusFilter.value = options.status
    }

    if (options?.limit) {
      limit.value = options.limit
    }

    if (options?.sort) {
      sortBy.value = options.sort
    }

    await refresh()
  }

  async function fetchNews(options?: LoadNewsOptions) {
    return await loadNews(options)
  }

  async function createNews(payload: NewsMutationPayload) {
    mutationPending.value = true
    mutationError.value = null

    try {
      const response = await $fetch<{ data: NewsItem; message?: string }>(apiUrl.value, {
        method: 'POST',
        body: normalizePayload(payload)
      })

      await refresh()

      return response.data
    } catch (error: any) {
      mutationError.value = getErrorMessage(error, 'Gagal membuat berita.')
      throw error
    } finally {
      mutationPending.value = false
    }
  }

  async function updateNews(id: string, payload: NewsMutationPayload) {
    mutationPending.value = true
    mutationError.value = null

    try {
      const response = await $fetch<{ data: NewsItem; message?: string }>(`${apiUrl.value}/${id}`, {
        method: 'PUT',
        body: normalizePayload(payload)
      })

      await refresh()

      return response.data
    } catch (error: any) {
      mutationError.value = getErrorMessage(error, 'Gagal mengupdate berita.')
      throw error
    } finally {
      mutationPending.value = false
    }
  }

  async function deleteNews(id: string) {
    mutationPending.value = true
    mutationError.value = null

    try {
      const response = await $fetch<{ message: string }>(`${apiUrl.value}/${id}`, {
        method: 'DELETE'
      })

      await refresh()

      return response
    } catch (error: any) {
      mutationError.value = getErrorMessage(error, 'Gagal menghapus berita.')
      throw error
    } finally {
      mutationPending.value = false
    }
  }

  const createItem = createNews
  const updateItem = updateNews
  const deleteItem = deleteNews
  const removeNews = deleteNews
  const remove = deleteNews
  const destroy = deleteNews

  function normalizePayload(payload?: NewsMutationPayload) {
    if (!payload) {
      throw new Error('Payload berita tidak boleh kosong.')
    }

    const content = normalizeContent(payload.content)

    const html =
      content.html ||
      ''

    const excerpt =
      payload.excerpt?.trim() ||
      stripHtml(html).slice(0, 180) ||
      'Belum ada deskripsi.'

    const categoryName = payload.category?.trim() || ''
    const categorySlug = payload.categorySlug || slugify(categoryName)

    const tagNames = Array.isArray(payload.tags)
      ? payload.tags.map((tag) => String(tag).trim()).filter(Boolean)
      : []

    return {
      title: payload.title.trim(),
      slug: slugify(payload.slug || payload.title),

      descriptionCard: excerpt,
      descriptionContent: html,

      coverUrl: payload.cover || '',

      categoryName,
      categorySlug,

      tagNames,
      tagSlugs: tagNames.map(slugify),

      status: normalizeApiStatus(payload.status || 'draft'),

      publishedAt: normalizePublishedAt(payload.publishedAt, payload.status),

      readTime:
        payload.readTime ||
        estimateReadTime(stripHtml(html)),

      content
    }
  }

  function normalizeContent(content: NewsMutationPayload['content']) {
    if (!content) {
      return {
        kind: 'tiptap',
        json: null,
        html: '<p></p>'
      }
    }

    if (typeof content === 'string') {
      return {
        kind: 'html',
        json: null,
        html: content
      }
    }

    return {
      kind: content.kind || 'tiptap',
      json: content.json || null,
      html: content.html || '<p></p>'
    }
  }

  function normalizeApiStatus(status?: NewsStatus | 'all') {
    /**
     * Backend service kamu saat ini hanya menerima:
     * draft, published, archived.
     *
     * Kalau nanti backend dan enum DB sudah support scheduled,
     * ubah return scheduled menjadi 'scheduled'.
     */
    if (status === 'published') return 'published'
    if (status === 'archived') return 'archived'

    return 'draft'
  }

  function normalizePublishedAt(value?: number | string | null, status?: NewsStatus) {
    if (status === 'published' && !value) {
      return toMysqlDateTime(new Date())
    }

    if (!value) return null

    return toMysqlDateTime(value)
  }

  function toMysqlDateTime(value?: Date | string | number | null) {
    if (!value) return null

    const date = value instanceof Date
      ? value
      : new Date(value)

    if (Number.isNaN(date.getTime())) return null

    const pad = (number: number) => String(number).padStart(2, '0')

    return [
      date.getFullYear(),
      pad(date.getMonth() + 1),
      pad(date.getDate())
    ].join('-') + ' ' + [
      pad(date.getHours()),
      pad(date.getMinutes()),
      pad(date.getSeconds())
    ].join(':')
  }

  function toggleTag(tag: string) {
    const next = new Set(selectedTags.value)

    if (next.has(tag)) {
      next.delete(tag)
    } else {
      next.add(tag)
    }

    selectedTags.value = next
    page.value = 1
  }

  function resetFilters() {
    q.value = ''
    selectedCategory.value = ''
    selectedTags.value = new Set()
    sortBy.value = 'newest'
    statusFilter.value = 'all'
    page.value = 1
  }

  async function openDetail(slug: string) {
    await router.push({
      query: {
        ...route.query,
        news: slug
      }
    })
  }

  async function backToList() {
    const query = { ...route.query }
    delete query.news

    await router.push({ query })
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

  function slugify(value: string) {
    return String(value || '')
      .toLowerCase()
      .trim()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '')
  }

  function stripHtml(value: string) {
    return String(value || '')
      .replace(/<[^>]*>/g, ' ')
      .replace(/\s+/g, ' ')
      .trim()
  }

  function estimateReadTime(text: string) {
    const words = String(text || '')
      .trim()
      .split(/\s+/)
      .filter(Boolean)

    return Math.max(1, Math.ceil(words.length / 200))
  }

  watch([q, selectedCategory, selectedTags, sortBy, statusFilter], () => {
    page.value = 1
  })

  return {
    tenantSlug,

    pending,
    error,
    refresh,
    loadNews,
    fetchNews,

    mutationPending,
    mutationError,

    items,

    q,
    selectedCategory,
    selectedTags,
    sortBy,
    statusFilter,

    categories,
    allTags,

    toggleTag,
    resetFilters,

    filtered,
    paged,
    hasMore,
    page,
    pageSize,

    isDetail,
    current,
    openDetail,
    backToList,
    renderedDetailHtml,

    createNews,
    updateNews,
    deleteNews,

    createItem,
    updateItem,
    deleteItem,
    removeNews,
    remove,
    destroy
  }
}