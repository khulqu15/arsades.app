import { resolveTenantFromEvent } from '../../../../../services/tenant.service'
import { getTenantNewsDetail } from '../../../../../services/news.service'

export default defineEventHandler(async (event) => {
    const tenant = await resolveTenantFromEvent(event)
    const slug = getRouterParam(event, 'slug')

    if (!slug) {
        throw createError({
            statusCode: 400,
            statusMessage: 'Slug berita wajib diisi.'
        })
    }

    return getTenantNewsDetail(tenant.id, slug)
})