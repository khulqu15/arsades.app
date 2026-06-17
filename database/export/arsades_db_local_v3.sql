-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: arsades_db
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(220) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_card` text COLLATE utf8mb4_unicode_ci,
  `description_content` longtext COLLATE utf8mb4_unicode_ci,
  `cover_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `read_time` int unsigned NOT NULL DEFAULT '1',
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_news_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_news_tenant_status_published` (`tenant_id`,`status`,`published_at`),
  KEY `idx_news_category` (`category_id`),
  FULLTEXT KEY `ft_news_search` (`title`,`description_card`,`description_content`),
  CONSTRAINT `fk_news_category` FOREIGN KEY (`category_id`) REFERENCES `news_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_news_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Progres pavingisasi barat lapangan Desa Martopuro','progres-pavingisasi-barat-lapangan-desa-martopuro','Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.','<p>Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-23 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('00663ec6-efdb-5deb-ab2a-890e9b41b300','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.','pembangunan-tpt-jembatan-dusun-klojen-desa-martopuro','Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.','<p>Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0202d245-a266-545f-9162-d6eea1ab2925','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Posbindu Kartini 4 Desa Martopuro.','giat-posbindu-kartini-4-desa-martopuro','Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.','<p>Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('027f21be-9112-5401-a8b7-f4138b7c972e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Khotmil Qur\'an Jum\'at Legi Kantor Desa Martopuro Bulan Agustus 2025','giat-khotmil-quran-jumat-legi-kantor-desa-martopuro-bulan-agustus-2025','Kegiatan Khotmil Qur\'an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.','<p>Kegiatan Khotmil Qur&#x27;an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('037e60f1-d579-5c99-955f-eb8ef6fa50c5','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','a3218aa8-f025-5b89-b870-d100001f417b','APBDes Desa Martopuro 2025','apbdes-desa-martopuro-2025','Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.','<p>Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-14 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('086e5012-1bce-5e52-8e64-b1dadc98f553','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro','penyaluran-bantuan-langsung-tunai-triwulan-i-tahun-2025-desa-martopuro','Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.','<p>Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-12.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-03-12 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0b3e53f9-c8a2-50b5-9846-8639df57da24','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penanaman Pohon Desa Martopuro','penanaman-pohon-desa-martopuro','Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.','<p>Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-27.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-02-27 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0d88cc0f-991a-5abd-b92a-b87fba44bf44','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.','pemasangan-speed-bump-jalan-dusun-klojen-desa-martopuro','Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.','<p>Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0de3d276-823d-583f-99c9-238dd1192685','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.','musyawarah-desa-khusus-pak-apbdes-2026-desa-martopuro','Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.','<p>Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-12.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-02-12 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0e1ac83c-6448-5299-ad51-0f738729c829','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','0dc3abf2-de70-5cef-b90c-c6872b5f8816','Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro','bumdes-berupaya-untuk-optimal-dalam-program-ketahanan-pangan-desa-martopuro','BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.','<p>BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-10-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0f5169fe-c105-5392-9ce6-eb8bce734ce9','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro','rapat-koordinasi-rutin-tiap-senin-pemdes-martopuro','Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.','<p>Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-17.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-11-17 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Gedung Sudah Jadi, Mobil Operasional Segera Datang, Koperasi Desa Martopuro Siap Ubah Nasib Warga','gedung-sudah-jadi-mobil-operasional-segera-datang-koperasi-desa-martopuro-siap-ubah-nasib-warga','Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.','<p>Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780202915/martopuro/news/covers/sedang-1778211629-foto_sqgqal.webp','published',1,'2026-05-08 23:00:00','2026-05-21 01:30:02','2026-05-31 04:48:40',NULL),('1200c374-aa7b-5f70-966a-6f94b09c9f1b','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Mengikuti Pelatihan Manajemen Data Kampung Keluarga Berencana.','mengikuti-pelatihan-manajemen-data-kampung-keluarga-berencana','Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.','<p>Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-28.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-28 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('12e93598-3a78-591f-a50a-1722d6fa50f8','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.','serah-terima-aset-koperasi-desa-merah-putih-kdmp-ke-pemdes-martopuro','Serah terima aset Koperasi Desa Merah Putih (KDMP) kepada Pemerintah Desa Martopuro.','<p>adknajidbajdajkndjakndjknajdnjabdhadbhad</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1779615698/martopuro/news/covers/sedang-1779155776-700506355-1339943901347854-3727692882221577314-n_cy8igj.webp','published',1,'2026-05-19 16:00:00','2026-05-21 01:30:02','2026-05-24 09:41:39',NULL),('14ac0d2b-754c-536c-99cf-15cc577f0e4e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.','musyawarah-desa-penyusunan-rencana-kerja-pembangunan-desa-martopuro-2026','Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.','<p>Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('1a44dc93-7a2d-5c4b-a91f-59b24b558625','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Monev Giat Dana Desa Semester 1 Desa Martopuro','monev-giat-dana-desa-semester-1-desa-martopuro','Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.','<p>Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-05.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-05 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('1ae0a0ed-b919-57c2-a986-f619ada9e2f0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Apel Peringatan Hari Desa Nasional Desa Martopuro.','apel-peringatan-hari-desa-nasional-desa-martopuro','Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.','<p>Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-23.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-01-23 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('1dc553b6-966d-5ee6-b20b-7c9cc52afab2','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Rembug Stunting Desa Martopuro 2025.','giat-rembug-stunting-desa-martopuro-2025','Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.','<p>Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('27efc7fe-a3de-5fd9-b18b-339c8ced838f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Keseriusan Pemerintah Desa Martopuro di Bawah Kepemimpinan Kepala Desa Rianto: Satu Tahun Kerja, Satu Tahun Bukti','keseriusan-pemerintah-desa-martopuro-di-bawah-kepemimpinan-kepala-desa-rianto-satu-tahun-kerja-satu-tahun-bukti','Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.','<p>Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-08 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan Gerai KDMP Martopuro.','pembangunan-gerai-kdmp-martopuro','Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.','<p>Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('28f7c0a9-08c4-5bb4-9525-f63edc7afe37','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Sosialisasi Akuntabilitas Pengelolaan Dana Desa.','sosialisasi-akuntabilitas-pengelolaan-dana-desa','Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.','<p>Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-04-30 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Penetapan APBDes Desa Martopuro 2026.','musyawarah-penetapan-apbdes-desa-martopuro-2026','Musyawarah penetapan APBDes Desa Martopuro tahun 2026.','<p>Musyawarah penetapan APBDes Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('2db2fdd3-52bd-51dc-a579-590db3bd4c21','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Kegiatan Rutin Jumat legi Khataman Qur\'an Pemerintah Desa Martopuro','kegiatan-rutin-jumat-legi-khataman-quran-pemerintah-desa-martopuro','Khotmil Qur\'an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.','<p>Khotmil Qur&#x27;an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-09.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-05-09 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('314b723c-3f8d-5166-bfa5-72aa7043a5a9','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','0dc3abf2-de70-5cef-b90c-c6872b5f8816','Polsek Purwosari Kerahkan Personel Dukung BUMDes Martopuro Garap Lahan Ketahanan Pangan','polsek-purwosari-kerahkan-personel-dukung-bumdes-martopuro-garap-lahan-ketahanan-pangan','Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.','<p>Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-06 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('37298592-f182-5f74-b78c-b3ec4bbc6131','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.','lomba-tumpeng-tp-pkk-desa-martopuro-peringatan-17-agustus-2025-di-pendopo-kec-purwosari','Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.','<p>Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musdes Khusus Desa Martopuro','musdes-khusus-desa-martopuro','Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.','<p>Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-26.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-02-26 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('37876a11-2d4b-5e70-8b61-474ab4551ae5','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro.','pengecatan-tempat-parkir-kantor-sumber-pad-pendapatan-asli-desa-desa-martopuro','Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.','<p>Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-17.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-17 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Camat Purwosari Munif Triatmoko, Secara Resmi Membuka \"Martopuro Cup 2025\"','camat-purwosari-munif-triatmoko-secara-resmi-membuka-martopuro-cup-2025','Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.','<p>Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-09-07 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('3a7b5d24-4b34-530e-a244-98c85a32780d','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Donor Darah Rutin diadakan 3bulan sekali Bersama Karangtaruna Permata Karya Martopuro','donor-darah-rutin-diadakan-3bulan-sekali-bersama-karangtaruna-permata-karya-martopuro','Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.','<p>Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-05-18.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-05-18 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('3ca099fa-59dd-57ee-9d62-eb8a3d23e060','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pemerintah Desa Martopuro BerQur\'ban','pemerintah-desa-martopuro-berqurban','Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.','<p>Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-06.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-06 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('3d5a8754-c917-5892-8545-2f03ef4746ed','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Pra LKPPD/LPPD Desa Martopuro.','musyawarah-pra-lkppd-lppd-desa-martopuro','Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.','<p>Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-01-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('4b70b27d-1a42-519d-af06-141de67515c7','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembinaan RT&RW Desa Martopuro Semester 1 2025','pembinaan-rt-dan-rw-desa-martopuro-semester-1-2025','Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.','<p>Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('4e2acb6e-09d3-589c-80a4-d7683ee2eb57','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT.Indolakto','sukses-mengadakan-santunan-105-anak-yatim-desa-martopuro-oleh-kepala-desa-martopuro-bersama-pt-indolakto','Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.','<p>Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-27.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-03-27 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('4fa40dea-5ca9-5e8b-91b6-61b784917577','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.','penyaluran-blt-dana-desa-tahun-2025-bulan-november-desember','Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.','<p>Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-08 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('50c43074-eb60-58bd-8cc8-6d88cb42e367','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Desa Martopuro Jadi Pelopor Musyawarah Desa Khusus 2025 untuk Pembiayaan Koperasi Desa Merah Putih','desa-martopuro-jadi-pelopor-musyawarah-desa-khusus-2025-untuk-pembiayaan-koperasi-desa-merah-putih','Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.','<p>Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-09 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('51f681e3-6898-57ff-90af-38c7da75782e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro','merealisasikan-pavingisasi-pemukiman-dusun-karangasem-desa-martopuro','Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.','<p>Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('52c08d85-b677-54bc-8fd2-b479c48ce2bf','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Monitoring Pajak Bumi & Bangunan oleh tim Monitoring Kecamatan Purwosari.','monitoring-pajak-bumi-dan-bangunan-oleh-tim-monitoring-kecamatan-purwosari','Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.','<p>Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-31.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-31 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('53d1a069-6c1b-5559-b7f0-88fc9215eeec','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.','pengecatan-mushola-hubbul-wathon-kantor-desa-martopuro','Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.','<p>Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('5447f892-ba7a-5ab1-b257-84ce92e64849','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyerahan THR Tahun 2026 BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan','penyerahan-thr-tahun-2026-bpd-perangkat-desa-pengurus-tp-pkk-rt-rw-linmas-kader-posyandu-modin-desa-martopuro-kec-purwosari-kab-pasuruan','Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.','<p>Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-03-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('5c6b17fa-8342-5aec-9b43-8882f65deed6','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Sukses mengadakan Pelatihan Pemulasaran Jenazah Desa Martopuro','sukses-mengadakan-pelatihan-pemulasaran-jenazah-desa-martopuro','Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.','<p>Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('5d8096bc-eb95-5638-9799-69ed0c7e7759','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Verifikasi proyek lapangan RKP 2026 Desa Martopuro.','verifikasi-proyek-lapangan-rkp-2026-desa-martopuro','Verifikasi proyek lapangan RKP 2026 Desa Martopuro.','<p>Verifikasi proyek lapangan RKP 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-08.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-11-08 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('6070b7fc-e04e-569d-b739-e2910ffd5090','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Turnamen Bola Voly Martopuro Cup Resmi dibuka diikuti Tim dari berbagai Kota, Pasuruan dan Sekitarnya','turnamen-bola-voly-martopuro-cup-resmi-dibuka-diikuti-tim-dari-berbagai-kota-pasuruan-dan-sekitarnya','Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.','<p>Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-09-07 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('669442fa-2d82-574d-a13e-a80bc0b6c09b','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','dcb17bd5-8af2-5484-86fe-e6bee5e15a38','Siap Menerima Siswa Baru Paud Tunas Bangsa Martopuro','siap-menerima-siswa-baru-paud-tunas-bangsa-martopuro','Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.','<p>Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.</p><p>Berita ini termasuk kategori PAUD Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('6803ca49-8946-5386-86a8-257563dfb328','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembinaan Karang Taruna \"Permata Karya\" Desa Martopuro.','pembinaan-karang-taruna-permata-karya-desa-martopuro','Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.','<p>Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-26.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-26 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('68d97ecd-8f43-592e-9a84-c151b1626e11','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Kades Martopuro Menjawab dengan Lounching Website Resmi Desa','kades-martopuro-menjawab-dengan-lounching-website-resmi-desa','Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.','<p>Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('690da950-e796-5869-b702-769a14174c0d','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.','plesterisasi-belakang-kios-desa-martopuro-timur-pasar','Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.','<p>Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-16 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('6dac5caf-5fd1-5024-947f-612840cdfe03','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pengecatan Gedung PAUD Desa Martopuro.','pengecatan-gedung-paud-desa-martopuro','Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.','<p>Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('716d2798-4298-5677-8de2-a849e97e0e4e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan TPT Depan Gerai KDMP Martopuro.','pembangunan-tpt-depan-gerai-kdmp-martopuro','Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.','<p>Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-04-30 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7190b957-3b9c-54eb-812e-5e4f87d0486e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.','rianto-kepala-desa-martopuro-mengikuti-bimbingan-teknis-administrasi-pemerintahan-desa','Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.','<p>Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-11-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7297bdb9-65d3-5e8b-a567-4c433e23c766','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Progres Pembangunan MCK dan Kios Desa Martopuro','progres-pembangunan-mck-dan-kios-desa-martopuro','Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.','<p>Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('742001dc-5a14-5b31-a224-e799ceed78da','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pavingisasi Makam Umum Desa Martopuro','pavingisasi-makam-umum-desa-martopuro','Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.','<p>Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-25.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-04-25 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga','hadirnya-martopuro-selection-fc-bentuk-pemerintah-desa-ingin-menggali-potensi-sdm-dibidang-olahrga','Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.','<p>Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('769da44b-8943-579c-aadf-f4cfbf063172','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025','desa-martopuro-termasuk-perwakilan-desa-di-kabupaten-pasuruan-yang-mengikuti-pelatihan-tata-kelola-desa-2025','Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.','<p>Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-29.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-29 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('790d87a5-2ae9-5430-840a-83736bee1d62','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','a3218aa8-f025-5b89-b870-d100001f417b','Realisasi APBDes Desa Martopuro 2024','realisasi-apbdes-desa-martopuro-2024','Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.','<p>Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-14 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7969e1ae-86fa-516c-90fc-e15f0a2a548c','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro','musyawarah-desa-khusus-musdesus-desa-martopuro','Musyawarah Desa Khusus (Musdesus) Desa Martopuro.','<p>Musyawarah Desa Khusus (Musdesus) Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-01-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Hebohnya Parade Karnaval Martopuro 2025, Mengalir Apresiasi SUKSES dan Permintaan diadakan lagi Tahun Depan','hebohnya-parade-karnaval-martopuro-2025-mengalir-apresiasi-sukses-dan-permintaan-diadakan-lagi-tahun-depan','Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.','<p>Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-08-24.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-24 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Merealisasikan TPT & Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro','merealisasikan-tpt-dan-pavingisasi-pemukiman-dusun-puntir-dana-desa-martopuro','Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.','<p>Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-24.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-03-24 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('8d9a0bf7-0371-56d2-b5df-c00099b22b88','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembinaan Linmas Desa Martopuro.','pembinaan-linmas-desa-martopuro','Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.','<p>Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-27.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-27 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('8eca8b9e-1818-5380-85dc-41dc5b06dfbf','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Sukses mengadakan Donor Darah Sebelum Bulan Puasa, Agenda Rutin 3bulan sekali Karang Taruna Permata Karya Desa Martopuro','sukses-mengadakan-donor-darah-sebelum-bulan-puasa-agenda-rutin-3bulan-sekali-karang-taruna-permata-karya-desa-martopuro','Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.','<p>Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2026-02-08.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-02-08 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('90753d65-2026-5e82-b69a-39c3d7d6840a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro','rehab-kantor-hippa-himpunan-petani-pemakai-air-desa-martopuro','Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.','<p>Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-30 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('9198aa9c-915c-582d-8e20-608ec82b6c1c','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','6009b765-2f64-50fd-951d-07a709ad1119','Lembaga di Desa Martopuro','lembaga-di-desa-martopuro','Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.','<p>Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Lembaga Desa Martopuro dan dipublikasikan pada 2025-04-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('92677901-c5ac-595a-8835-27d8ed0af3f0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','4 Tahun Pengabdian & Karya Nyata Kepala Desa Martopuro','4-tahun-pengabdian-dan-karya-nyata-kepala-desa-martopuro','Empat tahun pengabdian menjadi momentum apresiasi atas karya nyata Kepala Desa Martopuro bersama masyarakat.','<p>Empat tahun pengabdian menjadi momentum apresiasi atas karya nyata Kepala Desa Martopuro bersama masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-12.</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780149654/martopuro/news/covers/sedang-1778560271-chatgpt-image-12-mei-2026-11-30-55_susey7.webp','published',1,'2026-05-12 16:00:00','2026-05-21 01:30:02','2026-05-30 14:00:57',NULL),('93b7ab59-b0ac-5d18-96a2-e07db2776730','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Buka Bersama Keluarga Besar Pemdes Martopuro.','buka-bersama-keluarga-besar-pemdes-martopuro','Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.','<p>Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-03-01 09:00:00','2026-05-21 01:30:02','2026-05-30 14:01:34','2026-05-30 14:01:34'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','dc0a287d-c539-5407-b1af-83479bbde6b3','Musyawarah Desa Martopuro RKP Tahun 2026','musyawarah-desa-martopuro-rkp-tahun-2026','Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.','<p>Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.</p><p>Berita ini termasuk kategori BPD Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('9bd335b4-71c8-5489-958f-434540bdc86c','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Kunjungan Haji Pemdes Martopuro.','giat-kunjungan-haji-pemdes-martopuro','Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.','<p>Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('9dadaee9-719d-548b-8238-f4fe52022f8c','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.','penyaluran-blt-dana-desa-bulan-juli-agustus-2025-desa-martopuro','Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.','<p>Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('9f6d00a1-7abe-5365-87a9-23732bc1880d','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pavingisasi Depan Gerai KDMP Desa Martopuro.','pavingisasi-depan-gerai-kdmp-desa-martopuro','Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.','<p>Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-04.</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203061/martopuro/news/covers/sedang-1778211308-2aa46fc9-e6ea-453b-9aa8-ba9bf851be4e_t0pzet.webp','published',1,'2026-05-04 16:00:00','2026-05-21 01:30:02','2026-05-31 04:51:06',NULL),('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','0dc3abf2-de70-5cef-b90c-c6872b5f8816','Laporan Pertanggungjawaban BUMDES \"Karya Usaha Mandiri\" Desa Martopuro Tahun Anggaran 2025.','laporan-pertanggungjawaban-bumdes-karya-usaha-mandiri-desa-martopuro-tahun-anggaran-2025','Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.','<p>Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2026-01-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-01-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.','giat-pengukuran-dimensi-dan-titik-gawang-lapangan-panutan-desa-martopuro','Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.','<p>Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-14.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-14 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a71c4075-f75f-5679-9e9f-f92a1c40688a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Warga Padati Tarkam Bola Voly Martopuro Cup 2025, Pemain Proliga Turun Lapangan, Apresiasi Sukses Luar Biasa','warga-padati-tarkam-bola-voly-martopuro-cup-2025-pemain-proliga-turun-lapangan-apresiasi-sukses-luar-biasa','Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.','<p>Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-10-04.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-04 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a9d605f6-deff-5623-945e-97f2db2ec56f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.','sosialisasi-dan-edukasi-kesehatan-dari-pt-tea-fun-community-indonesia','Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.','<p>Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780201829/martopuro/news/covers/sedang-1778561426-690745846-1331084455567132-1643283762637915006-n_vcyeog.webp','published',1,'2026-05-08 16:00:00','2026-05-21 01:30:02','2026-05-31 04:30:32',NULL),('ab737371-da5c-527f-9a79-9c0c2f45675a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','176d3564-eaa3-5485-8dcf-b21dd51a3670','Sejarah Desa Martopuro','sejarah-desa-martopuro','Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.','<p>Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','27 RW siap Mensukseskan Karnaval Martopuro 2025','27-rw-siap-mensukseskan-karnaval-martopuro-2025','Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.','<p>Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-07-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('ad96b442-3513-573f-bc25-4b8090a7cd48','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan','santunan-dhuafa-oleh-ibu-bupati-pasuruan-di-desa-martopuro-dan-pengajian-rutin-tp-pkk-kab-pasuruan','Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.','<p>Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-16.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-16 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('ae99d98e-0fde-5894-bac8-4b5b13111604','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Business Matching Kab.Pasuruan.','giat-business-matching-kab-pasuruan','Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.','<p>Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-12.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-12 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('b8c6cb03-34cd-585e-a83d-85ecd115c79b','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Info Event Karangtaruna Permata karya','info-event-karangtaruna-permata-karya','Informasi event Karang Taruna Permata Karya Desa Martopuro.','<p>Informasi event Karang Taruna Permata Karya Desa Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2024-08-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2024-08-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('bb7a5901-0339-5235-8f4f-fad4cf2e30e9','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran BLT Dana Desa Bulan Juni 2025 Desa Martopuro.','penyaluran-blt-dana-desa-bulan-juni-2025-desa-martopuro','Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.','<p>Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-11.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-11 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa.','musyawarah-pemdes-martopuro-dengan-pengelola-kios-desa','Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.','<p>Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-11.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-11 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('bf3db79c-50cc-583d-b0f0-d0682ee9e38b','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','Wes Siap ta Dulur, Karnaval Martopuro 2025, Ini Persyaratan dan Waktunya','wes-siap-ta-dulur-karnaval-martopuro-2025-ini-persyaratan-dan-waktunya','Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.','<p>Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-30 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Sukses digelar Peringatan Hari Santri 2025 di Desa Martopuro','sukses-digelar-peringatan-hari-santri-2025-di-desa-martopuro','Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.','<p>Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.','rencana-lokasi-pembangunan-gerai-kdmp-koperasi-desa-merah-putih-martopuro','Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.','<p>Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-03.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-03 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran Bantuan Pangan Desa Martopuro.','penyaluran-bantuan-pangan-desa-martopuro','Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.','<p>Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-05.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-05 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c95d0ff1-76f4-5468-af55-c1d5333efd91','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.','musyawarah-desa-penetapan-indeks-desa-martopuro-2025','Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.','<p>Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-07.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-05-07 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun di Desa Martopuro di masa kepemimpinan Kepala Desa Rianto','manaqib-dzikir-ghofilin-rutin-di-agendakan-setiap-tahun-di-desa-martopuro-di-masa-kepemimpinan-kepala-desa-rianto','Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.','<p>Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-19.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-19 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) & Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.','laporan-keterangan-penyelenggaraan-pemerintah-desa-lkppd-dan-laporan-penyelenggaraan-pemerintah-desa-lppd-desa-martopuro','LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.','<p>LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-27.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-01-27 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Tasyakuran Awal Pelaksanaan Dana Desa tahap 2 tahun 2025','tasyakuran-awal-pelaksanaan-dana-desa-tahap-2-tahun-2025','Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.','<p>Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-21 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d41479a0-fd39-5334-b206-08e45fd69a44','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro.','giat-pemindahan-tiang-bendera-lapangan-panutan-desa-martopuro','Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.','<p>Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-16 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d4bb0bbd-d85b-516e-ae9b-9622be28e88e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari , 17 Agustus 2025','kerja-bakti-lapangan-panutan-desa-martopuro-persiapan-upacara-kemerdekaan-se-kecamatan-purwosari-17-agustus-2025','Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.','<p>Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d545b75f-5e33-5840-bbb8-75a04f3b81f8','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Louncing Panen Jagung Bumdes \" Karya Usaha Mandiri\" Desa Martopuro.','louncing-panen-jagung-bumdes-karya-usaha-mandiri-desa-martopuro','Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.','<p>Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d7cbd547-e969-58f3-be32-be1fc60baeb8','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Terbentuknya Pengurus Koperasi Desa Merah Putih Martopuro','terbentuknya-pengurus-koperasi-desa-merah-putih-martopuro','Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.','<p>Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-23 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.','penyaluran-blt-dana-desa-bulan-september-oktober-desa-martopuro-2025','Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.','<p>Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-10-09 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d94820bc-e2b3-5365-b15d-2918dcb35469','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Kerja Bakti Lingkungan Desa Martopuro','kerja-bakti-lingkungan-desa-martopuro','Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.','<p>Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-23.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-02-23 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Jambanisasi Warga Desa Martopuro APBDes 2025','jambanisasi-warga-desa-martopuro-apbdes-2025','Program jambanisasi warga Desa Martopuro melalui APBDes 2025.','<p>Program jambanisasi warga Desa Martopuro melalui APBDes 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-22 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('db1914b1-a569-54c6-9947-c394dbb9be82','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','0dc3abf2-de70-5cef-b90c-c6872b5f8816','Louncing Ketahanan Pangan Bumdes\" Karya Usaha Mandiri\" Desa Martopuro.','louncing-ketahanan-pangan-bumdes-karya-usaha-mandiri-desa-martopuro','Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.','<p>Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-06 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyaluran BLT DD Bulan Januari-April 2026 Desa Martopuro.','penyaluran-blt-dd-bulan-januari-april-2026-desa-martopuro','Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.','<p>Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-24.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2026-04-24 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('dbd545fb-0f53-5937-85ca-5d8f48b79aa7','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.','monev-giat-fisik-semester-2-tahun-2025-oleh-kecamatan-dan-ta-kabupaten-dana-desa-desa-martopuro','Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.','<p>Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-30.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-30 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('de43dc9d-c33d-501f-a100-518c0d4f1802','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Penyerahan BLT DD Bulan April Mei 2025 Desa Martopuro.','penyerahan-blt-dd-bulan-april-mei-2025-desa-martopuro','Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.','<p>Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-05-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e10f4c82-65d9-532f-ad6a-3dae598123ce','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.','pembangunan-tpt-pertanian-dusun-kemantren-rw-04-desa-martopuro','Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.','<p>Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-07-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e1e3eacd-eb83-5ef5-a86e-077945a4f60a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Laporan Pertanggungjawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024','laporan-pertanggungjawaban-kepala-desa-martopuro-akhir-tahun-anggaran-2024','Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.','<p>Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-15.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-01-15 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e234c8ce-3c68-5078-858b-028ecb8131c7','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.','musdes-penetapan-kpm-blt-dd-tahun-2026-desa-martopuro','Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.','<p>Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-12-08 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Desa Martopuro Juara 2 lomba Samroh TP PKK Kecamatan Purwosari','desa-martopuro-juara-2-lomba-samroh-tp-pkk-kecamatan-purwosari','Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.','<p>Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-08-01 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e443442d-8563-5fd5-991d-b26695297919','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','0dc3abf2-de70-5cef-b90c-c6872b5f8816','Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.','zoom-meeting-bumdes-karya-usaha-mandiri-desa-martopuro','Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.','<p>Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-11-03.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-11-03 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','176d3564-eaa3-5485-8dcf-b21dd51a3670','Visi dan Misi','visi-dan-misi','Informasi visi dan misi Desa Martopuro.','<p>Informasi visi dan misi Desa Martopuro.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('f08dfc48-80bf-52ea-9942-e801bb198c64','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro','pembangunan-tpt-lapangan-panutan-dana-desa-desa-martopuro','Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.','<p>Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-18.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-03-18 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Serah terima unit truk KDMP ( Koperasi Desa Merah Putih ) Martopuro.','serah-terima-unit-truk-kdmp-koperasi-desa-merah-putih-martopuro','Serah terima unit truk KDMP Martopuro sebagai dukungan operasional koperasi desa.','<p>Serah terima unit truk KDMP Martopuro sebagai dukungan operasional koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780202974/martopuro/news/covers/sedang-1778561485-689524461-1331342492207995-539456844175051007-n-1_ore6b0.webp','published',1,'2026-05-09 06:00:00','2026-05-21 01:30:02','2026-05-31 04:49:38',NULL),('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Semenjak Kepemimpinan Kades Rianto, Khataman Qur\'an menjadi Agenda Rutin Jumat legi Pemerintah Desa','semenjak-kepemimpinan-kades-rianto-khataman-quran-menjadi-agenda-rutin-jumat-legi-pemerintah-desa','Khataman Qur\'an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.','<p>Khataman Qur&#x27;an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-13 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro','merealisasikan-pembangunan-pavingisasi-depan-kios-desa-utara-pasar-purwosari-desa-martopuro','Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.','<p>Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-04-10 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','593eb4c5-7faf-565a-8503-e32028a43526','Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro.','pembangunan-tandon-air-lapangan-panutan-anggaran-pad-desa-martopuro','Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.','<p>Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>','/assets/images/village/martopuro-hero.jpg','published',1,'2025-06-16 09:00:00','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_categories`
--

DROP TABLE IF EXISTS `news_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_categories` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_news_categories_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_news_categories_tenant_status` (`tenant_id`,`status`),
  CONSTRAINT `fk_news_categories_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_categories`
--

LOCK TABLES `news_categories` WRITE;
/*!40000 ALTER TABLE `news_categories` DISABLE KEYS */;
INSERT INTO `news_categories` VALUES ('0dc3abf2-de70-5cef-b90c-c6872b5f8816','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BUMDES','bumdes','Informasi BUMDes Karya Usaha Mandiri dan ekonomi desa.',3,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('176d3564-eaa3-5485-8dcf-b21dd51a3670','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Profil','profil','Informasi profil, sejarah, visi, dan misi Desa Martopuro.',8,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('31e99a10-9b90-5af4-b124-cfbf5a9a4dfe','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Karang Taruna','karang-taruna','Kegiatan kepemudaan dan Karang Taruna Permata Karya Desa Martopuro.',2,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('593eb4c5-7faf-565a-8503-e32028a43526','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Berita Desa','berita-desa','Informasi umum dan kegiatan Pemerintah Desa Martopuro.',1,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('6009b765-2f64-50fd-951d-07a709ad1119','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Berita Lembaga','berita-lembaga','Informasi lembaga desa dan organisasi kemasyarakatan.',6,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a3218aa8-f025-5b89-b870-d100001f417b','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','APBDes','apbdes','Informasi anggaran, realisasi, dan transparansi APBDes.',7,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('dc0a287d-c539-5407-b1af-83479bbde6b3','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BPD','bpd','Informasi Badan Permusyawaratan Desa Martopuro.',4,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('dcb17bd5-8af2-5484-86fe-e6bee5e15a38','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PAUD','paud','Informasi pendidikan PAUD Tunas Bangsa Martopuro.',5,'active','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL);
/*!40000 ALTER TABLE `news_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_comments`
--

DROP TABLE IF EXISTS `news_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_comments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `news_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes_count` int unsigned NOT NULL DEFAULT '0',
  `dislikes_count` int unsigned NOT NULL DEFAULT '0',
  `status` enum('pending','approved','rejected','spam','hidden') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `approved_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_news_comments_tenant_news_status` (`tenant_id`,`news_id`,`status`,`created_at`),
  KEY `idx_news_comments_parent` (`parent_id`),
  KEY `idx_news_comments_author_email` (`tenant_id`,`author_email`),
  KEY `fk_news_comments_news` (`news_id`),
  KEY `fk_news_comments_approved_by` (`approved_by`),
  CONSTRAINT `fk_news_comments_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_news_comments_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_news_comments_parent` FOREIGN KEY (`parent_id`) REFERENCES `news_comments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_news_comments_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_comments`
--

LOCK TABLES `news_comments` WRITE;
/*!40000 ALTER TABLE `news_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_tag_map`
--

DROP TABLE IF EXISTS `news_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_tag_map` (
  `news_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`news_id`,`tag_id`),
  KEY `idx_news_tag_map_tag` (`tag_id`),
  CONSTRAINT `fk_news_tag_map_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_news_tag_map_tag` FOREIGN KEY (`tag_id`) REFERENCES `news_tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_tag_map`
--

LOCK TABLES `news_tag_map` WRITE;
/*!40000 ALTER TABLE `news_tag_map` DISABLE KEYS */;
INSERT INTO `news_tag_map` VALUES ('00124a2b-cd8c-5c07-a9b0-802a23f37540','1fd988f4-4834-5c01-9381-be463e47cc4f'),('00663ec6-efdb-5deb-ab2a-890e9b41b300','1fd988f4-4834-5c01-9381-be463e47cc4f'),('0d88cc0f-991a-5abd-b92a-b87fba44bf44','1fd988f4-4834-5c01-9381-be463e47cc4f'),('14ac0d2b-754c-536c-99cf-15cc577f0e4e','1fd988f4-4834-5c01-9381-be463e47cc4f'),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','1fd988f4-4834-5c01-9381-be463e47cc4f'),('51f681e3-6898-57ff-90af-38c7da75782e','1fd988f4-4834-5c01-9381-be463e47cc4f'),('690da950-e796-5869-b702-769a14174c0d','1fd988f4-4834-5c01-9381-be463e47cc4f'),('716d2798-4298-5677-8de2-a849e97e0e4e','1fd988f4-4834-5c01-9381-be463e47cc4f'),('7297bdb9-65d3-5e8b-a567-4c433e23c766','1fd988f4-4834-5c01-9381-be463e47cc4f'),('742001dc-5a14-5b31-a224-e799ceed78da','1fd988f4-4834-5c01-9381-be463e47cc4f'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','1fd988f4-4834-5c01-9381-be463e47cc4f'),('90753d65-2026-5e82-b69a-39c3d7d6840a','1fd988f4-4834-5c01-9381-be463e47cc4f'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','1fd988f4-4834-5c01-9381-be463e47cc4f'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','1fd988f4-4834-5c01-9381-be463e47cc4f'),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','1fd988f4-4834-5c01-9381-be463e47cc4f'),('e10f4c82-65d9-532f-ad6a-3dae598123ce','1fd988f4-4834-5c01-9381-be463e47cc4f'),('f08dfc48-80bf-52ea-9942-e801bb198c64','1fd988f4-4834-5c01-9381-be463e47cc4f'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','1fd988f4-4834-5c01-9381-be463e47cc4f'),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','1fd988f4-4834-5c01-9381-be463e47cc4f'),('0e1ac83c-6448-5299-ad51-0f738729c829','214fee5b-67a0-5f2d-b02d-83e714b7362a'),('314b723c-3f8d-5166-bfa5-72aa7043a5a9','214fee5b-67a0-5f2d-b02d-83e714b7362a'),('d545b75f-5e33-5840-bbb8-75a04f3b81f8','214fee5b-67a0-5f2d-b02d-83e714b7362a'),('db1914b1-a569-54c6-9947-c394dbb9be82','214fee5b-67a0-5f2d-b02d-83e714b7362a'),('37298592-f182-5f74-b78c-b3ec4bbc6131','356138ea-a420-5abe-8455-a6484baf6480'),('5447f892-ba7a-5ab1-b257-84ce92e64849','356138ea-a420-5abe-8455-a6484baf6480'),('9198aa9c-915c-582d-8e20-608ec82b6c1c','356138ea-a420-5abe-8455-a6484baf6480'),('ad96b442-3513-573f-bc25-4b8090a7cd48','356138ea-a420-5abe-8455-a6484baf6480'),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','356138ea-a420-5abe-8455-a6484baf6480'),('037e60f1-d579-5c99-955f-eb8ef6fa50c5','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('0de3d276-823d-583f-99c9-238dd1192685','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('1a44dc93-7a2d-5c4b-a91f-59b24b558625','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('28f7c0a9-08c4-5bb4-9525-f63edc7afe37','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('4fa40dea-5ca9-5e8b-91b6-61b784917577','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('790d87a5-2ae9-5430-840a-83736bee1d62','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('9dadaee9-719d-548b-8238-f4fe52022f8c','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('bb7a5901-0339-5235-8f4f-fad4cf2e30e9','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('dbd545fb-0f53-5937-85ca-5d8f48b79aa7','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('de43dc9d-c33d-501f-a100-518c0d4f1802','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('e234c8ce-3c68-5078-858b-028ecb8131c7','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('f08dfc48-80bf-52ea-9942-e801bb198c64','3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),('086e5012-1bce-5e52-8e64-b1dadc98f553','4b798f55-fff7-5df0-8421-c0837952f619'),('4fa40dea-5ca9-5e8b-91b6-61b784917577','4b798f55-fff7-5df0-8421-c0837952f619'),('9dadaee9-719d-548b-8238-f4fe52022f8c','4b798f55-fff7-5df0-8421-c0837952f619'),('bb7a5901-0339-5235-8f4f-fad4cf2e30e9','4b798f55-fff7-5df0-8421-c0837952f619'),('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e','4b798f55-fff7-5df0-8421-c0837952f619'),('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f','4b798f55-fff7-5df0-8421-c0837952f619'),('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0','4b798f55-fff7-5df0-8421-c0837952f619'),('de43dc9d-c33d-501f-a100-518c0d4f1802','4b798f55-fff7-5df0-8421-c0837952f619'),('e234c8ce-3c68-5078-858b-028ecb8131c7','4b798f55-fff7-5df0-8421-c0837952f619'),('0e1ac83c-6448-5299-ad51-0f738729c829','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('314b723c-3f8d-5166-bfa5-72aa7043a5a9','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('d545b75f-5e33-5840-bbb8-75a04f3b81f8','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('db1914b1-a569-54c6-9947-c394dbb9be82','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('e443442d-8563-5fd5-991d-b26695297919','7c7274c8-7817-5742-b1d2-7ae33479da4e'),('00663ec6-efdb-5deb-ab2a-890e9b41b300','7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),('716d2798-4298-5677-8de2-a849e97e0e4e','7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),('e10f4c82-65d9-532f-ad6a-3dae598123ce','7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),('f08dfc48-80bf-52ea-9942-e801bb198c64','7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),('5447f892-ba7a-5ab1-b257-84ce92e64849','8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),('9198aa9c-915c-582d-8e20-608ec82b6c1c','8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),('037e60f1-d579-5c99-955f-eb8ef6fa50c5','857bb874-2eb5-5b80-8dd3-e308485fe400'),('0de3d276-823d-583f-99c9-238dd1192685','857bb874-2eb5-5b80-8dd3-e308485fe400'),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','857bb874-2eb5-5b80-8dd3-e308485fe400'),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','857bb874-2eb5-5b80-8dd3-e308485fe400'),('51f681e3-6898-57ff-90af-38c7da75782e','857bb874-2eb5-5b80-8dd3-e308485fe400'),('790d87a5-2ae9-5430-840a-83736bee1d62','857bb874-2eb5-5b80-8dd3-e308485fe400'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','857bb874-2eb5-5b80-8dd3-e308485fe400'),('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06','857bb874-2eb5-5b80-8dd3-e308485fe400'),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','857bb874-2eb5-5b80-8dd3-e308485fe400'),('e1e3eacd-eb83-5ef5-a86e-077945a4f60a','857bb874-2eb5-5b80-8dd3-e308485fe400'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','857bb874-2eb5-5b80-8dd3-e308485fe400'),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','857bb874-2eb5-5b80-8dd3-e308485fe400'),('669442fa-2d82-574d-a13e-a80bc0b6c09b','91357d15-e607-56c6-a6d7-f44d06338356'),('6dac5caf-5fd1-5024-947f-612840cdfe03','91357d15-e607-56c6-a6d7-f44d06338356'),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','9ba60f88-4a36-50be-9e73-7983cacecca0'),('3a7b5d24-4b34-530e-a244-98c85a32780d','9ba60f88-4a36-50be-9e73-7983cacecca0'),('6070b7fc-e04e-569d-b739-e2910ffd5090','9ba60f88-4a36-50be-9e73-7983cacecca0'),('6803ca49-8946-5386-86a8-257563dfb328','9ba60f88-4a36-50be-9e73-7983cacecca0'),('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd','9ba60f88-4a36-50be-9e73-7983cacecca0'),('8eca8b9e-1818-5380-85dc-41dc5b06dfbf','9ba60f88-4a36-50be-9e73-7983cacecca0'),('a71c4075-f75f-5679-9e9f-f92a1c40688a','9ba60f88-4a36-50be-9e73-7983cacecca0'),('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7','9ba60f88-4a36-50be-9e73-7983cacecca0'),('b8c6cb03-34cd-585e-a83d-85ecd115c79b','9ba60f88-4a36-50be-9e73-7983cacecca0'),('bf3db79c-50cc-583d-b0f0-d0682ee9e38b','9ba60f88-4a36-50be-9e73-7983cacecca0'),('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4','a22ae8d5-e0ab-5082-ae3c-df1b2b557177'),('0202d245-a266-545f-9162-d6eea1ab2925','a2a354db-0948-5096-ad72-bc86ac5faba2'),('1dc553b6-966d-5ee6-b20b-7c9cc52afab2','a2a354db-0948-5096-ad72-bc86ac5faba2'),('3a7b5d24-4b34-530e-a244-98c85a32780d','a2a354db-0948-5096-ad72-bc86ac5faba2'),('8eca8b9e-1818-5380-85dc-41dc5b06dfbf','a2a354db-0948-5096-ad72-bc86ac5faba2'),('a9d605f6-deff-5623-945e-97f2db2ec56f','a2a354db-0948-5096-ad72-bc86ac5faba2'),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','a2a354db-0948-5096-ad72-bc86ac5faba2'),('00124a2b-cd8c-5c07-a9b0-802a23f37540','a3eda259-210c-5699-8e03-60d569ed4e60'),('00663ec6-efdb-5deb-ab2a-890e9b41b300','a3eda259-210c-5699-8e03-60d569ed4e60'),('0202d245-a266-545f-9162-d6eea1ab2925','a3eda259-210c-5699-8e03-60d569ed4e60'),('027f21be-9112-5401-a8b7-f4138b7c972e','a3eda259-210c-5699-8e03-60d569ed4e60'),('037e60f1-d579-5c99-955f-eb8ef6fa50c5','a3eda259-210c-5699-8e03-60d569ed4e60'),('086e5012-1bce-5e52-8e64-b1dadc98f553','a3eda259-210c-5699-8e03-60d569ed4e60'),('0b3e53f9-c8a2-50b5-9846-8639df57da24','a3eda259-210c-5699-8e03-60d569ed4e60'),('0d88cc0f-991a-5abd-b92a-b87fba44bf44','a3eda259-210c-5699-8e03-60d569ed4e60'),('0de3d276-823d-583f-99c9-238dd1192685','a3eda259-210c-5699-8e03-60d569ed4e60'),('0e1ac83c-6448-5299-ad51-0f738729c829','a3eda259-210c-5699-8e03-60d569ed4e60'),('0f5169fe-c105-5392-9ce6-eb8bce734ce9','a3eda259-210c-5699-8e03-60d569ed4e60'),('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9','a3eda259-210c-5699-8e03-60d569ed4e60'),('1200c374-aa7b-5f70-966a-6f94b09c9f1b','a3eda259-210c-5699-8e03-60d569ed4e60'),('12e93598-3a78-591f-a50a-1722d6fa50f8','a3eda259-210c-5699-8e03-60d569ed4e60'),('14ac0d2b-754c-536c-99cf-15cc577f0e4e','a3eda259-210c-5699-8e03-60d569ed4e60'),('1a44dc93-7a2d-5c4b-a91f-59b24b558625','a3eda259-210c-5699-8e03-60d569ed4e60'),('1ae0a0ed-b919-57c2-a986-f619ada9e2f0','a3eda259-210c-5699-8e03-60d569ed4e60'),('1dc553b6-966d-5ee6-b20b-7c9cc52afab2','a3eda259-210c-5699-8e03-60d569ed4e60'),('27efc7fe-a3de-5fd9-b18b-339c8ced838f','a3eda259-210c-5699-8e03-60d569ed4e60'),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','a3eda259-210c-5699-8e03-60d569ed4e60'),('28f7c0a9-08c4-5bb4-9525-f63edc7afe37','a3eda259-210c-5699-8e03-60d569ed4e60'),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','a3eda259-210c-5699-8e03-60d569ed4e60'),('2db2fdd3-52bd-51dc-a579-590db3bd4c21','a3eda259-210c-5699-8e03-60d569ed4e60'),('314b723c-3f8d-5166-bfa5-72aa7043a5a9','a3eda259-210c-5699-8e03-60d569ed4e60'),('37298592-f182-5f74-b78c-b3ec4bbc6131','a3eda259-210c-5699-8e03-60d569ed4e60'),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','a3eda259-210c-5699-8e03-60d569ed4e60'),('37876a11-2d4b-5e70-8b61-474ab4551ae5','a3eda259-210c-5699-8e03-60d569ed4e60'),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','a3eda259-210c-5699-8e03-60d569ed4e60'),('3a7b5d24-4b34-530e-a244-98c85a32780d','a3eda259-210c-5699-8e03-60d569ed4e60'),('3ca099fa-59dd-57ee-9d62-eb8a3d23e060','a3eda259-210c-5699-8e03-60d569ed4e60'),('3d5a8754-c917-5892-8545-2f03ef4746ed','a3eda259-210c-5699-8e03-60d569ed4e60'),('4b70b27d-1a42-519d-af06-141de67515c7','a3eda259-210c-5699-8e03-60d569ed4e60'),('4e2acb6e-09d3-589c-80a4-d7683ee2eb57','a3eda259-210c-5699-8e03-60d569ed4e60'),('4fa40dea-5ca9-5e8b-91b6-61b784917577','a3eda259-210c-5699-8e03-60d569ed4e60'),('50c43074-eb60-58bd-8cc8-6d88cb42e367','a3eda259-210c-5699-8e03-60d569ed4e60'),('51f681e3-6898-57ff-90af-38c7da75782e','a3eda259-210c-5699-8e03-60d569ed4e60'),('52c08d85-b677-54bc-8fd2-b479c48ce2bf','a3eda259-210c-5699-8e03-60d569ed4e60'),('53d1a069-6c1b-5559-b7f0-88fc9215eeec','a3eda259-210c-5699-8e03-60d569ed4e60'),('5447f892-ba7a-5ab1-b257-84ce92e64849','a3eda259-210c-5699-8e03-60d569ed4e60'),('5c6b17fa-8342-5aec-9b43-8882f65deed6','a3eda259-210c-5699-8e03-60d569ed4e60'),('5d8096bc-eb95-5638-9799-69ed0c7e7759','a3eda259-210c-5699-8e03-60d569ed4e60'),('6070b7fc-e04e-569d-b739-e2910ffd5090','a3eda259-210c-5699-8e03-60d569ed4e60'),('669442fa-2d82-574d-a13e-a80bc0b6c09b','a3eda259-210c-5699-8e03-60d569ed4e60'),('6803ca49-8946-5386-86a8-257563dfb328','a3eda259-210c-5699-8e03-60d569ed4e60'),('68d97ecd-8f43-592e-9a84-c151b1626e11','a3eda259-210c-5699-8e03-60d569ed4e60'),('690da950-e796-5869-b702-769a14174c0d','a3eda259-210c-5699-8e03-60d569ed4e60'),('6dac5caf-5fd1-5024-947f-612840cdfe03','a3eda259-210c-5699-8e03-60d569ed4e60'),('716d2798-4298-5677-8de2-a849e97e0e4e','a3eda259-210c-5699-8e03-60d569ed4e60'),('7190b957-3b9c-54eb-812e-5e4f87d0486e','a3eda259-210c-5699-8e03-60d569ed4e60'),('7297bdb9-65d3-5e8b-a567-4c433e23c766','a3eda259-210c-5699-8e03-60d569ed4e60'),('742001dc-5a14-5b31-a224-e799ceed78da','a3eda259-210c-5699-8e03-60d569ed4e60'),('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd','a3eda259-210c-5699-8e03-60d569ed4e60'),('769da44b-8943-579c-aadf-f4cfbf063172','a3eda259-210c-5699-8e03-60d569ed4e60'),('790d87a5-2ae9-5430-840a-83736bee1d62','a3eda259-210c-5699-8e03-60d569ed4e60'),('7969e1ae-86fa-516c-90fc-e15f0a2a548c','a3eda259-210c-5699-8e03-60d569ed4e60'),('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd','a3eda259-210c-5699-8e03-60d569ed4e60'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','a3eda259-210c-5699-8e03-60d569ed4e60'),('8d9a0bf7-0371-56d2-b5df-c00099b22b88','a3eda259-210c-5699-8e03-60d569ed4e60'),('8eca8b9e-1818-5380-85dc-41dc5b06dfbf','a3eda259-210c-5699-8e03-60d569ed4e60'),('90753d65-2026-5e82-b69a-39c3d7d6840a','a3eda259-210c-5699-8e03-60d569ed4e60'),('9198aa9c-915c-582d-8e20-608ec82b6c1c','a3eda259-210c-5699-8e03-60d569ed4e60'),('92677901-c5ac-595a-8835-27d8ed0af3f0','a3eda259-210c-5699-8e03-60d569ed4e60'),('93b7ab59-b0ac-5d18-96a2-e07db2776730','a3eda259-210c-5699-8e03-60d569ed4e60'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','a3eda259-210c-5699-8e03-60d569ed4e60'),('9bd335b4-71c8-5489-958f-434540bdc86c','a3eda259-210c-5699-8e03-60d569ed4e60'),('9dadaee9-719d-548b-8238-f4fe52022f8c','a3eda259-210c-5699-8e03-60d569ed4e60'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','a3eda259-210c-5699-8e03-60d569ed4e60'),('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06','a3eda259-210c-5699-8e03-60d569ed4e60'),('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0','a3eda259-210c-5699-8e03-60d569ed4e60'),('a71c4075-f75f-5679-9e9f-f92a1c40688a','a3eda259-210c-5699-8e03-60d569ed4e60'),('a9d605f6-deff-5623-945e-97f2db2ec56f','a3eda259-210c-5699-8e03-60d569ed4e60'),('ab737371-da5c-527f-9a79-9c0c2f45675a','a3eda259-210c-5699-8e03-60d569ed4e60'),('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7','a3eda259-210c-5699-8e03-60d569ed4e60'),('ad96b442-3513-573f-bc25-4b8090a7cd48','a3eda259-210c-5699-8e03-60d569ed4e60'),('ae99d98e-0fde-5894-bac8-4b5b13111604','a3eda259-210c-5699-8e03-60d569ed4e60'),('b8c6cb03-34cd-585e-a83d-85ecd115c79b','a3eda259-210c-5699-8e03-60d569ed4e60'),('bb7a5901-0339-5235-8f4f-fad4cf2e30e9','a3eda259-210c-5699-8e03-60d569ed4e60'),('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5','a3eda259-210c-5699-8e03-60d569ed4e60'),('bf3db79c-50cc-583d-b0f0-d0682ee9e38b','a3eda259-210c-5699-8e03-60d569ed4e60'),('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4','a3eda259-210c-5699-8e03-60d569ed4e60'),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','a3eda259-210c-5699-8e03-60d569ed4e60'),('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e','a3eda259-210c-5699-8e03-60d569ed4e60'),('c95d0ff1-76f4-5468-af55-c1d5333efd91','a3eda259-210c-5699-8e03-60d569ed4e60'),('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432','a3eda259-210c-5699-8e03-60d569ed4e60'),('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f','a3eda259-210c-5699-8e03-60d569ed4e60'),('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb','a3eda259-210c-5699-8e03-60d569ed4e60'),('d41479a0-fd39-5334-b206-08e45fd69a44','a3eda259-210c-5699-8e03-60d569ed4e60'),('d4bb0bbd-d85b-516e-ae9b-9622be28e88e','a3eda259-210c-5699-8e03-60d569ed4e60'),('d545b75f-5e33-5840-bbb8-75a04f3b81f8','a3eda259-210c-5699-8e03-60d569ed4e60'),('d7cbd547-e969-58f3-be32-be1fc60baeb8','a3eda259-210c-5699-8e03-60d569ed4e60'),('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f','a3eda259-210c-5699-8e03-60d569ed4e60'),('d94820bc-e2b3-5365-b15d-2918dcb35469','a3eda259-210c-5699-8e03-60d569ed4e60'),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','a3eda259-210c-5699-8e03-60d569ed4e60'),('db1914b1-a569-54c6-9947-c394dbb9be82','a3eda259-210c-5699-8e03-60d569ed4e60'),('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0','a3eda259-210c-5699-8e03-60d569ed4e60'),('dbd545fb-0f53-5937-85ca-5d8f48b79aa7','a3eda259-210c-5699-8e03-60d569ed4e60'),('de43dc9d-c33d-501f-a100-518c0d4f1802','a3eda259-210c-5699-8e03-60d569ed4e60'),('e10f4c82-65d9-532f-ad6a-3dae598123ce','a3eda259-210c-5699-8e03-60d569ed4e60'),('e1e3eacd-eb83-5ef5-a86e-077945a4f60a','a3eda259-210c-5699-8e03-60d569ed4e60'),('e234c8ce-3c68-5078-858b-028ecb8131c7','a3eda259-210c-5699-8e03-60d569ed4e60'),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','a3eda259-210c-5699-8e03-60d569ed4e60'),('e443442d-8563-5fd5-991d-b26695297919','a3eda259-210c-5699-8e03-60d569ed4e60'),('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd','a3eda259-210c-5699-8e03-60d569ed4e60'),('f08dfc48-80bf-52ea-9942-e801bb198c64','a3eda259-210c-5699-8e03-60d569ed4e60'),('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1','a3eda259-210c-5699-8e03-60d569ed4e60'),('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e','a3eda259-210c-5699-8e03-60d569ed4e60'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','a3eda259-210c-5699-8e03-60d569ed4e60'),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','a3eda259-210c-5699-8e03-60d569ed4e60'),('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9','a42a0420-9540-5dda-a676-87ece5869b3a'),('12e93598-3a78-591f-a50a-1722d6fa50f8','a42a0420-9540-5dda-a676-87ece5869b3a'),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','a42a0420-9540-5dda-a676-87ece5869b3a'),('50c43074-eb60-58bd-8cc8-6d88cb42e367','a42a0420-9540-5dda-a676-87ece5869b3a'),('716d2798-4298-5677-8de2-a849e97e0e4e','a42a0420-9540-5dda-a676-87ece5869b3a'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','a42a0420-9540-5dda-a676-87ece5869b3a'),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','a42a0420-9540-5dda-a676-87ece5869b3a'),('d7cbd547-e969-58f3-be32-be1fc60baeb8','a42a0420-9540-5dda-a676-87ece5869b3a'),('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1','a42a0420-9540-5dda-a676-87ece5869b3a'),('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('12e93598-3a78-591f-a50a-1722d6fa50f8','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('50c43074-eb60-58bd-8cc8-6d88cb42e367','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('d7cbd547-e969-58f3-be32-be1fc60baeb8','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1','a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),('3a7b5d24-4b34-530e-a244-98c85a32780d','a9a6c593-ad2c-54a7-8377-affa7b4b2022'),('8eca8b9e-1818-5380-85dc-41dc5b06dfbf','a9a6c593-ad2c-54a7-8377-affa7b4b2022'),('00124a2b-cd8c-5c07-a9b0-802a23f37540','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('51f681e3-6898-57ff-90af-38c7da75782e','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('742001dc-5a14-5b31-a224-e799ceed78da','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),('037e60f1-d579-5c99-955f-eb8ef6fa50c5','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('314b723c-3f8d-5166-bfa5-72aa7043a5a9','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('37298592-f182-5f74-b78c-b3ec4bbc6131','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('4b70b27d-1a42-519d-af06-141de67515c7','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('52c08d85-b677-54bc-8fd2-b479c48ce2bf','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('5447f892-ba7a-5ab1-b257-84ce92e64849','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('769da44b-8943-579c-aadf-f4cfbf063172','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('790d87a5-2ae9-5430-840a-83736bee1d62','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('d4bb0bbd-d85b-516e-ae9b-9622be28e88e','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('e10f4c82-65d9-532f-ad6a-3dae598123ce','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','ba7593f4-1683-53ab-b3cc-6b5da019b289'),('00124a2b-cd8c-5c07-a9b0-802a23f37540','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('5d8096bc-eb95-5638-9799-69ed0c7e7759','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('6070b7fc-e04e-569d-b739-e2910ffd5090','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('a71c4075-f75f-5679-9e9f-f92a1c40688a','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('d41479a0-fd39-5334-b206-08e45fd69a44','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('d4bb0bbd-d85b-516e-ae9b-9622be28e88e','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('f08dfc48-80bf-52ea-9942-e801bb198c64','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),('00124a2b-cd8c-5c07-a9b0-802a23f37540','da360318-3485-5a37-bc5c-916286bcb002'),('00663ec6-efdb-5deb-ab2a-890e9b41b300','da360318-3485-5a37-bc5c-916286bcb002'),('0202d245-a266-545f-9162-d6eea1ab2925','da360318-3485-5a37-bc5c-916286bcb002'),('027f21be-9112-5401-a8b7-f4138b7c972e','da360318-3485-5a37-bc5c-916286bcb002'),('086e5012-1bce-5e52-8e64-b1dadc98f553','da360318-3485-5a37-bc5c-916286bcb002'),('0b3e53f9-c8a2-50b5-9846-8639df57da24','da360318-3485-5a37-bc5c-916286bcb002'),('0d88cc0f-991a-5abd-b92a-b87fba44bf44','da360318-3485-5a37-bc5c-916286bcb002'),('0de3d276-823d-583f-99c9-238dd1192685','da360318-3485-5a37-bc5c-916286bcb002'),('0f5169fe-c105-5392-9ce6-eb8bce734ce9','da360318-3485-5a37-bc5c-916286bcb002'),('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9','da360318-3485-5a37-bc5c-916286bcb002'),('1200c374-aa7b-5f70-966a-6f94b09c9f1b','da360318-3485-5a37-bc5c-916286bcb002'),('12e93598-3a78-591f-a50a-1722d6fa50f8','da360318-3485-5a37-bc5c-916286bcb002'),('14ac0d2b-754c-536c-99cf-15cc577f0e4e','da360318-3485-5a37-bc5c-916286bcb002'),('1a44dc93-7a2d-5c4b-a91f-59b24b558625','da360318-3485-5a37-bc5c-916286bcb002'),('1ae0a0ed-b919-57c2-a986-f619ada9e2f0','da360318-3485-5a37-bc5c-916286bcb002'),('1dc553b6-966d-5ee6-b20b-7c9cc52afab2','da360318-3485-5a37-bc5c-916286bcb002'),('27efc7fe-a3de-5fd9-b18b-339c8ced838f','da360318-3485-5a37-bc5c-916286bcb002'),('28b6535e-30c4-5d14-8e1e-9e3239c752ec','da360318-3485-5a37-bc5c-916286bcb002'),('28f7c0a9-08c4-5bb4-9525-f63edc7afe37','da360318-3485-5a37-bc5c-916286bcb002'),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','da360318-3485-5a37-bc5c-916286bcb002'),('2db2fdd3-52bd-51dc-a579-590db3bd4c21','da360318-3485-5a37-bc5c-916286bcb002'),('37298592-f182-5f74-b78c-b3ec4bbc6131','da360318-3485-5a37-bc5c-916286bcb002'),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','da360318-3485-5a37-bc5c-916286bcb002'),('37876a11-2d4b-5e70-8b61-474ab4551ae5','da360318-3485-5a37-bc5c-916286bcb002'),('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5','da360318-3485-5a37-bc5c-916286bcb002'),('3ca099fa-59dd-57ee-9d62-eb8a3d23e060','da360318-3485-5a37-bc5c-916286bcb002'),('3d5a8754-c917-5892-8545-2f03ef4746ed','da360318-3485-5a37-bc5c-916286bcb002'),('4b70b27d-1a42-519d-af06-141de67515c7','da360318-3485-5a37-bc5c-916286bcb002'),('4e2acb6e-09d3-589c-80a4-d7683ee2eb57','da360318-3485-5a37-bc5c-916286bcb002'),('4fa40dea-5ca9-5e8b-91b6-61b784917577','da360318-3485-5a37-bc5c-916286bcb002'),('50c43074-eb60-58bd-8cc8-6d88cb42e367','da360318-3485-5a37-bc5c-916286bcb002'),('51f681e3-6898-57ff-90af-38c7da75782e','da360318-3485-5a37-bc5c-916286bcb002'),('52c08d85-b677-54bc-8fd2-b479c48ce2bf','da360318-3485-5a37-bc5c-916286bcb002'),('53d1a069-6c1b-5559-b7f0-88fc9215eeec','da360318-3485-5a37-bc5c-916286bcb002'),('5447f892-ba7a-5ab1-b257-84ce92e64849','da360318-3485-5a37-bc5c-916286bcb002'),('5c6b17fa-8342-5aec-9b43-8882f65deed6','da360318-3485-5a37-bc5c-916286bcb002'),('5d8096bc-eb95-5638-9799-69ed0c7e7759','da360318-3485-5a37-bc5c-916286bcb002'),('6803ca49-8946-5386-86a8-257563dfb328','da360318-3485-5a37-bc5c-916286bcb002'),('68d97ecd-8f43-592e-9a84-c151b1626e11','da360318-3485-5a37-bc5c-916286bcb002'),('690da950-e796-5869-b702-769a14174c0d','da360318-3485-5a37-bc5c-916286bcb002'),('6dac5caf-5fd1-5024-947f-612840cdfe03','da360318-3485-5a37-bc5c-916286bcb002'),('716d2798-4298-5677-8de2-a849e97e0e4e','da360318-3485-5a37-bc5c-916286bcb002'),('7190b957-3b9c-54eb-812e-5e4f87d0486e','da360318-3485-5a37-bc5c-916286bcb002'),('7297bdb9-65d3-5e8b-a567-4c433e23c766','da360318-3485-5a37-bc5c-916286bcb002'),('742001dc-5a14-5b31-a224-e799ceed78da','da360318-3485-5a37-bc5c-916286bcb002'),('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd','da360318-3485-5a37-bc5c-916286bcb002'),('769da44b-8943-579c-aadf-f4cfbf063172','da360318-3485-5a37-bc5c-916286bcb002'),('7969e1ae-86fa-516c-90fc-e15f0a2a548c','da360318-3485-5a37-bc5c-916286bcb002'),('8d7a3ff8-f997-5b48-818a-935b6c184fb6','da360318-3485-5a37-bc5c-916286bcb002'),('8d9a0bf7-0371-56d2-b5df-c00099b22b88','da360318-3485-5a37-bc5c-916286bcb002'),('90753d65-2026-5e82-b69a-39c3d7d6840a','da360318-3485-5a37-bc5c-916286bcb002'),('92677901-c5ac-595a-8835-27d8ed0af3f0','da360318-3485-5a37-bc5c-916286bcb002'),('93b7ab59-b0ac-5d18-96a2-e07db2776730','da360318-3485-5a37-bc5c-916286bcb002'),('9bd335b4-71c8-5489-958f-434540bdc86c','da360318-3485-5a37-bc5c-916286bcb002'),('9dadaee9-719d-548b-8238-f4fe52022f8c','da360318-3485-5a37-bc5c-916286bcb002'),('9f6d00a1-7abe-5365-87a9-23732bc1880d','da360318-3485-5a37-bc5c-916286bcb002'),('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0','da360318-3485-5a37-bc5c-916286bcb002'),('a9d605f6-deff-5623-945e-97f2db2ec56f','da360318-3485-5a37-bc5c-916286bcb002'),('ad96b442-3513-573f-bc25-4b8090a7cd48','da360318-3485-5a37-bc5c-916286bcb002'),('ae99d98e-0fde-5894-bac8-4b5b13111604','da360318-3485-5a37-bc5c-916286bcb002'),('bb7a5901-0339-5235-8f4f-fad4cf2e30e9','da360318-3485-5a37-bc5c-916286bcb002'),('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5','da360318-3485-5a37-bc5c-916286bcb002'),('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4','da360318-3485-5a37-bc5c-916286bcb002'),('c6b5b015-20c7-517d-8f1e-e088d5ef310d','da360318-3485-5a37-bc5c-916286bcb002'),('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e','da360318-3485-5a37-bc5c-916286bcb002'),('c95d0ff1-76f4-5468-af55-c1d5333efd91','da360318-3485-5a37-bc5c-916286bcb002'),('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432','da360318-3485-5a37-bc5c-916286bcb002'),('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f','da360318-3485-5a37-bc5c-916286bcb002'),('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb','da360318-3485-5a37-bc5c-916286bcb002'),('d41479a0-fd39-5334-b206-08e45fd69a44','da360318-3485-5a37-bc5c-916286bcb002'),('d4bb0bbd-d85b-516e-ae9b-9622be28e88e','da360318-3485-5a37-bc5c-916286bcb002'),('d545b75f-5e33-5840-bbb8-75a04f3b81f8','da360318-3485-5a37-bc5c-916286bcb002'),('d7cbd547-e969-58f3-be32-be1fc60baeb8','da360318-3485-5a37-bc5c-916286bcb002'),('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f','da360318-3485-5a37-bc5c-916286bcb002'),('d94820bc-e2b3-5365-b15d-2918dcb35469','da360318-3485-5a37-bc5c-916286bcb002'),('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff','da360318-3485-5a37-bc5c-916286bcb002'),('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0','da360318-3485-5a37-bc5c-916286bcb002'),('dbd545fb-0f53-5937-85ca-5d8f48b79aa7','da360318-3485-5a37-bc5c-916286bcb002'),('de43dc9d-c33d-501f-a100-518c0d4f1802','da360318-3485-5a37-bc5c-916286bcb002'),('e10f4c82-65d9-532f-ad6a-3dae598123ce','da360318-3485-5a37-bc5c-916286bcb002'),('e1e3eacd-eb83-5ef5-a86e-077945a4f60a','da360318-3485-5a37-bc5c-916286bcb002'),('e234c8ce-3c68-5078-858b-028ecb8131c7','da360318-3485-5a37-bc5c-916286bcb002'),('e37bc81d-7c20-50a6-9f03-fd3169b9037a','da360318-3485-5a37-bc5c-916286bcb002'),('f08dfc48-80bf-52ea-9942-e801bb198c64','da360318-3485-5a37-bc5c-916286bcb002'),('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1','da360318-3485-5a37-bc5c-916286bcb002'),('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e','da360318-3485-5a37-bc5c-916286bcb002'),('fd8458dc-aed4-5935-b3c1-ae08ba062a28','da360318-3485-5a37-bc5c-916286bcb002'),('ff5c9117-7d47-500b-bcf1-a037ea526e7f','da360318-3485-5a37-bc5c-916286bcb002'),('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd','e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7','e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),('bf3db79c-50cc-583d-b0f0-d0682ee9e38b','e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),('0de3d276-823d-583f-99c9-238dd1192685','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('14ac0d2b-754c-536c-99cf-15cc577f0e4e','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('2cf090c9-5ec7-5998-813e-24ff8cda4d03','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('377c2f8a-ce9a-5e09-a2e0-8517acb511ef','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('3d5a8754-c917-5892-8545-2f03ef4746ed','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('50c43074-eb60-58bd-8cc8-6d88cb42e367','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('7969e1ae-86fa-516c-90fc-e15f0a2a548c','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('c95d0ff1-76f4-5468-af55-c1d5333efd91','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('d7cbd547-e969-58f3-be32-be1fc60baeb8','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('e234c8ce-3c68-5078-858b-028ecb8131c7','e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),('ab737371-da5c-527f-9a79-9c0c2f45675a','e6b1c78b-7e84-51b8-901c-06c2c7d131b2'),('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd','e6b1c78b-7e84-51b8-901c-06c2c7d131b2'),('1ae0a0ed-b919-57c2-a986-f619ada9e2f0','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('3d5a8754-c917-5892-8545-2f03ef4746ed','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('5447f892-ba7a-5ab1-b257-84ce92e64849','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('8d9a0bf7-0371-56d2-b5df-c00099b22b88','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('90753d65-2026-5e82-b69a-39c3d7d6840a','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('9198aa9c-915c-582d-8e20-608ec82b6c1c','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('955c076e-9b6f-5209-a5e6-f05cc68dae4c','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f','f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),('027f21be-9112-5401-a8b7-f4138b7c972e','f9186399-961e-5bc6-a27d-2b2c45361f07'),('2db2fdd3-52bd-51dc-a579-590db3bd4c21','f9186399-961e-5bc6-a27d-2b2c45361f07'),('3ca099fa-59dd-57ee-9d62-eb8a3d23e060','f9186399-961e-5bc6-a27d-2b2c45361f07'),('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e','f9186399-961e-5bc6-a27d-2b2c45361f07');
/*!40000 ALTER TABLE `news_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_tags`
--

DROP TABLE IF EXISTS `news_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_tags` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_news_tags_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_news_tags_tenant` (`tenant_id`),
  CONSTRAINT `fk_news_tags_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_tags`
--

LOCK TABLES `news_tags` WRITE;
/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` VALUES ('1fd988f4-4834-5c01-9381-be463e47cc4f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','pembangunan','pembangunan','2026-05-21 01:30:02','2026-05-31 04:51:09',NULL),('214fee5b-67a0-5f2d-b02d-83e714b7362a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Ketahanan Pangan','ketahanan-pangan','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('356138ea-a420-5abe-8455-a6484baf6480','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PKK','pkk','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('3d1fded6-2be2-5c4e-bd89-9756efb00c6e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Dana Desa','dana-desa','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('4b798f55-fff7-5df0-8421-c0837952f619','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BLT','blt','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7c7274c8-7817-5742-b1d2-7ae33479da4e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BUMDES','bumdes','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('7dd3ddd2-1f97-56d7-b2fe-9245318ce91a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','TPT','tpt','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('8290c4c7-7327-50b6-9d8a-fcc22bbc6b22','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BPD','bpd','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('857bb874-2eb5-5b80-8dd3-e308485fe400','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','APBDes','apbdes','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('91357d15-e607-56c6-a6d7-f44d06338356','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PAUD','paud','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('9ba60f88-4a36-50be-9e73-7983cacecca0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Karang Taruna','karang-taruna','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a22ae8d5-e0ab-5082-ae3c-df1b2b557177','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Hari Santri','hari-santri','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('a2a354db-0948-5096-ad72-bc86ac5faba2','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','kesehatan','kesehatan','2026-05-21 01:30:02','2026-05-31 04:30:33',NULL),('a3eda259-210c-5699-8e03-60d569ed4e60','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','martopuro','martopuro','2026-05-21 01:30:02','2026-05-24 09:41:39',NULL),('a42a0420-9540-5dda-a676-87ece5869b3a','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','kdmp','kdmp','2026-05-21 01:30:02','2026-05-24 09:41:39',NULL),('a5f4ff91-7ddd-53d7-b564-3f29521a7c26','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','koperasi desa','koperasi-desa','2026-05-21 01:30:02','2026-05-24 09:41:39',NULL),('a9a6c593-ad2c-54a7-8377-affa7b4b2022','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Donor Darah','donor-darah','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('b29a5b4e-5967-5d40-bf93-5b57bd786ef0','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','pavingisasi','pavingisasi','2026-05-21 01:30:02','2026-05-31 04:51:08',NULL),('ba7593f4-1683-53ab-b3cc-6b5da019b289','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','RT RW','rt-rw','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('bda96326-5d8a-5592-9623-c593475f0475','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Pemerintahan Desa','pemerintahan-desa','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Olahraga','olahraga','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('da360318-3485-5a37-bc5c-916286bcb002','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','berita desa','berita-desa','2026-05-21 01:30:02','2026-05-24 09:41:39',NULL),('e2ec2732-77b8-5a6a-b01c-a543ca4951b5','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Karnaval','karnaval','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Musyawarah Desa','musyawarah-desa','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('e6b1c78b-7e84-51b8-901c-06c2c7d131b2','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Profil Desa','profil-desa','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('f89dce11-6aa2-5881-a3e1-ba18c1c3f79e','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Lembaga Desa','lembaga-desa','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL),('f9186399-961e-5bc6-a27d-2b2c45361f07','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Khotmil Quran','khotmil-quran','2026-05-21 01:30:02','2026-05-21 01:30:02',NULL);
/*!40000 ALTER TABLE `news_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_permissions_code` (`code`),
  KEY `idx_permissions_module_action` (`module`,`action`),
  KEY `idx_permissions_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES ('32ad0260-4de4-11f1-a9c1-44a3bb6ab520','tenant.read','tenant','read','Read Tenant','Melihat data tenant.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0825-4de4-11f1-a9c1-44a3bb6ab520','tenant.manage','tenant','manage','Manage Tenant','Mengelola tenant.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad09bb-4de4-11f1-a9c1-44a3bb6ab520','user.read','user','read','Read User','Melihat data user.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520','user.create','user','create','Create User','Membuat user.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0b77-4de4-11f1-a9c1-44a3bb6ab520','user.update','user','update','Update User','Mengubah user.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0c4f-4de4-11f1-a9c1-44a3bb6ab520','user.delete','user','delete','Delete User','Menghapus user.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0d22-4de4-11f1-a9c1-44a3bb6ab520','rbac.read','rbac','read','Read RBAC','Melihat role dan permission.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0de9-4de4-11f1-a9c1-44a3bb6ab520','rbac.manage','rbac','manage','Manage RBAC','Mengelola role dan permission.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0eba-4de4-11f1-a9c1-44a3bb6ab520','news.read','news','read','Read News','Melihat berita.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520','news.create','news','create','Create News','Membuat berita.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad10c3-4de4-11f1-a9c1-44a3bb6ab520','news.update','news','update','Update News','Mengubah berita.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad1198-4de4-11f1-a9c1-44a3bb6ab520','news.delete','news','delete','Delete News','Menghapus berita.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad1262-4de4-11f1-a9c1-44a3bb6ab520','site.read','site','read','Read Site Config','Melihat konfigurasi website.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32ad132b-4de4-11f1-a9c1-44a3bb6ab520','site.update','site','update','Update Site Config','Mengubah konfigurasi website.','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `fk_role_permissions_permission` (`permission_id`),
  CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES ('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0260-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0825-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad09bb-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0b77-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0c4f-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0d22-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0de9-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0eba-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad10c3-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad1198-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad1262-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','32ad132b-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad0260-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad09bb-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad0b77-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad0eba-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad10c3-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad1198-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad1262-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','32ad132b-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4be24-4de4-11f1-a9c1-44a3bb6ab520','32ad0260-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4be24-4de4-11f1-a9c1-44a3bb6ab520','32ad0eba-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12'),('32a4be24-4de4-11f1-a9c1-44a3bb6ab520','32ad1262-4de4-11f1-a9c1-44a3bb6ab520','2026-05-12 09:23:12');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` enum('global','tenant') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tenant',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_code` (`code`),
  KEY `idx_roles_scope_status` (`scope`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520','super_admin','Super Admin','Memiliki akses penuh ke semua tenant dan semua fitur.','global','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520','admin_tenant','Admin Tenant','Mengelola data dan konten pada tenant tertentu.','tenant','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('32a4be24-4de4-11f1-a9c1-44a3bb6ab520','user','User','Pengguna umum dengan akses dasar.','tenant','active','2026-05-12 09:23:12','2026-05-12 09:23:12',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structure_organization_charts`
--

DROP TABLE IF EXISTS `structure_organization_charts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structure_organization_charts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chart_type` enum('organization','department','school','pesantren','company','committee','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'organization',
  `layout_engine` enum('manual','tree','dagre','grid','radial','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manual',
  `layout_direction` enum('top-bottom','bottom-top','left-right','right-left','free') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'top-bottom',
  `canvas_width` int unsigned NOT NULL DEFAULT '1200',
  `canvas_height` int unsigned NOT NULL DEFAULT '800',
  `background_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_image_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grid_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `grid_size` int unsigned NOT NULL DEFAULT '20',
  `snap_to_grid` tinyint(1) NOT NULL DEFAULT '0',
  `zoom_min` decimal(5,2) NOT NULL DEFAULT '0.25',
  `zoom_max` decimal(5,2) NOT NULL DEFAULT '2.50',
  `initial_scale` decimal(5,2) NOT NULL DEFAULT '1.00',
  `node_default_config` json DEFAULT NULL,
  `edge_default_config` json DEFAULT NULL,
  `konva_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `status` enum('draft','published','archived','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_structure_org_charts_tenant_slug` (`tenant_id`,`slug`),
  UNIQUE KEY `uq_structure_org_charts_id_tenant` (`id`,`tenant_id`),
  KEY `idx_structure_org_charts_tenant_status` (`tenant_id`,`status`,`sort_order`),
  KEY `idx_structure_org_charts_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  CONSTRAINT `fk_structure_org_charts_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structure_organization_charts`
--

LOCK TABLES `structure_organization_charts` WRITE;
/*!40000 ALTER TABLE `structure_organization_charts` DISABLE KEYS */;
INSERT INTO `structure_organization_charts` VALUES ('7866650e-f3b0-4019-84fd-53c57630487f','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Struktur Organisasi','struktur-organisasi','Bagan struktur organisasi tenant.','organization','manual','top-bottom',1600,1000,'#ffffff',NULL,1,40,0,0.25,2.50,1.00,'{\"width\": 240, \"height\": 124, \"padding\": 16, \"cornerRadius\": 22}','{\"stroke\": \"#94a3b8\", \"lineCap\": \"round\", \"lineJoin\": \"round\", \"strokeWidth\": 2}','{\"x\": 390.2756388488641, \"y\": 37.98176486911595, \"scale\": 0.6650571136223362}','{\"source\": \"app-structure-organization\", \"edgeCount\": 7, \"nodeCount\": 8}','published',1,0,'2026-05-31 07:47:14','2026-05-31 16:16:25',NULL);
/*!40000 ALTER TABLE `structure_organization_charts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structure_organization_edges`
--

DROP TABLE IF EXISTS `structure_organization_edges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structure_organization_edges` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_node_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_node_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `edge_type` enum('hierarchy','assistant','coordination','dotted','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hierarchy',
  `label` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_type` enum('straight','orthogonal','bezier','step','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'orthogonal',
  `stroke_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stroke_width` decimal(8,2) NOT NULL DEFAULT '2.00',
  `stroke_dash` json DEFAULT NULL,
  `arrow_start` tinyint(1) NOT NULL DEFAULT '0',
  `arrow_end` tinyint(1) NOT NULL DEFAULT '0',
  `points_config` json DEFAULT NULL,
  `konva_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_structure_org_edge_unique` (`chart_id`,`source_node_id`,`target_node_id`,`edge_type`),
  KEY `idx_structure_org_edges_chart_status` (`chart_id`,`status`,`sort_order`),
  KEY `idx_structure_org_edges_source` (`source_node_id`),
  KEY `idx_structure_org_edges_target` (`target_node_id`),
  KEY `fk_structure_org_edges_tenant` (`tenant_id`),
  KEY `fk_structure_org_edges_chart` (`chart_id`,`tenant_id`),
  CONSTRAINT `fk_structure_org_edges_chart` FOREIGN KEY (`chart_id`, `tenant_id`) REFERENCES `structure_organization_charts` (`id`, `tenant_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_structure_org_edges_source` FOREIGN KEY (`source_node_id`) REFERENCES `structure_organizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_structure_org_edges_target` FOREIGN KEY (`target_node_id`) REFERENCES `structure_organizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_structure_org_edges_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structure_organization_edges`
--

LOCK TABLES `structure_organization_edges` WRITE;
/*!40000 ALTER TABLE `structure_organization_edges` DISABLE KEYS */;
/*!40000 ALTER TABLE `structure_organization_edges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structure_organizations`
--

DROP TABLE IF EXISTS `structure_organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structure_organizations` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(220) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_code` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_unit` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `content_json` json DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  `node_type` enum('person','position','department','division','unit','group','placeholder','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'person',
  `shape_type` enum('card','rounded_rect','rect','circle','avatar_card','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'card',
  `x` decimal(12,2) NOT NULL DEFAULT '0.00',
  `y` decimal(12,2) NOT NULL DEFAULT '0.00',
  `width` decimal(12,2) NOT NULL DEFAULT '220.00',
  `height` decimal(12,2) NOT NULL DEFAULT '110.00',
  `rotation` decimal(8,2) NOT NULL DEFAULT '0.00',
  `scale_x` decimal(8,3) NOT NULL DEFAULT '1.000',
  `scale_y` decimal(8,3) NOT NULL DEFAULT '1.000',
  `fill_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `border_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `border_width` decimal(8,2) NOT NULL DEFAULT '1.00',
  `text_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accent_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `font_family` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_font_size` int unsigned NOT NULL DEFAULT '16',
  `position_font_size` int unsigned NOT NULL DEFAULT '13',
  `photo_shape` enum('circle','rounded_rect','rect') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'circle',
  `photo_width` decimal(12,2) NOT NULL DEFAULT '56.00',
  `photo_height` decimal(12,2) NOT NULL DEFAULT '56.00',
  `draggable` tinyint(1) NOT NULL DEFAULT '1',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `konva_config` json DEFAULT NULL,
  `style_config` json DEFAULT NULL,
  `social_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_structure_org_node_chart_slug` (`chart_id`,`slug`),
  KEY `idx_structure_org_nodes_tenant_status` (`tenant_id`,`status`,`sort_order`),
  KEY `idx_structure_org_nodes_chart_status` (`chart_id`,`status`,`sort_order`),
  KEY `idx_structure_org_nodes_parent` (`parent_id`),
  KEY `idx_structure_org_nodes_position_code` (`tenant_id`,`chart_id`,`position_code`),
  KEY `fk_structure_org_nodes_chart` (`chart_id`,`tenant_id`),
  CONSTRAINT `fk_structure_org_nodes_chart` FOREIGN KEY (`chart_id`, `tenant_id`) REFERENCES `structure_organization_charts` (`id`, `tenant_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_structure_org_nodes_parent` FOREIGN KEY (`parent_id`) REFERENCES `structure_organizations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_structure_org_nodes_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structure_organizations`
--

LOCK TABLES `structure_organizations` WRITE;
/*!40000 ALTER TABLE `structure_organizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `structure_organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_complaints`
--

DROP TABLE IF EXISTS `tenant_complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_complaints` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_type` enum('aduan','laporan','pengajuan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aduan',
  `title` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporter_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporter_email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporter_phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `attachment_config` json DEFAULT NULL,
  `priority` enum('low','normal','high','urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `status` enum('new','in_review','in_progress','resolved','rejected','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `assigned_to` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response_text` text COLLATE utf8mb4_unicode_ci,
  `response_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `source_type` enum('public_form','admin','api','import') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public_form',
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_complaints_public_code` (`tenant_id`,`public_code`),
  KEY `idx_tenant_complaints_tenant_status` (`tenant_id`,`status`,`created_at`),
  KEY `idx_tenant_complaints_tenant_service_status` (`tenant_id`,`service_type`,`status`,`created_at`),
  KEY `idx_tenant_complaints_reporter_email` (`tenant_id`,`reporter_email`),
  KEY `idx_tenant_complaints_assigned_to` (`assigned_to`),
  CONSTRAINT `fk_tenant_complaints_assigned_to` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tenant_complaints_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_complaints`
--

LOCK TABLES `tenant_complaints` WRITE;
/*!40000 ALTER TABLE `tenant_complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_facilities`
--

DROP TABLE IF EXISTS `tenant_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_facilities` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facility_type` enum('health','market','education','sport','emergency','transport','water','public_service','office','worship','tourism','security','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `operational_hours` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_facilities_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_tenant_facilities_tenant_status` (`tenant_id`,`status`),
  KEY `idx_tenant_facilities_tenant_type` (`tenant_id`,`facility_type`,`status`),
  KEY `idx_tenant_facilities_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  KEY `idx_tenant_facilities_sort` (`tenant_id`,`sort_order`,`created_at`),
  CONSTRAINT `fk_tenant_facilities_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tenant_facilities_chk_1` CHECK (json_valid(`content_json`)),
  CONSTRAINT `tenant_facilities_chk_2` CHECK (json_valid(`contact_config`)),
  CONSTRAINT `tenant_facilities_chk_3` CHECK (json_valid(`operational_hours`)),
  CONSTRAINT `tenant_facilities_chk_4` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_facilities`
--

LOCK TABLES `tenant_facilities` WRITE;
/*!40000 ALTER TABLE `tenant_facilities` DISABLE KEYS */;
INSERT INTO `tenant_facilities` VALUES ('b1127b76-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','health','Kesehatan','Fasilitas layanan kesehatan masyarakat desa.','kesehatan','lucide:hospital','','','<p>Fasilitas kesehatan desa mendukung pelayanan kesehatan dasar, pemeriksaan rutin, posyandu, serta kegiatan kesehatan masyarakat.</p><p></p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan kesehatan masyarakat desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,'','','','','{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"images\":[]}','active',1,1,'2026-05-14 10:14:28','2026-05-24 09:17:03',NULL),('b112e33d-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','market','Pasar','Fasilitas perdagangan dan aktivitas ekonomi warga.','pasar','lucide:store',NULL,NULL,'<p>Pasar menjadi pusat aktivitas ekonomi masyarakat, tempat jual beli kebutuhan harian, produk lokal, dan hasil usaha warga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas perdagangan dan aktivitas ekonomi warga.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,2,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b1130aa1-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','education','Pendidikan','Fasilitas pendidikan dan pembelajaran masyarakat.','pendidikan','lucide:school',NULL,NULL,'<p>Fasilitas pendidikan mendukung proses belajar masyarakat mulai dari pendidikan anak usia dini hingga kegiatan pembelajaran warga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas pendidikan dan pembelajaran masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,3,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b113126b-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','sport','Lapangan','Sarana olahraga dan kegiatan masyarakat desa.','lapangan','lucide:map',NULL,NULL,'<p>Lapangan desa digunakan untuk olahraga, kegiatan warga, upacara, lomba, dan acara masyarakat.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Sarana olahraga dan kegiatan masyarakat desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,4,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b113152c-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','emergency','Ambulance','Layanan kendaraan darurat untuk kebutuhan kesehatan warga.','ambulance','lucide:ambulance',NULL,NULL,'<p>Ambulance desa membantu kebutuhan transportasi darurat kesehatan warga menuju fasilitas layanan kesehatan.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Layanan kendaraan darurat untuk kebutuhan kesehatan warga.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,5,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b11317f1-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','transport','Mobil Siaga','Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.','mobil-siaga','lucide:car',NULL,NULL,'<p>Mobil siaga desa digunakan untuk mendukung kebutuhan mendesak masyarakat dan operasional pelayanan desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,6,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b1131ac6-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','water','HIPAM','Fasilitas layanan air bersih masyarakat.','hipam','lucide:droplets',NULL,NULL,'<p>HIPAM mendukung pengelolaan dan distribusi air bersih bagi masyarakat desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan air bersih masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,7,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL);
/*!40000 ALTER TABLE `tenant_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_institutions`
--

DROP TABLE IF EXISTS `tenant_institutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_institutions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_institutions_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_tenant_institutions_tenant_status` (`tenant_id`,`status`),
  KEY `idx_tenant_institutions_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  KEY `idx_tenant_institutions_sort` (`tenant_id`,`sort_order`,`created_at`),
  CONSTRAINT `fk_tenant_institutions_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tenant_institutions_chk_1` CHECK (json_valid(`content_json`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_institutions`
--

LOCK TABLES `tenant_institutions` WRITE;
/*!40000 ALTER TABLE `tenant_institutions` DISABLE KEYS */;
INSERT INTO `tenant_institutions` VALUES ('31e430ff-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BPD','Badan Permusyawaratan Desa','bpd','solar:book-bold-duotone',NULL,'<ul><li><p><strong><em>adsjkfnajkfajkjkadjadabjkadj</em></strong></p></li><li><p></p></li></ul><p></p>','{\"type\": \"doc\", \"content\": [{\"type\": \"bulletList\", \"content\": [{\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"adsjkfnajkfajkjkadjadabjkadj\", \"type\": \"text\", \"marks\": [{\"type\": \"bold\"}, {\"type\": \"italic\"}]}]}]}, {\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\"}]}]}, {\"type\": \"paragraph\"}]}','active',1,1,'2026-05-14 08:45:01','2026-05-14 10:23:37',NULL),('31e4c4a3-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','LPMD','Lembaga Pemberdayaan Masyarakat Desa','lpmd','solar:widget-5-bold-duotone',NULL,'<p>Lembaga Pemberdayaan Masyarakat Desa</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Lembaga Pemberdayaan Masyarakat Desa\", \"type\": \"text\"}]}]}','active',1,2,'2026-05-14 08:45:01','2026-05-14 09:09:46',NULL),('31e4d181-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BHABINKAMTIBMAS','Bhayangkara Pembina Keamanan dan Ketertiban Masyarakat','bhabinkamtibmas','solar:shield-check-bold-duotone',NULL,'<p>BHABINKAMTIBMAS mendukung keamanan, ketertiban, dan pembinaan masyarakat di wilayah desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Bhayangkara Pembina Keamanan dan Ketertiban Masyarakat\", \"type\": \"text\"}]}]}','active',1,3,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4da04-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PKK','Pemberdayaan Kesejahteraan Keluarga','pkk','solar:heart-bold-duotone',NULL,'<p>PKK berfokus pada pemberdayaan keluarga, kesehatan, pendidikan, dan kesejahteraan masyarakat.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pemberdayaan Kesejahteraan Keluarga\", \"type\": \"text\"}]}]}','active',1,4,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4ded6-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BABINSA','Bintara Pembina Desa','babinsa','solar:shield-user-bold-duotone',NULL,'<p>BABINSA mendukung pembinaan teritorial, keamanan, dan koordinasi masyarakat desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Bintara Pembina Desa\", \"type\": \"text\"}]}]}','active',1,5,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4e416-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','LINMAS','Perlindungan Masyarakat','linmas','solar:shield-bold-duotone',NULL,'<p>LINMAS berperan dalam perlindungan masyarakat, ketertiban, dan kesiapsiagaan lingkungan.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Perlindungan Masyarakat\", \"type\": \"text\"}]}]}','active',1,6,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4e84a-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','HIPPA','Himpunan Petani Pemakai Air','hippa','solar:water-bold-duotone',NULL,'<p>HIPPA mengelola kepentingan petani dalam penggunaan dan distribusi air irigasi.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Himpunan Petani Pemakai Air\", \"type\": \"text\"}]}]}','active',1,7,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4ec24-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','HIPPAM','Himpunan Penduduk Pemakai Air Minum','hippam','solar:dropper-bold-duotone',NULL,'<p>HIPPAM berperan dalam pengelolaan layanan air minum masyarakat.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Himpunan Penduduk Pemakai Air Minum\", \"type\": \"text\"}]}]}','active',1,8,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4efd0-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','GAPOKTAN','Gabungan Kelompok Tani','gapoktan','solar:users-group-rounded-bold-duotone',NULL,'<p>GAPOKTAN menjadi wadah koordinasi kelompok tani dalam pengembangan pertanian desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Gabungan Kelompok Tani\", \"type\": \"text\"}]}]}','active',1,9,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4f373-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','KOPWAN','Koperasi Wanita','kopwan','solar:users-group-two-rounded-bold-duotone',NULL,'<p>KOPWAN mendukung pemberdayaan ekonomi perempuan melalui aktivitas koperasi.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Koperasi Wanita\", \"type\": \"text\"}]}]}','active',1,10,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4f736-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','KARANGTARUNA','Organisasi Desa','karangtaruna','solar:users-group-rounded-bold-duotone',NULL,'<p>Karang Taruna menjadi wadah kreativitas, kepemudaan, sosial, dan kegiatan masyarakat desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Organisasi Desa\", \"type\": \"text\"}]}]}','active',1,11,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4facd-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PUSTU','Puskesmas Pembantu','pustu','solar:heart-pulse-bold-duotone',NULL,'<p>PUSTU membantu pelayanan kesehatan dasar masyarakat di tingkat desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Puskesmas Pembantu\", \"type\": \"text\"}]}]}','active',1,12,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e4fe90-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','POSYANDU','Pos Pelayanan Terpadu','posyandu','solar:health-bold-duotone',NULL,'<p>POSYANDU memberikan layanan kesehatan ibu, anak, gizi, dan pemantauan tumbuh kembang.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pos Pelayanan Terpadu\", \"type\": \"text\"}]}]}','active',1,13,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e50226-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','PAUD','Pendidikan Anak Usia Dini','paud','solar:book-2-bold-duotone',NULL,'<p>PAUD menjadi lembaga pendidikan awal bagi anak usia dini di lingkungan desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pendidikan Anak Usia Dini\", \"type\": \"text\"}]}]}','active',1,14,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL),('31e50599-4f71-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','BUMDES','Badan Usaha Milik Desa','bumdes','solar:briefcase-bold-duotone',NULL,'<p>BUMDES mendukung pengembangan ekonomi desa melalui unit usaha dan pengelolaan potensi lokal.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Badan Usaha Milik Desa\", \"type\": \"text\"}]}]}','active',1,15,'2026-05-14 08:45:01','2026-05-14 08:45:01',NULL);
/*!40000 ALTER TABLE `tenant_institutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_organizations`
--

DROP TABLE IF EXISTS `tenant_organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_organizations` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_type` enum('government','village_government','bumdes','youth','women','community','religious','education','health','umkm','tourism','culture','security','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `logo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `address_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `operational_hours` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_organizations_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_tenant_organizations_tenant_status` (`tenant_id`,`status`),
  KEY `idx_tenant_organizations_tenant_type` (`tenant_id`,`organization_type`,`status`),
  KEY `idx_tenant_organizations_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  KEY `idx_tenant_organizations_parent` (`parent_id`),
  CONSTRAINT `fk_tenant_organizations_parent` FOREIGN KEY (`parent_id`) REFERENCES `tenant_organizations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tenant_organizations_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tenant_organizations_chk_1` CHECK (json_valid(`contact_config`)),
  CONSTRAINT `tenant_organizations_chk_2` CHECK (json_valid(`address_config`)),
  CONSTRAINT `tenant_organizations_chk_3` CHECK (json_valid(`social_config`)),
  CONSTRAINT `tenant_organizations_chk_4` CHECK (json_valid(`operational_hours`)),
  CONSTRAINT `tenant_organizations_chk_5` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_organizations`
--

LOCK TABLES `tenant_organizations` WRITE;
/*!40000 ALTER TABLE `tenant_organizations` DISABLE KEYS */;
INSERT INTO `tenant_organizations` VALUES ('6355beda-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'village_government','Pemerintah Desa Martopuro','Pemerintah Desa Martopuro','pemerintah-desa-martopuro','Pusat layanan pemerintahan, administrasi, dan informasi resmi Desa Martopuro.','<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>',NULL,'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203396/martopuro/organizations/cover/martopuro-hero_lhelnc.webp',NULL,NULL,NULL,'https://martopuro.com','Desa Martopuro',NULL,NULL,'{\"email\":null,\"phone\":null,\"whatsapp\":null}',NULL,'{\"instagram\":null,\"facebook\":null,\"youtube\":null,\"tiktok\":null}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"icon\":\"solar:buildings-3-bold-duotone\",\"images\":[\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203396/martopuro/organizations/cover/martopuro-hero_lhelnc.webp\",\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780150886/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_slfraf.webp\"],\"source\":\"seed\",\"section\":\"hero\",\"instagram\":null,\"updatedFrom\":\"app-organizations\",\"descriptionHtml\":\"<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>\",\"descriptionJson\":{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"content\":[{\"type\":\"text\",\"text\":\"Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.\"}]}]},\"facebook\":null,\"youtube\":null,\"tiktok\":null}','active',1,1,'2026-05-14 06:23:14','2026-05-31 04:56:45',NULL),('63574156-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'culture','Martopuro Culture Fest','Martopuro Culture Fest','martopuro-culture-fest','Wadah kegiatan budaya, musik, UMKM, dan kuliner lokal Martopuro.','Martopuro Culture Fest menjadi ruang kolaborasi warga untuk memperkenalkan budaya, musik, kuliner, UMKM, serta potensi lokal desa.',NULL,'https://martopuro.sencra.io/assets/culturefest/2.JPG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"ctaHref\": \"https://instagram.com/martopuroculturefest\", \"ctaLabel\": \"Buka Instagram\", \"instagram\": \"@martopuroculturefest\"}','active',1,2,'2026-05-14 06:23:14','2026-05-30 13:59:03','2026-05-30 13:59:03'),('63599780-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'umkm','UMKM Desa Martopuro','UMKM Desa Martopuro','umkm-desa-martopuro','Komunitas pelaku usaha lokal dan produk unggulan desa.','<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>',NULL,'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198106/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_hgaouu.webp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\":null,\"phone\":null,\"whatsapp\":null}',NULL,'{\"instagram\":null,\"facebook\":null,\"youtube\":null,\"tiktok\":null}',NULL,'{\"icon\":\"solar:shop-2-bold-duotone\",\"focus\":\"Produk lokal, kuliner, dan ekonomi warga\",\"images\":[\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198106/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_hgaouu.webp\"],\"instagram\":null,\"updatedFrom\":\"app-organizations\",\"descriptionHtml\":\"<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>\",\"descriptionJson\":{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"content\":[{\"type\":\"text\",\"text\":\"UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.\"}]}]},\"facebook\":null,\"youtube\":null,\"tiktok\":null}','active',1,3,'2026-05-14 06:23:14','2026-05-31 03:28:42',NULL);
/*!40000 ALTER TABLE `tenant_organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_potentials`
--

DROP TABLE IF EXISTS `tenant_potentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_potentials` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `potential_type` enum('agriculture','livestock','fishery','umkm','tourism','culture','natural_resource','human_resource','industry','creative_economy','food','craft','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `owner_name` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_name` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_capacity` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_unit` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `market_reach` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimated_value` decimal(18,2) DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `statistic_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_potentials_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_tenant_potentials_tenant_status` (`tenant_id`,`status`),
  KEY `idx_tenant_potentials_tenant_type` (`tenant_id`,`potential_type`,`status`),
  KEY `idx_tenant_potentials_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  KEY `idx_tenant_potentials_sort` (`tenant_id`,`sort_order`,`created_at`),
  FULLTEXT KEY `ft_tenant_potentials_search` (`title`,`subtitle`,`content_html`,`address`,`owner_name`,`manager_name`,`market_reach`),
  CONSTRAINT `fk_tenant_potentials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tenant_potentials_chk_1` CHECK (json_valid(`content_json`)),
  CONSTRAINT `tenant_potentials_chk_2` CHECK (json_valid(`contact_config`)),
  CONSTRAINT `tenant_potentials_chk_3` CHECK (json_valid(`statistic_config`)),
  CONSTRAINT `tenant_potentials_chk_4` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_potentials`
--

LOCK TABLES `tenant_potentials` WRITE;
/*!40000 ALTER TABLE `tenant_potentials` DISABLE KEYS */;
INSERT INTO `tenant_potentials` VALUES ('bf94213e-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','agriculture','Pertanian','Potensi hasil pertanian dan komoditas pangan desa.','pertanian','lucide:wheat',NULL,NULL,'<p>Potensi pertanian desa mencakup komoditas pangan, hasil panen warga, serta peluang pengembangan ekonomi berbasis lahan dan produksi lokal.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi hasil pertanian dan komoditas pangan desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Musiman','Komoditas','Pasar lokal dan wilayah sekitar',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi hasil pertanian dan komoditas pangan desa.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,1,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf9487f2-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','livestock','Peternakan','Potensi peternakan warga sebagai bagian dari ekonomi desa.','peternakan','mdi:storefront',NULL,NULL,'<p>Potensi peternakan dapat mencakup sapi, kambing, ayam, bebek, dan berbagai usaha ternak warga yang mendukung ekonomi keluarga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Ekor','Pasar lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\"}','{\"images\":[]}','active',1,2,'2026-05-14 10:29:11','2026-05-24 10:27:26',NULL),('bf949d7a-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','fishery','Perikanan','Potensi perikanan dan budidaya ikan masyarakat.','perikanan','lucide:fish',NULL,NULL,'<p>Potensi perikanan mencakup budidaya ikan air tawar, kolam warga, serta peluang pengembangan produk olahan berbasis ikan.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi perikanan dan budidaya ikan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Kg','Pasar lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi perikanan dan budidaya ikan masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,3,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94aa1b-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','umkm','UMKM Desa','Potensi usaha mikro, kecil, dan menengah masyarakat.','umkm','lucide:store',NULL,NULL,'<p>UMKM desa menjadi salah satu penggerak ekonomi masyarakat melalui produk makanan, kerajinan, jasa, dan perdagangan lokal.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Aktif','Unit usaha','Desa dan kecamatan sekitar',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,4,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94b4c7-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','tourism','Wisata Desa','Potensi wisata lokal, alam, edukasi, dan budaya desa.','wisata-desa','lucide:map-pin',NULL,NULL,'<p>Potensi wisata desa dapat dikembangkan melalui keunikan lingkungan, budaya lokal, edukasi masyarakat, dan daya tarik khas desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkembang','Destinasi','Pengunjung lokal dan regional',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,5,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94bee1-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','culture','Budaya Lokal','Potensi budaya, tradisi, dan kegiatan masyarakat.','budaya-lokal','lucide:landmark',NULL,NULL,'<p>Budaya lokal menjadi identitas desa yang dapat dikembangkan melalui kegiatan masyarakat, tradisi, seni, dan nilai gotong royong.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Kegiatan','Masyarakat desa',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,6,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94cccf-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','creative_economy','Ekonomi Kreatif','Potensi kreativitas warga dalam produk dan jasa bernilai tambah.','ekonomi-kreatif','lucide:palette',NULL,NULL,'<p>Ekonomi kreatif desa meliputi produk kreatif, desain, kerajinan, konten lokal, dan inovasi warga yang memiliki nilai jual.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Aktif','Produk','Online dan lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,7,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL);
/*!40000 ALTER TABLE `tenant_potentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_public_metrics`
--

DROP TABLE IF EXISTS `tenant_public_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_public_metrics` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric_group` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric_key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_decimal` decimal(18,2) DEFAULT NULL,
  `value_text` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_unit` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comparison_value` decimal(10,2) DEFAULT NULL,
  `comparison_unit` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comparison_direction` enum('up','down','same') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_type` enum('realtime','daily','weekly','monthly','yearly','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'realtime',
  `period_start` datetime DEFAULT NULL,
  `period_end` datetime DEFAULT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_type` enum('manual','analytics','system','api','import') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manual',
  `source_name` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_public_metrics_key` (`tenant_id`,`metric_group`,`metric_key`,`period_type`,`period_start`),
  KEY `idx_tenant_public_metrics_group_status` (`tenant_id`,`metric_group`,`status`,`sort_order`),
  CONSTRAINT `fk_tenant_public_metrics_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tenant_public_metrics_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_public_metrics`
--

LOCK TABLES `tenant_public_metrics` WRITE;
/*!40000 ALTER TABLE `tenant_public_metrics` DISABLE KEYS */;
INSERT INTO `tenant_public_metrics` VALUES ('35ec3954-4f85-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','visitor_statistics','today_visitors','Hari ini','Jumlah pengunjung hari ini',37.00,NULL,'visitor',12.10,'%','up','realtime',NULL,NULL,'solar:pulse-2-bold-duotone','#2563EB','manual','seed','{\"badge\": \"realtime\", \"display\": \"37\"}','active',1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35ece653-4f85-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','visitor_statistics','yesterday_visitors','Kemarin','Jumlah pengunjung kemarin',33.00,NULL,'visitor',NULL,NULL,NULL,'daily',NULL,NULL,'solar:calendar-bold-duotone','#64748B','manual','seed','{\"display\": \"33\"}','active',2,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35ecf2c7-4f85-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','visitor_statistics','total_visitors','Jumlah pengunjung','Total seluruh pengunjung website',6141.00,NULL,'visitor',NULL,NULL,NULL,'realtime',NULL,NULL,'solar:users-group-rounded-bold-duotone','#0F172A','manual','seed','{\"display\": \"6.141\"}','active',3,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL);
/*!40000 ALTER TABLE `tenant_public_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenants`
--

DROP TABLE IF EXISTS `tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenants` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_type` enum('village','school','pesantren','company','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `domain` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `og_image_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `subscription_plan` enum('free','basic','pro','enterprise','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'basic',
  `subscription_status` enum('trialing','active','past_due','paused','canceled','expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `subscription_started_at` datetime DEFAULT NULL,
  `subscription_ends_at` datetime DEFAULT NULL,
  `trial_ends_at` datetime DEFAULT NULL,
  `subscription_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `feature_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `theme_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `seo_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `hero_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `statistic_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `culture_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `warta_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `footer_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `navigation_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenants_slug` (`slug`),
  UNIQUE KEY `uq_tenants_domain` (`domain`),
  KEY `idx_tenants_status` (`status`),
  KEY `idx_tenants_type_status` (`tenant_type`,`status`),
  KEY `idx_tenants_subscription_status` (`subscription_plan`,`subscription_status`,`subscription_ends_at`),
  CONSTRAINT `tenants_chk_1` CHECK (json_valid(`subscription_config`)),
  CONSTRAINT `tenants_chk_10` CHECK (json_valid(`warta_config`)),
  CONSTRAINT `tenants_chk_11` CHECK (json_valid(`footer_config`)),
  CONSTRAINT `tenants_chk_12` CHECK (json_valid(`navigation_config`)),
  CONSTRAINT `tenants_chk_13` CHECK (json_valid(`social_config`)),
  CONSTRAINT `tenants_chk_2` CHECK (json_valid(`feature_config`)),
  CONSTRAINT `tenants_chk_3` CHECK (json_valid(`metadata`)),
  CONSTRAINT `tenants_chk_4` CHECK (json_valid(`theme_config`)),
  CONSTRAINT `tenants_chk_5` CHECK (json_valid(`seo_config`)),
  CONSTRAINT `tenants_chk_6` CHECK (json_valid(`hero_config`)),
  CONSTRAINT `tenants_chk_7` CHECK (json_valid(`contact_config`)),
  CONSTRAINT `tenants_chk_8` CHECK (json_valid(`statistic_config`)),
  CONSTRAINT `tenants_chk_9` CHECK (json_valid(`culture_config`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenants`
--

LOCK TABLES `tenants` WRITE;
/*!40000 ALTER TABLE `tenants` DISABLE KEYS */;
INSERT INTO `tenants` VALUES ('37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Desa Martopuro','Martopuro','martopuro','village','martopuro.com','https://martopuro.com','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198336/martopuro/site/martopuro-logo_m9hyzn.webp','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198330/martopuro/site/martopuro-logo_f8kmbq.webp','https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198342/martopuro/site/martopuro-hero_r9guox.webp','#2563eb','Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.','active','basic','active','2026-05-14 11:51:26','2027-05-14 23:59:59',NULL,'{}','{\"news\":true,\"finance\":false,\"letterC\":false,\"onlineLetter\":false}','{\"aboutHtml\":\"\",\"themeNote\":\"\",\"defaultLogo\":\"/assets/images/logo-martopuro.png\"}','{\"primaryColor\":\"#2563eb\",\"note\":\"\"}','{\"title\":\"Martopuro\",\"description\":\"Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.\",\"ogImage\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198342/martopuro/site/martopuro-hero_r9guox.webp\"}','{\"brand\":\"Desa Martopuro\",\"stats\":[{\"label\":\"UMKM\",\"value\":\"35+\"},{\"label\":\"Layanan\",\"value\":\"12\"},{\"label\":\"Agenda\",\"value\":\"Aktif\"}],\"badges\":[{\"icon\":\"lucide:file-check-2\",\"label\":\"Surat Keterangan\"},{\"icon\":\"lucide:store\",\"label\":\"Direktori UMKM\"},{\"icon\":\"lucide:calendar-days\",\"label\":\"Agenda Desa\"},{\"icon\":\"lucide:map-pin\",\"label\":\"Wisata\"}],\"quicks\":[{\"icon\":\"lucide:clock-3\",\"label\":\"Jam Layanan Kantor\",\"value\":\"Senin窶笛umat 窶｢ 08.00窶?15.00\"},{\"icon\":\"lucide:store\",\"label\":\"UMKM Terdaftar\",\"value\":\"35 usaha lokal aktif\"},{\"icon\":\"lucide:phone-call\",\"label\":\"Nomor Darurat\",\"value\":\"112 窶｢ 0812-xxxx-xxxx\"}],\"waIntl\":\"6289563836\",\"bgImage\":\"/assets/images/village/martopuro-hero.jpg\",\"tagline\":\"Portal Resmi Pemerintah Desa\",\"subtitle\":\"Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.\",\"titleMain\":\"Selamat Datang di Desa \",\"ctaPrimary\":{\"href\":\"/layanan\",\"label\":\"Ajukan Surat Online\"},\"ctaSecondary\":{\"href\":\"/profile\",\"label\":\"Lihat Profil Desa\"},\"titleHighlight\":\"Martopuro\",\"searchPlaceholder\":\"Cari layanan, berita, agenda, UMKM...\",\"title\":\"\",\"heading\":\"\",\"highlight\":\"\",\"description\":\"Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.\",\"imageUrl\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198353/martopuro/site/martopuro-hero_pbibrx.webp\",\"image\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198353/martopuro/site/martopuro-hero_pbibrx.webp\",\"ctaLabel\":\"\",\"ctaHref\":\"\",\"primaryCta\":{\"label\":\"\",\"href\":\"\"},\"contentHtml\":\"\"}','{\"email\":\"team.sencra@gmail.com\",\"phone\":\"0343-591234\",\"waIntl\":\"6289563836\",\"address\":\"Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur\",\"mapsQuery\":\"Kantor Desa Martopuro, Pasuruan\",\"officeName\":\"Kantor Desa Martopuro\",\"mapEmbedSrc\":\"\",\"officeSubtitle\":\"Pemerintah Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan\",\"whatsapp\":\"\",\"mapUrl\":\"\",\"mapsUrl\":\"\"}','{\"title\":\"Ringkasan Kinerja & APBDes 2026\",\"ctaHref\":\"/apbdes\",\"eyebrow\":\"Statistik Desa\",\"ctaLabel\":\"Lihat APBDes Lengkap\",\"subtitle\":\"Pantau statistik layanan, data aparatur, dan ringkasan APBDes secara ringkas, transparan, dan mudah dipahami masyarakat.\"}','{\"title\":\"Budaya, Musik, & Kuliner \",\"images\":[\"https://martopuro.sencra.io/assets/culturefest/2.JPG\",\"https://martopuro.sencra.io/assets/culturefest/0.JPG\",\"https://martopuro.sencra.io/assets/culturefest/1.JPG\",\"https://martopuro.sencra.io/assets/culturefest/2.JPG\"],\"eyebrow\":\"Martopuro Culture Fest\",\"subtitle\":\"Parade seni tradisi, UMKM lokal, pentas musik, lomba warga, dan kuliner khas dalam satu perayaan meriah.\",\"highlight\":\"Martopuro!\",\"instagram\":\"@martopuroculturefest\",\"eyebrowIcon\":\"lucide:ticket\",\"floatingBadge\":\"Festival Desa Digital\"}','{\"limit\":12,\"title\":\"Artikel Pilihan & Terbaru\",\"eyebrow\":\"Warta Martopuro\",\"subtitle\":\"Ikuti informasi terbaru dari Desa Martopuro, mulai dari pelayanan publik, kegiatan warga, UMKM, kesehatan, pendidikan, hingga agenda desa.\",\"viewAllHref\":\"/news\",\"viewAllLabel\":\"Lihat Semua\"}','{\"text\":\"\",\"copyright\":\"\"}','[]','{\"email\":\"team.sencra@gmail.com\",\"youtube\":\"\",\"facebook\":\"\",\"whatsapp\":\"https://wa.me/6289563836\",\"instagram\":\"https://instagram.com/martopuroculturefest\",\"tiktok\":\"\"}','2026-05-12 09:09:02','2026-05-31 03:41:05',NULL);
/*!40000 ALTER TABLE `tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_roles_user` (`user_id`),
  KEY `idx_user_roles_role` (`role_id`),
  KEY `idx_user_roles_tenant` (`tenant_id`),
  KEY `idx_user_roles_user_tenant` (`user_id`,`tenant_id`),
  KEY `fk_user_roles_assigned_by` (`assigned_by`),
  CONSTRAINT `fk_user_roles_assigned_by` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_roles_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES ('289529c0-7610-44b1-8a27-dc6fee275192','4902b8e3-5381-4ce4-9856-582008b7aa20','32a4be24-4de4-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'2026-05-13 02:10:14',NULL),('32b514dd-4de4-11f1-a9c1-44a3bb6ab520','32b21afe-4de4-11f1-a9c1-44a3bb6ab520','32a48a5b-4de4-11f1-a9c1-44a3bb6ab520',NULL,NULL,'2026-05-12 09:23:12',NULL),('80c412c4-1584-4f9d-a3ef-07fd1219483a','3370aa46-0450-4ed3-9998-af956e7d721f','32a4be24-4de4-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'2026-05-13 02:20:02',NULL);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','suspended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `email_verified_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `idx_users_status` (`status`),
  CONSTRAINT `users_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('32b21afe-4de4-11f1-a9c1-44a3bb6ab520','Super Admin','superadmin@obayan.id','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',NULL,NULL,'active','2026-05-12 16:23:12',NULL,NULL,'2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('3370aa46-0450-4ed3-9998-af956e7d721f','User Martopuro','user@martopuro.com','$2b$10$SpDan018aCxyxgD2l56BVOVU/S4Tn6bWVWbwD7PikaV0T0pufn3Pa',NULL,NULL,'active',NULL,NULL,NULL,'2026-05-13 02:20:02','2026-05-13 02:20:02',NULL),('4902b8e3-5381-4ce4-9856-582008b7aa20','Admin martopuro','admin@martopuro.com','$2b$10$qXWvlbMMkuuqxoQgkY2RKuS4U8wEkIaHf9HVtwIU2vHbz3msdoGfq',NULL,NULL,'active',NULL,'2026-05-24 11:04:01',NULL,'2026-05-13 02:10:14','2026-05-24 11:04:01',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `village_budget_lines`
--

DROP TABLE IF EXISTS `village_budget_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `village_budget_lines` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_type` enum('revenue','expense','financing') COLLATE utf8mb4_unicode_ci NOT NULL,
  `line_group` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_code` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(220) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budget_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `realized_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `unit` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_village_budget_line_period_slug` (`budget_period_id`,`slug`),
  KEY `idx_village_budget_lines_type_status` (`budget_period_id`,`line_type`,`status`,`sort_order`),
  KEY `idx_village_budget_lines_parent` (`parent_id`),
  CONSTRAINT `fk_village_budget_lines_parent` FOREIGN KEY (`parent_id`) REFERENCES `village_budget_lines` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_village_budget_lines_period` FOREIGN KEY (`budget_period_id`) REFERENCES `village_budget_periods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `village_budget_lines_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `village_budget_lines`
--

LOCK TABLES `village_budget_lines` WRITE;
/*!40000 ALTER TABLE `village_budget_lines` DISABLE KEYS */;
INSERT INTO `village_budget_lines` VALUES ('35f4751c-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'revenue','Pendapatan per Sumber','PADESA-LAIN','Lain-Lain PADesa','lain-lain-padesa','Pendapatan asli desa dari lain-lain PADesa.',65000000.00,0.00,'rupiah','solar:wallet-money-bold-duotone','#2563EB','{\"source\": \"seed\", \"displayBudget\": \"Rp 65.000.000\"}','active',1,1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f48bd4-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'revenue','Pendapatan per Sumber','DD','Dana Desa','dana-desa','Pendapatan transfer Dana Desa.',1656078000.00,0.00,'rupiah','solar:banknote-bold-duotone','#2563EB','{\"source\": \"seed\", \"displayBudget\": \"Rp 1.656.078.000\"}','active',1,2,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f49085-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'revenue','Pendapatan per Sumber','BHP-RETRIBUSI','Bagi Hasil Pajak & Retribusi','bagi-hasil-pajak-retribusi','Pendapatan bagi hasil pajak dan retribusi.',254416000.00,0.00,'rupiah','solar:bill-list-bold-duotone','#2563EB','{\"source\": \"seed\", \"displayBudget\": \"Rp 254.416.000\"}','active',1,3,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f49360-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'revenue','Pendapatan per Sumber','ADD','Alokasi Dana Desa (ADD)','alokasi-dana-desa-add','Pendapatan dari Alokasi Dana Desa.',442958000.00,0.00,'rupiah','solar:buildings-3-bold-duotone','#2563EB','{\"source\": \"seed\", \"displayBudget\": \"Rp 442.958.000\"}','active',1,4,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f49679-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'revenue','Pendapatan per Sumber','BANKABKOTA','Bantuan Keuangan Kab/Kota','bantuan-keuangan-kab-kota','Bantuan keuangan dari kabupaten atau kota.',366000000.00,0.00,'rupiah','solar:hand-money-bold-duotone','#2563EB','{\"source\": \"seed\", \"displayBudget\": \"Rp 366.000.000\"}','active',1,5,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f499a5-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'expense','Belanja per Bidang','01','Penyelenggaraan Pemerintahan Desa','penyelenggaraan-pemerintahan-desa','Belanja bidang penyelenggaraan pemerintahan desa.',1159164470.00,0.00,'rupiah','solar:buildings-bold-duotone','#0EA5E9','{\"source\": \"seed\", \"displayBudget\": \"Rp 1.159.164.470\"}','active',1,1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f49c3f-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'expense','Belanja per Bidang','02','Pelaksanaan Pembangunan Desa','pelaksanaan-pembangunan-desa','Belanja bidang pelaksanaan pembangunan desa.',1286368100.00,0.00,'rupiah','solar:home-2-bold-duotone','#0EA5E9','{\"source\": \"seed\", \"displayBudget\": \"Rp 1.286.368.100\"}','active',1,2,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f49eea-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'expense','Belanja per Bidang','03','Pembinaan Kemasyarakatan Desa','pembinaan-kemasyarakatan-desa','Belanja bidang pembinaan kemasyarakatan desa.',136430000.00,0.00,'rupiah','solar:users-group-rounded-bold-duotone','#0EA5E9','{\"source\": \"seed\", \"displayBudget\": \"Rp 136.430.000\"}','active',1,3,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f4a19a-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'expense','Belanja per Bidang','04','Pemberdayaan Masyarakat Desa','pemberdayaan-masyarakat-desa','Belanja bidang pemberdayaan masyarakat desa.',90055500.00,0.00,'rupiah','solar:hand-heart-bold-duotone','#0EA5E9','{\"source\": \"seed\", \"displayBudget\": \"Rp 90.055.500\"}','active',1,4,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f4a42b-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'expense','Belanja per Bidang','05','Penanggulangan Bencana/Darurat','penanggulangan-bencana-darurat','Belanja bidang penanggulangan bencana, keadaan darurat, dan mendesak desa.',150900000.00,0.00,'rupiah','solar:shield-warning-bold-duotone','#0EA5E9','{\"source\": \"seed\", \"displayBudget\": \"Rp 150.900.000\"}','active',1,5,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL),('35f4a6c6-4f85-11f1-ab3a-40c2ba92d539','35f0acc1-4f85-11f1-ab3a-40c2ba92d539',NULL,'financing','Pembiayaan','FINANCING','Pembiayaan Desa','pembiayaan-desa','Pembiayaan desa tahun berjalan.',38466070.00,0.00,'rupiah','solar:pie-chart-2-bold-duotone','#64748B','{\"source\": \"seed\", \"displayBudget\": \"Rp 38.466.070\"}','active',1,1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL);
/*!40000 ALTER TABLE `village_budget_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `village_budget_periods`
--

DROP TABLE IF EXISTS `village_budget_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `village_budget_periods` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_year` year NOT NULL,
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_code` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'IDR',
  `legal_basis` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `is_current` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_village_budget_period_tenant_year` (`tenant_id`,`budget_year`),
  KEY `idx_village_budget_period_current` (`tenant_id`,`is_current`,`status`),
  CONSTRAINT `fk_village_budget_periods_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `village_budget_periods_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `village_budget_periods`
--

LOCK TABLES `village_budget_periods` WRITE;
/*!40000 ALTER TABLE `village_budget_periods` DISABLE KEYS */;
INSERT INTO `village_budget_periods` VALUES ('35f0acc1-4f85-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',2026,'APBDes 2026','Realisasi dibandingkan anggaran','IDR',NULL,'APBDes Desa',NULL,'Data dapat disesuaikan dengan sumber resmi desa atau API APBDes agar masyarakat mendapat informasi terbaru.','{\"ui\": {\"tabs\": [\"Ringkas\", \"Pendapatan\", \"Belanja\"], \"variant\": \"summary-finance\"}, \"source\": \"seed\", \"tenant\": \"martopuro\"}','published',1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL);
/*!40000 ALTER TABLE `village_budget_periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `village_officials`
--

DROP TABLE IF EXISTS `village_officials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `village_officials` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_code` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `photo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_status` enum('present','away','leave','inactive','unknown') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `attendance_label` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_village_officials_tenant_slug` (`tenant_id`,`slug`),
  KEY `idx_village_officials_tenant_status` (`tenant_id`,`status`,`sort_order`),
  KEY `idx_village_officials_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  CONSTRAINT `fk_village_officials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `village_officials_chk_1` CHECK (json_valid(`content_json`)),
  CONSTRAINT `village_officials_chk_2` CHECK (json_valid(`social_config`)),
  CONSTRAINT `village_officials_chk_3` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `village_officials`
--

LOCK TABLES `village_officials` WRITE;
/*!40000 ALTER TABLE `village_officials` DISABLE KEYS */;
INSERT INTO `village_officials` VALUES ('35eeec22-4f85-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Rianto','rianto','Kepala Desa','kepala-desa','Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan, dan pemberdayaan warga.','<p>Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.\", \"type\": \"text\"}]}]}',NULL,'solar:user-rounded-bold-duotone',NULL,NULL,NULL,'present','Hadir',NULL,NULL,'{}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,1,'2026-05-14 11:08:17','2026-05-14 11:08:17',NULL);
/*!40000 ALTER TABLE `village_officials` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-17 16:29:24
