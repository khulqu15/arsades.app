<template>
  <div>
    <HeaderHeroVillage />
    <BlogHeroVillage />
    <InvitationHeroVillage />
    <InfoHeroVillage />
    <ArsadesHeroVillage />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute, useRuntimeConfig, useSeoMeta, useHead } from '#imports'

// @ts-ignore - ignore Vue SFC default export type issue
import HeaderHeroVillage from '../components/hero/HeaderHero.vue'
// @ts-ignore - ignore Vue SFC default export type issue
import BlogHeroVillage from '../components/hero/BlogHero.vue'
// @ts-ignore - ignore Vue SFC default export type issue
import InvitationHeroVillage from '../components/hero/InvitationHero.vue'
// @ts-ignore - ignore Vue SFC default export type issue
import InfoHeroVillage from '../components/hero/InfoHero.vue'
// @ts-ignore - ignore Vue SFC default export type issue
import ArsadesHeroVillage from '../components/hero/ArsadesHero.vue'

const route = useRoute()
const config = useRuntimeConfig()
const publicConfig = config.public as Record<string, unknown>

type SeoProfile = {
  siteUrl: string
  siteName: string
  title: string
  description: string
  keywords: string
  ogImage: string
  logo: string
  favicon: string
  themeColor: string
  twitterSite: string
  organizationType: string
  sameAs: string[]
  faq: {
    question: string
    answer: string
  }[]
}

function publicString(key: string, fallback = '') {
  const value = publicConfig[key]

  return String(value ?? fallback).trim() || fallback
}

function trimSlash(value: string) {
  return String(value || '').replace(/\/+$/, '')
}

function normalizeSiteUrl(value: string) {
  const cleanValue = trimSlash(value || 'https://obayan.id')

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

const seoProfile = computed<SeoProfile>(() => {
  const siteUrl = normalizeSiteUrl(publicString('siteUrl', 'https://obayan.id'))
  const siteName = publicString('siteName', publicString('clientDisplayName', 'Obayan'))
  const clientName = publicString('clientName', 'obayan')
  const clientDisplayName = publicString('clientDisplayName', siteName)

  const appName = publicString('appName', siteName)
  const appSubtitle = publicString('appSubtitle', '')
  const logo = publicString('appLogo', '/assets/logo.png')
  const themeColor = publicString('appThemeColor', '#16a34a')

  const heroTitleMain = publicString('heroTitleMain', siteName)
  const heroTitleHighlight = publicString('heroTitleHighlight', '')
  const heroTagline = publicString('heroTagline', '')
  const heroSubtitle = publicString('heroSubtitle', '')

  const description = publicString(
    'siteDescription',
    heroSubtitle || `${siteName} adalah website resmi untuk informasi, layanan, berita, dan profil lembaga.`
  )

  const titleParts = [
    heroTitleMain || siteName,
    heroTitleHighlight,
    heroTagline || appSubtitle
  ].filter(Boolean)

  const title = `${titleParts.join(' · ')} | ${siteName}`

  const ogImage = publicString('ogImage', logo)

  const keywords = [
    siteName,
    clientDisplayName,
    clientName,
    appName,
    heroTitleMain,
    heroTitleHighlight,
    heroTagline,
    'website resmi',
    'portal informasi',
    'layanan masyarakat',
    'berita',
    'profil'
  ]
    .filter(Boolean)
    .join(', ')

  return {
    siteUrl,
    siteName,
    title,
    description,
    keywords,
    ogImage,
    logo,
    favicon: logo,
    themeColor,
    twitterSite: publicString('twitterSite', ''),
    organizationType: clientName === 'martopuro' ? 'GovernmentOrganization' : 'Organization',
    sameAs: [
      publicString('instagramUrl', ''),
      publicString('facebookUrl', ''),
      publicString('youtubeUrl', '')
    ].filter(Boolean),
    faq: [
      {
        question: `Apa itu ${siteName}?`,
        answer: `${siteName} adalah portal resmi yang menyediakan informasi, berita, profil, dan layanan digital.`
      },
      {
        question: `Informasi apa saja yang tersedia di ${siteName}?`,
        answer: `Website ini memuat informasi profil, berita, agenda, layanan, fasilitas, potensi, dan informasi publik yang relevan.`
      },
      {
        question: `Apakah ${siteName} bisa digunakan untuk layanan online?`,
        answer: `Ya, website dapat menyediakan layanan online sesuai fitur yang diaktifkan oleh pengelola.`
      }
    ]
  }
})

const pageUrl = computed(() => {
  return new URL(route.fullPath || '/', seoProfile.value.siteUrl).toString()
})

const absoluteOgImage = computed(() => {
  return absoluteUrl(seoProfile.value.ogImage, seoProfile.value.siteUrl)
})

const absoluteLogo = computed(() => {
  return absoluteUrl(seoProfile.value.logo, seoProfile.value.siteUrl)
})

const absoluteFavicon = computed(() => {
  return absoluteUrl(seoProfile.value.favicon, seoProfile.value.siteUrl)
})

useSeoMeta({
  title: () => seoProfile.value.title,
  description: () => seoProfile.value.description,

  ogTitle: () => seoProfile.value.title,
  ogDescription: () => seoProfile.value.description,
  ogType: 'website',
  ogSiteName: () => seoProfile.value.siteName,
  ogUrl: () => pageUrl.value,
  ogImage: () => absoluteOgImage.value,
  ogLocale: 'id_ID',

  twitterCard: 'summary_large_image',
  twitterTitle: () => seoProfile.value.title,
  twitterDescription: () => seoProfile.value.description,
  twitterImage: () => absoluteOgImage.value,
  twitterSite: () => seoProfile.value.twitterSite,

  robots: 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
  applicationName: () => seoProfile.value.siteName,
  appleMobileWebAppTitle: () => seoProfile.value.siteName,
  keywords: () => seoProfile.value.keywords
})

useHead(() => {
  const organizationJsonLd = {
    '@context': 'https://schema.org',
    '@type': seoProfile.value.organizationType,
    name: seoProfile.value.siteName,
    url: seoProfile.value.siteUrl,
    logo: absoluteLogo.value,
    sameAs: seoProfile.value.sameAs
  }

  const websiteJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'WebSite',
    name: seoProfile.value.siteName,
    url: seoProfile.value.siteUrl
  }

  const faqJsonLd = seoProfile.value.faq.length
    ? {
        '@context': 'https://schema.org',
        '@type': 'FAQPage',
        mainEntity: seoProfile.value.faq.map((item) => ({
          '@type': 'Question',
          name: item.question,
          acceptedAnswer: {
            '@type': 'Answer',
            text: item.answer
          }
        }))
      }
    : null

  return {
    htmlAttrs: {
      lang: 'id'
    },
    link: [
      {
        rel: 'canonical',
        href: pageUrl.value
      },
      {
        rel: 'icon',
        href: absoluteFavicon.value
      },
      {
        rel: 'shortcut icon',
        href: absoluteFavicon.value
      },
      {
        rel: 'apple-touch-icon',
        href: absoluteFavicon.value
      },
      {
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        crossorigin: ''
      },
      {
        rel: 'preconnect',
        href: 'https://fonts.googleapis.com'
      }
    ],
    meta: [
      {
        name: 'theme-color',
        content: seoProfile.value.themeColor
      },
      {
        name: 'format-detection',
        content: 'telephone=no'
      }
    ],
    script: [
      {
        key: 'organization-jsonld',
        type: 'application/ld+json',
        innerHTML: JSON.stringify(organizationJsonLd)
      },
      {
        key: 'website-jsonld',
        type: 'application/ld+json',
        innerHTML: JSON.stringify(websiteJsonLd)
      },
      ...(faqJsonLd
        ? [
            {
              key: 'faq-jsonld',
              type: 'application/ld+json',
              innerHTML: JSON.stringify(faqJsonLd)
            }
          ]
        : [])
    ]
  }
})
</script>