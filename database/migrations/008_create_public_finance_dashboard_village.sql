CREATE TABLE tenant_public_metrics (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    metric_group VARCHAR(80) NOT NULL,
    metric_key VARCHAR(120) NOT NULL,

    label VARCHAR(160) NOT NULL,
    description VARCHAR(500) NULL,

    value_decimal DECIMAL(18, 2) NULL,
    value_text VARCHAR(190) NULL,
    value_unit VARCHAR(40) NULL,

    comparison_value DECIMAL(10, 2) NULL,
    comparison_unit VARCHAR(40) NULL,
    comparison_direction ENUM('up', 'down', 'same') NULL,

    period_type ENUM('realtime', 'daily', 'weekly', 'monthly', 'yearly', 'custom') NOT NULL DEFAULT 'realtime',
    period_start DATETIME NULL,
    period_end DATETIME NULL,

    icon VARCHAR(160) NULL,
    color VARCHAR(40) NULL,

    source_type ENUM('manual', 'analytics', 'system', 'api', 'import') NOT NULL DEFAULT 'manual',
    source_name VARCHAR(160) NULL,

    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_tenant_public_metrics_key (
        tenant_id,
        metric_group,
        metric_key,
        period_type,
        period_start
    ),

    KEY idx_tenant_public_metrics_group_status (
        tenant_id,
        metric_group,
        status,
        sort_order
    ),

    CONSTRAINT fk_tenant_public_metrics_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE village_officials (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    name VARCHAR(180) NOT NULL,
    slug VARCHAR(200) NOT NULL,

    position_title VARCHAR(180) NOT NULL,
    position_code VARCHAR(120) NULL,

    short_description VARCHAR(500) NULL,
    content_html LONGTEXT NULL,
    content_json JSON NULL,

    photo_url VARCHAR(700) NULL,
    icon VARCHAR(160) NULL,

    phone VARCHAR(80) NULL,
    whatsapp VARCHAR(80) NULL,
    email VARCHAR(190) NULL,

    attendance_status ENUM('present', 'away', 'leave', 'inactive', 'unknown') NOT NULL DEFAULT 'unknown',
    attendance_label VARCHAR(80) NULL,

    term_start DATE NULL,
    term_end DATE NULL,

    social_config JSON NULL,
    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_village_officials_tenant_slug (tenant_id, slug),

    KEY idx_village_officials_tenant_status (
        tenant_id,
        status,
        sort_order
    ),

    KEY idx_village_officials_featured (
        tenant_id,
        is_featured,
        status,
        sort_order
    ),

    CONSTRAINT fk_village_officials_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE village_budget_periods (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    budget_year YEAR NOT NULL,

    title VARCHAR(180) NOT NULL,
    subtitle VARCHAR(500) NULL,

    currency_code CHAR(3) NOT NULL DEFAULT 'IDR',

    legal_basis VARCHAR(255) NULL,
    source_name VARCHAR(190) NULL,
    source_url VARCHAR(700) NULL,

    notes TEXT NULL,

    metadata JSON NULL,

    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'published',
    is_current TINYINT(1) NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_village_budget_period_tenant_year (
        tenant_id,
        budget_year
    ),

    KEY idx_village_budget_period_current (
        tenant_id,
        is_current,
        status
    ),

    CONSTRAINT fk_village_budget_periods_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE village_budget_lines (
    id CHAR(36) NOT NULL,
    budget_period_id CHAR(36) NOT NULL,

    parent_id CHAR(36) NULL,

    line_type ENUM('revenue', 'expense', 'financing') NOT NULL,

    line_group VARCHAR(120) NULL,
    line_code VARCHAR(80) NULL,

    title VARCHAR(220) NOT NULL,
    slug VARCHAR(240) NOT NULL,

    description VARCHAR(700) NULL,

    budget_amount DECIMAL(18, 2) NOT NULL DEFAULT 0,
    realized_amount DECIMAL(18, 2) NOT NULL DEFAULT 0,

    unit VARCHAR(80) NULL,

    icon VARCHAR(160) NULL,
    color VARCHAR(40) NULL,

    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_village_budget_line_period_slug (
        budget_period_id,
        slug
    ),

    KEY idx_village_budget_lines_type_status (
        budget_period_id,
        line_type,
        status,
        sort_order
    ),

    KEY idx_village_budget_lines_parent (
        parent_id
    ),

    CONSTRAINT fk_village_budget_lines_period
        FOREIGN KEY (budget_period_id) REFERENCES village_budget_periods(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_village_budget_lines_parent
        FOREIGN KEY (parent_id) REFERENCES village_budget_lines(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;