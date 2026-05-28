import type { CreateNewsPayload } from '../../../../../types/news'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { createTenantNews } from '../../../../services/news.service'

export default defineEventHandler(async (event) => {
    const tenant = await resolveTenantFromEvent(event)
    const body = await readBody<CreateNewsPayload>(event)

    return createTenantNews(tenant.id, body)
})