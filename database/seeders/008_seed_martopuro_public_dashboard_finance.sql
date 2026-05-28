INSERT INTO tenant_public_metrics (
    id,
    tenant_id,
    metric_group,
    metric_key,
    label,
    description,
    value_decimal,
    value_text,
    value_unit,
    comparison_value,
    comparison_unit,
    comparison_direction,
    period_type,
    icon,
    color,
    source_type,
    source_name,
    metadata,
    status,
    sort_order
)
SELECT
    UUID(),
    t.id,
    seed.metric_group,
    seed.metric_key,
    seed.label,
    seed.description,
    seed.value_decimal,
    seed.value_text,
    seed.value_unit,
    seed.comparison_value,
    seed.comparison_unit,
    seed.comparison_direction,
    seed.period_type,
    seed.icon,
    seed.color,
    'manual',
    'seed',
    seed.metadata,
    'active',
    seed.sort_order
FROM tenants t
JOIN (
    SELECT
        'visitor_statistics' AS metric_group,
        'today_visitors' AS metric_key,
        'Hari ini' AS label,
        'Jumlah pengunjung hari ini' AS description,
        37 AS value_decimal,
        NULL AS value_text,
        'visitor' AS value_unit,
        12.10 AS comparison_value,
        '%' AS comparison_unit,
        'up' AS comparison_direction,
        'realtime' AS period_type,
        'solar:pulse-2-bold-duotone' AS icon,
        '#2563EB' AS color,
        JSON_OBJECT('display', '37', 'badge', 'realtime') AS metadata,
        1 AS sort_order

    UNION ALL SELECT
        'visitor_statistics',
        'yesterday_visitors',
        'Kemarin',
        'Jumlah pengunjung kemarin',
        33,
        NULL,
        'visitor',
        NULL,
        NULL,
        NULL,
        'daily',
        'solar:calendar-bold-duotone',
        '#64748B',
        JSON_OBJECT('display', '33'),
        2

    UNION ALL SELECT
        'visitor_statistics',
        'total_visitors',
        'Jumlah pengunjung',
        'Total seluruh pengunjung website',
        6141,
        NULL,
        'visitor',
        NULL,
        NULL,
        NULL,
        'realtime',
        'solar:users-group-rounded-bold-duotone',
        '#0F172A',
        JSON_OBJECT('display', '6.141'),
        3
) seed
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    label = VALUES(label),
    description = VALUES(description),
    value_decimal = VALUES(value_decimal),
    value_text = VALUES(value_text),
    value_unit = VALUES(value_unit),
    comparison_value = VALUES(comparison_value),
    comparison_unit = VALUES(comparison_unit),
    comparison_direction = VALUES(comparison_direction),
    icon = VALUES(icon),
    color = VALUES(color),
    metadata = VALUES(metadata),
    status = 'active',
    sort_order = VALUES(sort_order),
    deleted_at = NULL;


INSERT INTO village_officials (
    id,
    tenant_id,
    name,
    slug,
    position_title,
    position_code,
    short_description,
    content_html,
    content_json,
    photo_url,
    icon,
    attendance_status,
    attendance_label,
    social_config,
    metadata,
    status,
    is_featured,
    sort_order
)
SELECT
    UUID(),
    t.id,
    'Rianto',
    'rianto',
    'Kepala Desa',
    'kepala-desa',
    'Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan, dan pemberdayaan warga.',
    '<p>Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.</p>',
    JSON_OBJECT(
        'type', 'doc',
        'content', JSON_ARRAY(
            JSON_OBJECT(
                'type', 'paragraph',
                'content', JSON_ARRAY(
                    JSON_OBJECT(
                        'type', 'text',
                        'text', 'Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.'
                    )
                )
            )
        )
    ),
    NULL,
    'solar:user-rounded-bold-duotone',
    'present',
    'Hadir',
    JSON_OBJECT(),
    JSON_OBJECT(
        'source', 'seed',
        'tenant', 'martopuro'
    ),
    'active',
    1,
    1
FROM tenants t
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    position_title = VALUES(position_title),
    position_code = VALUES(position_code),
    short_description = VALUES(short_description),
    content_html = VALUES(content_html),
    content_json = VALUES(content_json),
    photo_url = VALUES(photo_url),
    icon = VALUES(icon),
    attendance_status = VALUES(attendance_status),
    attendance_label = VALUES(attendance_label),
    social_config = VALUES(social_config),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = VALUES(sort_order),
    deleted_at = NULL;


INSERT INTO village_budget_periods (
    id,
    tenant_id,
    budget_year,
    title,
    subtitle,
    currency_code,
    source_name,
    notes,
    metadata,
    status,
    is_current
)
SELECT
    UUID(),
    t.id,
    2026,
    'APBDes 2026',
    'Realisasi dibandingkan anggaran',
    'IDR',
    'APBDes Desa',
    'Data dapat disesuaikan dengan sumber resmi desa atau API APBDes agar masyarakat mendapat informasi terbaru.',
    JSON_OBJECT(
        'source', 'seed',
        'tenant', 'martopuro',
        'ui', JSON_OBJECT(
            'variant', 'summary-finance',
            'tabs', JSON_ARRAY('Ringkas', 'Pendapatan', 'Belanja')
        )
    ),
    'published',
    1
FROM tenants t
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    currency_code = VALUES(currency_code),
    source_name = VALUES(source_name),
    notes = VALUES(notes),
    metadata = VALUES(metadata),
    status = 'published',
    is_current = 1,
    deleted_at = NULL;


INSERT INTO village_budget_lines (
    id,
    budget_period_id,
    parent_id,
    line_type,
    line_group,
    line_code,
    title,
    slug,
    description,
    budget_amount,
    realized_amount,
    unit,
    icon,
    color,
    metadata,
    status,
    is_featured,
    sort_order
)
SELECT
    UUID(),
    bp.id,
    NULL,
    seed.line_type,
    seed.line_group,
    seed.line_code,
    seed.title,
    seed.slug,
    seed.description,
    seed.budget_amount,
    seed.realized_amount,
    'rupiah',
    seed.icon,
    seed.color,
    JSON_OBJECT(
        'source', 'seed',
        'displayBudget', seed.display_budget
    ),
    'active',
    1,
    seed.sort_order
FROM village_budget_periods bp
JOIN tenants t ON t.id = bp.tenant_id
JOIN (
    SELECT
        'revenue' AS line_type,
        'Pendapatan per Sumber' AS line_group,
        'PADESA-LAIN' AS line_code,
        'Lain-Lain PADesa' AS title,
        'lain-lain-padesa' AS slug,
        'Pendapatan asli desa dari lain-lain PADesa.' AS description,
        65000000 AS budget_amount,
        0 AS realized_amount,
        'solar:wallet-money-bold-duotone' AS icon,
        '#2563EB' AS color,
        'Rp 65.000.000' AS display_budget,
        1 AS sort_order

    UNION ALL SELECT
        'revenue',
        'Pendapatan per Sumber',
        'DD',
        'Dana Desa',
        'dana-desa',
        'Pendapatan transfer Dana Desa.',
        1656078000,
        0,
        'solar:banknote-bold-duotone',
        '#2563EB',
        'Rp 1.656.078.000',
        2

    UNION ALL SELECT
        'revenue',
        'Pendapatan per Sumber',
        'BHP-RETRIBUSI',
        'Bagi Hasil Pajak & Retribusi',
        'bagi-hasil-pajak-retribusi',
        'Pendapatan bagi hasil pajak dan retribusi.',
        254416000,
        0,
        'solar:bill-list-bold-duotone',
        '#2563EB',
        'Rp 254.416.000',
        3

    UNION ALL SELECT
        'revenue',
        'Pendapatan per Sumber',
        'ADD',
        'Alokasi Dana Desa (ADD)',
        'alokasi-dana-desa-add',
        'Pendapatan dari Alokasi Dana Desa.',
        442958000,
        0,
        'solar:buildings-3-bold-duotone',
        '#2563EB',
        'Rp 442.958.000',
        4

    UNION ALL SELECT
        'revenue',
        'Pendapatan per Sumber',
        'BANKABKOTA',
        'Bantuan Keuangan Kab/Kota',
        'bantuan-keuangan-kab-kota',
        'Bantuan keuangan dari kabupaten atau kota.',
        366000000,
        0,
        'solar:hand-money-bold-duotone',
        '#2563EB',
        'Rp 366.000.000',
        5

    UNION ALL SELECT
        'expense',
        'Belanja per Bidang',
        '01',
        'Penyelenggaraan Pemerintahan Desa',
        'penyelenggaraan-pemerintahan-desa',
        'Belanja bidang penyelenggaraan pemerintahan desa.',
        1159164470,
        0,
        'solar:buildings-bold-duotone',
        '#0EA5E9',
        'Rp 1.159.164.470',
        1

    UNION ALL SELECT
        'expense',
        'Belanja per Bidang',
        '02',
        'Pelaksanaan Pembangunan Desa',
        'pelaksanaan-pembangunan-desa',
        'Belanja bidang pelaksanaan pembangunan desa.',
        1286368100,
        0,
        'solar:home-2-bold-duotone',
        '#0EA5E9',
        'Rp 1.286.368.100',
        2

    UNION ALL SELECT
        'expense',
        'Belanja per Bidang',
        '03',
        'Pembinaan Kemasyarakatan Desa',
        'pembinaan-kemasyarakatan-desa',
        'Belanja bidang pembinaan kemasyarakatan desa.',
        136430000,
        0,
        'solar:users-group-rounded-bold-duotone',
        '#0EA5E9',
        'Rp 136.430.000',
        3

    UNION ALL SELECT
        'expense',
        'Belanja per Bidang',
        '04',
        'Pemberdayaan Masyarakat Desa',
        'pemberdayaan-masyarakat-desa',
        'Belanja bidang pemberdayaan masyarakat desa.',
        90055500,
        0,
        'solar:hand-heart-bold-duotone',
        '#0EA5E9',
        'Rp 90.055.500',
        4

    UNION ALL SELECT
        'expense',
        'Belanja per Bidang',
        '05',
        'Penanggulangan Bencana/Darurat',
        'penanggulangan-bencana-darurat',
        'Belanja bidang penanggulangan bencana, keadaan darurat, dan mendesak desa.',
        150900000,
        0,
        'solar:shield-warning-bold-duotone',
        '#0EA5E9',
        'Rp 150.900.000',
        5

    UNION ALL SELECT
        'financing',
        'Pembiayaan',
        'FINANCING',
        'Pembiayaan Desa',
        'pembiayaan-desa',
        'Pembiayaan desa tahun berjalan.',
        38466070,
        0,
        'solar:pie-chart-2-bold-duotone',
        '#64748B',
        'Rp 38.466.070',
        1
) seed
WHERE t.slug = 'martopuro'
AND bp.budget_year = 2026
ON DUPLICATE KEY UPDATE
    line_type = VALUES(line_type),
    line_group = VALUES(line_group),
    line_code = VALUES(line_code),
    title = VALUES(title),
    description = VALUES(description),
    budget_amount = VALUES(budget_amount),
    realized_amount = VALUES(realized_amount),
    unit = VALUES(unit),
    icon = VALUES(icon),
    color = VALUES(color),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = VALUES(is_featured),
    sort_order = VALUES(sort_order),
    deleted_at = NULL;