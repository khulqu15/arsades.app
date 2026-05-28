SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS news_tag_map;
DROP TABLE IF EXISTS news;
DROP TABLE IF EXISTS news_tags;
DROP TABLE IF EXISTS news_categories;
DROP TABLE IF EXISTS tenants;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE tenants (
    id CHAR(36) NOT NULL,

    name VARCHAR(160) NOT NULL,
    display_name VARCHAR(160) NULL,
    slug VARCHAR(120) NOT NULL,
    tenant_type ENUM('village', 'school', 'pesantren', 'company', 'custom') NOT NULL DEFAULT 'custom',

    domain VARCHAR(190) NULL,
    site_url VARCHAR(255) NULL,

    logo_url VARCHAR(700) NULL,
    favicon_url VARCHAR(700) NULL,
    og_image_url VARCHAR(700) NULL,

    primary_color VARCHAR(40) NULL,
    description TEXT NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',

    metadata JSON NULL,

    theme_config JSON NULL,
    seo_config JSON NULL,
    hero_config JSON NULL,
    contact_config JSON NULL,
    statistic_config JSON NULL,
    culture_config JSON NULL,
    warta_config JSON NULL,
    footer_config JSON NULL,
    navigation_config JSON NULL,
    social_config JSON NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),
    UNIQUE KEY uq_tenants_slug (slug),
    UNIQUE KEY uq_tenants_domain (domain),
    KEY idx_tenants_status (status),
    KEY idx_tenants_type_status (tenant_type, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE news_categories (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    name VARCHAR(140) NOT NULL,
    slug VARCHAR(160) NOT NULL,
    description VARCHAR(500) NULL,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),
    UNIQUE KEY uq_news_categories_tenant_slug (tenant_id, slug),
    KEY idx_news_categories_tenant_status (tenant_id, status),

    CONSTRAINT fk_news_categories_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE news_tags (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    name VARCHAR(120) NOT NULL,
    slug VARCHAR(140) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),
    UNIQUE KEY uq_news_tags_tenant_slug (tenant_id, slug),
    KEY idx_news_tags_tenant (tenant_id),

    CONSTRAINT fk_news_tags_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE news (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,
    category_id CHAR(36) NULL,

    title VARCHAR(190) NOT NULL,
    slug VARCHAR(220) NOT NULL,

    description_card TEXT NULL,
    description_content LONGTEXT NULL,

    cover_url VARCHAR(700) NULL,

    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    read_time INT UNSIGNED NOT NULL DEFAULT 1,
    published_at DATETIME NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),
    UNIQUE KEY uq_news_tenant_slug (tenant_id, slug),
    KEY idx_news_tenant_status_published (tenant_id, status, published_at),
    KEY idx_news_category (category_id),
    FULLTEXT KEY ft_news_search (title, description_card, description_content),

    CONSTRAINT fk_news_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_news_category
        FOREIGN KEY (category_id) REFERENCES news_categories(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE news_tag_map (
    news_id CHAR(36) NOT NULL,
    tag_id CHAR(36) NOT NULL,

    PRIMARY KEY (news_id, tag_id),
    KEY idx_news_tag_map_tag (tag_id),

    CONSTRAINT fk_news_tag_map_news
        FOREIGN KEY (news_id) REFERENCES news(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_news_tag_map_tag
        FOREIGN KEY (tag_id) REFERENCES news_tags(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;