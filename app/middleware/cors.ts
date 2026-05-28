import { getHeader, getMethod, getRequestURL, sendNoContent, setResponseHeaders } from 'h3'

export default defineEventHandler((event) => {
    const pathname = getRequestURL(event).pathname
    if (!pathname.startsWith('/api/')) return

    const allowedOrigins = String(process.env.CORS_ORIGINS || '')
        .split(',')
        .map((item) => item.trim())
        .filter(Boolean)

    const origin = getHeader(event, 'origin') || ''
    const allowAny = allowedOrigins.includes('*')
    const isAllowed = allowAny || allowedOrigins.includes(origin)

    if (isAllowed) {
        setResponseHeaders(event, {
            'Access-Control-Allow-Origin': allowAny ? '*' : origin,
            'Vary': 'Origin',
            'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With',
            'Access-Control-Allow-Credentials': 'true',
        })
    }

    if (getMethod(event) === 'OPTIONS') return sendNoContent(event, 204)
})