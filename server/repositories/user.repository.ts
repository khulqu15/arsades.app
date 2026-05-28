import type { PoolConnection, RowDataPacket } from 'mysql2/promise'
import type { RoleCode, UserStatus } from '../../types/rbac'
import { dbExecute, dbQuery } from '../utils/mysql'
import type { DbParams } from '../utils/mysql'

export type UserRow = RowDataPacket & {
  id: string
  name: string
  email: string
  password_hash: string | null
  avatar_url: string | null
  phone: string | null
  status: UserStatus
  email_verified_at: Date | string | null
  last_login_at: Date | string | null
  created_at: Date | string
  updated_at: Date | string

  role_codes: string | null
  role_names: string | null
  role_scopes: string | null
  tenant_ids: string | null
  tenant_slugs: string | null
  tenant_names: string | null
}

export type RoleRow = RowDataPacket & {
  id: string
  code: string
  name: string
  description: string | null
  scope: 'global' | 'tenant'
  status: 'active' | 'inactive'
}

export type PermissionRow = RowDataPacket & {
  id: string
  code: string
  module: string
  action: string
  name: string
  description: string | null
  status: 'active' | 'inactive'
}

export type UserListQuery = {
  tenantId?: string | null
  q?: string
  roleCode?: string
  status?: UserStatus | 'all'
  page?: number
  limit?: number
}

export type InsertUserInput = {
  id: string
  name: string
  email: string
  passwordHash: string | null
  avatarUrl: string | null
  phone: string | null
  status: UserStatus
}

export type UpdateUserInput = Partial<Omit<InsertUserInput, 'id' | 'passwordHash'> & {
  passwordHash: string | null
}>

const userSelect = `
  u.id,
  u.name,
  u.email,
  u.password_hash,
  u.avatar_url,
  u.phone,
  u.status,
  u.email_verified_at,
  u.last_login_at,
  u.created_at,
  u.updated_at,

  GROUP_CONCAT(DISTINCT r.code ORDER BY r.code SEPARATOR '||') AS role_codes,
  GROUP_CONCAT(DISTINCT r.name ORDER BY r.code SEPARATOR '||') AS role_names,
  GROUP_CONCAT(DISTINCT r.scope ORDER BY r.code SEPARATOR '||') AS role_scopes,
  GROUP_CONCAT(DISTINCT COALESCE(t.id, '') ORDER BY r.code SEPARATOR '||') AS tenant_ids,
  GROUP_CONCAT(DISTINCT COALESCE(t.slug, '') ORDER BY r.code SEPARATOR '||') AS tenant_slugs,
  GROUP_CONCAT(DISTINCT COALESCE(t.name, '') ORDER BY r.code SEPARATOR '||') AS tenant_names
`

function buildUserWhere(params: UserListQuery): {
  whereSql: string
  values: DbParams
} {
  const where: string[] = ['u.deleted_at IS NULL']
  const values: DbParams = []

  if (params.tenantId) {
    where.push(`
      (
        ur.tenant_id = ?
        OR r.code = 'super_admin'
      )
    `)
    values.push(params.tenantId)
  }

  if (params.q) {
    where.push(`
      (
        u.name LIKE ?
        OR u.email LIKE ?
        OR u.phone LIKE ?
      )
    `)

    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword)
  }

  if (params.roleCode) {
    where.push('r.code = ?')
    values.push(params.roleCode)
  }

  if (params.status && params.status !== 'all') {
    where.push('u.status = ?')
    values.push(params.status)
  }

  return {
    whereSql: `WHERE ${where.join(' AND ')}`,
    values
  }
}

export async function findUsers(params: UserListQuery) {
  const page = Math.max(Number(params.page || 1), 1)
  const limit = Math.min(Math.max(Number(params.limit || 20), 1), 100)
  const offset = (page - 1) * limit

  const safeLimit = Number.isFinite(limit) ? limit : 20
  const safeOffset = Number.isFinite(offset) ? offset : 0

  const { whereSql, values } = buildUserWhere(params)

  const countRows = await dbQuery<(RowDataPacket & { total: number })[]>(
    `
      SELECT COUNT(DISTINCT u.id) AS total
      FROM users u
      LEFT JOIN user_roles ur ON ur.user_id = u.id AND ur.deleted_at IS NULL
      LEFT JOIN roles r ON r.id = ur.role_id AND r.deleted_at IS NULL
      LEFT JOIN tenants t ON t.id = ur.tenant_id AND t.deleted_at IS NULL
      ${whereSql}
    `,
    values
  )

  const rows = await dbQuery<UserRow[]>(
    `
      SELECT ${userSelect}
      FROM users u
      LEFT JOIN user_roles ur ON ur.user_id = u.id AND ur.deleted_at IS NULL
      LEFT JOIN roles r ON r.id = ur.role_id AND r.deleted_at IS NULL
      LEFT JOIN tenants t ON t.id = ur.tenant_id AND t.deleted_at IS NULL
      ${whereSql}
      GROUP BY
        u.id,
        u.name,
        u.email,
        u.password_hash,
        u.avatar_url,
        u.phone,
        u.status,
        u.email_verified_at,
        u.last_login_at,
        u.created_at,
        u.updated_at
      ORDER BY u.created_at DESC
      LIMIT ${safeLimit} OFFSET ${safeOffset}
    `,
    values
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0),
    page,
    limit: safeLimit
  }
}

export async function findUserById(id: string) {
  const rows = await dbQuery<UserRow[]>(
    `
      SELECT ${userSelect}
      FROM users u
      LEFT JOIN user_roles ur ON ur.user_id = u.id AND ur.deleted_at IS NULL
      LEFT JOIN roles r ON r.id = ur.role_id AND r.deleted_at IS NULL
      LEFT JOIN tenants t ON t.id = ur.tenant_id AND t.deleted_at IS NULL
      WHERE u.id = ?
      AND u.deleted_at IS NULL
      GROUP BY
        u.id,
        u.name,
        u.email,
        u.password_hash,
        u.avatar_url,
        u.phone,
        u.status,
        u.email_verified_at,
        u.last_login_at,
        u.created_at,
        u.updated_at
      LIMIT 1
    `,
    [id]
  )

  return rows[0] || null
}

export async function findUserByEmail(email: string) {
  const rows = await dbQuery<UserRow[]>(
    `
      SELECT ${userSelect}
      FROM users u
      LEFT JOIN user_roles ur ON ur.user_id = u.id AND ur.deleted_at IS NULL
      LEFT JOIN roles r ON r.id = ur.role_id AND r.deleted_at IS NULL
      LEFT JOIN tenants t ON t.id = ur.tenant_id AND t.deleted_at IS NULL
      WHERE u.email = ?
      AND u.deleted_at IS NULL
      GROUP BY
        u.id,
        u.name,
        u.email,
        u.password_hash,
        u.avatar_url,
        u.phone,
        u.status,
        u.email_verified_at,
        u.last_login_at,
        u.created_at,
        u.updated_at
      LIMIT 1
    `,
    [email]
  )

  return rows[0] || null
}

export async function insertUser(
  input: InsertUserInput,
  connection: PoolConnection
) {
  await dbExecute(
    `
      INSERT INTO users (
        id,
        name,
        email,
        password_hash,
        avatar_url,
        phone,
        status
      )
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.name,
      input.email,
      input.passwordHash,
      input.avatarUrl,
      input.phone,
      input.status
    ],
    connection
  )

  return input.id
}

export async function updateUserById(
  id: string,
  input: UpdateUserInput,
  connection: PoolConnection
) {
  const fields: string[] = []
  const values: DbParams = []

  const map: Record<keyof UpdateUserInput, string> = {
    name: 'name',
    email: 'email',
    passwordHash: 'password_hash',
    avatarUrl: 'avatar_url',
    phone: 'phone',
    status: 'status'
  }

  for (const [key, column] of Object.entries(map)) {
    const value = input[key as keyof UpdateUserInput]

    if (typeof value === 'undefined') continue

    fields.push(`${column} = ?`)
    values.push(value)
  }

  if (!fields.length) return 0

  values.push(id)

  const result = await dbExecute(
    `
      UPDATE users
      SET ${fields.join(', ')}
      WHERE id = ?
      AND deleted_at IS NULL
    `,
    values,
    connection
  )

  return result.affectedRows
}

export async function softDeleteUserById(id: string) {
  const result = await dbExecute(
    `
      UPDATE users
      SET deleted_at = NOW()
      WHERE id = ?
      AND deleted_at IS NULL
    `,
    [id]
  )

  return result.affectedRows
}

export async function findRoles() {
  return dbQuery<RoleRow[]>(
    `
      SELECT
        id,
        code,
        name,
        description,
        scope,
        status
      FROM roles
      WHERE deleted_at IS NULL
      AND status = 'active'
      ORDER BY
        CASE code
          WHEN 'super_admin' THEN 1
          WHEN 'admin_tenant' THEN 2
          WHEN 'user' THEN 3
          ELSE 4
        END,
        name ASC
    `
  )
}

export async function findRoleByCode(code: RoleCode | string) {
  const rows = await dbQuery<RoleRow[]>(
    `
      SELECT
        id,
        code,
        name,
        description,
        scope,
        status
      FROM roles
      WHERE code = ?
      AND status = 'active'
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [code]
  )

  return rows[0] || null
}

export async function clearUserRolesByTenant(
  userId: string,
  tenantId: string | null,
  connection: PoolConnection
) {
  if (tenantId) {
    await dbExecute(
      `
        UPDATE user_roles
        SET deleted_at = NOW()
        WHERE user_id = ?
        AND tenant_id = ?
        AND deleted_at IS NULL
      `,
      [userId, tenantId],
      connection
    )

    return
  }

  await dbExecute(
    `
      UPDATE user_roles
      SET deleted_at = NOW()
      WHERE user_id = ?
      AND tenant_id IS NULL
      AND deleted_at IS NULL
    `,
    [userId],
    connection
  )
}

export async function assignUserRole(
  input: {
    id: string
    userId: string
    roleId: string
    tenantId: string | null
    assignedBy?: string | null
  },
  connection: PoolConnection
) {
  await dbExecute(
    `
      INSERT INTO user_roles (
        id,
        user_id,
        role_id,
        tenant_id,
        assigned_by
      )
      VALUES (?, ?, ?, ?, ?)
    `,
    [
      input.id,
      input.userId,
      input.roleId,
      input.tenantId,
      input.assignedBy || null
    ],
    connection
  )

  return input.id
}

export async function findPermissionsByUser(
  userId: string,
  tenantId?: string | null
) {
  const values: DbParams = [userId]

  let tenantWhere = ''

  if (tenantId) {
    tenantWhere = `
      AND (
        ur.tenant_id = ?
        OR r.code = 'super_admin'
      )
    `
    values.push(tenantId)
  }

  return dbQuery<PermissionRow[]>(
    `
      SELECT DISTINCT
        p.id,
        p.code,
        p.module,
        p.action,
        p.name,
        p.description,
        p.status
      FROM users u
      JOIN user_roles ur ON ur.user_id = u.id AND ur.deleted_at IS NULL
      JOIN roles r ON r.id = ur.role_id AND r.deleted_at IS NULL
      JOIN role_permissions rp ON rp.role_id = r.id
      JOIN permissions p ON p.id = rp.permission_id AND p.deleted_at IS NULL
      WHERE u.id = ?
      AND u.deleted_at IS NULL
      AND u.status = 'active'
      AND p.status = 'active'
      ${tenantWhere}
      ORDER BY p.module ASC, p.action ASC
    `,
    values
  )
}

export async function updateUserLastLoginAt(id: string) {
    const result = await dbExecute(
        `
            UPDATE users
            SET last_login_at = NOW()
            WHERE id = ?
            AND deleted_at IS NULL
        `,
        [id]
    )

    return result.affectedRows
}