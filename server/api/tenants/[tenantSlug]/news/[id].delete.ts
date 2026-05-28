import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { deleteTenantNews } from '../../../../services/news.service'

export default defineEventHandler(async (event) => {
    const tenant = await resolveTenantFromEvent(event)
    const id = getRouterParam(event, 'id')

    if (!id) {
        throw createError({
            statusCode: 400,
            statusMessage: 'ID berita tidak valid.'
        })
    }

    return deleteTenantNews(tenant.id, id)
})