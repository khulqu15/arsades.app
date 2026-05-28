CREATE TABLE tenant_organizations (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,
    parent_id CHAR(36) NULL,

    organization_type ENUM(
        'government',
        'village_government',
        'bumdes',
        'youth',
        'women',
        'community',
        'religious',
        'education',
        'health',
        'umkm',
        'tourism',
        'culture',
        'security',
        'custom'
    ) NOT NULL DEFAULT 'custom',

    name VARCHAR(180) NOT NULL,
    display_name VARCHAR(180) NULL,
    slug VARCHAR(180) NOT NULL,

    short_description VARCHAR(500) NULL,
    description TEXT NULL,

    logo_url VARCHAR(700) NULL,
    cover_url VARCHAR(700) NULL,

    email VARCHAR(190) NULL,
    phone VARCHAR(80) NULL,
    whatsapp VARCHAR(80) NULL,
    website_url VARCHAR(255) NULL,

    address TEXT NULL,
    latitude DECIMAL(10, 7) NULL,
    longitude DECIMAL(10, 7) NULL,

    contact_config JSON NULL,
    address_config JSON NULL,
    social_config JSON NULL,
    operational_hours JSON NULL,
    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_tenant_organizations_tenant_slug (tenant_id, slug),

    KEY idx_tenant_organizations_tenant_status (tenant_id, status),
    KEY idx_tenant_organizations_tenant_type (tenant_id, organization_type, status),
    KEY idx_tenant_organizations_featured (tenant_id, is_featured, status, sort_order),
    KEY idx_tenant_organizations_parent (parent_id),

    CONSTRAINT fk_tenant_organizations_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tenant_organizations_parent
        FOREIGN KEY (parent_id) REFERENCES tenant_organizations(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;