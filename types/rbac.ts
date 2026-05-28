export type UUID = string

export type UserStatus = 'active' | 'inactive' | 'suspended'
export type RoleCode = 'super_admin' | 'admin_tenant' | 'user'
export type RoleScope = 'global' | 'tenant'

export type UserItem = {
  id: UUID
  name: string
  email: string
  avatarUrl: string | null
  phone: string | null
  status: UserStatus
  emailVerifiedAt: number | null
  lastLoginAt: number | null
  createdAt: number
  updatedAt: number
  roles: UserRoleSummary[]
  permissions?: string[]
}

export type UserRoleSummary = {
  roleCode: RoleCode | string
  roleName: string
  scope: RoleScope
  tenantId: UUID | null
  tenantSlug: string | null
  tenantName: string | null
}

export type RoleItem = {
  id: UUID
  code: RoleCode | string
  name: string
  description: string | null
  scope: RoleScope
  status: 'active' | 'inactive'
}

export type PermissionItem = {
  id: UUID
  code: string
  module: string
  action: string
  name: string
  description: string | null
  status: 'active' | 'inactive'
}

export type UserListResponse = {
  data: UserItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

export type RoleListResponse = {
  data: RoleItem[]
}

export type CreateUserPayload = {
  name: string
  email: string
  password?: string
  avatarUrl?: string | null
  phone?: string | null
  status?: UserStatus
  roleCode?: RoleCode
  tenantId?: UUID | null
}

export type UpdateUserPayload = {
  name?: string
  email?: string
  password?: string
  avatarUrl?: string | null
  phone?: string | null
  status?: UserStatus
  roleCode?: RoleCode
  tenantId?: UUID | null
}

export type UserListParams = {
  tenantId?: UUID | null
  q?: string
  roleCode?: RoleCode | string
  status?: UserStatus | 'all'
  page?: number
  limit?: number
}