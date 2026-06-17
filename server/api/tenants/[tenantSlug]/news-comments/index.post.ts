import { getTenantSiteFromEvent } from '../../../../services/tenant-site.service'
import { createTenantNewsComment } from '../../../../services/news-comment.service'

function getClientIp(event: any) {
  const forwardedFor = getHeader(event, 'x-forwarded-for')
    ?.split(',')[0]
    ?.trim()

  return (
    forwardedFor ||
    getHeader(event, 'x-real-ip') ||
    event.node.req.socket.remoteAddress ||
    null
  )
}

export default defineEventHandler(async (event) => {
  const tenantResponse = await getTenantSiteFromEvent(event)
  const tenant = tenantResponse.data
  const body = await readBody(event)

  return await createTenantNewsComment(
    tenant.id,
    body,
    {
      ipAddress: getClientIp(event),
      userAgent: getHeader(event, 'user-agent') || null
    }
  )
})
