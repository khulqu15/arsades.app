// plugins/page-loading.client.ts
import { nextTick } from 'vue'

export default defineNuxtPlugin((nuxtApp) => {
  const isLoading = useState<boolean>('pageLoading', () => false)

  const flushDOM = async (frames = 2) => {
    await nextTick()
    for (let i = 0; i < frames; i++) {
      await new Promise<void>((r) => requestAnimationFrame(() => r()))
    }
  }

  const start = async () => {
    if (isLoading.value) return
    isLoading.value = true
    document.documentElement.setAttribute('aria-busy', 'true')
    // beri 1 frame supaya overlay terpasang rapi
    await flushDOM(1)
  }

  const finish = async () => {
    // tunggu patching komponen halaman selesai dulu
    await flushDOM(2)
    isLoading.value = false
    document.documentElement.removeAttribute('aria-busy')
  }

  // Router + Nuxt hooks
  nuxtApp.hook('app:router:beforeEach', async (to, from) => {
    if (to.fullPath !== from.fullPath) await start()
  })
  nuxtApp.hook('app:router:afterEach', async () => { await finish() })
  nuxtApp.hook('page:start', start)
  nuxtApp.hook('page:finish', async () => { await finish() })
  nuxtApp.hook('app:error', async () => { await finish() })
  nuxtApp.hook('vue:error', async () => { await finish() })
  nuxtApp.hook('app:mounted', async () => { await flushDOM(1); isLoading.value = false })

  return {
    provide: {
      pageLoading: { start, finish, state: isLoading }
    }
  }
})
