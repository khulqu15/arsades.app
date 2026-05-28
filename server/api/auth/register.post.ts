import type { CreateUserPayload } from '../../../types/rbac'
import { registerTenantUser } from '../../services/auth.service'
import { setAuthCookie } from '../../utils/auth-token'

export default defineEventHandler(async (event) => {
  const body = await readBody<CreateUserPayload & {
    tenantSlug?: string
  }>(event)

  const runtime = useRuntimeConfig()

  const tenantSlug =
    body.tenantSlug ||
    String(runtime.public?.clientName || 'martopuro')

  const result = await registerTenantUser({
    ...body,
    tenantSlug
  })

  setAuthCookie(event, result.token)

  return {
    data: result.user,
    message: 'Registrasi berhasil.'
  }
})