INSERT INTO tenant_facilities (
    id,
    tenant_id,
    facility_type,
    title,
    subtitle,
    slug,
    icon,
    logo_url,
    image_url,
    content_html,
    content_json,
    address,
    contact_config,
    operational_hours,
    metadata,
    status,
    is_featured,
    sort_order
)
SELECT
    UUID(),
    t.id,
    seed.facility_type,
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
    JSON_OBJECT(
        'phone', '',
        'whatsapp', '',
        'email', ''
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
        'tenant', 'martopuro'
    ),
    'active',
    1,
    seed.sort_order
FROM tenants t
JOIN (
    SELECT
        'health' AS facility_type,
        'Kesehatan' AS title,
        'Fasilitas layanan kesehatan masyarakat desa.' AS subtitle,
        'kesehatan' AS slug,
        'lucide:hospital' AS icon,
        NULL AS image_url,
        '<p>Fasilitas kesehatan desa mendukung pelayanan kesehatan dasar, pemeriksaan rutin, posyandu, serta kegiatan kesehatan masyarakat.</p>' AS content_html,
        1 AS sort_order

    UNION ALL SELECT
        'market',
        'Pasar',
        'Fasilitas perdagangan dan aktivitas ekonomi warga.',
        'pasar',
        'lucide:store',
        NULL,
        '<p>Pasar menjadi pusat aktivitas ekonomi masyarakat, tempat jual beli kebutuhan harian, produk lokal, dan hasil usaha warga.</p>',
        2

    UNION ALL SELECT
        'education',
        'Pendidikan',
        'Fasilitas pendidikan dan pembelajaran masyarakat.',
        'pendidikan',
        'lucide:school',
        NULL,
        '<p>Fasilitas pendidikan mendukung proses belajar masyarakat mulai dari pendidikan anak usia dini hingga kegiatan pembelajaran warga.</p>',
        3

    UNION ALL SELECT
        'sport',
        'Lapangan',
        'Sarana olahraga dan kegiatan masyarakat desa.',
        'lapangan',
        'lucide:map',
        NULL,
        '<p>Lapangan desa digunakan untuk olahraga, kegiatan warga, upacara, lomba, dan acara masyarakat.</p>',
        4

    UNION ALL SELECT
        'emergency',
        'Ambulance',
        'Layanan kendaraan darurat untuk kebutuhan kesehatan warga.',
        'ambulance',
        'lucide:ambulance',
        NULL,
        '<p>Ambulance desa membantu kebutuhan transportasi darurat kesehatan warga menuju fasilitas layanan kesehatan.</p>',
        5

    UNION ALL SELECT
        'transport',
        'Mobil Siaga',
        'Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.',
        'mobil-siaga',
        'lucide:car',
        NULL,
        '<p>Mobil siaga desa digunakan untuk mendukung kebutuhan mendesak masyarakat dan operasional pelayanan desa.</p>',
        6

    UNION ALL SELECT
        'water',
        'HIPAM',
        'Fasilitas layanan air bersih masyarakat.',
        'hipam',
        'lucide:droplets',
        NULL,
        '<p>HIPAM mendukung pengelolaan dan distribusi air bersih bagi masyarakat desa.</p>',
        7
) seed
WHERE t.slug = 'martopuro'
ON DUPLICATE KEY UPDATE
    facility_type = VALUES(facility_type),
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    icon = VALUES(icon),
    logo_url = VALUES(logo_url),
    image_url = VALUES(image_url),
    content_html = VALUES(content_html),
    content_json = VALUES(content_json),
    address = VALUES(address),
    contact_config = VALUES(contact_config),
    operational_hours = VALUES(operational_hours),
    metadata = VALUES(metadata),
    status = 'active',
    is_featured = 1,
    sort_order = VALUES(sort_order),
    deleted_at = NULL;