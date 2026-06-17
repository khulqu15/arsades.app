<template>
  <div>
    <NuxtLoadingIndicator color="#2563eb" :height="3" :throttle="0" :duration="2000" />
    <AppLoading />
    <AppToast />

    <NuxtLayout v-bind="page?.meta?.layoutProps">
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>

<script lang="ts" setup>
import { computed, onMounted, ref, watch } from 'vue'
import { useHead, useRequestURL, useRuntimeConfig } from '#imports'
import { useRoute } from 'vue-router'

const page = useRoute()
const forced = ref(false)

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const publicConfig = config.public as Record<string, unknown>

function publicString(key: string, fallback = '') {
  const value = publicConfig[key]
  return String(value ?? fallback).trim() || fallback
}

function trimSlash(value: string) {
  return String(value || '').replace(/\/+$/, '')
}

function normalizeSiteUrl(value: string) {
  const cleanValue = trimSlash(value || `${requestUrl.protocol}//${requestUrl.host}`)

  if (/^https?:\/\//i.test(cleanValue)) {
    return cleanValue
  }

  return `https://${cleanValue}`
}

function absoluteUrl(pathOrUrl: string, baseUrl: string) {
  const value = String(pathOrUrl || '').trim()
  const safeBaseUrl = normalizeSiteUrl(baseUrl)

  if (!value) return safeBaseUrl
  if (/^https?:\/\//i.test(value)) return value

  return `${trimSlash(safeBaseUrl)}${value.startsWith('/') ? value : `/${value}`}`
}

function withCacheVersion(url: string) {
  const version = encodeURIComponent(
    publicString('clientName', 'app')
      .toLowerCase()
      .replace(/\s+/g, '-')
  )

  if (!url) return url
  if (url.includes('?')) return `${url}&v=${version}`

  return `${url}?v=${version}`
}

const siteUrl = computed(() => {
  return normalizeSiteUrl(publicString('siteUrl', `${requestUrl.protocol}//${requestUrl.host}`))
})

const faviconUrl = computed(() => {
  const favicon =
    publicString('appFavicon', '') ||
    publicString('favicon', '') ||
    publicString('appLogo', '') ||
    publicString('logo', '') ||
    '/favicon.ico'

  return withCacheVersion(absoluteUrl(favicon, siteUrl.value))
})

const appleTouchIconUrl = computed(() => {
  const icon =
    publicString('appleTouchIcon', '') ||
    publicString('appFavicon', '') ||
    publicString('favicon', '') ||
    publicString('appLogo', '') ||
    publicString('logo', '') ||
    '/favicon.ico'

  return withCacheVersion(absoluteUrl(icon, siteUrl.value))
})

const themeColor = computed(() => {
  return publicString('appThemeColor', publicString('themeColor', '#2563eb'))
})

const siteName = computed(() => {
  return publicString(
    'siteName',
    publicString('clientDisplayName', publicString('appName', 'Arsades'))
  )
})

useHead(() => ({
  titleTemplate: (titleChunk) => {
    return titleChunk ? `${titleChunk}` : siteName.value
  },
  link: [
    {
      key: 'force-favicon-icon',
      rel: 'icon',
      type: 'image/png',
      href: faviconUrl.value
    },
    {
      key: 'force-favicon-shortcut',
      rel: 'shortcut icon',
      href: faviconUrl.value
    },
    {
      key: 'force-favicon-apple',
      rel: 'apple-touch-icon',
      href: appleTouchIconUrl.value
    },
    {
      key: 'force-favicon-mask',
      rel: 'mask-icon',
      href: faviconUrl.value,
      color: themeColor.value
    }
  ],
  meta: [
    {
      key: 'force-theme-color',
      name: 'theme-color',
      content: themeColor.value
    },
    {
      key: 'force-application-name',
      name: 'application-name',
      content: siteName.value
    },
    {
      key: 'force-apple-title',
      name: 'apple-mobile-web-app-title',
      content: siteName.value
    }
  ]
}))

function forceFaviconInBrowser() {
  if (typeof document === 'undefined') return

  const selectors = [
    'link[rel="icon"]',
    'link[rel="shortcut icon"]',
    'link[rel="apple-touch-icon"]',
    'link[rel="mask-icon"]'
  ]

  for (const selector of selectors) {
    document.querySelectorAll(selector).forEach((element) => {
      element.parentNode?.removeChild(element)
    })
  }

  const icon = document.createElement('link')
  icon.rel = 'icon'
  icon.type = 'image/png'
  icon.href = faviconUrl.value
  document.head.appendChild(icon)

  const shortcut = document.createElement('link')
  shortcut.rel = 'shortcut icon'
  shortcut.href = faviconUrl.value
  document.head.appendChild(shortcut)

  const apple = document.createElement('link')
  apple.rel = 'apple-touch-icon'
  apple.href = appleTouchIconUrl.value
  document.head.appendChild(apple)

  forced.value = true
}

onMounted(() => {
  forceFaviconInBrowser()
})

watch(faviconUrl, () => {
  forceFaviconInBrowser()
})
</script>