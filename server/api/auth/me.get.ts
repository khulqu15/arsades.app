import { getAuthenticatedUser } from '../../services/auth.service'
import { getAuthPayloadFromEvent } from '../../utils/auth-token'

export default defineEventHandler(async (event) => {
  const payload = getAuthPayloadFromEvent(event)

  if (!payload?.sub) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Belum login.'
    })
  }

  return getAuthenticatedUser({
    userId: payload.sub,
    tenantId: payload.tenantId || null
  })
})