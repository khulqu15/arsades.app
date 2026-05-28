import type { CreateUserPayload } from '../../../../../types/rbac'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { createUser } from '../../../../services/user.service'

export default defineEventHandler(async (event) => {
  const tenant = await resolveTenantFromEvent(event)
  const body = await readBody<CreateUserPayload>(event)

  return createUser(
    {
      ...body,
      tenantId: body.tenantId || tenant.id,
      roleCode: body.roleCode || 'user'
    },
    {
      tenantId: tenant.id
    }
  )
})