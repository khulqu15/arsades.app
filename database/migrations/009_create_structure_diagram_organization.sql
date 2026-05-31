CREATE TABLE structure_organization_charts (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,

    title VARCHAR(180) NOT NULL,
    slug VARCHAR(200) NOT NULL,
    description VARCHAR(700) NULL,

    chart_type ENUM(
        'organization',
        'department',
        'school',
        'pesantren',
        'company',
        'committee',
        'custom'
    ) NOT NULL DEFAULT 'organization',

    layout_engine ENUM(
        'manual',
        'tree',
        'dagre',
        'grid',
        'radial',
        'custom'
    ) NOT NULL DEFAULT 'manual',

    layout_direction ENUM(
        'top-bottom',
        'bottom-top',
        'left-right',
        'right-left',
        'free'
    ) NOT NULL DEFAULT 'top-bottom',

    canvas_width INT UNSIGNED NOT NULL DEFAULT 1200,
    canvas_height INT UNSIGNED NOT NULL DEFAULT 800,

    background_color VARCHAR(40) NULL,
    background_image_url VARCHAR(700) NULL,

    grid_enabled TINYINT(1) NOT NULL DEFAULT 0,
    grid_size INT UNSIGNED NOT NULL DEFAULT 20,
    snap_to_grid TINYINT(1) NOT NULL DEFAULT 0,

    zoom_min DECIMAL(5, 2) NOT NULL DEFAULT 0.25,
    zoom_max DECIMAL(5, 2) NOT NULL DEFAULT 2.50,
    initial_scale DECIMAL(5, 2) NOT NULL DEFAULT 1.00,

    node_default_config JSON NULL,
    edge_default_config JSON NULL,
    konva_config JSON NULL,

    metadata JSON NULL,

    status ENUM('draft', 'published', 'archived', 'inactive') NOT NULL DEFAULT 'published',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_structure_org_charts_tenant_slug (
        tenant_id,
        slug
    ),

    UNIQUE KEY uq_structure_org_charts_id_tenant (
        id,
        tenant_id
    ),

    KEY idx_structure_org_charts_tenant_status (
        tenant_id,
        status,
        sort_order
    ),

    KEY idx_structure_org_charts_featured (
        tenant_id,
        is_featured,
        status,
        sort_order
    ),

    CONSTRAINT fk_structure_org_charts_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE structure_organizations (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,
    chart_id CHAR(36) NOT NULL,

    parent_id CHAR(36) NULL,

    name VARCHAR(180) NOT NULL,
    slug VARCHAR(220) NOT NULL,

    position_title VARCHAR(180) NOT NULL,
    position_code VARCHAR(120) NULL,
    organization_unit VARCHAR(180) NULL,

    photo_url VARCHAR(700) NULL,
    icon VARCHAR(160) NULL,

    short_description VARCHAR(500) NULL,
    content_html LONGTEXT NULL,
    content_json JSON NULL,

    phone VARCHAR(80) NULL,
    whatsapp VARCHAR(80) NULL,
    email VARCHAR(190) NULL,

    term_start DATE NULL,
    term_end DATE NULL,

    node_type ENUM(
        'person',
        'position',
        'department',
        'division',
        'unit',
        'group',
        'placeholder',
        'custom'
    ) NOT NULL DEFAULT 'person',

    shape_type ENUM(
        'card',
        'rounded_rect',
        'rect',
        'circle',
        'avatar_card',
        'custom'
    ) NOT NULL DEFAULT 'card',

    x DECIMAL(12, 2) NOT NULL DEFAULT 0,
    y DECIMAL(12, 2) NOT NULL DEFAULT 0,
    width DECIMAL(12, 2) NOT NULL DEFAULT 220,
    height DECIMAL(12, 2) NOT NULL DEFAULT 110,

    rotation DECIMAL(8, 2) NOT NULL DEFAULT 0,
    scale_x DECIMAL(8, 3) NOT NULL DEFAULT 1.000,
    scale_y DECIMAL(8, 3) NOT NULL DEFAULT 1.000,

    fill_color VARCHAR(40) NULL,
    border_color VARCHAR(40) NULL,
    border_width DECIMAL(8, 2) NOT NULL DEFAULT 1,
    text_color VARCHAR(40) NULL,
    accent_color VARCHAR(40) NULL,

    font_family VARCHAR(120) NULL,
    name_font_size INT UNSIGNED NOT NULL DEFAULT 16,
    position_font_size INT UNSIGNED NOT NULL DEFAULT 13,

    photo_shape ENUM('circle', 'rounded_rect', 'rect') NOT NULL DEFAULT 'circle',
    photo_width DECIMAL(12, 2) NOT NULL DEFAULT 56,
    photo_height DECIMAL(12, 2) NOT NULL DEFAULT 56,

    draggable TINYINT(1) NOT NULL DEFAULT 1,
    locked TINYINT(1) NOT NULL DEFAULT 0,
    visible TINYINT(1) NOT NULL DEFAULT 1,

    konva_config JSON NULL,
    style_config JSON NULL,
    social_config JSON NULL,
    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_structure_org_node_chart_slug (
        chart_id,
        slug
    ),

    KEY idx_structure_org_nodes_tenant_status (
        tenant_id,
        status,
        sort_order
    ),

    KEY idx_structure_org_nodes_chart_status (
        chart_id,
        status,
        sort_order
    ),

    KEY idx_structure_org_nodes_parent (
        parent_id
    ),

    KEY idx_structure_org_nodes_position_code (
        tenant_id,
        chart_id,
        position_code
    ),

    CONSTRAINT fk_structure_org_nodes_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_structure_org_nodes_chart
        FOREIGN KEY (chart_id, tenant_id)
        REFERENCES structure_organization_charts(id, tenant_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_structure_org_nodes_parent
        FOREIGN KEY (parent_id) REFERENCES structure_organizations(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE structure_organization_edges (
    id CHAR(36) NOT NULL,
    tenant_id CHAR(36) NOT NULL,
    chart_id CHAR(36) NOT NULL,

    source_node_id CHAR(36) NOT NULL,
    target_node_id CHAR(36) NOT NULL,

    edge_type ENUM(
        'hierarchy',
        'assistant',
        'coordination',
        'dotted',
        'custom'
    ) NOT NULL DEFAULT 'hierarchy',

    label VARCHAR(160) NULL,

    line_type ENUM(
        'straight',
        'orthogonal',
        'bezier',
        'step',
        'custom'
    ) NOT NULL DEFAULT 'orthogonal',

    stroke_color VARCHAR(40) NULL,
    stroke_width DECIMAL(8, 2) NOT NULL DEFAULT 2,
    stroke_dash JSON NULL,

    arrow_start TINYINT(1) NOT NULL DEFAULT 0,
    arrow_end TINYINT(1) NOT NULL DEFAULT 0,

    points_config JSON NULL,
    konva_config JSON NULL,
    metadata JSON NULL,

    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    sort_order INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    PRIMARY KEY (id),

    UNIQUE KEY uq_structure_org_edge_unique (
        chart_id,
        source_node_id,
        target_node_id,
        edge_type
    ),

    KEY idx_structure_org_edges_chart_status (
        chart_id,
        status,
        sort_order
    ),

    KEY idx_structure_org_edges_source (
        source_node_id
    ),

    KEY idx_structure_org_edges_target (
        target_node_id
    ),

    CONSTRAINT fk_structure_org_edges_tenant
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_structure_org_edges_chart
        FOREIGN KEY (chart_id, tenant_id)
        REFERENCES structure_organization_charts(id, tenant_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_structure_org_edges_source
        FOREIGN KEY (source_node_id) REFERENCES structure_organizations(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_structure_org_edges_target
        FOREIGN KEY (target_node_id) REFERENCES structure_organizations(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;