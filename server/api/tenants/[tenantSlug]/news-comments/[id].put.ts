import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { updateTenantNewsComment } from '../../../../services/news-comment.service'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID komentar wajib diisi.'
    })
  }

  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await updateTenantNewsComment(tenant.id, id, body)
})
