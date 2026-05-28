import type { UpdateNewsPayload } from '../../../../../types/news'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { updateTenantNews } from '../../../../services/news.service'

export default defineEventHandler(async (event) => {
    const tenant = await resolveTenantFromEvent(event)
    const id = getRouterParam(event, 'id')

    if (!id) {
        throw createError({
            statusCode: 400,
            statusMessage: 'ID berita tidak valid.'
        })
    }

    const body = await readBody<UpdateNewsPayload>(event)

    return updateTenantNews(tenant.id, id, body)
})