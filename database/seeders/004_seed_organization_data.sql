INSERT INTO tenant_organizations (
    id,
    tenant_id,
    organization_type,
    name,
    display_name,
    slug,
    short_description,
    description,
    logo_url,
    cover_url,
    email,
    phone,
    whatsapp,
    website_url,
    address,
    contact_config,
    social_config,
    operational_hours,
    metadata,
    status,
    is_featured,
    sort_order
)
SELECT
    UUID(),
    t.id,
    'village_government',
    'Pemerintah Desa Martopuro',
    'Pemerintah Desa Martopuro',
    'pemerintah-desa-martopuro',
    'Pusat layanan pemerintahan, administrasi, dan informasi resmi Desa Martopuro.',
    'Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.',
    '/assets/images/logo-martopuro.png',
    '/assets/images/village/martopuro-hero.jpg',
    NULL,
    NULL,
    NULL,
    'https://martopuro.com',
    'Desa Martopuro',
    JSON_OBJECT(
        'serviceHours', 'Senin-Jumat 08.00-15.00',
        'emergencyNumber', '112'
    ),
    JSON_OBJECT(
        'instagram', '',
        'facebook', '',
        'youtube', ''
    ),
    JSON_OBJECT(
        'monday', '08:00-15:00',
        'tuesday', '08:00-15:00',
        'wednesday', '08:00-15:00',
        'thursday', '08:00-15:00',
        'friday', '08:00-15:00'
    ),
    JSON_OBJECT(
        'source', 'seed',
        'section', 'hero'
    ),
    'active',
    1,
    1
FROM tenants t
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    display_name = VALUES(display_name),
    short_description = VALUES(short_description),
    description = VALUES(description),
    logo_url = VALUES(logo_url),
    cover_url = VALUES(cover_url),
    website_url = VALUES(website_url),
    contact_config = VALUES(contact_config),
    social_config = VALUES(social_config),
    operational_hours = VALUES(operational_hours),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = 1,
    deleted_at = NULL;


INSERT INTO tenant_organizations (
    id,
    tenant_id,
    organization_type,
    name,
    display_name,
    slug,
    short_description,
    description,
    logo_url,
    cover_url,
    status,
    is_featured,
    sort_order,
    metadata
)
SELECT
    UUID(),
    t.id,
    'culture',
    'Martopuro Culture Fest',
    'Martopuro Culture Fest',
    'martopuro-culture-fest',
    'Wadah kegiatan budaya, musik, UMKM, dan kuliner lokal Martopuro.',
    'Martopuro Culture Fest menjadi ruang kolaborasi warga untuk memperkenalkan budaya, musik, kuliner, UMKM, serta potensi lokal desa.',
    NULL,
    'https://martopuro.sencra.io/assets/culturefest/2.JPG',
    'active',
    1,
    2,
    JSON_OBJECT(
        'instagram', '@martopuroculturefest',
        'ctaLabel', 'Buka Instagram',
        'ctaHref', 'https://instagram.com/martopuroculturefest'
    )
FROM tenants t
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    display_name = VALUES(display_name),
    short_description = VALUES(short_description),
    description = VALUES(description),
    cover_url = VALUES(cover_url),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = 2,
    deleted_at = NULL;


INSERT INTO tenant_organizations (
    id,
    tenant_id,
    organization_type,
    name,
    display_name,
    slug,
    short_description,
    description,
    status,
    is_featured,
    sort_order,
    metadata
)
SELECT
    UUID(),
    t.id,
    'umkm',
    'UMKM Desa Martopuro',
    'UMKM Desa Martopuro',
    'umkm-desa-martopuro',
    'Komunitas pelaku usaha lokal dan produk unggulan desa.',
    'UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.',
    'active',
    1,
    3,
    JSON_OBJECT(
        'focus', 'Produk lokal, kuliner, dan ekonomi warga'
    )
FROM tenants t
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    display_name = VALUES(display_name),
    short_description = VALUES(short_description),
    description = VALUES(description),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = 3,
    deleted_at = NULL;