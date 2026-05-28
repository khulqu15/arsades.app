import { useAuth } from '../composables/data/useAuth'

export default defineNuxtRouteMiddleware(async () => {
  if (import.meta.server) return

  const { user, fetchMe } = useAuth()

  if (!user.value) {
    await fetchMe()
  }

  if (user.value) {
    return navigateTo('/app')
  }
})