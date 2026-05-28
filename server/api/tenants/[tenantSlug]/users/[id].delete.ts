import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { deleteUser } from '../../../../services/user.service'

export default defineEventHandler(async (event) => {
  await resolveTenantFromEvent(event)

  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID user tidak valid.'
    })
  }

  return deleteUser(id)
})