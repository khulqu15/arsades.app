import {
  getHeader,
  getMethod,
  sendNoContent,
  setResponseHeaders
} from 'h3'

export function setCorsHeaders(event: any) {
  const origin = getHeader(event, 'origin') || '*'
  const requestHeaders = getHeader(event, 'access-control-request-headers')

  setResponseHeaders(event, {
    'Access-Control-Allow-Origin': origin,
    'Vary': 'Origin',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'Access-Control-Allow-Headers':
      requestHeaders || 'Content-Type, Authorization, X-Requested-With, Accept, Origin',
    'Access-Control-Max-Age': '86400'
  })
}

export function handleCorsPreflight(event: any) {
  setCorsHeaders(event)

  if (getMethod(event) === 'OPTIONS') {
    return sendNoContent(event, 204)
  }

  return null
}