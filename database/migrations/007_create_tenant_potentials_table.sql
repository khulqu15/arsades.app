CREATE TABLE tenant_potentials (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    potential_type ENUM(
        'agriculture',
        'livestock',
        'fishery',
        'umkm',
        'tourism',
        'culture',
        'natural_resource',
        'human_resource',
        'industry',
        'creative_economy',
        'food',
        'craft',
        'custom'
    ) NOT NULL DEFAULT 'custom',

    title VARCHAR(180) NOT NULL,
    subtitle VARCHAR(500) NULL,
    slug VARCHAR(200) NOT NULL,

    icon VARCHAR(160) NULL,
    logo_url VARCHAR(700) NULL,
    image_url VARCHAR(700) NULL,

    content_html LONGTEXT NULL,
    content_json JSON NULL,

    address TEXT NULL,
    latitude DECIMAL(10, 7) NULL,
    longitude DECIMAL(10, 7) NULL,

    owner_name VARCHAR(180) NULL,
    manager_name VARCHAR(180) NULL,

    production_capacity VARCHAR(180) NULL,
    production_unit VARCHAR(80) NULL,
    market_reach VARCHAR(255) NULL,
    estimated_value DECIMAL(18, 2) NULL,

    email VARCHAR(190) NULL,
    phone VARCHAR(80) NULL,
    whatsapp VARCHAR(80) NULL,
    website_url VARCHAR(255) NULL,

    contact_config JSON NULL,
    statistic_config JSON NULL,
    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_tenant_potentials_tenant_slug (tenant_id, slug),

    KEY idx_tenant_potentials_tenant_status (tenant_id, status),
    KEY idx_tenant_potentials_tenant_type (tenant_id, potential_type, status),
    KEY idx_tenant_potentials_featured (tenant_id, is_featured, status, sort_order),
    KEY idx_tenant_potentials_sort (tenant_id, sort_order, created_at),

    FULLTEXT KEY ft_tenant_potentials_search (
        title,
        subtitle,
        content_html,
        address,
        owner_name,
        manager_name,
        market_reach
    ),

    CONSTRAINT fk_tenant_potentials_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;