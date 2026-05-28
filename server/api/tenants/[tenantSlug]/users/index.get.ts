import type { RoleCode, UserStatus } from '../../../../../types/rbac'
import { resolveTenantFromEvent } from '../../../../services/tenant.service'
import { getUserList } from '../../../../services/user.service'

export default defineEventHandler(async (event) => {
    const tenant = await resolveTenantFromEvent(event)
    const query = getQuery(event)

    return getUserList({
        tenantId: tenant.id,
        q: query.q ? String(query.q) : undefined,
        roleCode: query.role ? String(query.role) as RoleCode : undefined,
        status: query.status ? String(query.status) as UserStatus | 'all' : 'all',
        page: query.page ? Number(query.page) : 1,
        limit: query.limit ? Number(query.limit) : 20
    })
})