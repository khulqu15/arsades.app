import { randomUUID } from 'node:crypto'
import bcrypt from 'bcryptjs'
import type {
  CreateUserPayload,
  RoleCode,
  RoleItem,
  UpdateUserPayload,
  UserItem,
  UserListParams,
  UserRoleSummary,
  UserStatus
} from '../../types/rbac'
import { withTransaction } from '../utils/mysql'
import {
  assignUserRole,
  clearUserRolesByTenant,
  findPermissionsByUser,
  findRoleByCode,
  findRoles,
  findUserByEmail,
  findUserById,
  findUsers,
  insertUser,
  softDeleteUserById,
  updateUserById,
  type RoleRow,
  type UserRow
} from '../repositories/user.repository'

const allowedStatuses: UserStatus[] = ['active', 'inactive', 'suspended']
const allowedRoles: RoleCode[] = ['super_admin', 'admin_tenant', 'user']

function createUuid() {
  return randomUUID()
}

function normalizeEmail(email: string) {
  return email.trim().toLowerCase()
}

function normalizeStatus(value?: string): UserStatus {
  if (value && allowedStatuses.includes(value as UserStatus)) {
    return value as UserStatus
  }

  return 'active'
}

function normalizeRoleCode(value?: string): RoleCode {
  if (value && allowedRoles.includes(value as RoleCode)) {
    return value as RoleCode
  }

  return 'user'
}

function toTimestamp(value: Date | string | null | undefined) {
  if (!value) return null
  return new Date(value).getTime()
}

function splitConcat(value?: string | null) {
  if (!value) return []

  return value
    .split('||')
    .map((item) => item.trim())
    .filter(Boolean)
}

async function hashPassword(password?: string) {
  if (!password) return null

  if (password.length < 8) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Password minimal 8 karakter.'
    })
  }

  return bcrypt.hash(password, 10)
}

function mapRoleRow(row: RoleRow): RoleItem {
  return {
    id: row.id,
    code: row.code,
    name: row.name,
    description: row.description,
    scope: row.scope,
    status: row.status
  }
}

function mapUserRow(row: UserRow, permissions?: string[]): UserItem {
  const roleCodes = splitConcat(row.role_codes)
  const roleNames = splitConcat(row.role_names)
  const roleScopes = splitConcat(row.role_scopes)
  const tenantIds = splitConcat(row.tenant_ids)
  const tenantSlugs = splitConcat(row.tenant_slugs)
  const tenantNames = splitConcat(row.tenant_names)

  const roles: UserRoleSummary[] = roleCodes.map((roleCode, index) => {
    return {
      roleCode,
      roleName: roleNames[index] || roleCode,
      scope: roleScopes[index] === 'global' ? 'global' : 'tenant',
      tenantId: tenantIds[index] || null,
      tenantSlug: tenantSlugs[index] || null,
      tenantName: tenantNames[index] || null
    }
  })

  return {
    id: row.id,
    name: row.name,
    email: row.email,
    avatarUrl: row.avatar_url,
    phone: row.phone,
    status: row.status,
    emailVerifiedAt: toTimestamp(row.email_verified_at),
    lastLoginAt: toTimestamp(row.last_login_at),
    createdAt: new Date(row.created_at).getTime(),
    updatedAt: new Date(row.updated_at).getTime(),
    roles,
    permissions
  }
}

export async function getUserList(params: UserListParams) {
  const result = await findUsers(params)

  return {
    data: result.rows.map((row) => mapUserRow(row)),
    meta: {
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: Math.ceil(result.total / result.limit)
    }
  }
}

export async function getUserDetail(
  id: string,
  tenantId?: string | null
) {
  const user = await findUserById(id)

  if (!user) {
    throw createError({
      statusCode: 404,
      statusMessage: 'User tidak ditemukan.'
    })
  }

  const permissions = await findPermissionsByUser(id, tenantId)

  return {
    data: mapUserRow(
      user,
      permissions.map((permission) => permission.code)
    )
  }
}

export async function getRoleList() {
  const roles = await findRoles()

  return {
    data: roles.map(mapRoleRow)
  }
}

export async function createUser(
  payload: CreateUserPayload,
  options?: {
    tenantId?: string | null
    assignedBy?: string | null
  }
) {
  if (!payload.name || payload.name.trim().length < 2) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Nama user minimal 2 karakter.'
    })
  }

  if (!payload.email || !payload.email.includes('@')) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Email tidak valid.'
    })
  }

  const email = normalizeEmail(payload.email)
  const existing = await findUserByEmail(email)

  if (existing) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Email sudah digunakan.'
    })
  }

  const roleCode = normalizeRoleCode(payload.roleCode)
  const role = await findRoleByCode(roleCode)

  if (!role) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Role tidak ditemukan.'
    })
  }

  const tenantId =
    role.scope === 'global'
      ? null
      : payload.tenantId || options?.tenantId || null

  if (role.scope === 'tenant' && !tenantId) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Tenant wajib diisi untuk role tenant.'
    })
  }

  const passwordHash = await hashPassword(payload.password || 'Password123')

  const userId = await withTransaction(async (connection) => {
    const insertedUserId = await insertUser(
      {
        id: createUuid(),
        name: payload.name.trim(),
        email,
        passwordHash,
        avatarUrl: payload.avatarUrl || null,
        phone: payload.phone || null,
        status: normalizeStatus(payload.status)
      },
      connection
    )

    await assignUserRole(
      {
        id: createUuid(),
        userId: insertedUserId,
        roleId: role.id,
        tenantId,
        assignedBy: options?.assignedBy || null
      },
      connection
    )

    return insertedUserId
  })

  return getUserDetail(userId, tenantId)
}

export async function updateUser(
  id: string,
  payload: UpdateUserPayload,
  options?: {
    tenantId?: string | null
    assignedBy?: string | null
  }
) {
  const existing = await findUserById(id)

  if (!existing) {
    throw createError({
      statusCode: 404,
      statusMessage: 'User tidak ditemukan.'
    })
  }

  let email: string | undefined

  if (payload.email) {
    email = normalizeEmail(payload.email)

    if (email !== existing.email) {
      const duplicated = await findUserByEmail(email)

      if (duplicated) {
        throw createError({
          statusCode: 409,
          statusMessage: 'Email sudah digunakan.'
        })
      }
    }
  }

  const passwordHash =
    typeof payload.password === 'string'
      ? await hashPassword(payload.password)
      : undefined

  await withTransaction(async (connection) => {
    await updateUserById(
      id,
      {
        name: payload.name?.trim(),
        email,
        passwordHash,
        avatarUrl: payload.avatarUrl,
        phone: payload.phone,
        status: payload.status
      },
      connection
    )

    if (payload.roleCode) {
      const roleCode = normalizeRoleCode(payload.roleCode)
      const role = await findRoleByCode(roleCode)

      if (!role) {
        throw createError({
          statusCode: 404,
          statusMessage: 'Role tidak ditemukan.'
        })
      }

      const tenantId =
        role.scope === 'global'
          ? null
          : payload.tenantId || options?.tenantId || null

      if (role.scope === 'tenant' && !tenantId) {
        throw createError({
          statusCode: 422,
          statusMessage: 'Tenant wajib diisi untuk role tenant.'
        })
      }

      await clearUserRolesByTenant(id, tenantId, connection)

      await assignUserRole(
        {
          id: createUuid(),
          userId: id,
          roleId: role.id,
          tenantId,
          assignedBy: options?.assignedBy || null
        },
        connection
      )
    }
  })

  return getUserDetail(id, options?.tenantId || null)
}

export async function deleteUser(id: string) {
  const affectedRows = await softDeleteUserById(id)

  if (!affectedRows) {
    throw createError({
      statusCode: 404,
      statusMessage: 'User tidak ditemukan.'
    })
  }

  return {
    message: 'User berhasil dihapus.'
  }
}

export async function userHasPermission(
  userId: string,
  permissionCode: string,
  tenantId?: string | null
) {
  const permissions = await findPermissionsByUser(userId, tenantId)

  return permissions.some((permission) => permission.code === permissionCode)
}