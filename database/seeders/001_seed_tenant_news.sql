SET @tenant_id = UUID();

INSERT INTO tenants (
  id,
  name,
  display_name,
  slug,
  tenant_type,
  domain,
  site_url,
  logo_url,
  favicon_url,
  og_image_url,
  primary_color,
  description,
  status,
  hero_config,
  contact_config,
  statistic_config,
  culture_config,
  warta_config,
  social_config
) VALUES (
  @tenant_id,
  'Desa Martopuro',
  'Martopuro',
  'martopuro',
  'village',
  'martopuro.com',
  'https://martopuro.com',
  '/assets/logo.png',
  '/favicon.png',
  '/og-obayan.png',
  '#2563eb',
  'Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.',
  'active',

  JSON_OBJECT(
    'brand', 'Desa Martopuro',
    'bgImage', '/assets/images/village/martopuro-hero.jpg',
    'titleMain', 'Selamat Datang di Desa ',
    'titleHighlight', 'Martopuro',
    'tagline', 'Portal Resmi Pemerintah Desa',
    'subtitle', 'Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.',
    'waIntl', '6289563836',
    'ctaPrimary', JSON_OBJECT('label', 'Ajukan Surat Online', 'href', '/layanan'),
    'ctaSecondary', JSON_OBJECT('label', 'Lihat Profil Desa', 'href', '/profile'),
    'badges', JSON_ARRAY(
      JSON_OBJECT('label', 'Surat Keterangan', 'icon', 'lucide:file-check-2'),
      JSON_OBJECT('label', 'Direktori UMKM', 'icon', 'lucide:store'),
      JSON_OBJECT('label', 'Agenda Desa', 'icon', 'lucide:calendar-days'),
      JSON_OBJECT('label', 'Wisata', 'icon', 'lucide:map-pin')
    ),
    'stats', JSON_ARRAY(
      JSON_OBJECT('label', 'UMKM', 'value', '35+'),
      JSON_OBJECT('label', 'Layanan', 'value', '12'),
      JSON_OBJECT('label', 'Agenda', 'value', 'Aktif')
    ),
    'quicks', JSON_ARRAY(
      JSON_OBJECT('label', 'Jam Layanan Kantor', 'value', 'Senin–Jumat • 08.00–15.00', 'icon', 'lucide:clock-3'),
      JSON_OBJECT('label', 'UMKM Terdaftar', 'value', '35 usaha lokal aktif', 'icon', 'lucide:store'),
      JSON_OBJECT('label', 'Nomor Darurat', 'value', '112 • 0812-xxxx-xxxx', 'icon', 'lucide:phone-call')
    ),
    'searchPlaceholder', 'Cari layanan, berita, agenda, UMKM...'
  ),

  JSON_OBJECT(
    'officeName', 'Kantor Desa Martopuro',
    'officeSubtitle', 'Pemerintah Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',
    'address', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur',
    'email', 'team.sencra@gmail.com',
    'phone', '0343-591234',
    'waIntl', '6289563836',
    'mapsQuery', 'Kantor Desa Martopuro, Pasuruan',
    'mapEmbedSrc', ''
  ),

  JSON_OBJECT(
    'eyebrow', 'Statistik Desa',
    'title', 'Ringkasan Kinerja & APBDes 2026',
    'subtitle', 'Pantau statistik layanan, data aparatur, dan ringkasan APBDes secara ringkas, transparan, dan mudah dipahami masyarakat.',
    'ctaLabel', 'Lihat APBDes Lengkap',
    'ctaHref', '/apbd'
  ),

  JSON_OBJECT(
    'eyebrow', 'Martopuro Culture Fest',
    'eyebrowIcon', 'lucide:ticket',
    'title', 'Budaya, Musik, & Kuliner ',
    'highlight', 'Martopuro!',
    'subtitle', 'Parade seni tradisi, UMKM lokal, pentas musik, lomba warga, dan kuliner khas dalam satu perayaan meriah.',
    'instagram', '@martopuroculturefest',
    'floatingBadge', 'Festival Desa Digital',
    'images', JSON_ARRAY(
      'https://martopuro.sencra.io/assets/culturefest/2.JPG',
      'https://martopuro.sencra.io/assets/culturefest/0.JPG',
      'https://martopuro.sencra.io/assets/culturefest/1.JPG',
      'https://martopuro.sencra.io/assets/culturefest/2.JPG'
    )
  ),

  JSON_OBJECT(
    'eyebrow', 'Warta Martopuro',
    'title', 'Artikel Pilihan & Terbaru',
    'subtitle', 'Ikuti informasi terbaru dari Desa Martopuro, mulai dari pelayanan publik, kegiatan warga, UMKM, kesehatan, pendidikan, hingga agenda desa.',
    'viewAllLabel', 'Lihat Semua',
    'viewAllHref', '/news',
    'limit', 12
  ),

  JSON_OBJECT(
    'instagram', 'https://instagram.com/martopuroculturefest',
    'facebook', '',
    'youtube', '',
    'whatsapp', 'https://wa.me/6289563836',
    'email', 'team.sencra@gmail.com'
  )
)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  display_name = VALUES(display_name),
  tenant_type = VALUES(tenant_type),
  domain = VALUES(domain),
  site_url = VALUES(site_url),
  logo_url = VALUES(logo_url),
  favicon_url = VALUES(favicon_url),
  og_image_url = VALUES(og_image_url),
  primary_color = VALUES(primary_color),
  description = VALUES(description),
  status = VALUES(status),
  hero_config = VALUES(hero_config),
  contact_config = VALUES(contact_config),
  statistic_config = VALUES(statistic_config),
  culture_config = VALUES(culture_config),
  warta_config = VALUES(warta_config),
  social_config = VALUES(social_config);


SET @tenant_id = (
  SELECT id FROM tenants
  WHERE slug = 'martopuro'
  LIMIT 1
);


SET @category_id = UUID();

INSERT INTO news_categories (
  id,
  tenant_id,
  name,
  slug,
  description,
  sort_order,
  status
) VALUES (
  @category_id,
  @tenant_id,
  'Kegiatan',
  'kegiatan',
  'Informasi kegiatan desa.',
  1,
  'active'
)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description),
  sort_order = VALUES(sort_order),
  status = VALUES(status),
  deleted_at = NULL;


SET @category_id = (
  SELECT id FROM news_categories
  WHERE tenant_id = @tenant_id
  AND slug = 'kegiatan'
  LIMIT 1
);


SET @tag_santri_id = UUID();
SET @tag_desa_id = UUID();

INSERT INTO news_tags (
  id,
  tenant_id,
  name,
  slug
) VALUES
(@tag_santri_id, @tenant_id, 'Warga', 'warga'),
(@tag_desa_id, @tenant_id, 'Desa', 'desa')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  deleted_at = NULL;


SET @news_id = UUID();

INSERT INTO news (
  id,
  tenant_id,
  category_id,
  title,
  slug,
  description_card,
  description_content,
  cover_url,
  status,
  read_time,
  published_at
) VALUES (
  @news_id,
  @tenant_id,
  @category_id,
  'Kegiatan Warga Desa Martopuro',
  'kegiatan-warga-desa-martopuro',
  'Informasi kegiatan terbaru warga Desa Martopuro.',
  '<p>Ini adalah contoh konten berita dari MySQL dengan UUID. Nantinya konten ini bisa diisi dari Tiptap Editor.</p>',
  '/assets/images/martopuro-news-1.jpg',
  'published',
  1,
  NOW()
)
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at),
  deleted_at = NULL;


SET @news_id = (
  SELECT id FROM news
  WHERE tenant_id = @tenant_id
  AND slug = 'kegiatan-warga-desa-martopuro'
  LIMIT 1
);


INSERT IGNORE INTO news_tag_map (news_id, tag_id)
SELECT @news_id, id
FROM news_tags
WHERE tenant_id = @tenant_id
AND slug IN ('warga', 'desa');