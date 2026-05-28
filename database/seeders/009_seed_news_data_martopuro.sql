-- Seeder news Desa Martopuro
-- Source: martopuro.berdesa.id index pages 1-14
-- Cover image is intentionally normalized to /assets/images/village/martopuro-hero.jpg
-- Tenant is NOT inserted here because tenant martopuro already exists.
-- This script looks up the existing tenant by slug, then resets all Martopuro news data before seeding.

START TRANSACTION;

SET @tenant_slug = 'martopuro';
SET @tenant_id = (
  SELECT id
  FROM tenants
  WHERE slug = @tenant_slug
  LIMIT 1
);

-- Check result. This value must not be NULL.
SELECT @tenant_id AS martopuro_tenant_id;

-- Reset old Martopuro news data only. Tenant row is kept.
DELETE ntm
FROM news_tag_map ntm
INNER JOIN news n ON n.id = ntm.news_id
WHERE n.tenant_id = @tenant_id;

DELETE FROM news
WHERE tenant_id = @tenant_id;

-- Reset category/tag master data for Martopuro so this seed is clean from zero.
DELETE FROM news_tags
WHERE tenant_id = @tenant_id;

DELETE FROM news_categories
WHERE tenant_id = @tenant_id;

-- Categories
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('593eb4c5-7faf-565a-8503-e32028a43526', @tenant_id, 'Berita Desa', 'berita-desa', 'Informasi umum dan kegiatan Pemerintah Desa Martopuro.', 1, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', @tenant_id, 'Karang Taruna', 'karang-taruna', 'Kegiatan kepemudaan dan Karang Taruna Permata Karya Desa Martopuro.', 2, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('0dc3abf2-de70-5cef-b90c-c6872b5f8816', @tenant_id, 'BUMDES', 'bumdes', 'Informasi BUMDes Karya Usaha Mandiri dan ekonomi desa.', 3, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('dc0a287d-c539-5407-b1af-83479bbde6b3', @tenant_id, 'BPD', 'bpd', 'Informasi Badan Permusyawaratan Desa Martopuro.', 4, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('dcb17bd5-8af2-5484-86fe-e6bee5e15a38', @tenant_id, 'PAUD', 'paud', 'Informasi pendidikan PAUD Tunas Bangsa Martopuro.', 5, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('6009b765-2f64-50fd-951d-07a709ad1119', @tenant_id, 'Berita Lembaga', 'berita-lembaga', 'Informasi lembaga desa dan organisasi kemasyarakatan.', 6, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('a3218aa8-f025-5b89-b870-d100001f417b', @tenant_id, 'APBDes', 'apbdes', 'Informasi anggaran, realisasi, dan transparansi APBDes.', 7, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);
INSERT INTO news_categories (id, tenant_id, name, slug, description, sort_order, status)
VALUES ('176d3564-eaa3-5485-8dcf-b21dd51a3670', @tenant_id, 'Profil', 'profil', 'Informasi profil, sejarah, visi, dan misi Desa Martopuro.', 8, 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order), status = VALUES(status);

-- Tags
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a3eda259-210c-5699-8e03-60d569ed4e60', @tenant_id, 'Martopuro', 'martopuro')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('da360318-3485-5a37-bc5c-916286bcb002', @tenant_id, 'Berita Desa', 'berita-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('bda96326-5d8a-5592-9623-c593475f0475', @tenant_id, 'Pemerintahan Desa', 'pemerintahan-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('1fd988f4-4834-5c01-9381-be463e47cc4f', @tenant_id, 'Pembangunan', 'pembangunan')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('3d1fded6-2be2-5c4e-bd89-9756efb00c6e', @tenant_id, 'Dana Desa', 'dana-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('857bb874-2eb5-5b80-8dd3-e308485fe400', @tenant_id, 'APBDes', 'apbdes')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('4b798f55-fff7-5df0-8421-c0837952f619', @tenant_id, 'BLT', 'blt')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('7c7274c8-7817-5742-b1d2-7ae33479da4e', @tenant_id, 'BUMDES', 'bumdes')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a42a0420-9540-5dda-a676-87ece5869b3a', @tenant_id, 'KDMP', 'kdmp')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a5f4ff91-7ddd-53d7-b564-3f29521a7c26', @tenant_id, 'Koperasi Desa', 'koperasi-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('9ba60f88-4a36-50be-9e73-7983cacecca0', @tenant_id, 'Karang Taruna', 'karang-taruna')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('e2ec2732-77b8-5a6a-b01c-a543ca4951b5', @tenant_id, 'Karnaval', 'karnaval')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9', @tenant_id, 'Olahraga', 'olahraga')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('214fee5b-67a0-5f2d-b02d-83e714b7362a', @tenant_id, 'Ketahanan Pangan', 'ketahanan-pangan')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a2a354db-0948-5096-ad72-bc86ac5faba2', @tenant_id, 'Kesehatan', 'kesehatan')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a9a6c593-ad2c-54a7-8377-affa7b4b2022', @tenant_id, 'Donor Darah', 'donor-darah')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2', @tenant_id, 'Musyawarah Desa', 'musyawarah-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('ba7593f4-1683-53ab-b3cc-6b5da019b289', @tenant_id, 'RT RW', 'rt-rw')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('b29a5b4e-5967-5d40-bf93-5b57bd786ef0', @tenant_id, 'Pavingisasi', 'pavingisasi')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('7dd3ddd2-1f97-56d7-b2fe-9245318ce91a', @tenant_id, 'TPT', 'tpt')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('91357d15-e607-56c6-a6d7-f44d06338356', @tenant_id, 'PAUD', 'paud')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('356138ea-a420-5abe-8455-a6484baf6480', @tenant_id, 'PKK', 'pkk')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('a22ae8d5-e0ab-5082-ae3c-df1b2b557177', @tenant_id, 'Hari Santri', 'hari-santri')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('f9186399-961e-5bc6-a27d-2b2c45361f07', @tenant_id, 'Khotmil Quran', 'khotmil-quran')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('e6b1c78b-7e84-51b8-901c-06c2c7d131b2', @tenant_id, 'Profil Desa', 'profil-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('8290c4c7-7327-50b6-9d8a-fcc22bbc6b22', @tenant_id, 'BPD', 'bpd')
ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO news_tags (id, tenant_id, name, slug)
VALUES ('f89dce11-6aa2-5881-a3e1-ba18c1c3f79e', @tenant_id, 'Lembaga Desa', 'lembaga-desa')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- News
INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '12e93598-3a78-591f-a50a-1722d6fa50f8', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.',
  'serah-terima-aset-koperasi-desa-merah-putih-kdmp-ke-pemdes-martopuro',
  'Serah terima aset Koperasi Desa Merah Putih (KDMP) kepada Pemerintah Desa Martopuro.',
  '<p>Serah terima aset Koperasi Desa Merah Putih (KDMP) kepada Pemerintah Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-19.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-19 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('12e93598-3a78-591f-a50a-1722d6fa50f8', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '92677901-c5ac-595a-8835-27d8ed0af3f0', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  '4 Tahun Pengabdian & Karya Nyata Kepala Desa Martopuro',
  '4-tahun-pengabdian-dan-karya-nyata-kepala-desa-martopuro',
  'Empat tahun pengabdian menjadi momentum apresiasi atas karya nyata Kepala Desa Martopuro bersama masyarakat.',
  '<p>Empat tahun pengabdian menjadi momentum apresiasi atas karya nyata Kepala Desa Martopuro bersama masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-12.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-12 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('92677901-c5ac-595a-8835-27d8ed0af3f0', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('92677901-c5ac-595a-8835-27d8ed0af3f0', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Serah terima unit truk KDMP ( Koperasi Desa Merah Putih ) Martopuro.',
  'serah-terima-unit-truk-kdmp-koperasi-desa-merah-putih-martopuro',
  'Serah terima unit truk KDMP Martopuro sebagai dukungan operasional koperasi desa.',
  '<p>Serah terima unit truk KDMP Martopuro sebagai dukungan operasional koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'a9d605f6-deff-5623-945e-97f2db2ec56f', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.',
  'sosialisasi-dan-edukasi-kesehatan-dari-pt-tea-fun-community-indonesia',
  'Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.',
  '<p>Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a9d605f6-deff-5623-945e-97f2db2ec56f', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a9d605f6-deff-5623-945e-97f2db2ec56f', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a9d605f6-deff-5623-945e-97f2db2ec56f', 'a2a354db-0948-5096-ad72-bc86ac5faba2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Gedung Sudah Jadi, Mobil Operasional Segera Datang, Koperasi Desa Martopuro Siap Ubah Nasib Warga',
  'gedung-sudah-jadi-mobil-operasional-segera-datang-koperasi-desa-martopuro-siap-ubah-nasib-warga',
  'Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.',
  '<p>Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '9f6d00a1-7abe-5365-87a9-23732bc1880d', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pavingisasi Depan Gerai KDMP Desa Martopuro.',
  'pavingisasi-depan-gerai-kdmp-desa-martopuro',
  'Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.',
  '<p>Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-04.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-05-04 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '28f7c0a9-08c4-5bb4-9525-f63edc7afe37', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Sosialisasi Akuntabilitas Pengelolaan Dana Desa.',
  'sosialisasi-akuntabilitas-pengelolaan-dana-desa',
  'Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.',
  '<p>Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-30 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '716d2798-4298-5677-8de2-a849e97e0e4e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan TPT Depan Gerai KDMP Martopuro.',
  'pembangunan-tpt-depan-gerai-kdmp-martopuro',
  'Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.',
  '<p>Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-30 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('716d2798-4298-5677-8de2-a849e97e0e4e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('716d2798-4298-5677-8de2-a849e97e0e4e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('716d2798-4298-5677-8de2-a849e97e0e4e', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('716d2798-4298-5677-8de2-a849e97e0e4e', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('716d2798-4298-5677-8de2-a849e97e0e4e', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '742001dc-5a14-5b31-a224-e799ceed78da', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pavingisasi Makam Umum Desa Martopuro',
  'pavingisasi-makam-umum-desa-martopuro',
  'Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.',
  '<p>Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-25.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-25 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('742001dc-5a14-5b31-a224-e799ceed78da', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('742001dc-5a14-5b31-a224-e799ceed78da', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('742001dc-5a14-5b31-a224-e799ceed78da', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('742001dc-5a14-5b31-a224-e799ceed78da', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran BLT DD Bulan Januari-April 2026 Desa Martopuro.',
  'penyaluran-blt-dd-bulan-januari-april-2026-desa-martopuro',
  'Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.',
  '<p>Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-24.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-24 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '5447f892-ba7a-5ab1-b257-84ce92e64849', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyerahan THR Tahun 2026 BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan',
  'penyerahan-thr-tahun-2026-bpd-perangkat-desa-pengurus-tp-pkk-rt-rw-linmas-kader-posyandu-modin-desa-martopuro-kec-purwosari-kab-pasuruan',
  'Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.',
  '<p>Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-03-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', '356138ea-a420-5abe-8455-a6484baf6480');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5447f892-ba7a-5ab1-b257-84ce92e64849', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '93b7ab59-b0ac-5d18-96a2-e07db2776730', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Buka Bersama Keluarga Besar Pemdes Martopuro.',
  'buka-bersama-keluarga-besar-pemdes-martopuro',
  'Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.',
  '<p>Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-03-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('93b7ab59-b0ac-5d18-96a2-e07db2776730', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('93b7ab59-b0ac-5d18-96a2-e07db2776730', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0b3e53f9-c8a2-50b5-9846-8639df57da24', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penanaman Pohon Desa Martopuro',
  'penanaman-pohon-desa-martopuro',
  'Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.',
  '<p>Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-27.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-27 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0b3e53f9-c8a2-50b5-9846-8639df57da24', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0b3e53f9-c8a2-50b5-9846-8639df57da24', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0de3d276-823d-583f-99c9-238dd1192685', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.',
  'musyawarah-desa-khusus-pak-apbdes-2026-desa-martopuro',
  'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.',
  '<p>Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-12.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-12 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0de3d276-823d-583f-99c9-238dd1192685', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0de3d276-823d-583f-99c9-238dd1192685', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0de3d276-823d-583f-99c9-238dd1192685', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0de3d276-823d-583f-99c9-238dd1192685', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0de3d276-823d-583f-99c9-238dd1192685', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '8eca8b9e-1818-5380-85dc-41dc5b06dfbf', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Sukses mengadakan Donor Darah Sebelum Bulan Puasa, Agenda Rutin 3bulan sekali Karang Taruna Permata Karya Desa Martopuro',
  'sukses-mengadakan-donor-darah-sebelum-bulan-puasa-agenda-rutin-3bulan-sekali-karang-taruna-permata-karya-desa-martopuro',
  'Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.',
  '<p>Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2026-02-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a2a354db-0948-5096-ad72-bc86ac5faba2');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) & Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.',
  'laporan-keterangan-penyelenggaraan-pemerintah-desa-lkppd-dan-laporan-penyelenggaraan-pemerintah-desa-lppd-desa-martopuro',
  'LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.',
  '<p>LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-27.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-27 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '3d5a8754-c917-5892-8545-2f03ef4746ed', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Pra LKPPD/LPPD Desa Martopuro.',
  'musyawarah-pra-lkppd-lppd-desa-martopuro',
  'Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.',
  '<p>Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3d5a8754-c917-5892-8545-2f03ef4746ed', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3d5a8754-c917-5892-8545-2f03ef4746ed', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3d5a8754-c917-5892-8545-2f03ef4746ed', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3d5a8754-c917-5892-8545-2f03ef4746ed', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', @tenant_id, '0dc3abf2-de70-5cef-b90c-c6872b5f8816',
  'Laporan Pertanggungjawaban BUMDES "Karya Usaha Mandiri" Desa Martopuro Tahun Anggaran 2025.',
  'laporan-pertanggungjawaban-bumdes-karya-usaha-mandiri-desa-martopuro-tahun-anggaran-2025',
  'Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.',
  '<p>Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2026-01-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', '7c7274c8-7817-5742-b1d2-7ae33479da4e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '28b6535e-30c4-5d14-8e1e-9e3239c752ec', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan Gerai KDMP Martopuro.',
  'pembangunan-gerai-kdmp-martopuro',
  'Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.',
  '<p>Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28b6535e-30c4-5d14-8e1e-9e3239c752ec', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.',
  'giat-pengukuran-dimensi-dan-titik-gawang-lapangan-panutan-desa-martopuro',
  'Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.',
  '<p>Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-14.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-14 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0202d245-a266-545f-9162-d6eea1ab2925', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Posbindu Kartini 4 Desa Martopuro.',
  'giat-posbindu-kartini-4-desa-martopuro',
  'Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.',
  '<p>Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0202d245-a266-545f-9162-d6eea1ab2925', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0202d245-a266-545f-9162-d6eea1ab2925', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0202d245-a266-545f-9162-d6eea1ab2925', 'a2a354db-0948-5096-ad72-bc86ac5faba2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ae99d98e-0fde-5894-bac8-4b5b13111604', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Business Matching Kab.Pasuruan.',
  'giat-business-matching-kab-pasuruan',
  'Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.',
  '<p>Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-12.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-12 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ae99d98e-0fde-5894-bac8-4b5b13111604', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ae99d98e-0fde-5894-bac8-4b5b13111604', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '2cf090c9-5ec7-5998-813e-24ff8cda4d03', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Penetapan APBDes Desa Martopuro 2026.',
  'musyawarah-penetapan-apbdes-desa-martopuro-2026',
  'Musyawarah penetapan APBDes Desa Martopuro tahun 2026.',
  '<p>Musyawarah penetapan APBDes Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2cf090c9-5ec7-5998-813e-24ff8cda4d03', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2cf090c9-5ec7-5998-813e-24ff8cda4d03', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '14ac0d2b-754c-536c-99cf-15cc577f0e4e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.',
  'musyawarah-desa-penyusunan-rencana-kerja-pembangunan-desa-martopuro-2026',
  'Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.',
  '<p>Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('14ac0d2b-754c-536c-99cf-15cc577f0e4e', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '27efc7fe-a3de-5fd9-b18b-339c8ced838f', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Keseriusan Pemerintah Desa Martopuro di Bawah Kepemimpinan Kepala Desa Rianto: Satu Tahun Kerja, Satu Tahun Bukti',
  'keseriusan-pemerintah-desa-martopuro-di-bawah-kepemimpinan-kepala-desa-rianto-satu-tahun-kerja-satu-tahun-bukti',
  'Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.',
  '<p>Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('27efc7fe-a3de-5fd9-b18b-339c8ced838f', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('27efc7fe-a3de-5fd9-b18b-339c8ced838f', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '4fa40dea-5ca9-5e8b-91b6-61b784917577', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.',
  'penyaluran-blt-dana-desa-tahun-2025-bulan-november-desember',
  'Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.',
  '<p>Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4fa40dea-5ca9-5e8b-91b6-61b784917577', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4fa40dea-5ca9-5e8b-91b6-61b784917577', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4fa40dea-5ca9-5e8b-91b6-61b784917577', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4fa40dea-5ca9-5e8b-91b6-61b784917577', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'e234c8ce-3c68-5078-858b-028ecb8131c7', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.',
  'musdes-penetapan-kpm-blt-dd-tahun-2026-desa-martopuro',
  'Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.',
  '<p>Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e234c8ce-3c68-5078-858b-028ecb8131c7', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e234c8ce-3c68-5078-858b-028ecb8131c7', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e234c8ce-3c68-5078-858b-028ecb8131c7', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e234c8ce-3c68-5078-858b-028ecb8131c7', '4b798f55-fff7-5df0-8421-c0837952f619');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e234c8ce-3c68-5078-858b-028ecb8131c7', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran Bantuan Pangan Desa Martopuro.',
  'penyaluran-bantuan-pangan-desa-martopuro',
  'Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.',
  '<p>Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-05.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-05 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c6b5b015-20c7-517d-8f1e-e088d5ef310d', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.',
  'rencana-lokasi-pembangunan-gerai-kdmp-koperasi-desa-merah-putih-martopuro',
  'Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.',
  '<p>Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-03.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-03 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6b5b015-20c7-517d-8f1e-e088d5ef310d', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd545b75f-5e33-5840-bbb8-75a04f3b81f8', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Louncing Panen Jagung Bumdes " Karya Usaha Mandiri" Desa Martopuro.',
  'louncing-panen-jagung-bumdes-karya-usaha-mandiri-desa-martopuro',
  'Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.',
  '<p>Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d545b75f-5e33-5840-bbb8-75a04f3b81f8', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d545b75f-5e33-5840-bbb8-75a04f3b81f8', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d545b75f-5e33-5840-bbb8-75a04f3b81f8', '7c7274c8-7817-5742-b1d2-7ae33479da4e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d545b75f-5e33-5840-bbb8-75a04f3b81f8', '214fee5b-67a0-5f2d-b02d-83e714b7362a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0f5169fe-c105-5392-9ce6-eb8bce734ce9', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro',
  'rapat-koordinasi-rutin-tiap-senin-pemdes-martopuro',
  'Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.',
  '<p>Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-17.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-17 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f5169fe-c105-5392-9ce6-eb8bce734ce9', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0f5169fe-c105-5392-9ce6-eb8bce734ce9', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '7190b957-3b9c-54eb-812e-5e4f87d0486e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.',
  'rianto-kepala-desa-martopuro-mengikuti-bimbingan-teknis-administrasi-pemerintahan-desa',
  'Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.',
  '<p>Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7190b957-3b9c-54eb-812e-5e4f87d0486e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7190b957-3b9c-54eb-812e-5e4f87d0486e', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '5d8096bc-eb95-5638-9799-69ed0c7e7759', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.',
  'verifikasi-proyek-lapangan-rkp-2026-desa-martopuro',
  'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.',
  '<p>Verifikasi proyek lapangan RKP 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-08.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-08 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'e443442d-8563-5fd5-991d-b26695297919', @tenant_id, '0dc3abf2-de70-5cef-b90c-c6872b5f8816',
  'Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.',
  'zoom-meeting-bumdes-karya-usaha-mandiri-desa-martopuro',
  'Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.',
  '<p>Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-11-03.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-03 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e443442d-8563-5fd5-991d-b26695297919', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e443442d-8563-5fd5-991d-b26695297919', '7c7274c8-7817-5742-b1d2-7ae33479da4e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '52c08d85-b677-54bc-8fd2-b479c48ce2bf', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Monitoring Pajak Bumi & Bangunan oleh tim Monitoring Kecamatan Purwosari.',
  'monitoring-pajak-bumi-dan-bangunan-oleh-tim-monitoring-kecamatan-purwosari',
  'Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.',
  '<p>Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-31.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-31 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '769da44b-8943-579c-aadf-f4cfbf063172', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025',
  'desa-martopuro-termasuk-perwakilan-desa-di-kabupaten-pasuruan-yang-mengikuti-pelatihan-tata-kelola-desa-2025',
  'Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.',
  '<p>Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-29.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-29 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('769da44b-8943-579c-aadf-f4cfbf063172', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('769da44b-8943-579c-aadf-f4cfbf063172', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('769da44b-8943-579c-aadf-f4cfbf063172', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '1200c374-aa7b-5f70-966a-6f94b09c9f1b', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Mengikuti Pelatihan Manajemen Data Kampung Keluarga Berencana.',
  'mengikuti-pelatihan-manajemen-data-kampung-keluarga-berencana',
  'Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.',
  '<p>Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-28.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-28 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1200c374-aa7b-5f70-966a-6f94b09c9f1b', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1200c374-aa7b-5f70-966a-6f94b09c9f1b', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Sukses digelar Peringatan Hari Santri 2025 di Desa Martopuro',
  'sukses-digelar-peringatan-hari-santri-2025-di-desa-martopuro',
  'Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.',
  '<p>Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'a22ae8d5-e0ab-5082-ae3c-df1b2b557177');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ad96b442-3513-573f-bc25-4b8090a7cd48', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan',
  'santunan-dhuafa-oleh-ibu-bupati-pasuruan-di-desa-martopuro-dan-pengajian-rutin-tp-pkk-kab-pasuruan',
  'Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.',
  '<p>Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-16.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-16 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ad96b442-3513-573f-bc25-4b8090a7cd48', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ad96b442-3513-573f-bc25-4b8090a7cd48', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ad96b442-3513-573f-bc25-4b8090a7cd48', '356138ea-a420-5abe-8455-a6484baf6480');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0e1ac83c-6448-5299-ad51-0f738729c829', @tenant_id, '0dc3abf2-de70-5cef-b90c-c6872b5f8816',
  'Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro',
  'bumdes-berupaya-untuk-optimal-dalam-program-ketahanan-pangan-desa-martopuro',
  'BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.',
  '<p>BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-10-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0e1ac83c-6448-5299-ad51-0f738729c829', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0e1ac83c-6448-5299-ad51-0f738729c829', '7c7274c8-7817-5742-b1d2-7ae33479da4e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0e1ac83c-6448-5299-ad51-0f738729c829', '214fee5b-67a0-5f2d-b02d-83e714b7362a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '50c43074-eb60-58bd-8cc8-6d88cb42e367', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Desa Martopuro Jadi Pelopor Musyawarah Desa Khusus 2025 untuk Pembiayaan Koperasi Desa Merah Putih',
  'desa-martopuro-jadi-pelopor-musyawarah-desa-khusus-2025-untuk-pembiayaan-koperasi-desa-merah-putih',
  'Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.',
  '<p>Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-09 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd9157e08-e6de-5b47-8bb3-d7edf5b6a53f', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.',
  'penyaluran-blt-dana-desa-bulan-september-oktober-desa-martopuro-2025',
  'Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.',
  '<p>Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-09 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'a71c4075-f75f-5679-9e9f-f92a1c40688a', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Warga Padati Tarkam Bola Voly Martopuro Cup 2025, Pemain Proliga Turun Lapangan, Apresiasi Sukses Luar Biasa',
  'warga-padati-tarkam-bola-voly-martopuro-cup-2025-pemain-proliga-turun-lapangan-apresiasi-sukses-luar-biasa',
  'Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.',
  '<p>Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-10-04.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-04 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a71c4075-f75f-5679-9e9f-f92a1c40688a', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a71c4075-f75f-5679-9e9f-f92a1c40688a', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('a71c4075-f75f-5679-9e9f-f92a1c40688a', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '6070b7fc-e04e-569d-b739-e2910ffd5090', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Turnamen Bola Voly Martopuro Cup Resmi dibuka diikuti Tim dari berbagai Kota, Pasuruan dan Sekitarnya',
  'turnamen-bola-voly-martopuro-cup-resmi-dibuka-diikuti-tim-dari-berbagai-kota-pasuruan-dan-sekitarnya',
  'Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.',
  '<p>Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-09-07 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6070b7fc-e04e-569d-b739-e2910ffd5090', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6070b7fc-e04e-569d-b739-e2910ffd5090', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6070b7fc-e04e-569d-b739-e2910ffd5090', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Camat Purwosari Munif Triatmoko, Secara Resmi Membuka "Martopuro Cup 2025"',
  'camat-purwosari-munif-triatmoko-secara-resmi-membuka-martopuro-cup-2025',
  'Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.',
  '<p>Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-09-07 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'dbd545fb-0f53-5937-85ca-5d8f48b79aa7', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.',
  'monev-giat-fisik-semester-2-tahun-2025-oleh-kecamatan-dan-ta-kabupaten-dana-desa-desa-martopuro',
  'Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.',
  '<p>Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-30.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-30 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Hebohnya Parade Karnaval Martopuro 2025, Mengalir Apresiasi SUKSES dan Permintaan diadakan lagi Tahun Depan',
  'hebohnya-parade-karnaval-martopuro-2025-mengalir-apresiasi-sukses-dan-permintaan-diadakan-lagi-tahun-depan',
  'Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.',
  '<p>Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-08-24.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-24 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '027f21be-9112-5401-a8b7-f4138b7c972e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Khotmil Qur''an Jum''at Legi Kantor Desa Martopuro Bulan Agustus 2025',
  'giat-khotmil-quran-jumat-legi-kantor-desa-martopuro-bulan-agustus-2025',
  'Kegiatan Khotmil Qur''an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.',
  '<p>Kegiatan Khotmil Qur&#x27;an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('027f21be-9112-5401-a8b7-f4138b7c972e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('027f21be-9112-5401-a8b7-f4138b7c972e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('027f21be-9112-5401-a8b7-f4138b7c972e', 'f9186399-961e-5bc6-a27d-2b2c45361f07');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '37298592-f182-5f74-b78c-b3ec4bbc6131', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.',
  'lomba-tumpeng-tp-pkk-desa-martopuro-peringatan-17-agustus-2025-di-pendopo-kec-purwosari',
  'Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.',
  '<p>Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37298592-f182-5f74-b78c-b3ec4bbc6131', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37298592-f182-5f74-b78c-b3ec4bbc6131', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37298592-f182-5f74-b78c-b3ec4bbc6131', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37298592-f182-5f74-b78c-b3ec4bbc6131', '356138ea-a420-5abe-8455-a6484baf6480');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '9dadaee9-719d-548b-8238-f4fe52022f8c', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.',
  'penyaluran-blt-dana-desa-bulan-juli-agustus-2025-desa-martopuro',
  'Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.',
  '<p>Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9dadaee9-719d-548b-8238-f4fe52022f8c', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9dadaee9-719d-548b-8238-f4fe52022f8c', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9dadaee9-719d-548b-8238-f4fe52022f8c', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9dadaee9-719d-548b-8238-f4fe52022f8c', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '1dc553b6-966d-5ee6-b20b-7c9cc52afab2', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Rembug Stunting Desa Martopuro 2025.',
  'giat-rembug-stunting-desa-martopuro-2025',
  'Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.',
  '<p>Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'a2a354db-0948-5096-ad72-bc86ac5faba2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd4bb0bbd-d85b-516e-ae9b-9622be28e88e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari , 17 Agustus 2025',
  'kerja-bakti-lapangan-panutan-desa-martopuro-persiapan-upacara-kemerdekaan-se-kecamatan-purwosari-17-agustus-2025',
  'Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.',
  '<p>Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga',
  'hadirnya-martopuro-selection-fc-bentuk-pemerintah-desa-ingin-menggali-potensi-sdm-dibidang-olahrga',
  'Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.',
  '<p>Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'db1914b1-a569-54c6-9947-c394dbb9be82', @tenant_id, '0dc3abf2-de70-5cef-b90c-c6872b5f8816',
  'Louncing Ketahanan Pangan Bumdes" Karya Usaha Mandiri" Desa Martopuro.',
  'louncing-ketahanan-pangan-bumdes-karya-usaha-mandiri-desa-martopuro',
  'Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.',
  '<p>Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-06 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('db1914b1-a569-54c6-9947-c394dbb9be82', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('db1914b1-a569-54c6-9947-c394dbb9be82', '7c7274c8-7817-5742-b1d2-7ae33479da4e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('db1914b1-a569-54c6-9947-c394dbb9be82', '214fee5b-67a0-5f2d-b02d-83e714b7362a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '314b723c-3f8d-5166-bfa5-72aa7043a5a9', @tenant_id, '0dc3abf2-de70-5cef-b90c-c6872b5f8816',
  'Polsek Purwosari Kerahkan Personel Dukung BUMDes Martopuro Garap Lahan Ketahanan Pangan',
  'polsek-purwosari-kerahkan-personel-dukung-bumdes-martopuro-garap-lahan-ketahanan-pangan',
  'Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.',
  '<p>Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-06 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('314b723c-3f8d-5166-bfa5-72aa7043a5a9', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('314b723c-3f8d-5166-bfa5-72aa7043a5a9', '7c7274c8-7817-5742-b1d2-7ae33479da4e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('314b723c-3f8d-5166-bfa5-72aa7043a5a9', '214fee5b-67a0-5f2d-b02d-83e714b7362a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('314b723c-3f8d-5166-bfa5-72aa7043a5a9', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '00663ec6-efdb-5deb-ab2a-890e9b41b300', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.',
  'pembangunan-tpt-jembatan-dusun-klojen-desa-martopuro',
  'Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.',
  '<p>Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00663ec6-efdb-5deb-ab2a-890e9b41b300', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00663ec6-efdb-5deb-ab2a-890e9b41b300', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00663ec6-efdb-5deb-ab2a-890e9b41b300', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00663ec6-efdb-5deb-ab2a-890e9b41b300', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'e37bc81d-7c20-50a6-9f03-fd3169b9037a', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Desa Martopuro Juara 2 lomba Samroh TP PKK Kecamatan Purwosari',
  'desa-martopuro-juara-2-lomba-samroh-tp-pkk-kecamatan-purwosari',
  'Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.',
  '<p>Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e37bc81d-7c20-50a6-9f03-fd3169b9037a', '356138ea-a420-5abe-8455-a6484baf6480');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '8d9a0bf7-0371-56d2-b5df-c00099b22b88', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembinaan Linmas Desa Martopuro.',
  'pembinaan-linmas-desa-martopuro',
  'Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.',
  '<p>Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-27.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-27 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '6803ca49-8946-5386-86a8-257563dfb328', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembinaan Karang Taruna "Permata Karya" Desa Martopuro.',
  'pembinaan-karang-taruna-permata-karya-desa-martopuro',
  'Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.',
  '<p>Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-26.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-26 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6803ca49-8946-5386-86a8-257563dfb328', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6803ca49-8946-5386-86a8-257563dfb328', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6803ca49-8946-5386-86a8-257563dfb328', '9ba60f88-4a36-50be-9e73-7983cacecca0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Jambanisasi Warga Desa Martopuro APBDes 2025',
  'jambanisasi-warga-desa-martopuro-apbdes-2025',
  'Program jambanisasi warga Desa Martopuro melalui APBDes 2025.',
  '<p>Program jambanisasi warga Desa Martopuro melalui APBDes 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'a2a354db-0948-5096-ad72-bc86ac5faba2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '6dac5caf-5fd1-5024-947f-612840cdfe03', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pengecatan Gedung PAUD Desa Martopuro.',
  'pengecatan-gedung-paud-desa-martopuro',
  'Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.',
  '<p>Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6dac5caf-5fd1-5024-947f-612840cdfe03', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6dac5caf-5fd1-5024-947f-612840cdfe03', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('6dac5caf-5fd1-5024-947f-612840cdfe03', '91357d15-e607-56c6-a6d7-f44d06338356');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '5c6b17fa-8342-5aec-9b43-8882f65deed6', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Sukses mengadakan Pelatihan Pemulasaran Jenazah Desa Martopuro',
  'sukses-mengadakan-pelatihan-pemulasaran-jenazah-desa-martopuro',
  'Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.',
  '<p>Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5c6b17fa-8342-5aec-9b43-8882f65deed6', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('5c6b17fa-8342-5aec-9b43-8882f65deed6', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '53d1a069-6c1b-5559-b7f0-88fc9215eeec', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.',
  'pengecatan-mushola-hubbul-wathon-kantor-desa-martopuro',
  'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.',
  '<p>Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('53d1a069-6c1b-5559-b7f0-88fc9215eeec', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('53d1a069-6c1b-5559-b7f0-88fc9215eeec', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '9bd335b4-71c8-5489-958f-434540bdc86c', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Kunjungan Haji Pemdes Martopuro.',
  'giat-kunjungan-haji-pemdes-martopuro',
  'Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.',
  '<p>Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9bd335b4-71c8-5489-958f-434540bdc86c', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9bd335b4-71c8-5489-958f-434540bdc86c', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa.',
  'musyawarah-pemdes-martopuro-dengan-pengelola-kios-desa',
  'Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.',
  '<p>Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-11.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-11 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  '27 RW siap Mensukseskan Karnaval Martopuro 2025',
  '27-rw-siap-mensukseskan-karnaval-martopuro-2025',
  'Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.',
  '<p>Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-07-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '0d88cc0f-991a-5abd-b92a-b87fba44bf44', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.',
  'pemasangan-speed-bump-jalan-dusun-klojen-desa-martopuro',
  'Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.',
  '<p>Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0d88cc0f-991a-5abd-b92a-b87fba44bf44', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0d88cc0f-991a-5abd-b92a-b87fba44bf44', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('0d88cc0f-991a-5abd-b92a-b87fba44bf44', '1fd988f4-4834-5c01-9381-be463e47cc4f');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'e10f4c82-65d9-532f-ad6a-3dae598123ce', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.',
  'pembangunan-tpt-pertanian-dusun-kemantren-rw-04-desa-martopuro',
  'Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.',
  '<p>Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e10f4c82-65d9-532f-ad6a-3dae598123ce', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e10f4c82-65d9-532f-ad6a-3dae598123ce', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'bf3db79c-50cc-583d-b0f0-d0682ee9e38b', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Wes Siap ta Dulur, Karnaval Martopuro 2025, Ini Persyaratan dan Waktunya',
  'wes-siap-ta-dulur-karnaval-martopuro-2025-ini-persyaratan-dan-waktunya',
  'Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.',
  '<p>Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-30 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '90753d65-2026-5e82-b69a-39c3d7d6840a', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro',
  'rehab-kantor-hippa-himpunan-petani-pemakai-air-desa-martopuro',
  'Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.',
  '<p>Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-30 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('90753d65-2026-5e82-b69a-39c3d7d6840a', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('90753d65-2026-5e82-b69a-39c3d7d6840a', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('90753d65-2026-5e82-b69a-39c3d7d6840a', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('90753d65-2026-5e82-b69a-39c3d7d6840a', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd10f7b8e-635b-5b8f-be54-9da7a60eb1eb', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Tasyakuran Awal Pelaksanaan Dana Desa tahap 2 tahun 2025',
  'tasyakuran-awal-pelaksanaan-dana-desa-tahap-2-tahun-2025',
  'Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.',
  '<p>Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '955c076e-9b6f-5209-a5e6-f05cc68dae4c', @tenant_id, 'dc0a287d-c539-5407-b1af-83479bbde6b3',
  'Musyawarah Desa Martopuro RKP Tahun 2026',
  'musyawarah-desa-martopuro-rkp-tahun-2026',
  'Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.',
  '<p>Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.</p><p>Berita ini termasuk kategori BPD Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('955c076e-9b6f-5209-a5e6-f05cc68dae4c', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('955c076e-9b6f-5209-a5e6-f05cc68dae4c', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun di Desa Martopuro di masa kepemimpinan Kepala Desa Rianto',
  'manaqib-dzikir-ghofilin-rutin-di-agendakan-setiap-tahun-di-desa-martopuro-di-masa-kepemimpinan-kepala-desa-rianto',
  'Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.',
  '<p>Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-19.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-19 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '37876a11-2d4b-5e70-8b61-474ab4551ae5', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro.',
  'pengecatan-tempat-parkir-kantor-sumber-pad-pendapatan-asli-desa-desa-martopuro',
  'Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.',
  '<p>Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-17.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-17 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37876a11-2d4b-5e70-8b61-474ab4551ae5', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('37876a11-2d4b-5e70-8b61-474ab4551ae5', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '690da950-e796-5869-b702-769a14174c0d', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.',
  'plesterisasi-belakang-kios-desa-martopuro-timur-pasar',
  'Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.',
  '<p>Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('690da950-e796-5869-b702-769a14174c0d', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('690da950-e796-5869-b702-769a14174c0d', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('690da950-e796-5869-b702-769a14174c0d', '1fd988f4-4834-5c01-9381-be463e47cc4f');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ff5c9117-7d47-500b-bcf1-a037ea526e7f', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro.',
  'pembangunan-tandon-air-lapangan-panutan-anggaran-pad-desa-martopuro',
  'Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.',
  '<p>Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ff5c9117-7d47-500b-bcf1-a037ea526e7f', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ff5c9117-7d47-500b-bcf1-a037ea526e7f', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd41479a0-fd39-5334-b206-08e45fd69a44', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro.',
  'giat-pemindahan-tiang-bendera-lapangan-panutan-desa-martopuro',
  'Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.',
  '<p>Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d41479a0-fd39-5334-b206-08e45fd69a44', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d41479a0-fd39-5334-b206-08e45fd69a44', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d41479a0-fd39-5334-b206-08e45fd69a44', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '4b70b27d-1a42-519d-af06-141de67515c7', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembinaan RT&RW Desa Martopuro Semester 1 2025',
  'pembinaan-rt-dan-rw-desa-martopuro-semester-1-2025',
  'Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.',
  '<p>Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4b70b27d-1a42-519d-af06-141de67515c7', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4b70b27d-1a42-519d-af06-141de67515c7', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4b70b27d-1a42-519d-af06-141de67515c7', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Semenjak Kepemimpinan Kades Rianto, Khataman Qur''an menjadi Agenda Rutin Jumat legi Pemerintah Desa',
  'semenjak-kepemimpinan-kades-rianto-khataman-quran-menjadi-agenda-rutin-jumat-legi-pemerintah-desa',
  'Khataman Qur''an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.',
  '<p>Khataman Qur&#x27;an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'f9186399-961e-5bc6-a27d-2b2c45361f07');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'bb7a5901-0339-5235-8f4f-fad4cf2e30e9', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran BLT Dana Desa Bulan Juni 2025 Desa Martopuro.',
  'penyaluran-blt-dana-desa-bulan-juni-2025-desa-martopuro',
  'Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.',
  '<p>Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-11.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-11 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '3ca099fa-59dd-57ee-9d62-eb8a3d23e060', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pemerintah Desa Martopuro BerQur''ban',
  'pemerintah-desa-martopuro-berqurban',
  'Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.',
  '<p>Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-06.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-06 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'f9186399-961e-5bc6-a27d-2b2c45361f07');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '1a44dc93-7a2d-5c4b-a91f-59b24b558625', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Monev Giat Dana Desa Semester 1 Desa Martopuro',
  'monev-giat-dana-desa-semester-1-desa-martopuro',
  'Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.',
  '<p>Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-05.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-05 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1a44dc93-7a2d-5c4b-a91f-59b24b558625', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1a44dc93-7a2d-5c4b-a91f-59b24b558625', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1a44dc93-7a2d-5c4b-a91f-59b24b558625', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '3a7b5d24-4b34-530e-a244-98c85a32780d', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Donor Darah Rutin diadakan 3bulan sekali Bersama Karangtaruna Permata Karya Martopuro',
  'donor-darah-rutin-diadakan-3bulan-sekali-bersama-karangtaruna-permata-karya-martopuro',
  'Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.',
  '<p>Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-05-18.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-18 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3a7b5d24-4b34-530e-a244-98c85a32780d', '9ba60f88-4a36-50be-9e73-7983cacecca0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a2a354db-0948-5096-ad72-bc86ac5faba2');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'de43dc9d-c33d-501f-a100-518c0d4f1802', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyerahan BLT DD Bulan April Mei 2025 Desa Martopuro.',
  'penyerahan-blt-dd-bulan-april-mei-2025-desa-martopuro',
  'Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.',
  '<p>Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('de43dc9d-c33d-501f-a100-518c0d4f1802', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('de43dc9d-c33d-501f-a100-518c0d4f1802', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('de43dc9d-c33d-501f-a100-518c0d4f1802', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('de43dc9d-c33d-501f-a100-518c0d4f1802', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '2db2fdd3-52bd-51dc-a579-590db3bd4c21', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Kegiatan Rutin Jumat legi Khataman Qur''an Pemerintah Desa Martopuro',
  'kegiatan-rutin-jumat-legi-khataman-quran-pemerintah-desa-martopuro',
  'Khotmil Qur''an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.',
  '<p>Khotmil Qur&#x27;an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-09.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-09 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'f9186399-961e-5bc6-a27d-2b2c45361f07');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'c95d0ff1-76f4-5468-af55-c1d5333efd91', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.',
  'musyawarah-desa-penetapan-indeks-desa-martopuro-2025',
  'Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.',
  '<p>Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-07.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-07 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd7cbd547-e969-58f3-be32-be1fc60baeb8', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Terbentuknya Pengurus Koperasi Desa Merah Putih Martopuro',
  'terbentuknya-pengurus-koperasi-desa-merah-putih-martopuro',
  'Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.',
  '<p>Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-23 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a42a0420-9540-5dda-a676-87ece5869b3a');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '00124a2b-cd8c-5c07-a9b0-802a23f37540', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Progres pavingisasi barat lapangan Desa Martopuro',
  'progres-pavingisasi-barat-lapangan-desa-martopuro',
  'Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.',
  '<p>Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-23 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '669442fa-2d82-574d-a13e-a80bc0b6c09b', @tenant_id, 'dcb17bd5-8af2-5484-86fe-e6bee5e15a38',
  'Siap Menerima Siswa Baru Paud Tunas Bangsa Martopuro',
  'siap-menerima-siswa-baru-paud-tunas-bangsa-martopuro',
  'Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.',
  '<p>Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.</p><p>Berita ini termasuk kategori PAUD Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('669442fa-2d82-574d-a13e-a80bc0b6c09b', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('669442fa-2d82-574d-a13e-a80bc0b6c09b', '91357d15-e607-56c6-a6d7-f44d06338356');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '7297bdb9-65d3-5e8b-a567-4c433e23c766', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Progres Pembangunan MCK dan Kios Desa Martopuro',
  'progres-pembangunan-mck-dan-kios-desa-martopuro',
  'Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.',
  '<p>Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-21 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7297bdb9-65d3-5e8b-a567-4c433e23c766', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7297bdb9-65d3-5e8b-a567-4c433e23c766', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7297bdb9-65d3-5e8b-a567-4c433e23c766', '1fd988f4-4834-5c01-9381-be463e47cc4f');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '9198aa9c-915c-582d-8e20-608ec82b6c1c', @tenant_id, '6009b765-2f64-50fd-951d-07a709ad1119',
  'Lembaga di Desa Martopuro',
  'lembaga-di-desa-martopuro',
  'Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.',
  '<p>Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Lembaga Desa Martopuro dan dipublikasikan pada 2025-04-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9198aa9c-915c-582d-8e20-608ec82b6c1c', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9198aa9c-915c-582d-8e20-608ec82b6c1c', '356138ea-a420-5abe-8455-a6484baf6480');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9198aa9c-915c-582d-8e20-608ec82b6c1c', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('9198aa9c-915c-582d-8e20-608ec82b6c1c', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '037e60f1-d579-5c99-955f-eb8ef6fa50c5', @tenant_id, 'a3218aa8-f025-5b89-b870-d100001f417b',
  'APBDes Desa Martopuro 2025',
  'apbdes-desa-martopuro-2025',
  'Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.',
  '<p>Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-14 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('037e60f1-d579-5c99-955f-eb8ef6fa50c5', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('037e60f1-d579-5c99-955f-eb8ef6fa50c5', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('037e60f1-d579-5c99-955f-eb8ef6fa50c5', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('037e60f1-d579-5c99-955f-eb8ef6fa50c5', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '790d87a5-2ae9-5430-840a-83736bee1d62', @tenant_id, 'a3218aa8-f025-5b89-b870-d100001f417b',
  'Realisasi APBDes Desa Martopuro 2024',
  'realisasi-apbdes-desa-martopuro-2024',
  'Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.',
  '<p>Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-14 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('790d87a5-2ae9-5430-840a-83736bee1d62', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('790d87a5-2ae9-5430-840a-83736bee1d62', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('790d87a5-2ae9-5430-840a-83736bee1d62', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('790d87a5-2ae9-5430-840a-83736bee1d62', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ab737371-da5c-527f-9a79-9c0c2f45675a', @tenant_id, '176d3564-eaa3-5485-8dcf-b21dd51a3670',
  'Sejarah Desa Martopuro',
  'sejarah-desa-martopuro',
  'Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.',
  '<p>Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab737371-da5c-527f-9a79-9c0c2f45675a', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ab737371-da5c-527f-9a79-9c0c2f45675a', 'e6b1c78b-7e84-51b8-901c-06c2c7d131b2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', @tenant_id, '176d3564-eaa3-5485-8dcf-b21dd51a3670',
  'Visi dan Misi',
  'visi-dan-misi',
  'Informasi visi dan misi Desa Martopuro.',
  '<p>Informasi visi dan misi Desa Martopuro.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', 'e6b1c78b-7e84-51b8-901c-06c2c7d131b2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '68d97ecd-8f43-592e-9a84-c151b1626e11', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Kades Martopuro Menjawab dengan Lounching Website Resmi Desa',
  'kades-martopuro-menjawab-dengan-lounching-website-resmi-desa',
  'Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.',
  '<p>Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('68d97ecd-8f43-592e-9a84-c151b1626e11', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('68d97ecd-8f43-592e-9a84-c151b1626e11', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '51f681e3-6898-57ff-90af-38c7da75782e', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro',
  'merealisasikan-pavingisasi-pemukiman-dusun-karangasem-desa-martopuro',
  'Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.',
  '<p>Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('51f681e3-6898-57ff-90af-38c7da75782e', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('51f681e3-6898-57ff-90af-38c7da75782e', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('51f681e3-6898-57ff-90af-38c7da75782e', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('51f681e3-6898-57ff-90af-38c7da75782e', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('51f681e3-6898-57ff-90af-38c7da75782e', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'fd8458dc-aed4-5935-b3c1-ae08ba062a28', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro',
  'merealisasikan-pembangunan-pavingisasi-depan-kios-desa-utara-pasar-purwosari-desa-martopuro',
  'Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.',
  '<p>Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-10 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'ba7593f4-1683-53ab-b3cc-6b5da019b289');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '4e2acb6e-09d3-589c-80a4-d7683ee2eb57', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT.Indolakto',
  'sukses-mengadakan-santunan-105-anak-yatim-desa-martopuro-oleh-kepala-desa-martopuro-bersama-pt-indolakto',
  'Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.',
  '<p>Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-27.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-27 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4e2acb6e-09d3-589c-80a4-d7683ee2eb57', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('4e2acb6e-09d3-589c-80a4-d7683ee2eb57', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '8d7a3ff8-f997-5b48-818a-935b6c184fb6', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Merealisasikan TPT & Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro',
  'merealisasikan-tpt-dan-pavingisasi-pemukiman-dusun-puntir-dana-desa-martopuro',
  'Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.',
  '<p>Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-24.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-24 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'f08dfc48-80bf-52ea-9942-e801bb198c64', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro',
  'pembangunan-tpt-lapangan-panutan-dana-desa-desa-martopuro',
  'Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.',
  '<p>Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-18.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-18 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', '1fd988f4-4834-5c01-9381-be463e47cc4f');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('f08dfc48-80bf-52ea-9942-e801bb198c64', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '086e5012-1bce-5e52-8e64-b1dadc98f553', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro',
  'penyaluran-bantuan-langsung-tunai-triwulan-i-tahun-2025-desa-martopuro',
  'Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.',
  '<p>Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-12.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-12 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('086e5012-1bce-5e52-8e64-b1dadc98f553', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('086e5012-1bce-5e52-8e64-b1dadc98f553', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('086e5012-1bce-5e52-8e64-b1dadc98f553', '4b798f55-fff7-5df0-8421-c0837952f619');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '377c2f8a-ce9a-5e09-a2e0-8517acb511ef', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musdes Khusus Desa Martopuro',
  'musdes-khusus-desa-martopuro',
  'Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.',
  '<p>Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-26.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-02-26 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', '857bb874-2eb5-5b80-8dd3-e308485fe400');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', '7c7274c8-7817-5742-b1d2-7ae33479da4e');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'd94820bc-e2b3-5365-b15d-2918dcb35469', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Kerja Bakti Lingkungan Desa Martopuro',
  'kerja-bakti-lingkungan-desa-martopuro',
  'Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.',
  '<p>Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-23.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-02-23 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d94820bc-e2b3-5365-b15d-2918dcb35469', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('d94820bc-e2b3-5365-b15d-2918dcb35469', 'da360318-3485-5a37-bc5c-916286bcb002');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '1ae0a0ed-b919-57c2-a986-f619ada9e2f0', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Apel Peringatan Hari Desa Nasional Desa Martopuro.',
  'apel-peringatan-hari-desa-nasional-desa-martopuro',
  'Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.',
  '<p>Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-23.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-23 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  '7969e1ae-86fa-516c-90fc-e15f0a2a548c', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro',
  'musyawarah-desa-khusus-musdesus-desa-martopuro',
  'Musyawarah Desa Khusus (Musdesus) Desa Martopuro.',
  '<p>Musyawarah Desa Khusus (Musdesus) Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-22.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-22 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'e1e3eacd-eb83-5ef5-a86e-077945a4f60a', @tenant_id, '593eb4c5-7faf-565a-8503-e32028a43526',
  'Laporan Pertanggungjawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024',
  'laporan-pertanggungjawaban-kepala-desa-martopuro-akhir-tahun-anggaran-2024',
  'Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.',
  '<p>Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-15.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-15 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', 'da360318-3485-5a37-bc5c-916286bcb002');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', '857bb874-2eb5-5b80-8dd3-e308485fe400');

INSERT INTO news (id, tenant_id, category_id, title, slug, description_card, description_content, cover_url, status, read_time, published_at)
VALUES (
  'b8c6cb03-34cd-585e-a83d-85ecd115c79b', @tenant_id, '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe',
  'Info Event Karangtaruna Permata karya',
  'info-event-karangtaruna-permata-karya',
  'Informasi event Karang Taruna Permata Karya Desa Martopuro.',
  '<p>Informasi event Karang Taruna Permata Karya Desa Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2024-08-01.</p>',
  '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2024-08-01 09:00:00'
)
ON DUPLICATE KEY UPDATE
  category_id = VALUES(category_id),
  title = VALUES(title),
  description_card = VALUES(description_card),
  description_content = VALUES(description_content),
  cover_url = VALUES(cover_url),
  status = VALUES(status),
  read_time = VALUES(read_time),
  published_at = VALUES(published_at);
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('b8c6cb03-34cd-585e-a83d-85ecd115c79b', 'a3eda259-210c-5699-8e03-60d569ed4e60');
INSERT IGNORE INTO news_tag_map (news_id, tag_id) VALUES ('b8c6cb03-34cd-585e-a83d-85ecd115c79b', '9ba60f88-4a36-50be-9e73-7983cacecca0');

COMMIT;