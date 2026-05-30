import {
  defineEventHandler,
  getHeader,
  sendNoContent,
  setResponseHeaders
} from 'h3'

export default defineEventHandler((event) => {
  const requestHeaders = getHeader(event, 'access-control-request-headers')

  setResponseHeaders(event, {
    'Access-Control-Allow-Origin': '*',
    'Vary': 'Origin',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'Access-Control-Allow-Headers':
      requestHeaders || 'Content-Type, Authorization, X-Requested-With, Accept, Origin',
    'Access-Control-Max-Age': '86400'
  })

  return sendNoContent(event, 204)
})