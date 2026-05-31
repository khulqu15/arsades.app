import tailwindcss from "@tailwindcss/vite";

export default defineNuxtConfig({
  compatibilityDate: '2026-05-17',
  devtools: { enabled: true },
  hub: {
    db: 'mysql',
  },
  css: [
    '~/assets/css/main.css',
  ],

  vite: {
    plugins: [
      tailwindcss()
    ],
  },

  plugins: [
    '~/plugins/preline.client.ts',
    '~/plugins/page-loading.client.ts',
  ],

  nitro: {
    routeRules: {
      '/api/**': {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With, Accept, Origin',
          'Access-Control-Max-Age': '86400'
        }
      }
    },
    prerender: {
      crawlLinks: false,
      failOnError: false,
      routes: [
        '/',
        '/news',
        '/profile',
        '/status',
        '/apbd',
        '/facilities',
        '/institutions',
        '/potentials',
        '/organizations',
        '/login',
        '/register',
        '/app',
        '/app/news',
        '/app/facilities',
        '/app/institutions',
        '/app/organizations',
        '/app/potentials',
        '/app/profile',
      ],
    }
  },

  imports: {
    autoImport: true
  },

  app: {
    head: {
      titleTemplate: (titleChunk: string) => (titleChunk ? `${titleChunk} · Obayan` : 'Obayan · Modern Pesantren Platform'),
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'theme-color', content: '#58CC02' },
        { name: 'description', content: 'Obayan — platform modern untuk pondok pesantren: web profile, SIAKAD, pembayaran, akademik, absensi, kunjungan, pelanggaran, perizinan — terintegrasi RFID & Fingerprint (ToriID).'},
        { property: 'og:type', content: 'website' },
        { property: 'og:title', content: 'Obayan · Modern Pesantren Platform' },
        { property: 'og:description', content: 'Web profile, SIAKAD, pembayaran, akademik, absensi RFID & Fingerprint (ToriID), kunjungan, pelanggaran, perizinan.' },
        { property: 'og:image', content: '/og-obayan.png' },
      ],
      link: [
        { rel: 'icon', type: 'image/png', href: '/favicon.png' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap' }
      ]
    }
  },

  runtimeConfig: {
    public: {
      devVersion: process.env.NUXT_PUBLIC_DEV_VERSION || false,

      siteUrl: process.env.NUXT_PUBLIC_SITE_URL || 'https://obayan.id',
      siteName: process.env.NUXT_PUBLIC_SITE_NAME || 'Obayan',
      siteDescription: process.env.NUXT_PUBLIC_SITE_DESCRIPTION || 'Obayan — platform modern untuk pondok pesantren.',
      twitterSite: process.env.NUXT_PUBLIC_TWITTER_SITE || '@obayan',

      clientName: process.env.NUXT_PUBLIC_CLIENT_NAME || 'obayan',
      clientDisplayName: process.env.NUXT_PUBLIC_CLIENT_DISPLAY_NAME || 'Obayan',

      appName: process.env.NUXT_PUBLIC_APP_NAME || 'Obayan',
      appSubtitle: process.env.NUXT_PUBLIC_APP_SUBTITLE || 'Modern Education Platform',
      appLogo: process.env.NUXT_PUBLIC_APP_LOGO || '/assets/logo.png',
      appThemeColor: process.env.NUXT_PUBLIC_APP_THEME_COLOR || '#16a34a',

      ogImage: process.env.NUXT_PUBLIC_OG_IMAGE || '',

      heroBgImage: process.env.NUXT_PUBLIC_HERO_BG_IMAGE || '',
      heroTitleMain: process.env.NUXT_PUBLIC_HERO_TITLE_MAIN || '',
      heroTitleHighlight: process.env.NUXT_PUBLIC_HERO_TITLE_HIGHLIGHT || '',
      heroTagline: process.env.NUXT_PUBLIC_HERO_TAGLINE || '',
      heroSubtitle: process.env.NUXT_PUBLIC_HERO_SUBTITLE || '',
      waIntl: process.env.NUXT_PUBLIC_WA_INTL || '',
      schoolLevels: process.env.NUXT_PUBLIC_SCHOOL_LEVELS || '',
      ppdbTimeline: process.env.NUXT_PUBLIC_PPDB_TIMELINE || '',

      heroPrimaryLabel: process.env.NUXT_PUBLIC_HERO_PRIMARY_LABEL || '',
      heroPrimaryHref: process.env.NUXT_PUBLIC_HERO_PRIMARY_HREF || '',
      heroSecondaryLabel: process.env.NUXT_PUBLIC_HERO_SECONDARY_LABEL || '',
      heroSecondaryHref: process.env.NUXT_PUBLIC_HERO_SECONDARY_HREF || '',
      heroPpdbLabel: process.env.NUXT_PUBLIC_HERO_PPDB_LABEL || '',
      heroPpdbHref: process.env.NUXT_PUBLIC_HERO_PPDB_HREF || '',
      adminLabel: process.env.NUXT_PUBLIC_ADMIN_LABEL || '',

      instagramUrl: process.env.NUXT_PUBLIC_INSTAGRAM_URL || '',
      facebookUrl: process.env.NUXT_PUBLIC_FACEBOOK_URL || '',
      youtubeUrl: process.env.NUXT_PUBLIC_YOUTUBE_URL || '',

      cloudinaryCloudName: process.env.NUXT_PUBLIC_CLOUDINARY_CLOUD_NAME || process.env.CLOUDINARY_CLOUD_NAME || '',
      cloudinaryUploadPreset: process.env.NUXT_PUBLIC_CLOUDINARY_UPLOAD_PRESET || '',

      apiRemoteEnabled: String(process.env.NUXT_PUBLIC_API_REMOTE_ENABLED || 'false') === 'true',
      apiBaseUrl: process.env.API_BASE_URL || '',
      
       // Firebase
      firebaseApiKey: process.env.NUXT_PUBLIC_FIREBASE_API_KEY || '',
      firebaseAuthDomain: process.env.NUXT_PUBLIC_FIREBASE_AUTH_DOMAIN || '',
      firebaseDatabaseURL: process.env.NUXT_PUBLIC_FIREBASE_DATABASE_URL || '',
      firebaseProjectId: process.env.NUXT_PUBLIC_FIREBASE_PROJECT_ID || '',
      firebaseStorageBucket: process.env.NUXT_PUBLIC_FIREBASE_STORAGE_BUCKET || '',
      firebaseMessagingSenderId:
        process.env.NUXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID || '',
      firebaseAppId: process.env.NUXT_PUBLIC_FIREBASE_APP_ID || '',

      // MySQL existing user lookup only
      // Tidak create user baru di MySQL.
      enableMysqlUserLookup: process.env.NUXT_PUBLIC_ENABLE_MYSQL_USER_LOOKUP || 'true',
      mysqlUserLookupPath: process.env.NUXT_PUBLIC_MYSQL_USER_LOOKUP_PATH || '/users'
    },
    apiBaseUrl: process.env.API_BASE_URL || '',
    databaseHost: process.env.DATABASE_HOST || 'localhost',
    databasePort: process.env.DATABASE_PORT || '3306',
    databaseUser: process.env.DATABASE_USER || 'root',
    databasePassword: process.env.DATABASE_PASSWORD || '',
    databaseName: process.env.DATABASE_NAME || 'obayan',
    databaseConnectionLimit: process.env.DATABASE_CONNECTION_LIMIT || '10',
    jwtSecret: process.env.JWT_SECRET || 'supersecretkey',
    authSecret: process.env.AUTH_SECRET || 'arsades_secret_2026',
    authCookieName: process.env.AUTH_COOKIE_NAME || 'arsades_auth',
    authCookieMaxAge: process.env.AUTH_COOKIE_MAX_AGE || '604800000',
  },

  modules: ['nuxt-tiptap-editor'],
  tiptap: {
    prefix: 'Tiptap',
  },
})  