SET @role_super_admin_id = UUID();
SET @role_admin_tenant_id = UUID();
SET @role_user_id = UUID();

INSERT INTO roles (
  id,
  code,
  name,
  description,
  scope,
  status
) VALUES
(
  @role_super_admin_id,
  'super_admin',
  'Super Admin',
  'Memiliki akses penuh ke semua tenant dan semua fitur.',
  'global',
  'active'
),
(
  @role_admin_tenant_id,
  'admin_tenant',
  'Admin Tenant',
  'Mengelola data dan konten pada tenant tertentu.',
  'tenant',
  'active'
),
(
  @role_user_id,
  'user',
  'User',
  'Pengguna umum dengan akses dasar.',
  'tenant',
  'active'
)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description),
  scope = VALUES(scope),
  status = VALUES(status),
  deleted_at = NULL;


SET @role_super_admin_id = (SELECT id FROM roles WHERE code = 'super_admin' LIMIT 1);
SET @role_admin_tenant_id = (SELECT id FROM roles WHERE code = 'admin_tenant' LIMIT 1);
SET @role_user_id = (SELECT id FROM roles WHERE code = 'user' LIMIT 1);


INSERT INTO permissions (
  id,
  code,
  module,
  action,
  name,
  description,
  status
) VALUES
(UUID(), 'tenant.read', 'tenant', 'read', 'Read Tenant', 'Melihat data tenant.', 'active'),
(UUID(), 'tenant.manage', 'tenant', 'manage', 'Manage Tenant', 'Mengelola tenant.', 'active'),

(UUID(), 'user.read', 'user', 'read', 'Read User', 'Melihat data user.', 'active'),
(UUID(), 'user.create', 'user', 'create', 'Create User', 'Membuat user.', 'active'),
(UUID(), 'user.update', 'user', 'update', 'Update User', 'Mengubah user.', 'active'),
(UUID(), 'user.delete', 'user', 'delete', 'Delete User', 'Menghapus user.', 'active'),

(UUID(), 'rbac.read', 'rbac', 'read', 'Read RBAC', 'Melihat role dan permission.', 'active'),
(UUID(), 'rbac.manage', 'rbac', 'manage', 'Manage RBAC', 'Mengelola role dan permission.', 'active'),

(UUID(), 'news.read', 'news', 'read', 'Read News', 'Melihat berita.', 'active'),
(UUID(), 'news.create', 'news', 'create', 'Create News', 'Membuat berita.', 'active'),
(UUID(), 'news.update', 'news', 'update', 'Update News', 'Mengubah berita.', 'active'),
(UUID(), 'news.delete', 'news', 'delete', 'Delete News', 'Menghapus berita.', 'active'),

(UUID(), 'site.read', 'site', 'read', 'Read Site Config', 'Melihat konfigurasi website.', 'active'),
(UUID(), 'site.update', 'site', 'update', 'Update Site Config', 'Mengubah konfigurasi website.', 'active')
ON DUPLICATE KEY UPDATE
  module = VALUES(module),
  action = VALUES(action),
  name = VALUES(name),
  description = VALUES(description),
  status = VALUES(status),
  deleted_at = NULL;


DELETE FROM role_permissions
WHERE role_id IN (@role_super_admin_id, @role_admin_tenant_id, @role_user_id);


INSERT INTO role_permissions (role_id, permission_id)
SELECT @role_super_admin_id, id
FROM permissions
WHERE status = 'active'
AND deleted_at IS NULL;


INSERT INTO role_permissions (role_id, permission_id)
SELECT @role_admin_tenant_id, id
FROM permissions
WHERE code IN (
  'tenant.read',
  'user.read',
  'user.create',
  'user.update',
  'news.read',
  'news.create',
  'news.update',
  'news.delete',
  'site.read',
  'site.update'
)
AND status = 'active'
AND deleted_at IS NULL;


INSERT INTO role_permissions (role_id, permission_id)
SELECT @role_user_id, id
FROM permissions
WHERE code IN (
  'tenant.read',
  'news.read',
  'site.read'
)
AND status = 'active'
AND deleted_at IS NULL;


SET @super_admin_user_id = UUID();

INSERT INTO users (
  id,
  name,
  email,
  password_hash,
  status,
  email_verified_at
) VALUES (
  @super_admin_user_id,
  'Super Admin',
  'superadmin@obayan.id',
  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
  'active',
  NOW()
)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  status = VALUES(status),
  deleted_at = NULL;


SET @super_admin_user_id = (
  SELECT id FROM users
  WHERE email = 'superadmin@obayan.id'
  LIMIT 1
);


INSERT INTO user_roles (
  id,
  user_id,
  role_id,
  tenant_id,
  assigned_by
)
SELECT
  UUID(),
  @super_admin_user_id,
  @role_super_admin_id,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1
  FROM user_roles
  WHERE user_id = @super_admin_user_id
  AND role_id = @role_super_admin_id
  AND tenant_id IS NULL
  AND deleted_at IS NULL
);