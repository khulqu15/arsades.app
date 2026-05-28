import { createHmac, timingSafeEqual } from 'node:crypto'
import { deleteCookie, getCookie, setCookie } from 'h3'

export type AuthTokenPayload = {
  sub: string
  email: string
  tenantId?: string | null
  tenantSlug?: string | null
  iat: number
  exp: number
}

function base64UrlEncode(value: string | Buffer) {
  return Buffer.from(value)
    .toString('base64url')
}

function base64UrlDecode(value: string) {
  return Buffer.from(value, 'base64url').toString('utf8')
}

function getAuthSecret() {
  const config = useRuntimeConfig()
  const secret = String(config.authSecret || '')

  if (!secret || secret.length < 32) {
    throw createError({
      statusCode: 500,
      statusMessage: 'AUTH_SECRET minimal 32 karakter.'
    })
  }

  return secret
}

export function getAuthCookieName() {
  const config = useRuntimeConfig()

  return String(config.authCookieName || 'obayan_session')
}

export function getAuthMaxAge() {
  const config = useRuntimeConfig()

  return Number(config.authCookieMaxAge || 60 * 60 * 24 * 7)
}

function signValue(value: string) {
  return createHmac('sha256', getAuthSecret())
    .update(value)
    .digest('base64url')
}

export function signAuthToken(payload: Omit<AuthTokenPayload, 'iat' | 'exp'>) {
  const now = Math.floor(Date.now() / 1000)
  const maxAge = getAuthMaxAge()

  const header = {
    alg: 'HS256',
    typ: 'JWT'
  }

  const body: AuthTokenPayload = {
    ...payload,
    iat: now,
    exp: now + maxAge
  }

  const encodedHeader = base64UrlEncode(JSON.stringify(header))
  const encodedPayload = base64UrlEncode(JSON.stringify(body))
  const data = `${encodedHeader}.${encodedPayload}`
  const signature = signValue(data)

  return `${data}.${signature}`
}

export function verifyAuthToken(token?: string | null): AuthTokenPayload | null {
  if (!token) return null

  const parts = token.split('.')

  if (parts.length !== 3) return null

  const [header, payload, signature] = parts
  const data = `${header}.${payload}`
  const expectedSignature = signValue(data)

  const signatureBuffer = Buffer.from(signature)
  const expectedBuffer = Buffer.from(expectedSignature)

  if (signatureBuffer.length !== expectedBuffer.length) return null

  const isValidSignature = timingSafeEqual(signatureBuffer, expectedBuffer)

  if (!isValidSignature) return null

  try {
    const parsedPayload = JSON.parse(base64UrlDecode(payload)) as AuthTokenPayload
    const now = Math.floor(Date.now() / 1000)

    if (!parsedPayload.exp || parsedPayload.exp < now) {
      return null
    }

    return parsedPayload
  } catch {
    return null
  }
}

export function getAuthTokenFromEvent(event: any) {
  return getCookie(event, getAuthCookieName())
}

export function getAuthPayloadFromEvent(event: any) {
  const token = getAuthTokenFromEvent(event)

  return verifyAuthToken(token)
}

export function setAuthCookie(event: any, token: string) {
  const isProduction = process.env.NODE_ENV === 'production'

  setCookie(event, getAuthCookieName(), token, {
    httpOnly: true,
    secure: isProduction,
    sameSite: 'lax',
    path: '/',
    maxAge: getAuthMaxAge()
  })
}

export function clearAuthCookie(event: any) {
  deleteCookie(event, getAuthCookieName(), {
    path: '/'
  })
}