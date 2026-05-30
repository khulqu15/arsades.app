// server/middleware/cors.ts
import { getRequestURL } from 'h3'
import { handleCorsPreflight, setCorsHeaders } from '../../server/utils/cors'

export default defineEventHandler((event) => {
  const pathname = getRequestURL(event).pathname

  if (!pathname.startsWith('/api/')) return

  const preflight = handleCorsPreflight(event)
  if (preflight) return preflight

  setCorsHeaders(event)
})