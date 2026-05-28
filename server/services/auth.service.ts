import bcrypt from 'bcryptjs'
import type { CreateUserPayload } from '../../types/rbac'
import { findTenantBySlug } from '../repositories/tenant.repository'
import {
  findPermissionsByUser,
  findUserByEmail,
  findUserById,
  updateUserLastLoginAt
} from '../repositories/user.repository'
import { createUser, getUserDetail } from './user.service'
import { signAuthToken } from '../utils/auth-token'

function normalizeEmail(email: string) {
  return email.trim().toLowerCase()
}

function getRoleCodes(user: Awaited<ReturnType<typeof getUserDetail>>['data']) {
  return user.roles.map((role) => role.roleCode)
}

export async function loginWithEmailPassword(payload: {
  email: string
  password: string
  tenantSlug: string
}) {
  if (!payload.email || !payload.password) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Email dan password wajib diisi.'
    })
  }

  const tenant = await findTenantBySlug(payload.tenantSlug)

  if (!tenant) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan.'
    })
  }

  const email = normalizeEmail(payload.email)
  const user = await findUserByEmail(email)

  if (!user || !user.password_hash) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Email atau password salah.'
    })
  }

  if (user.status !== 'active') {
    throw createError({
      statusCode: 403,
      statusMessage: 'Akun tidak aktif.'
    })
  }

  const passwordValid = await bcrypt.compare(payload.password, user.password_hash)

  if (!passwordValid) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Email atau password salah.'
    })
  }

  const detail = await getUserDetail(user.id, tenant.id)
  const roleCodes = getRoleCodes(detail.data)

  const isSuperAdmin = roleCodes.includes('super_admin')
  const hasTenantRole = detail.data.roles.some((role) => role.tenantId === tenant.id)

  if (!isSuperAdmin && !hasTenantRole) {
    throw createError({
      statusCode: 403,
      statusMessage: 'Akun tidak memiliki akses ke tenant ini.'
    })
  }

  await updateUserLastLoginAt(user.id)

  const permissions = await findPermissionsByUser(user.id, tenant.id)

  const token = signAuthToken({
    sub: user.id,
    email: user.email,
    tenantId: tenant.id,
    tenantSlug: tenant.slug
  })

  return {
    token,
    user: {
      ...detail.data,
      permissions: permissions.map((permission) => permission.code)
    }
  }
}

export async function registerTenantUser(payload: CreateUserPayload & {
  tenantSlug: string
}) {
  if (!payload.tenantSlug) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Tenant wajib diisi.'
    })
  }

  if (!payload.password || payload.password.length < 8) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Password minimal 8 karakter.'
    })
  }

  const tenant = await findTenantBySlug(payload.tenantSlug)

  if (!tenant) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan.'
    })
  }

  const created = await createUser(
    {
      name: payload.name,
      email: payload.email,
      password: payload.password,
      phone: payload.phone || null,
      avatarUrl: payload.avatarUrl || null,
      status: 'active',
      roleCode: 'user',
      tenantId: tenant.id
    },
    {
      tenantId: tenant.id
    }
  )

  const token = signAuthToken({
    sub: created.data.id,
    email: created.data.email,
    tenantId: tenant.id,
    tenantSlug: tenant.slug
  })

  return {
    token,
    user: created.data
  }
}

export async function getAuthenticatedUser(payload: {
  userId: string
  tenantId?: string | null
}) {
  const user = await findUserById(payload.userId)

  if (!user) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Sesi tidak valid.'
    })
  }

  if (user.status !== 'active') {
    throw createError({
      statusCode: 403,
      statusMessage: 'Akun tidak aktif.'
    })
  }

  const detail = await getUserDetail(user.id, payload.tenantId || null)

  return detail
}