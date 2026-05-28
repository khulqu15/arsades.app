// server/middleware/cors.ts
import {
  getMethod,
  getRequestURL,
  sendNoContent,
  setResponseHeaders
} from 'h3'

export default defineEventHandler((event) => {
  const pathname = getRequestURL(event).pathname

  if (!pathname.startsWith('/api/')) return

  setResponseHeaders(event, {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'Access-Control-Allow-Headers':
      'Content-Type, Authorization, X-Requested-With, Accept, Origin',
    'Access-Control-Max-Age': '86400'
  })

  if (getMethod(event) === 'OPTIONS') {
    return sendNoContent(event, 204)
  }
})