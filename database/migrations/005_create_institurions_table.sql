CREATE TABLE tenant_institutions (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    title VARCHAR(180) NOT NULL,
    subtitle VARCHAR(500) NULL,
    slug VARCHAR(200) NOT NULL,

    icon VARCHAR(160) NULL,
    logo_url VARCHAR(700) NULL,

    content_html LONGTEXT NULL,
    content_json JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_tenant_institutions_tenant_slug (tenant_id, slug),

    KEY idx_tenant_institutions_tenant_status (tenant_id, status),
    KEY idx_tenant_institutions_featured (tenant_id, is_featured, status, sort_order),
    KEY idx_tenant_institutions_sort (tenant_id, sort_order, created_at),

    CONSTRAINT fk_tenant_institutions_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;