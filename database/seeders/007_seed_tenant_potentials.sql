INSERT INTO tenant_potentials (
    id,
    tenant_id,
    potential_type,
    title,
    subtitle,
    slug,
    icon,
    logo_url,
    image_url,
    content_html,
    content_json,
    address,
    owner_name,
    manager_name,
    production_capacity,
    production_unit,
    market_reach,
    estimated_value,
    contact_config,
    statistic_config,
    metadata,
    status,
    is_featured,
    sort_order
)
SELECT
    UUID(),
    t.id,
    seed.potential_type,
    seed.title,
    seed.subtitle,
    seed.slug,
    seed.icon,
    NULL,
    seed.image_url,
    seed.content_html,
    JSON_OBJECT(
        'type', 'doc',
        'content', JSON_ARRAY(
            JSON_OBJECT(
                'type', 'paragraph',
                'content', JSON_ARRAY(
                    JSON_OBJECT(
                        'type', 'text',
                        'text', seed.subtitle
                    )
                )
            )
        )
    ),
    'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',
    NULL,
    NULL,
    seed.production_capacity,
    seed.production_unit,
    seed.market_reach,
    NULL,
    JSON_OBJECT(
        'phone', '',
        'whatsapp', '',
        'email', ''
    ),
    JSON_OBJECT(
        'summary', seed.subtitle
    ),
    JSON_OBJECT(
        'source', 'seed',
        'tenant', 'martopuro',
        'images', JSON_ARRAY()
    ),
    'active',
    1,
    seed.sort_order
FROM tenants t
JOIN (
    SELECT
        'agriculture' AS potential_type,
        'Pertanian' AS title,
        'Potensi hasil pertanian dan komoditas pangan desa.' AS subtitle,
        'pertanian' AS slug,
        'lucide:wheat' AS icon,
        NULL AS image_url,
        '<p>Potensi pertanian desa mencakup komoditas pangan, hasil panen warga, serta peluang pengembangan ekonomi berbasis lahan dan produksi lokal.</p>' AS content_html,
        'Musiman' AS production_capacity,
        'Komoditas' AS production_unit,
        'Pasar lokal dan wilayah sekitar' AS market_reach,
        1 AS sort_order

    UNION ALL SELECT
        'livestock',
        'Peternakan',
        'Potensi peternakan warga sebagai bagian dari ekonomi desa.',
        'peternakan',
        'lucide:cow',
        NULL,
        '<p>Potensi peternakan dapat mencakup sapi, kambing, ayam, bebek, dan berbagai usaha ternak warga yang mendukung ekonomi keluarga.</p>',
        'Berkala',
        'Ekor',
        'Pasar lokal',
        2

    UNION ALL SELECT
        'fishery',
        'Perikanan',
        'Potensi perikanan dan budidaya ikan masyarakat.',
        'perikanan',
        'lucide:fish',
        NULL,
        '<p>Potensi perikanan mencakup budidaya ikan air tawar, kolam warga, serta peluang pengembangan produk olahan berbasis ikan.</p>',
        'Berkala',
        'Kg',
        'Pasar lokal',
        3

    UNION ALL SELECT
        'umkm',
        'UMKM Desa',
        'Potensi usaha mikro, kecil, dan menengah masyarakat.',
        'umkm',
        'lucide:store',
        NULL,
        '<p>UMKM desa menjadi salah satu penggerak ekonomi masyarakat melalui produk makanan, kerajinan, jasa, dan perdagangan lokal.</p>',
        'Aktif',
        'Unit usaha',
        'Desa dan kecamatan sekitar',
        4

    UNION ALL SELECT
        'tourism',
        'Wisata Desa',
        'Potensi wisata lokal, alam, edukasi, dan budaya desa.',
        'wisata-desa',
        'lucide:map-pin',
        NULL,
        '<p>Potensi wisata desa dapat dikembangkan melalui keunikan lingkungan, budaya lokal, edukasi masyarakat, dan daya tarik khas desa.</p>',
        'Berkembang',
        'Destinasi',
        'Pengunjung lokal dan regional',
        5

    UNION ALL SELECT
        'culture',
        'Budaya Lokal',
        'Potensi budaya, tradisi, dan kegiatan masyarakat.',
        'budaya-lokal',
        'lucide:landmark',
        NULL,
        '<p>Budaya lokal menjadi identitas desa yang dapat dikembangkan melalui kegiatan masyarakat, tradisi, seni, dan nilai gotong royong.</p>',
        'Berkala',
        'Kegiatan',
        'Masyarakat desa',
        6

    UNION ALL SELECT
        'creative_economy',
        'Ekonomi Kreatif',
        'Potensi kreativitas warga dalam produk dan jasa bernilai tambah.',
        'ekonomi-kreatif',
        'lucide:palette',
        NULL,
        '<p>Ekonomi kreatif desa meliputi produk kreatif, desain, kerajinan, konten lokal, dan inovasi warga yang memiliki nilai jual.</p>',
        'Aktif',
        'Produk',
        'Online dan lokal',
        7
) seed
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    potential_type = VALUES(potential_type),
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    icon = VALUES(icon),
    logo_url = VALUES(logo_url),
    image_url = VALUES(image_url),
    content_html = VALUES(content_html),
    content_json = VALUES(content_json),
    address = VALUES(address),
    owner_name = VALUES(owner_name),
    manager_name = VALUES(manager_name),
    production_capacity = VALUES(production_capacity),
    production_unit = VALUES(production_unit),
    market_reach = VALUES(market_reach),
    estimated_value = VALUES(estimated_value),
    contact_config = VALUES(contact_config),
    statistic_config = VALUES(statistic_config),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = VALUES(sort_order),
    deleted_at = NULL;