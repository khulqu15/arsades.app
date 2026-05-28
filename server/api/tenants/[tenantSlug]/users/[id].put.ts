import type { UpdateUserPayload } from '../../../../../types/rbac'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { updateUser } from '../../../../services/user.service'

export default defineEventHandler(async (event) => {
  const tenant = await resolveTenantFromEvent(event)
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID user tidak valid.'
    })
  }

  const body = await readBody<UpdateUserPayload>(event)

  return updateUser(
    id,
    {
      ...body,
      tenantId: body.tenantId || tenant.id
    },
    {
      tenantId: tenant.id
    }
  )
})