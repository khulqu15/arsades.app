import { getAuthenticatedUser } from '../services/auth.service'
import { getAuthPayloadFromEvent } from './auth-token'

export async function requireAuth(event: any) {
    const payload = getAuthPayloadFromEvent(event)

    if (!payload?.sub) {
        throw createError({
        statusCode: 401,
        statusMessage: 'Belum login.'
        })
    }

    const user = await getAuthenticatedUser({
        userId: payload.sub,
        tenantId: payload.tenantId || null
    })

    return {
        payload,
        user: user.data
    }
}

export async function requirePermission(
  event: any,
  permissionCode: string
) {
    const auth = await requireAuth(event)
    const permissions = auth.user.permissions || []
    if (!permissions.includes(permissionCode)) {
        throw createError({
        statusCode: 403,
        statusMessage: 'Anda tidak memiliki akses.'
        })
    }

    return auth
}