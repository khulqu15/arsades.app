import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { getUserDetail } from '../../../../services/user.service'

export default defineEventHandler(async (event) => {
  const tenant = await resolveTenantFromEvent(event)
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID user tidak valid.'
    })
  }

  return getUserDetail(id, tenant.id)
})