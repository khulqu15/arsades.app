CREATE TABLE news_comments (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,
    news_id CHAR(36) NOT NULL,

    parent_id CHAR(36) NULL,

    author_name VARCHAR(160) NOT NULL,
    author_email VARCHAR(190) NOT NULL,
    author_phone VARCHAR(80) NULL,

    content TEXT NOT NULL,

    likes_count INT UNSIGNED NOT NULL DEFAULT 0,
    dislikes_count INT UNSIGNED NOT NULL DEFAULT 0,

    status ENUM('pending', 'approved', 'rejected', 'spam', 'hidden') NOT NULL DEFAULT 'pending',

    ip_address VARCHAR(45) NULL,
    user_agent VARCHAR(500) NULL,

    approved_at DATETIME NULL,
    approved_by CHAR(36) NULL,

    metadata JSON NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    KEY idx_news_comments_tenant_news_status (
        tenant_id,
        news_id,
        status,
        created_at
    ),

    KEY idx_news_comments_parent (
        parent_id
    ),

    KEY idx_news_comments_author_email (
        tenant_id,
        author_email
    ),

    CONSTRAINT fk_news_comments_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_news_comments_news
        FOREIGN KEY (news_id) REFERENCES news(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_news_comments_parent
        FOREIGN KEY (parent_id) REFERENCES news_comments(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_news_comments_approved_by
        FOREIGN KEY (approved_by) REFERENCES users(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE tenant_complaints (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    public_code VARCHAR(40) NULL,

    service_type ENUM('aduan', 'laporan', 'pengajuan') NOT NULL DEFAULT 'aduan',

    title VARCHAR(180) NULL,
    message TEXT NOT NULL,

    reporter_name VARCHAR(160) NOT NULL,
    reporter_email VARCHAR(190) NOT NULL,
    reporter_phone VARCHAR(80) NULL,

    address TEXT NULL,
    latitude DECIMAL(10, 7) NULL,
    longitude DECIMAL(10, 7) NULL,

    attachment_config JSON NULL,

    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    status ENUM(
        'new',
        'in_review',
        'in_progress',
        'resolved',
        'rejected',
        'closed'
    ) NOT NULL DEFAULT 'new',

    assigned_to CHAR(36) NULL,

    response_text TEXT NULL,
    response_at DATETIME NULL,
    resolved_at DATETIME NULL,
    closed_at DATETIME NULL,

    source_type ENUM('public_form', 'admin', 'api', 'import') NOT NULL DEFAULT 'public_form',

    metadata JSON NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_tenant_complaints_public_code (
        tenant_id,
        public_code
    ),

    KEY idx_tenant_complaints_tenant_status (
        tenant_id,
        status,
        created_at
    ),

    KEY idx_tenant_complaints_tenant_service_status (
        tenant_id,
        service_type,
        status,
        created_at
    ),

    KEY idx_tenant_complaints_reporter_email (
        tenant_id,
        reporter_email
    ),

    KEY idx_tenant_complaints_assigned_to (
        assigned_to
    ),

    CONSTRAINT fk_tenant_complaints_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tenant_complaints_assigned_to
        FOREIGN KEY (assigned_to) REFERENCES users(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
