-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2026 at 08:40 AM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u854039322_arsades_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `category_id` char(36) DEFAULT NULL,
  `title` varchar(190) NOT NULL,
  `slug` varchar(220) NOT NULL,
  `description_card` text DEFAULT NULL,
  `description_content` longtext DEFAULT NULL,
  `cover_url` varchar(700) DEFAULT NULL,
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'draft',
  `read_time` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `tenant_id`, `category_id`, `title`, `slug`, `description_card`, `description_content`, `cover_url`, `status`, `read_time`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('00124a2b-cd8c-5c07-a9b0-802a23f37540', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Progres pavingisasi barat lapangan Desa Martopuro', 'progres-pavingisasi-barat-lapangan-desa-martopuro', 'Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.', '<p>Progres pavingisasi barat Lapangan Desa Martopuro sebagai bagian dari pembangunan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-23 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('00663ec6-efdb-5deb-ab2a-890e9b41b300', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.', 'pembangunan-tpt-jembatan-dusun-klojen-desa-martopuro', 'Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.', '<p>Pembangunan TPT jembatan Dusun Klojen Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0202d245-a266-545f-9162-d6eea1ab2925', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Posbindu Kartini 4 Desa Martopuro.', 'giat-posbindu-kartini-4-desa-martopuro', 'Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.', '<p>Kegiatan Posbindu Kartini 4 Desa Martopuro sebagai layanan kesehatan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('020bab30-db2f-4388-aee3-a8a74d015634', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.', 'penyaluran-blt-dana-desa-tahun-2025-bulan-november-desember-mpus3ypx-1a530d25', 'Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.', '<p>Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292367/martopuro/news/covers/sedang-1765168395-597101887-1215529283789317-8313923142876361726-n_wkk2f5.webp', 'published', 1, '2026-06-01 12:39:28', '2026-06-01 05:39:31', '2026-06-01 05:39:31', NULL),
('027f21be-9112-5401-a8b7-f4138b7c972e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Khotmil Qur\'an Jum\'at Legi Kantor Desa Martopuro Bulan Agustus 2025', 'giat-khotmil-quran-jumat-legi-kantor-desa-martopuro-bulan-agustus-2025', 'Kegiatan Khotmil Qur\'an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.', '<p>Kegiatan Khotmil Qur&#x27;an Jumat Legi Kantor Desa Martopuro bulan Agustus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('030ca3a3-ae2d-43d6-b218-e67932a17cdb', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Kades Martopuro Menjawab dengan Lounching Website Resmi Desa', 'kades-martopuro-menjawab-dengan-lounching-website-resmi-desa-mpuo0l9y-4aaeadd3', 'Kades Martopuro Bpk. Rianto, mencoba meluncurkan inovasi untuk menjawab kritik dan saran masyarakat dengan informasi yang akan disampaikan melalu website resmi sekaligus transparansi kegiata desa dengan update informasi prestasi dan bukti nyata perubahan pembangunan yang telah dicapai, sehingga masyarakat bisa mengetahui perkembangan dan kemajuan desa sampai detik ini.', '<p>Kades Martopuro Bpk. Rianto, mencoba meluncurkan inovasi untuk menjawab kritik dan saran masyarakat dengan informasi yang akan disampaikan melalu website resmi sekaligus transparansi kegiata desa dengan update informasi prestasi dan bukti nyata perubahan pembangunan yang telah dicapai, sehingga masyarakat bisa mengetahui perkembangan dan kemajuan desa sampai detik ini.</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285488/richtext/images/sedang-1744553816-ketua-terpilih3a_gpz3o4.webp\" alt=\"sedang_1744553816_Ketua_Terpilih3a.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285490/martopuro/news/covers/sedang-1744553891-a_jrkgsi.webp', 'published', 1, '2026-06-01 10:44:52', '2026-06-01 03:44:55', '2026-06-01 03:44:55', NULL),
('037e60f1-d579-5c99-955f-eb8ef6fa50c5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'a3218aa8-f025-5b89-b870-d100001f417b', 'APBDes Desa Martopuro 2025', 'apbdes-desa-martopuro-2025', 'Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.', '<p>Informasi Anggaran Pendapatan dan Belanja Desa Martopuro Kecamatan Purwosari tahun anggaran 2025.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-14 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('058b0705-9d56-440e-a9fd-dd97a4f3ba74', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.', 'giat-pengukuran-dimensi-dan-titik-gawang-lapangan-panutan-desa-martopuro-mpuscg9s-51cdca16', 'Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.', '<p>Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292763/martopuro/news/covers/sedang-1770517837-598942890-1219843470024565-1561027264858960530-n_fnzcuy.webp', 'published', 1, '2026-06-01 12:46:04', '2026-06-01 05:46:07', '2026-06-01 05:46:07', NULL),
('06122912-1963-43b7-815c-7c97b52faf3c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Desa Martopuro Juara 2 lomba Samroh TP PKK Kecamatan Purwosari', 'desa-martopuro-juara-2-lomba-samroh-tp-pkk-kecamatan-purwosari-mpuqp52f-bd5bc4c1', 'Alhamdulillah Desa Martopuro Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari', '<p>Alhamdulillah Desa Martopuro Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780289996/martopuro/news/covers/sedang-1754040642-525794623-1113376360671277-6419983586028980672-n-1_xexa51.webp', 'published', 1, '2026-06-01 11:59:56', '2026-06-01 05:00:00', '2026-06-01 05:00:00', NULL),
('06310a4b-a9a2-4262-b974-b6a2bf1f2de9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sukses mengadakan Donor Darah Sebelum Bulan Puasa, Agenda Rutin 3bulan sekali Karang Taruna Permata Karya Desa Martopuro', 'sukses-mengadakan-donor-darah-sebelum-bulan-puasa-agenda-rutin-3bulan-sekali-karang-taruna-permata-karya-desa-martopuro-mpusho0i-df10ab6d', 'Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang datangnya bulan suci Ramadan.', '<p>Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang datangnya bulan suci Ramadan. Kegiatan ini merupakan agenda rutin yang dilaksanakan setiap tiga bulan sekali sebagai bentuk kepedulian sosial dan kontribusi nyata kepada masyarakat.</p><p>Sebelumnya, kegiatan donor darah rutin dilaksanakan di Gedung Karwo yang berlokasi dekat Pasar Purwosari. Namun, karena saat ini gedung tersebut digunakan sebagai Gedung MBG, lokasi pelaksanaan donor darah kali ini dipindahkan ke Balai Desa Martopuro.</p><p>Kegiatan donor darah ini dilaksanakan pada hari Minggu, 08 Februari 2026, bertempat di Balai Desa Martopuro. Meskipun terjadi perpindahan lokasi, antusiasme masyarakat tetap tinggi. Warga dari berbagai kalangan dengan sukarela hadir dan berpartisipasi dalam kegiatan ini.</p><p>Selain bertujuan untuk membantu ketersediaan stok darah bagi yang membutuhkan, kegiatan donor darah juga menjadi sarana untuk menjaga kesehatan tubuh. Terlebih menjelang bulan puasa, donor darah menjadi momentum yang tepat untuk berbagi kebaikan dan meraih pahala.</p><p>Karang Taruna Permata Karya berharap kegiatan ini dapat terus berjalan secara berkelanjutan dan semakin meningkatkan kesadaran masyarakat akan pentingnya donor darah. Semangat gotong royong dan kepedulian sosial yang ditunjukkan dalam kegiatan ini menjadi bukti bahwa solidaritas masyarakat Desa Martopuro tetap terjaga dengan baik.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293006/martopuro/news/covers/sedang-1770515672-whatsapp-image-2026-02-08-at-08-38-56_dapaoo.webp', 'published', 1, '2026-06-01 12:50:07', '2026-06-01 05:50:11', '2026-06-01 05:50:11', NULL),
('0688f468-777f-41ba-b8a5-a07ab6d8fed1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Monev Giat Dana Desa Semester 1 Desa Martopuro', 'monev-giat-dana-desa-semester-1-desa-martopuro-mpuos6f0-f07c7433', 'Monev Giat Dana Desa Semester 1 Desa Martopuro', '<p>Monev Giat Dana Desa Semester 1 Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286778/martopuro/news/covers/sedang-1749737163-501068814-1071082068234040-8986992202863610128-n_rua0uh.webp', 'published', 1, '2026-06-01 11:06:19', '2026-06-01 04:06:22', '2026-06-01 04:06:22', NULL),
('0746ae12-f1da-4333-b821-8c0f8ca7e73b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Camat Purwosari Munif Triatmoko, Secara Resmi Membuka \"Martopuro Cup 2025\"', 'camat-purwosari-munif-triatmoko-secara-resmi-membuka-martopuro-cup-2025-mpurci10-ef996902', 'Pasuruan - Dalam rangka memperingati Hari Ulang Tahun (HUT) Republik Indonesia ke-80, Pemerintah Desa (Pemdes) dan Karang Taruna (Kartar) Permata Karya Desa Martopuro', '<p><strong>Pasuruan</strong>&nbsp;- Dalam rangka memperingati Hari Ulang Tahun (HUT) Republik Indonesia ke-80, Pemerintah Desa (Pemdes) dan Karang Taruna (Kartar) Permata Karya Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan, menggelar turnamen bola voli, yang di buka secara resmi oleh Camat Purwosari. Minggu (7/9/2025) malam.</p><p>&nbsp;</p><p>Tutut hadir dalam kegiatan tersebut, Camat Purwosari Munif Triatmoko, Iptu Yusuf Kapolsek Purwosari, Danramil 0819/21 Purwosari Mukrab, Kepala Desa (Kades) Martopuro Rianto, Ketua BPD Martopuro, Ketua Karang Taruna (Kartar) Tunas Muda Martopuro,&nbsp;</p><p>&nbsp;</p><p>Acara Turnamen Martopuro Cup 2025 dibuka secara resmi oleh Camat Purwosari Munif Triatmoko, dihadapan panitia dan warga Martopuro yang hadir di Lapangan Bola Voly Dusun Pakem menyampaikan, bahwa kegiatan ini digelar dalam rangka memperingati Hari Ulang Tahun (HUT) Kemerdekaan Republik Indonesia Ke 80 sekaligus juga peringati hari jadi kabupaten Pasuruan.</p><p>&nbsp;</p><p>\"Dengan adanya kegiatan Turnamen Martopuro Cup 2025 ini, Desa Martopuro dapat melahirkan atlet bibit-bibit voly yang baik dan handal yang nantinya bisa membawa nama baik desa dan kecamatan lebih-lebih Kabupaten Pasuruan. Pada malam ini Turnamen Bola Voly \"Martopuro Cup 2025\" secara resmi saya buka,\" merdeka selamat bertanding dan jaga Sportivitas,\" ucap Camat Purwosari.</p><p>&nbsp;</p><p>Sementara, menurut Kades Martopuro Rianto, menyampaikan terima kasih kepada masyarakat Martopuro, khususnya Dusun Pakem, yang telah mendukung terselenggaranya kegiatan ini. Turnamen Martopuro Cup 2025 ini, juga bertujuan untuk meningkatkan kesadaran masyarakat akan pentingnya olahraga.</p><p>&nbsp;</p><p>Dari kegiatan ini diharapkan dapat mengurangi kegiatan negatif dan meningkatkan kegiatan positif di kalangan masyarakat, lebih-lebih patisipasi masyarakat terhadap agenda kegiatan yang diselenggarakan oleh pemdes. Dengan adanya turnamen ini, masyarakat Martopuro dapat semakin rukun dan tujuan kegiatan dapat diridhoi Allah SWT</p><p>&nbsp;</p><p>\"Saya berharap, acara turnamen Martopuro Cup 2025 yang diselenggarakan oleh panitia yang dimulai malam ini hingga final nanti berjalan dengan aman dan kondusif, panitia, para pemain selama pertandingan diberi kesehatan,\" sampainya.</p><p>&nbsp;</p><p>Disisi lain, Ketua Kartar Permata Karya Desa Martopuro, Doddy Teguh R , kepada awak media mengatakan, bahwasanya kegiatan Martopuro Cup telah menjadi agenda rutin tahunan.&nbsp;</p><p>&nbsp;</p><p>Untuk kegiatan Turnamen Martopuro Cup 2025, diikuti 32 tim dari wilayah Kabupaten Pasuruan, sebagai awal pembuka laga, ada tim dari perangkat desa melawan panitia.&nbsp;</p><p>&nbsp;</p><p>\"kepada semua tim yang mengikuti turnamen, saya berharap junjung tinggi sportivitas dalam bermain, untuk para suporter kondusifitas, keamanan kita jaga bersama demi suksesnya turnamen Martopuro Cup 2025,\" pungkasnya. (Son/Red)</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291086/martopuro/news/covers/sedang-1757312338-whatsapp-image-2025-09-07-at-19-51-42_tonrdl.webp', 'published', 2, '2026-06-01 12:18:06', '2026-06-01 05:18:10', '2026-06-01 05:18:10', NULL),
('086e5012-1bce-5e52-8e64-b1dadc98f553', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro', 'penyaluran-bantuan-langsung-tunai-triwulan-i-tahun-2025-desa-martopuro', 'Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.', '<p>Penyaluran Bantuan Langsung Tunai triwulan I tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-12.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-12 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0aa19503-fb6a-434c-b002-873032bcae51', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penanaman Pohon Desa Martopuro', 'penanaman-pohon-desa-martopuro-mpusk2f5-0f29ae66', 'Penanaman Pohon Desa Martopuro', '<p>Penanaman Pohon Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293118/martopuro/news/covers/sedang-1773291336-642817324-1277476417594603-5836596434457585062-n_z4av2n.webp', 'published', 1, '2026-06-01 12:51:59', '2026-06-01 05:52:02', '2026-06-01 05:52:02', NULL),
('0b3e53f9-c8a2-50b5-9846-8639df57da24', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penanaman Pohon Desa Martopuro', 'penanaman-pohon-desa-martopuro', 'Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.', '<p>Kegiatan penanaman pohon di Desa Martopuro sebagai bentuk kepedulian terhadap lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-27.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-27 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0be41b32-d04a-4b97-ac59-4385697d1057', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.', 'musdes-penetapan-kpm-blt-dd-tahun-2026-desa-martopuro-mpus2j1l-226ec0ad', 'Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.', '<p>Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292300/martopuro/news/covers/sedang-1765168209-597322522-1215533750455537-2182493619200393028-n_gdgto2.webp', 'published', 1, '2026-06-01 12:38:21', '2026-06-01 05:38:24', '2026-06-01 05:38:24', NULL),
('0d88cc0f-991a-5abd-b92a-b87fba44bf44', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.', 'pemasangan-speed-bump-jalan-dusun-klojen-desa-martopuro', 'Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.', '<p>Pemasangan speed bump jalan Dusun Klojen Desa Martopuro untuk keamanan pengguna jalan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0de3d276-823d-583f-99c9-238dd1192685', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.', 'musyawarah-desa-khusus-pak-apbdes-2026-desa-martopuro', 'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.', '<p>Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro membahas penyesuaian anggaran desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-02-12.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-12 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0e1ac83c-6448-5299-ad51-0f738729c829', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '0dc3abf2-de70-5cef-b90c-c6872b5f8816', 'Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro', 'bumdes-berupaya-untuk-optimal-dalam-program-ketahanan-pangan-desa-martopuro', 'BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.', '<p>BUMDes Martopuro berupaya mengoptimalkan program ketahanan pangan desa.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-10-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0e470769-7ccd-49b5-9b2e-504c65501484', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.', 'plesterisasi-belakang-kios-desa-martopuro-timur-pasar-mpup5l0i-52901007', 'Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.', '<p>Proses Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287397/richtext/images/sedang-1750046294-506934431-1078939914114922-7443276901192023024-n_kp0wjo.webp\" alt=\"sedang_1750046294_506934431_1078939914114922_7443276901192023024_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287403/martopuro/news/covers/sedang-1750046294-506730856-1078941400781440-8214030370609489988-n_nogqdh.webp', 'published', 1, '2026-06-01 11:16:44', '2026-06-01 04:16:48', '2026-06-01 04:16:48', NULL),
('0f5169fe-c105-5392-9ce6-eb8bce734ce9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro', 'rapat-koordinasi-rutin-tiap-senin-pemdes-martopuro', 'Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.', '<p>Rapat koordinasi rutin setiap Senin Pemerintah Desa Martopuro untuk mengevaluasi dan menyiapkan agenda kerja.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-17.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-17 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Gedung Sudah Jadi, Mobil Operasional Segera Datang, Koperasi Desa Martopuro Siap Ubah Nasib Warga', 'gedung-sudah-jadi-mobil-operasional-segera-datang-koperasi-desa-martopuro-siap-ubah-nasib-warga', 'Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.', '<p>Gedung KDMP telah berdiri dan mobil operasional segera hadir sebagai langkah penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780202915/martopuro/news/covers/sedang-1778211629-foto_sqgqal.webp', 'published', 1, '2026-05-08 23:00:00', '2026-05-21 01:30:02', '2026-05-31 04:48:40', NULL),
('1200c374-aa7b-5f70-966a-6f94b09c9f1b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Mengikuti Pelatihan Manajemen Data Kampung Keluarga Berencana.', 'mengikuti-pelatihan-manajemen-data-kampung-keluarga-berencana', 'Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.', '<p>Pemerintah Desa Martopuro mengikuti pelatihan manajemen data Kampung Keluarga Berencana.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-28.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-28 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('122a034f-a3e0-407b-9646-8124da939ebe', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Donor Darah Rutin diadakan 3bulan sekali Bersama Karangtaruna Permata Karya Martopuro', 'donor-darah-rutin-diadakan-3bulan-sekali-bersama-karangtaruna-permata-karya-martopuro-mpuoqxvd-8e10543b', 'Alhamdulillah kami selaku karangtaruna permata karya desa martopuro mengucapkan terimakasih kepada PMI yang senantiasa respon', '<p>Alhamdulillah kami selaku karangtaruna permata karya desa martopuro mengucapkan terimakasih kepada PMI yang senantiasa respon terhadap pengajuan kami mengajak kalaborasi untuk bisa rutin mengadakan kegiatan donor darah di wilayah martopuro , sekali lagi terimakasih kepada PMI dan sekaligus ucapan terimakasih kepada semua yang mensupport kegiatan ini sehingga bisa berjalan rutin setiap 3 bulan sekali, semoga niat kita pengorbanan kita melalui kegiatan ini bisa menjadi ladang amal untuk kita dan insyaAllah akan dibalas dengan kebaikan kebaikan yang tidak kita duga. Aamiin</p><p>Kegiatan donor darah ini kenapa menjadi agenda yang rutin kami agendakan, sebab permintaan dari masyarakat cukup tinggi dan mengapreasi kegiatan tersebut, sehingga kegiatan donor darah ini kami adakan semoga bisa rutin seterusnya.</p><p>dan hari ini tanggal 18 mei 2025 dimulai kembali setelah libur Ramadhan / Hari Raya Idul Fitri.<br><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286718/richtext/images/sedang-1747536374-8b2ab423-4878-45e5-8bc6-53b1f7b35b34_jd1dgn.webp\" alt=\"sedang_1747536374_8b2ab423-4878-45e5-8bc6-53b1f7b35b34.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286720/martopuro/news/covers/sedang-1747536374-1_cgrzkx.webp', 'published', 1, '2026-06-01 11:05:21', '2026-06-01 04:05:25', '2026-06-01 04:05:25', NULL),
('12e93598-3a78-591f-a50a-1722d6fa50f8', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.', 'serah-terima-aset-koperasi-desa-merah-putih-kdmp-ke-pemdes-martopuro', 'Serah terima aset Koperasi Desa Merah Putih (KDMP) kepada Pemerintah Desa Martopuro.', '<p>Serah Terima Aset Koperasi Desa Merah Putih ( KDMP )</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780282973/richtext/images/sedang-1779155776-700708427-1339943934681184-2371708735377060474-n_um6ybz.webp\" alt=\"sedang_1779155776_700708427_1339943934681184_2371708735377060474_n.jpg\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780282984/richtext/images/sedang-1779155776-702764615-1339943768014534-3013305737483254325-n_fwswyc.webp\" alt=\"sedang_1779155776_702764615_1339943768014534_3013305737483254325_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1779615698/martopuro/news/covers/sedang-1779155776-700506355-1339943901347854-3727692882221577314-n_cy8igj.webp', 'published', 1, '2026-06-01 10:10:10', '2026-05-21 01:30:02', '2026-06-01 03:10:13', NULL),
('1374e553-0b7a-4d8f-a799-56fe0a66fa5b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.', 'pengecatan-mushola-hubbul-wathon-kantor-desa-martopuro-mpuprbpm-5594ab31', 'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.', '<p>Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288418/martopuro/news/covers/sedang-1753152757-520214071-1105662908109289-3211706935198340304-n_fpedg1.webp', 'published', 1, '2026-06-01 11:33:39', '2026-06-01 04:33:42', '2026-06-01 04:33:42', NULL),
('14ac0d2b-754c-536c-99cf-15cc577f0e4e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.', 'musyawarah-desa-penyusunan-rencana-kerja-pembangunan-desa-martopuro-2026', 'Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.', '<p>Musyawarah desa penyusunan RKP Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('16e2a5a9-8086-4a57-8a76-6b08cd10769d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Kerja Bakti Lingkungan Desa Martopuro', 'kerja-bakti-lingkungan-desa-martopuro-mpung6s5-05aedb73', 'Seluruh warga Kerja Bakti di Lingkungan masing masing dusun di Desa Martopuro', '<p>Seluruh warga Kerja Bakti di Lingkungan masing masing dusun di Desa Martopuro</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284534/richtext/images/sedang-1744696822-481102429-998145255527722-8208278499161567684-n_corvi5.webp\" alt=\"sedang_1744696822_481102429_998145255527722_8208278499161567684_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284539/martopuro/news/covers/sedang-1744696822-480357167-998144465527801-5364264892768198190-n_fy2nhc.webp', 'published', 1, '2026-06-01 10:29:00', '2026-06-01 03:29:03', '2026-06-01 03:29:03', NULL),
('1a44dc93-7a2d-5c4b-a91f-59b24b558625', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Monev Giat Dana Desa Semester 1 Desa Martopuro', 'monev-giat-dana-desa-semester-1-desa-martopuro', 'Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.', '<p>Monitoring dan evaluasi kegiatan Dana Desa semester 1 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-05.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-05 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Apel Peringatan Hari Desa Nasional Desa Martopuro.', 'apel-peringatan-hari-desa-nasional-desa-martopuro', 'Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.', '<p>Apel Peringatan Hari Desa Nasional Desa Martopuro diikuti perangkat desa dan lembaga desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-23.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-23 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Rembug Stunting Desa Martopuro 2025.', 'giat-rembug-stunting-desa-martopuro-2025', 'Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.', '<p>Rembug stunting Desa Martopuro tahun 2025 sebagai forum koordinasi pencegahan dan penanganan stunting.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('1de35778-7c09-4d4b-9ddb-3129cb9f85c9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'APBDes Desa Martopuro 2025', 'apbdes-desa-martopuro-2025-mpuo9jq2-fc8c7443', 'Anggaran Pendapatan & Belanja Desa (APBDes) Desa Martopuro Kecamatan Purwosari Tahun Anggaran 2025', '<p>Anggaran Pendapatan &amp; Belanja Desa (APBDes) Desa Martopuro Kecamatan Purwosari Tahun Anggaran 2025</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285897/richtext/images/cuplikan-layar-2026-06-01-105016_w41gq3.webp\" alt=\"Cuplikan layar 2026-06-01 105016.png\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285907/richtext/images/cuplikan-layar-2026-06-01-105050_smpqle.webp\" alt=\"Cuplikan layar 2026-06-01 105050.png\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285909/martopuro/news/covers/sedang-1744590191-22b44ca5-8994-4d51-a193-f3f029f518aa_ixj6dc.webp', 'published', 1, '2026-06-01 10:51:50', '2026-06-01 03:51:54', '2026-06-01 03:51:54', NULL),
('22712218-926b-48bf-ac6c-f25402df5309', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.', 'lomba-tumpeng-tp-pkk-desa-martopuro-peringatan-17-agustus-2025-di-pendopo-kecpurwosari-mpur3bfz-0c28c3f7', 'Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.', '<p>Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290654/richtext/images/sedang-1755828844-536272717-1128858212456425-6226277653469695151-n_wnafwa.webp\" alt=\"sedang_1755828844_536272717_1128858212456425_6226277653469695151_n.jpg\"><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290657/martopuro/news/covers/sedang-1755828844-536275027-1128858165789763-646067462744295419-n_m3y6an.webp', 'published', 1, '2026-06-01 12:10:58', '2026-06-01 05:11:01', '2026-06-01 05:11:01', NULL),
('235958bb-f030-4537-a8c6-fc549b8019bc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan', 'santunan-dhuafa-oleh-ibu-bupati-pasuruan-di-desa-martopuro-dan-pengajian-rutin-tp-pkk-kab-pasuruan-mpurmfmh-116b5575', 'Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. PasuruanSantunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan', '<p>Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. PasuruanSantunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291549/martopuro/news/covers/sedang-1764728373-561886636-1174258907916355-4338103756789973754-n_pofk3o.webp', 'published', 1, '2026-06-01 12:25:50', '2026-06-01 05:25:53', '2026-06-01 05:25:53', NULL),
('2432d3ab-2ca7-42cd-a482-cb3eb7524a66', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Buka Bersama Keluarga Besar Pemdes Martopuro.', 'buka-bersama-keluarga-besar-pemdes-martopuro-mpuskvfz-5acc486e', 'Buka Bersama Keluarga Besar Pemdes Martopuro.', '<p>Buka Bersama Keluarga Besar Pemdes Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293156/martopuro/news/covers/sedang-1773291162-644416459-1279024764106435-985483426028320464-n_gksluk.webp', 'published', 1, '2026-06-01 12:52:36', '2026-06-01 05:52:40', '2026-06-01 05:52:40', NULL),
('278b6e8c-47e0-4217-96fb-70a391fd8307', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Louncing Ketahanan Pangan Bumdes\" Karya Usaha Mandiri\" Desa Martopuro.', 'louncing-ketahanan-pangan-bumdes-karya-usaha-mandiri-desa-martopuro-mpuqtlhm-2bef1667', 'Louncing Ketahanan Pangan Bumdes\" Karya Usaha Mandiri\" Desa Martopuro.', '<p>Louncing Ketahanan Pangan Bumdes\" Karya Usaha Mandiri\" Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290204/martopuro/news/covers/sedang-1754462217-528027617-1117298080279105-5831565985277532206-n_xfhcbq.webp', 'published', 1, '2026-06-01 12:03:24', '2026-06-01 05:03:28', '2026-06-01 05:03:28', NULL),
('27efc7fe-a3de-5fd9-b18b-339c8ced838f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Keseriusan Pemerintah Desa Martopuro di Bawah Kepemimpinan Kepala Desa Rianto: Satu Tahun Kerja, Satu Tahun Bukti', 'keseriusan-pemerintah-desa-martopuro-di-bawah-kepemimpinan-kepala-desa-rianto-satu-tahun-kerja-satu-tahun-bukti', 'Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.', '<p>Pemerintah Desa Martopuro menunjukkan komitmen menghadirkan perubahan dalam satu tahun kerja di bawah kepemimpinan Kepala Desa Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('28b53495-85c2-4a29-a7b1-38a9146b05cc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pemerintah Desa Martopuro BerQur\'ban', 'pemerintah-desa-martopuro-berqurban-mpuotr8w-f05b37fe', 'Penyembelihan dan pendistribusian hewan kurban Pemerintah desa martopuro', '<p>Penyembelihan dan pendistribusian hewan kurban Pemerintah desa martopuro&nbsp;</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286848/richtext/images/sedang-1749737269-503360198-1071678328174414-5431468107349260-n_bgxsrk.webp\" alt=\"sedang_1749737269_503360198_1071678328174414_5431468107349260_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286852/martopuro/news/covers/sedang-1749737269-504807781-1071678048174442-1517926813812784490-n_din58d.webp', 'published', 1, '2026-06-01 11:07:32', '2026-06-01 04:07:36', '2026-06-01 04:07:36', NULL),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan Gerai KDMP Martopuro.', 'pembangunan-gerai-kdmp-martopuro', 'Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.', '<p>Pembangunan Gerai KDMP Martopuro sebagai sarana penguatan koperasi desa dan ekonomi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Sosialisasi Akuntabilitas Pengelolaan Dana Desa.', 'sosialisasi-akuntabilitas-pengelolaan-dana-desa', 'Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.', '<p>Sosialisasi akuntabilitas pengelolaan dana desa sebagai penguatan tata kelola pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-30 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('2a5d579f-941a-46c2-9287-15adb4eb2751', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro', 'rehab-kantor-hippa-himpunan-petani-pemakai-air-desa-martopuro-mpupfxcg-d28df9ab', 'Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro, semoga berjalan lancar dan bisa dimanfaatkan dan dikelola dengan baik', '<p>Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro, semoga berjalan lancar dan bisa dimanfaatkan dan dikelola dengan baik</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287886/martopuro/news/covers/sedang-1751251779-514030470-1089286549746925-2973816209427470846-n_gnpu75.webp', 'published', 1, '2026-06-01 11:24:47', '2026-06-01 04:24:50', '2026-06-01 04:24:50', NULL),
('2a693bbe-b6d7-4fb8-ae79-a12033e2d3e3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musdes Khusus Desa Martopuro', 'musdes-khusus-desa-martopuro-mpunk10v-78a75369', 'Musyawarah Desa Khusus Perubahan Perdes Bumdes Anggaran Dasar (AD Bumdes)', '<p>Musyawarah Desa Khusus<br>tentang&nbsp;</p><ol><li><p>Perubahan Perdes Bumdes Anggaran Dasar (AD Bumdes)</p></li><li><p>Perdes Penyertaan Modal Bumdes</p></li><li><p>Perdes Pemanfaatan Aset DesaMusyawarah Desa Khusus</p></li></ol><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284716/richtext/images/sedang-1744696721-480770315-999825105359737-8091656753071312503-n_yfe9vl.webp\" alt=\"sedang_1744696721_480770315_999825105359737_8091656753071312503_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284718/martopuro/news/covers/sedang-1744696721-481000489-999825242026390-1521537694035331853-n_jmbjaf.webp', 'published', 1, '2026-06-01 10:31:59', '2026-06-01 03:32:02', '2026-06-01 03:32:02', NULL),
('2ba41ebe-04db-485f-8258-2163848cd3da', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Rehab SPA Kantor Desa Martopuro', 'rehab-spa-kantor-desa-martopuro-mq86tmwv-6d3277c3', 'Rehab SPA Kantor Desa Martopuro', '<p>Rehab SPA Kantor Desa Martopuro</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103833/richtext/images/sedang-1764728519-561325022-1173416008000645-6302788988409644531-n_wj5npt.webp\" alt=\"sedang_1764728519_561325022_1173416008000645_6302788988409644531_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103142/martopuro/news/covers/710755714-1351594813516096-2548734872101372858-n_qxyz3t.webp', 'published', 1, '2026-06-10 22:04:10', '2026-06-10 14:52:26', '2026-06-10 15:04:15', NULL),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Penetapan APBDes Desa Martopuro 2026.', 'musyawarah-penetapan-apbdes-desa-martopuro-2026', 'Musyawarah penetapan APBDes Desa Martopuro tahun 2026.', '<p>Musyawarah penetapan APBDes Desa Martopuro tahun 2026.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('2db2fdd3-52bd-51dc-a579-590db3bd4c21', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Kegiatan Rutin Jumat legi Khataman Qur\'an Pemerintah Desa Martopuro', 'kegiatan-rutin-jumat-legi-khataman-quran-pemerintah-desa-martopuro', 'Khotmil Qur\'an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.', '<p>Khotmil Qur&#x27;an Jumat Legi di Musholla Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-09.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-09 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('2dc65dc5-2352-4053-9cfd-32b649f6efa7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran BLT DD Bulan Januari-April 2026 Desa Martopuro.', 'penyaluran-blt-dd-bulan-januari-april-2026-desa-martopuro-mpusmuyu-44f84d7b', 'PENYERAHAN BANTUAN LANGSUNG TUNAI DANA DESA ( BLT-DD ) TAHUN 2026 KEPADA 22 KPM KELUARGA MISKIN DESA MARTOPURO KEC. PURWOSARI KAB. PASURUAN BULAN: JANUARI, FEBRUARI, MARET & APRIL', '<p>PENYERAHAN BANTUAN LANGSUNG TUNAI DANA DESA ( BLT-DD ) TAHUN 2026 KEPADA 22 KPM KELUARGA MISKIN DESA MARTOPURO KEC. PURWOSARI KAB. PASURUAN BULAN: JANUARI, FEBRUARI, MARET &amp; APRIL</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293249/martopuro/news/covers/sedang-1777519616-674671896-1319825043359740-4196405078834983431-n-1_dsbxt9.webp', 'published', 1, '2026-06-01 12:54:09', '2026-06-01 05:54:13', '2026-06-01 05:54:13', NULL),
('2ffc1f6c-fd0a-46ce-9602-7dd4870bbb56', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sukses mengadakan Pelatihan Pemulasaran Jenazah Desa Martopuro', 'sukses-mengadakan-pelatihan-pemulasaran-jenazah-desa-martopuro-mpuq1200-3db88c35', 'Pemerintah desa martopuro mengadakan Pelatihan Pemulasaran Jenazah, upaya untuk meningkatkan pengetahuan tentang pemulasaran jenazah', '<p>Pemerintah desa martopuro mengadakan Pelatihan Pemulasaran Jenazah, upaya untuk meningkatkan pengetahuan tentang pemulasaran jenazah di wilayah desa martopuro sebagai bentuk menambah wawasan yang dibutuhkan dalam pelayanan ditengah masyarakat khususnya tentang pemulasaran jenazah. pemateri dikhadiri langsung oleh penyuluh KUA Kec.Purwosari Ust. Sulhan Mahmudi beserta tim. semoga apa yang diberikan dalam pelatihan ini bisa memberikan pemahaman yang baik tentang pemulasaran jenazah diwilayah desa martopuro, ucap Bpk.Rianto selaku Kepala Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288872/martopuro/news/covers/sedang-1753155404-522913095-1105681574774089-225806292113472555-n_edllmw.webp', 'published', 1, '2026-06-01 11:41:13', '2026-06-01 04:41:16', '2026-06-01 04:41:16', NULL),
('311b93f0-f8b3-4c80-9cbf-1fa765bd1848', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Laporan Pertanggung-jawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024', 'laporan-pertanggung-jawaban-kepala-desa-martopuro-akhir-tahun-anggaran-2024-mpun6t83-387aef0a', 'Laporan Pertanggungjawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024', '<p>Laporan Pertanggungjawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284086/richtext/images/sedang-1744697125-479550422-991336039541977-1837358838722609320-n_sdgmrn.webp\" alt=\"sedang_1744697125_479550422_991336039541977_1837358838722609320_n.jpg\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284097/richtext/images/sedang-1744697125-477448775-991338306208417-7726628492456440439-n_q9lywr.webp\" alt=\"sedang_1744697125_477448775_991338306208417_7726628492456440439_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284101/martopuro/news/covers/sedang-1744697125-479953785-991335546208693-5567122389130180138-n_f93ugj.webp', 'published', 1, '2026-06-01 10:21:42', '2026-06-01 03:21:46', '2026-06-01 03:21:46', NULL),
('314b723c-3f8d-5166-bfa5-72aa7043a5a9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '0dc3abf2-de70-5cef-b90c-c6872b5f8816', 'Polsek Purwosari Kerahkan Personel Dukung BUMDes Martopuro Garap Lahan Ketahanan Pangan', 'polsek-purwosari-kerahkan-personel-dukung-bumdes-martopuro-garap-lahan-ketahanan-pangan', 'Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.', '<p>Polsek Purwosari mendukung BUMDes Martopuro dalam program penggarapan lahan ketahanan pangan.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-06 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('3355a1ee-dcfa-4644-b6d2-2ae6e1407e12', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.', 'sosialisasi-dan-edukasi-kesehatan-dari-pttea-fun-community-indonesia-mput0g6k-ec2f97ca', 'Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.', '<p>Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293883/martopuro/news/covers/sedang-1778561426-690745846-1331084455567132-1643283762637915006-n-1_heqhej.webp', 'published', 1, '2026-06-01 13:04:43', '2026-06-01 06:04:47', '2026-06-01 06:04:47', NULL),
('35454365-c241-40f1-aef6-60126f166177', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Hebohnya Parade Karnaval Martopuro 2025, Mengalir Apresiasi SUKSES dan Permintaan diadakan lagi Tahun Depan', 'hebohnya-parade-karnaval-martopuro-2025-mengalir-apresiasi-sukses-dan-permintaan-diadakan-lagi-tahun-depan-mpur6k8j-a7b0cf5a', 'Memperingati hari ulang tahun kemerdekaan Republik Indonesia (HUT RI) ke-80, dilaksanakan kegiatan parade budaya nusantara (karnaval martopuro 2025) dengan tema gemilang budaya, tangguh pangan indonesia.', '<p>Memperingati hari ulang tahun kemerdekaan Republik Indonesia (HUT RI) ke-80, dilaksanakan kegiatan parade budaya nusantara (karnaval martopuro 2025) dengan tema gemilang budaya, tangguh pangan indonesia.&nbsp; 27&nbsp; peserta ikut ambil bagian meramaikan karnaval&nbsp; yang sudah menjadi agenda yang ditunggu tunggu masyarakat desa martopuro.</p><p>&nbsp;</p><p>Karnaval yang digelar di Desa Martopuro Minggu (24/8) kemarin berlangsung meriah dan heboh, diawali dengan penampilan epik dari Perangkat dan Kepala Desa dan yang menjadi sorotan ialah kepala desa dengan pakaian kerajaan dan menaiki kereta berkuda, dan rombongan kepala dusun yang menaiki kuda, kemudian rombongan odong-odong PKK dan Paud dan Bumdes diikuti Paskibraka Pramuka Kec.Purwosari dan Marching Band SMK Al Inayah menjadi pembuka yang mengawali sampai finish.</p><p>&nbsp;</p><p>Parade Budaya Nusantara Karnaval Martopuro 2025 kemarin mayoritas peserta tampil sesuai dengan tema, yang telah disepakati bersama seluruh RW se desa martopuro 54 hari sebelum kegiatan, banyak kreasi murni yang lahir dari peserta menjadi tanda ikut merasakan kemeriahan dan kebersamaan memperingati HUT Kemerdekaan RI ke-80 tahun 2025, dan Banyaknya Ogoh ogoh menarik dan bagus besar yang menjadi sorotan yang di tunggu-tunggu masyarakat, dan dilanjutkan atraksi setiap perserta karnaval di depan area panggung finish yang menjadi tolak ukur penilaian karnafal tahun ini.</p><p>&nbsp;</p><p>“Kehebohan ini bentuk kerinduan masyarakat terhadap hiburan tahunan, dan tema yang kami usung menjadi bentuk pedulian kami untuk menjunjung nilai budaya dan mensupport program pemerintah terkait dengan ketahanan pangan. semoga ini menjadi daya tarik tersendiri untuk desa martopuro” imbuh Adi Darmawan (Konseptor Parade Budaya Nusantara Karnaval Martopuro)<br><br>\"Atensi Masyarakat Martopuro Sungguh Luar biasa, apresiasi setinggi-tingginya untuk yang mensuksesikan acara karnaval ini, kami selaku camat purwosari akan selalu support kegiatan apapun yang mendorong kemajuan kreatifitas masyarakat khususnya di Purwosari\" Camat Purwosari dalam sambutannya.<br></p><p>Pemerintah Desa, katanya, mengharapkan kegiatan tersebut menjadi momentum mempromosikan kretifitas SDM di Desa Martopuro. Meningkatkan apresiasi dan kecintaan terhadap, sejarah, seni dan budaya&nbsp; nusantara.</p><p>&nbsp;</p><p>dibalik kehebohan karnaval desa martopuro pasti ada yang menjadi kontroversi ditengah tengah masyarakat, dan ini bagian bumbu yang sudah biasa dalam kegiatan apapun untuk evaluasi lebih baik.</p><p>&nbsp;</p><p>Kepala Desa Martopuro ini juga tampil dengan senyum sumringah, berpakaian ala kerajaan menaiki kereta kencana,&nbsp; karena puluhan kontingen yang melintas, mayoritas mempertunjukkan atraksi kreatif, yang membuat kagum dan bangga terhadap kreatifitas warganya.<br></p><p>“Disamping itu hal yang paling istimewa kita bisa meningkatkan persatuan dan persatuan bangsa, dan kami mengucapkan terima kasih sebanyak – bayaknya kepada masyarakat desa martopuro yang telah mendukung kegiatan rangkaian kegiatan kalih ini,” pungkasnya.<br><br>karnaval berjalan dengan baik sesuai dengan kesepakatan bersama terkait kedatangan peserta yang disiplin maupun penilaian keseluruhan terkait karnaval tahun ini , tapi disisi lain ada 2 peserta yang memang menyepakati ingin meramaikan karnaval dengan memakai sound horeg, tanpa mengharap juara. karena memang panitia sudah mengatur terkait batasan mobil sound system.<br><br>dan kedatangan mereka menjadi daya tarik dan penutup tersendiri dalam karnaval tahun ini, heboh dan meriah walaupun sampai dimalam hari.</p><p>&nbsp;</p><p>Karnafal yang dimulai jam 09.00 Wib berlanjut sampai pengumuman kemenangan atau Juara di jam 19.00 Wib yang di bacakan langsung oleh Adi Darmawan di Panggung Finish depan Pasar Purwosari, sekaligus pemberian hadiah Uang Pembinaan dan Tropy</p><p>&nbsp;</p><p>Diantara pemenangannya :&nbsp;</p><p>&nbsp;</p><p>Juara 1 : RW 03 Kemantren (5Jt + Tropy)</p><p>Juara 2 : RW 10 Alkmar (3.5Jt + Tropy)</p><p>Juara 3 : RW 09 Alkmar (2Jt + Tropy)</p><p>Harapan 1 : RW 22 Puntir (1Jt + Tropy)</p><p>Harapan 2 : RW 07 Alkmar (750k + Tropy)</p><p>Harapan 3 : RW 08 Alkmar (500k + Tropy)<br>Harapan 4 : RW 02 Kemanten (500k + Tropy)<br>Harapan 5 : RW 25 Puntir (500k + Tropy)</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290806/richtext/images/sedang-1756524032-juara1_y4wm6h.webp\" alt=\"sedang_1756524032_juara1.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290808/martopuro/news/covers/sedang-1756524032-dsc00993_rz0x4g.webp', 'published', 3, '2026-06-01 12:13:29', '2026-06-01 05:13:33', '2026-06-01 05:13:33', NULL),
('35683772-c594-481a-8eb1-eaee4d1b12a8', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.', 'musyawarah-desa-khusus-pak-apbdes-2026-desa-martopuro-mpusixdc-7e243d2d', 'Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.', '<p>Musyawarah Desa Khusus PAK APBDes 2026 Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293065/martopuro/news/covers/sedang-1773291264-632685250-1264699248872320-1168933766715133322-n_zhauts.webp', 'published', 1, '2026-06-01 12:51:06', '2026-06-01 05:51:09', '2026-06-01 05:51:09', NULL);
INSERT INTO `news` (`id`, `tenant_id`, `category_id`, `title`, `slug`, `description_card`, `description_content`, `cover_url`, `status`, `read_time`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('367ccb5e-c6d1-4568-bf13-71c3d551456a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Progres Pembangunan MCK dan Kios Desa Martopuro', 'progres-pembangunan-mck-dan-kios-desa-martopuro-mpuocg1k-f64b7a2e', 'Progres  Pembangunan MCK dan Kios Desa Martopuro lokasi disebelah embung martopuro timur belakang pasar purwosari', '<p>Progres &nbsp;Pembangunan MCK dan Kios Desa Martopuro lokasi disebelah embung martopuro timur belakang pasar purwosari</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286044/martopuro/news/covers/sedang-1745200517-491936823-1039266431415604-5566213460792904384-n_mophtv.webp', 'published', 1, '2026-06-01 10:54:05', '2026-06-01 03:54:09', '2026-06-01 03:54:09', NULL),
('37298592-f182-5f74-b78c-b3ec4bbc6131', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Lomba Tumpeng TP PKK Desa Martopuro Peringatan 17 Agustus 2025 di Pendopo Kec.Purwosari.', 'lomba-tumpeng-tp-pkk-desa-martopuro-peringatan-17-agustus-2025-di-pendopo-kec-purwosari', 'Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.', '<p>Lomba tumpeng TP PKK Desa Martopuro dalam peringatan 17 Agustus 2025 di Pendopo Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musdes Khusus Desa Martopuro', 'musdes-khusus-desa-martopuro', 'Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.', '<p>Musyawarah Desa Khusus tentang perubahan Perdes BUMDes, Anggaran Dasar BUMDes, dan penyertaan modal.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-26.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-02-26 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('37876a11-2d4b-5e70-8b61-474ab4551ae5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro.', 'pengecatan-tempat-parkir-kantor-sumber-pad-pendapatan-asli-desa-desa-martopuro', 'Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.', '<p>Pengecatan tempat parkir kantor sumber Pendapatan Asli Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-17.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-17 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('38de09ff-57e4-4f30-b432-025b26f16922', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan TPT Depan Gerai KDMP Martopuro.', 'pembangunan-tpt-depan-gerai-kdmp-martopuro-mpusouz9-8e3927bd', 'Pembangunan TPT Depan Gerai KDMP Martopuro.', '<p>Pembangunan TPT Depan Gerai KDMP Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293342/martopuro/news/covers/sedang-1777519721-679825107-1320638213278423-8036341707433122046-n_hjl8ew.webp', 'published', 1, '2026-06-01 12:55:42', '2026-06-01 05:55:46', '2026-06-01 05:55:46', NULL),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Camat Purwosari Munif Triatmoko, Secara Resmi Membuka \"Martopuro Cup 2025\"', 'camat-purwosari-munif-triatmoko-secara-resmi-membuka-martopuro-cup-2025', 'Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.', '<p>Camat Purwosari Munif Triatmoko secara resmi membuka Martopuro Cup 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-09-07 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('39d2b2b8-be48-40c2-8b8e-7ef599d2577f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Kegiatan Rutin Jumat legi Khataman Qur\'an Pemerintah Desa Martopuro', 'kegiatan-rutin-jumat-legi-khataman-quran-pemerintah-desa-martopuro-mpuontsm-f5dab58b', 'Khotmil Qur\'an Jum\'at legi di Musholla Hubbul Wathon Kantor Desa Martopuro. kegiatan Rutin Jumat legi', '<p>Khotmil Qur\'an Jum\'at legi di Musholla Hubbul Wathon Kantor Desa Martopuro. kegiatan Rutin Jumat legi Khataman Qur\'an Pemerintah Desa Martopuro, yang diikuti semua perangkat desa, tokoh masyarakat, dll.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286575/martopuro/news/covers/sedang-1749736865-495174673-1052203373455243-2282683868996996185-n_mrjyzx.webp', 'published', 1, '2026-06-01 11:02:56', '2026-06-01 04:03:00', '2026-06-01 04:03:00', NULL),
('3a7b5d24-4b34-530e-a244-98c85a32780d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Donor Darah Rutin diadakan 3bulan sekali Bersama Karangtaruna Permata Karya Martopuro', 'donor-darah-rutin-diadakan-3bulan-sekali-bersama-karangtaruna-permata-karya-martopuro', 'Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.', '<p>Kegiatan donor darah rutin tiga bulan sekali bersama Karang Taruna Permata Karya Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-05-18.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-18 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pemerintah Desa Martopuro BerQur\'ban', 'pemerintah-desa-martopuro-berqurban', 'Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.', '<p>Penyembelihan dan pendistribusian hewan kurban Pemerintah Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-06.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-06 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('3cca2173-6c5b-46ed-91b2-930f421e961e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Wes Siap ta Dulur, Karnaval Martopuro 2025, Ini Persyaratan dan Waktunya', 'wes-siap-ta-dulur-karnaval-martopuro-2025-ini-persyaratan-dan-waktunya-mpuphcgq-55642870', 'tahun kemarin kita sukses mengadakan Martopuro Culture Fest 2024 dengan berbagai event, (Turnamen Volly, Sepak Bola Pelajar dan ditutup Jalan Sehat dan Gebyar Pentas Seni dengan atensi yang cukup luar biasa suksesnya.', '<p><strong>Gimana Dulur sudah Siap ta....?</strong></p><p>tahun kemarin kita sukses mengadakan Martopuro Culture Fest 2024 dengan berbagai event, (Turnamen Volly, Sepak Bola Pelajar dan ditutup Jalan Sehat dan Gebyar Pentas Seni dengan atensi yang cukup luar biasa suksesnya.<br><br>Tahun ini kami mengadakan kegitan sesuai aspirasi masyarakat yang berharap ajang kreatifitas masyarakat martopuro bisa tumpah ruah di event karnaval sehingga, kita coba berupaya negosiasi dan berhasil di support pemerintah desa martopuro, Alhamdulillah</p><p>Dalam rangka dirgahayu Republik Indonesia ke 80 tahun<br>Karangtaruna Permata Karya dan Pemerintah Desa Martopuro dalam Martopuro Culture Festival 2025 akan mengadakan 2 event besar diantaranya Karnaval Martopuro dan Turnamen Sepak Bola Antar Kampung. semoga bisa berjalan dengan baik dan sukses.<br><br>untuk event pertama dimulai dengan <strong>Parade Budaya Nusantara \"KARNAVAL MARTOPURO 2025, </strong>dengan Tema Gemilang Budaya, Tangguh Pangan Indonesia kegiatan ini merupakan&nbsp;AJANG BERGENGSI KREATIFITAS MASYARAKAT MARTOPURO.</p><p>InsyaAllah akan dilaksanakan pada Hari Minggu, 24 Agustus 2025<br><strong>Total hadiah Puluhan Juta,</strong><br>Start Lapangan Puntir / Jl Klojen dan Finish Depan Pasar Purwosari. (jika ada perubahan diperjelas di technical meeting)\'</p><p><strong>adapun persyaratannya bisa dibaca diposter dibawah boleh didownload</strong></p><p><strong>Pendaftaran</strong> melalui Link <a target=\"_blank\" rel=\"noopener\" href=\"https://martopuro.berdesa.id/web/form/bit.ly/pendaftarankarnavalmartopuro2025\" title=\"Pendaftaran\">bit.ly/pendaftarankarnavalmartopuro2025</a></p><p><strong>atau lewat Karantaruna Permata Karya</strong></p><ul><li><p>Rozi (+62 856-0601-2013) Alkmar, Mantren</p></li><li><p>Cahyo (+62 815-5911-146) Donorejo, Karangasem, Pakem</p></li><li><p>Jayin (+62 895-1382-3472) Klojen, Puntir, Putranan</p></li></ul><p><strong><em>perubahan informasi akan diperjelas di Technical meeting</em></strong></p><p><strong>Technical Meeting :</strong></p><ul><li><p>Hari &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : Minggu, 10 Agustus 2025 Wib</p></li><li><p>Jam &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : 19.30 Wib - Selesai Tempat &nbsp;: Balai Desa Martopuro</p></li></ul><p>Berita ini sekaligus sebagai undangan Technical Meeting untuk Peserta.</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287952/martopuro/news/covers/sedang-1751291213-thubnail_ibgb1m.webp', 'published', 2, '2026-06-01 11:25:53', '2026-06-01 04:25:56', '2026-06-01 04:25:56', NULL),
('3d5a8754-c917-5892-8545-2f03ef4746ed', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Pra LKPPD/LPPD Desa Martopuro.', 'musyawarah-pra-lkppd-lppd-desa-martopuro', 'Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.', '<p>Musyawarah Pra LKPPD/LPPD Desa Martopuro membahas persiapan laporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('3defa28f-1983-40e9-9681-d0880123d8ad', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Laporan Pertanggungjawaban BUMDES \"Karya Usaha Mandiri\" Desa Martopuro Tahun Anggaran 2025.', 'laporan-pertanggungjawaban-bumdes-karya-usaha-mandiri-desa-martopuro-tahun-anggaran-2025-mpuse5h9-cf3d00d4', 'Laporan Pertanggungjawaban BUMDES \"Karya Usaha Mandiri\" Desa Martopuro Tahun Anggaran 2025.', '<p>Laporan Pertanggungjawaban BUMDES \"Karya Usaha Mandiri\" Desa Martopuro Tahun Anggaran 2025.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292842/martopuro/news/covers/sedang-1770525958-615347713-1241187064556872-8363236902145195926-n_zbqgqs.webp', 'published', 1, '2026-06-01 12:47:23', '2026-06-01 05:47:26', '2026-06-01 05:47:26', NULL),
('3dfd8ed2-7a71-4c43-976c-32db781ad739', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Opname Pekerjaan Realisasi TPT dan Pavingisasi Depan Gerai KDMP Desa Martopuro.', 'opname-pekerjaan-realisasi-tpt-dan-pavingisasi-depan-gerai-kdmp-desa-martopuro-mq86xkp2-6e84ba3d', 'Opname Pekerjaan Realisasi TPT dan Pavingisasi Depan Gerai KDMP Desa Martopuro.', '<p>Opname Pekerjaan Realisasi TPT dan Pavingisasi Depan Gerai KDMP Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103325/martopuro/news/covers/713753992-1351750390167205-1554018337228033370-n_thtluv.webp', 'published', 1, '2026-06-10 21:55:24', '2026-06-10 14:55:29', '2026-06-10 14:55:29', NULL),
('3f50d240-10a1-4e26-96d6-43f00be57750', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro.', 'giat-pemindahan-tiang-bendera-lapangan-panutan-desa-martopuro-mpup2e32-b8b06440', 'Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro. yang semula ada diare dekat', '<p>Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro. yang semula ada diare dekat dengan tangga masuk lapangan kiri berada lebih kebelakang agar bisa center dengan paving yang berada disebelah barat.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287254/martopuro/news/covers/sedang-1750044792-506115657-1078163994192514-3692326716275356219-n_mdityn.webp', 'published', 1, '2026-06-01 11:14:15', '2026-06-01 04:14:19', '2026-06-01 04:14:19', NULL),
('43107ae5-57d8-45f1-bc84-a3d714815420', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari , 17 Agustus 2025', 'kerja-bakti-lapangan-panutan-desa-martopuro-persiapan-upacara-kemerdekaan-se-kecamatan-purwosari-17-agustus-2025-mpuqxv21-29954a23', 'Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari , 17 Agustus 2025', '<p>Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari | 17 Agustus 2025</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290403/martopuro/news/covers/sedang-1755226580-532228926-1124063979602515-5193734925066549207-n_snfemd.webp', 'published', 1, '2026-06-01 12:06:43', '2026-06-01 05:06:47', '2026-06-01 05:06:47', NULL),
('43fcbd6d-ca10-40f2-a643-00c97c9c2238', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.', 'musyawarah-desa-penetapan-indeks-desa-martopuro-2025-mpuoliop-ae8c339c', 'Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.', '<p>Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025. dihadiri perwakilan dari kecamatan dan pendamping desa , BPD dan seluruh perangkat desa martopuro, berjalan lancar dan sukses&nbsp;</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286467/martopuro/news/covers/sedang-1749736707-495241235-1051068340235413-161512056325677364-n_vkyjid.webp', 'published', 1, '2026-06-01 11:01:08', '2026-06-01 04:01:11', '2026-06-01 04:01:11', NULL),
('47f7d6e6-271e-4a54-8046-a015f83eda9f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Desa Martopuro Jadi Pelopor Musyawarah Desa Khusus 2025 untuk Pembiayaan Koperasi Desa Merah Putih', 'desa-martopuro-jadi-pelopor-musyawarah-desa-khusus-2025-untuk-pembiayaan-koperasi-desa-merah-putih-mpurjdue-beb5d1c4', 'Martopuro, Purwosari – Desa Martopuro kembali mencatatkan langkah penting dalam perjalanan pembangunan ekonomi desa. Pada tahun 2025 ini', '<p>Martopuro, Purwosari – Desa Martopuro kembali mencatatkan langkah penting dalam perjalanan pembangunan ekonomi desa. Pada tahun 2025 ini, <strong>Desa Martopuro menjadi salah satu dari empat desa di Kabupaten Pasuruan yang pertama kali menyelenggarakan <em>Musyawarah Desa Khusus (Musdesus)</em></strong> sesuai dengan <strong>Surat Edaran Menteri Desa Nomor 8 Tahun 2025</strong>. Musyawarah ini dilaksanakan dalam rangka <strong>persetujuan dukungan pembiayaan dan pengembalian pinjaman Koperasi Desa Merah Putih (KDMP)</strong>.</p><p>Kegiatan ini juga sejalan dengan amanat <strong>Peraturan Menteri Desa (Permendes) Nomor 10 Tahun 2025</strong> tentang <em>Mekanisme Persetujuan Kepala Desa dalam Pembiayaan Koperasi Desa</em>. Melalui Musdesus ini, seluruh unsur masyarakat desa — mulai dari Camat Purwosari, kordinator pendamping desa, Kasi PMD Kec.Purwosari, pendamping desa martopuro, pemerintah desa, BPD, tokoh masyarakat, hingga pengurus koperasi — hadir untuk memberikan dukungan dan masukan terhadap keberlanjutan serta tanggung jawab pengelolaan koperasi desa.</p><p>Dalam sambutannya, <strong>Kepala Desa Martopuro, Rianto</strong>, menyampaikan rasa syukur dan bangga atas terselenggaranya musyawarah ini.</p><blockquote><p>“Desa kita menjadi yang pertama melaksanakan Musdesus sesuai aturan terbaru. Semoga ini bisa menjadi contoh dan percontohan bagi desa-desa lain di Kabupaten Pasuruan,” ujar Rianto dalam pidatonya.</p></blockquote><p>Beliau juga menegaskan bahwa Koperasi Desa Merah Putih adalah bentuk nyata semangat gotong royong ekonomi warga desa.</p><blockquote><p>“Doa kita semua, semoga dari Koperasi Desa Merah Putih ini terwujud kesejahteraan masyarakat. Tetap semangat untuk para pengurus KDMP yang akan terus berjuang membangun ekonomi desa,” tambahnya.</p></blockquote><p>Musyawarah ini menghasilkan keputusan bersama untuk memberikan <strong>dukungan penuh terhadap mekanisme pembiayaan koperasi</strong>, dengan harapan dapat memperkuat perputaran ekonomi di tingkat lokal, membuka lapangan kerja, serta meningkatkan pendapatan warga.</p><p>Langkah progresif Desa Martopuro ini diharapkan menjadi <strong>inspirasi bagi desa-desa lain khususnya di kecamatan purwosari</strong> dalam mengelola potensi ekonomi secara mandiri dan berkelanjutan, sejalan dengan semangat pemberdayaan desa dan kemandirian ekonomi masyarakat.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291405/martopuro/news/covers/sedang-1760015280-559429851-1168302055178707-6494616238893681022-n_iycxku.webp', 'published', 2, '2026-06-01 12:23:27', '2026-06-01 05:23:31', '2026-06-01 05:23:31', NULL),
('4a11404b-31fe-4605-b39c-3219f1a67028', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembinaan Linmas Desa Martopuro.', 'pembinaan-linmas-desa-martopuro-mpuqmosi-39bc3529', 'Pembinaan Linmas Desa Martopuro.', '<p>Pembinaan Linmas Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780289881/martopuro/news/covers/sedang-1753619879-523949626-1109316671077246-1599043738776480933-n_c8v8uc.webp', 'published', 1, '2026-06-01 11:58:02', '2026-06-01 04:58:06', '2026-06-01 04:58:06', NULL),
('4a164b15-6037-42ac-ac3e-a271f5a92f95', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Gedung Sudah Jadi, Mobil Operasional Segera Datang, Koperasi Desa Martopuro Siap Ubah Nasib Warga', 'gedung-sudah-jadi-mobil-operasional-segera-datang-koperasi-desa-martopuro-siap-ubah-nasib-warga-mpusz6x5-60ed39d9', 'Gedung Sudah Jadi, Mobil Operasional Segera Datang, Koperasi Desa Martopuro Siap Ubah Nasib Warga', '<p><strong>“Gedung Sudah Berdiri Megah, Mobil Operasional Segera Hadir! Saatnya Warga Martopuro Bangkit Bersama Koperasi Desa Merah Putih”</strong></p><p>Kabar membanggakan datang dari Desa Martopuro. Gedung Koperasi Desa Merah Putih kini telah rampung dibangun dan tampil megah sebagai simbol kebangkitan ekonomi desa. Dengan tampilan yang rapi, halaman yang sudah dipaving dengan baik, serta fasilitas yang semakin lengkap, koperasi ini siap memasuki tahap operasional dalam waktu dekat.</p><p>Tidak hanya berhenti pada pembangunan fisik, kesiapan koperasi juga ditandai dengan hadirnya mobil operasional yang saat ini sedang dalam proses pengambilan. Mobil tersebut nantinya akan digunakan untuk menunjang berbagai kegiatan usaha, distribusi barang, hingga pelayanan kepada anggota koperasi. Hal ini menunjukkan keseriusan pengelola dalam membangun sistem koperasi yang aktif, modern, dan bermanfaat langsung bagi masyarakat.</p><p>Koperasi Desa Merah Putih diharapkan menjadi pusat kegiatan ekonomi yang mampu menggerakkan potensi lokal. Mulai dari usaha perdagangan, pertanian, hingga pengembangan produk unggulan desa, semua dapat difasilitasi melalui koperasi ini. Dengan manajemen yang baik dan dukungan masyarakat, koperasi bukan hanya menjadi tempat simpan pinjam, tetapi juga wadah kolaborasi untuk menciptakan peluang usaha baru.</p><p>Namun, keberhasilan koperasi tidak hanya bergantung pada bangunan dan fasilitas semata. Peran aktif masyarakat Desa Martopuro menjadi kunci utama. Koperasi adalah milik bersama, dan kemajuannya sangat ditentukan oleh partisipasi anggotanya. Oleh karena itu, seluruh warga diharapkan dapat ikut berkontribusi, baik dengan menjadi anggota, menabung, bertransaksi, maupun mengembangkan usaha melalui koperasi.</p><p>Mari bersama kita manfaatkan kehadiran Koperasi Desa Merah Putih ini sebagai langkah nyata untuk meningkatkan kesejahteraan. Dengan semangat gotong royong dan kebersamaan, bukan tidak mungkin koperasi ini akan menjadi motor penggerak ekonomi desa yang kuat dan berkelanjutan.</p><p>Saatnya warga Martopuro bersatu, berkontribusi, dan tumbuh bersama. Karena dari desa, kita bisa membangun masa depan yang lebih sejahtera.<br><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293821/richtext/images/sedang-1778211629-6a73e647-ce35-4623-b529-346ff583e70f_o2pmca.webp\" alt=\"sedang_1778211629_6a73e647-ce35-4623-b529-346ff583e70f.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293824/martopuro/news/covers/sedang-1778211629-foto_ycjyzx.webp', 'published', 2, '2026-06-01 13:03:44', '2026-06-01 06:03:49', '2026-06-01 06:03:49', NULL),
('4a829d74-5b10-4e89-8c47-08ba47dbe561', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sukses digelar Peringatan Hari Santri 2025 di Desa Martopuro', 'sukses-digelar-peringatan-hari-santri-2025-di-desa-martopuro-mpuroxem-cbe54edb', 'Sukses digelar Peringatan Hari Santri 2025 di Desa MartopuroSukses digelar Peringatan Hari Santri 2025 di Desa Martopuro', '<p>Sukses digelar Peringatan Hari Santri 2025 di Desa MartopuroSukses digelar Peringatan Hari Santri 2025 di Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291665/martopuro/news/covers/sedang-1764728272-567691383-1179132604095652-5762045227339039061-n_imu55h.webp', 'published', 1, '2026-06-01 12:27:46', '2026-06-01 05:27:51', '2026-06-01 05:27:51', NULL),
('4b70b27d-1a42-519d-af06-141de67515c7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembinaan RT&RW Desa Martopuro Semester 1 2025', 'pembinaan-rt-dan-rw-desa-martopuro-semester-1-2025', 'Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.', '<p>Pembinaan Ketua RW dan Ketua RT Desa Martopuro Kecamatan Purwosari Kabupaten Pasuruan semester 1 tahun 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('4c7b3e0e-9429-4f03-9d43-624c8f18d5a6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Terbentuknya Pengurus Koperasi Desa Merah Putih Martopuro', 'terbentuknya-pengurus-koperasi-desa-merah-putih-martopuro-mpuok0pg-72cc62b1', 'Musyawarah desa khusus 2025 , pemerintahan desa martopuro membahas percepatan pembentukan koperasi merah putih', '<p>Musyawarah desa khusus 2025 , pemerintahan desa martopuro membahas percepatan pembentukan koperasi merah putih, salah satu program pemerintahan baru presiden terpilih prabowo subianto yang diharapkan memberikan dampak signifikan dalam kesejahteran di desa. (25/04/2025)</p><p>\"Harapan kami Pembentukan koperasi desa merah putih bisa berdampak besar dalam meningkatkan upaya kesejahteraan masyarakat khususnya di desa martopuro, ucap Rianto selaku kepala desa martopuro dalam sambutannya</p><p>Dan sebelum pembentukan pengurus kepala desa melempar ke audiensi untuk memilih 3 unsur untuk menjadi pimpinan rapat /musyawarah diantaranya.</p><p>Perwakilan LPK. bpk.Hafidz, perwakilan karangtaruna, Dodik, perwakilan BPD, Bpk.Heru.</p><p>Harapan dalam pembentukan koperasi desa merah putih bisa berjalan dengan baik dan bisa meningkatkan kesejahteraan desa, dan mampu menciptakan lapangan pekerja, dan modernisasi sistem koperasi, dll, ucap perwakilan dari Kecamatan Purwosari sekaligus pendamping yang membaca tujuan pembentukan koperasi merah putih.</p><p>Pimpinan Rapat Bpk.Heru, disesi akhir musyawarah / rapat menyampaikan berita acara pembentukan yang sudah disepakati bersama dari unsur perwakilan wilayah dusun pada pukul 21.30, adapun susunan pengurus Koperasi Desa Merah Putih Martopuro diantaranya&nbsp;</p><p>Pengawas : Rianto (Kepala Desa), Nouval, Rinaldi</p><ul><li><p>Ketua : Sujono, M.Pd</p></li><li><p>Wakil 1 Ketua Bidang Usaha : Ir. Bambang Irwanto</p></li><li><p>Wakil 2 Ketua Bidang Usaha : Nikmatus Sholihah</p></li><li><p>Wakil 1 Ketua Bidang Anggota : Wawan</p></li><li><p>Wakil 2 Ketua Bidang Anggota : Dhedi Lesmawan</p></li><li><p>Sekretararis : Adi Darmawan, <a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"http://A.Md\">A.Md</a> Kom</p></li><li><p>Bendahara : Wahyu Manggaring Tyas</p></li></ul><p>adapun nama nama yang belum dimasukkan akan masuk dibagian bidang bidang yang lain disusun setelah sosialisasi dari kementrian koperasi republik indonesia yang akan datang dibulan mei .</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286398/martopuro/news/covers/sedang-1745421910-aa80cc4e-2718-43c3-a7de-c34268fb13d9_qtk9zk.webp', 'published', 2, '2026-06-01 10:59:58', '2026-06-01 04:00:02', '2026-06-01 04:00:02', NULL),
('4e2acb6e-09d3-589c-80a4-d7683ee2eb57', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT.Indolakto', 'sukses-mengadakan-santunan-105-anak-yatim-desa-martopuro-oleh-kepala-desa-martopuro-bersama-pt-indolakto', 'Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.', '<p>Santunan 105 anak yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT Indolakto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-27.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-27 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('4fa40dea-5ca9-5e8b-91b6-61b784917577', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran BLT Dana Desa Tahun 2025 bulan November Desember.', 'penyaluran-blt-dana-desa-tahun-2025-bulan-november-desember', 'Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.', '<p>Penyaluran BLT Dana Desa tahun 2025 untuk bulan November dan Desember di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Desa Martopuro Jadi Pelopor Musyawarah Desa Khusus 2025 untuk Pembiayaan Koperasi Desa Merah Putih', 'desa-martopuro-jadi-pelopor-musyawarah-desa-khusus-2025-untuk-pembiayaan-koperasi-desa-merah-putih', 'Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.', '<p>Desa Martopuro mencatat langkah penting dalam pembiayaan Koperasi Desa Merah Putih melalui Musyawarah Desa Khusus 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-09 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('51f681e3-6898-57ff-90af-38c7da75782e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro', 'merealisasikan-pavingisasi-pemukiman-dusun-karangasem-desa-martopuro', 'Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.', '<p>Realisasi pavingisasi pemukiman Dusun Karangasem Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('52c08d85-b677-54bc-8fd2-b479c48ce2bf', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Monitoring Pajak Bumi & Bangunan oleh tim Monitoring Kecamatan Purwosari.', 'monitoring-pajak-bumi-dan-bangunan-oleh-tim-monitoring-kecamatan-purwosari', 'Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.', '<p>Monitoring Pajak Bumi dan Bangunan oleh tim monitoring Kecamatan Purwosari di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-31.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-31 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('5344407f-87d5-47ed-867d-a360cb9056d4', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Pra LKPPD/LPPD Desa Martopuro.', 'musyawarah-pra-lkppdlppd-desa-martopuro-mpusff9l-c4694999', 'Musyawarah Pra LKPPD/LPPD Desa Martopuro.', '<p>Musyawarah Pra LKPPD/LPPD Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292901/martopuro/news/covers/sedang-1770525917-615812481-1247494803926098-5655504032784862749-n_nvj6tw.webp', 'published', 1, '2026-06-01 12:48:22', '2026-06-01 05:48:26', '2026-06-01 05:48:26', NULL),
('53d1a069-6c1b-5559-b7f0-88fc9215eeec', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.', 'pengecatan-mushola-hubbul-wathon-kantor-desa-martopuro', 'Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.', '<p>Pengecatan Mushola Hubbul Wathon Kantor Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('5447f892-ba7a-5ab1-b257-84ce92e64849', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyerahan THR Tahun 2026 BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan', 'penyerahan-thr-tahun-2026-bpd-perangkat-desa-pengurus-tp-pkk-rt-rw-linmas-kader-posyandu-modin-desa-martopuro-kec-purwosari-kab-pasuruan', 'Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.', '<p>Penyerahan THR tahun 2026 kepada BPD, perangkat desa, pengurus TP PKK, RT-RW, Linmas, kader Posyandu, dan Modin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-03-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('54516f96-faac-4ea0-96f6-304835999627', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Posbindu Kartini 4 Desa Martopuro.', 'giat-posbindu-kartini-4-desa-martopuro-mpusbjli-19f23149', 'Giat Posbindu Kartini 4 Desa Martopuro.', '<p>Giat Posbindu Kartini 4 Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292720/martopuro/news/covers/sedang-1770517804-600188751-1218357516839827-7638519426361433833-n_haazot.webp', 'published', 1, '2026-06-01 12:45:21', '2026-06-01 05:45:25', '2026-06-01 05:45:25', NULL),
('59c2d5ca-09b0-41c5-b067-be89d9c44a90', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.', 'rencana-lokasi-pembangunan-gerai-kdmp-koperasi-desa-merah-putih-martopuro-mpurzvbw-d67ef38b', 'Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.', '<p>Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292176/martopuro/news/covers/sedang-1764727854-581215558-1197501142258798-3871344574206866935-n_uehfno.webp', 'published', 1, '2026-06-01 12:36:16', '2026-06-01 05:36:20', '2026-06-01 05:36:20', NULL),
('5ae7096e-679e-410a-ab61-ce0a2c9bbb0a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Info Event Karangtaruna Permata karya', 'info-event-karangtaruna-permata-karya-mpun2zjo-699084bb', 'Informasi lengkap terkait event karangtaruna permata karya bisa langsung cek instagram kita , selalu update dalam memberikan informasi disini Martopuroculturefest', '<p>Informasi lengkap terkait event karangtaruna permata karya bisa langsung cek instagram kita , selalu update dalam memberikan informasi disini <a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"https://www.instagram.com/martopuroculturefest/\">Martopuroculturefest</a></p><p>&nbsp;</p><p>2024 sukses mengadakan event martopuro culture fest&nbsp; mulai dari turnamen volly, turnamen sepak bola pelajar sampai jalan sehat berhadiah dan ditutup malam puncak martopuro culture perform (pentas budaya) bisa dicek beritanya disini</p><p>&nbsp;</p><p><a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"https://www.wartabromo.com/2024/09/09/sukses-martopuro-rayakan-kemerdekaan-ri-dari-turnamen-hingga-gelar-martopuro-culture-fest/\">Sukses! Martopuro Rayakan Kemerdekaan RI dari Turnamen hingga Gelar Martopuro Culture Fest - WartaBromo</a></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780283923/martopuro/news/covers/sedang-1745212766-ketua-terpilih2_wtsqxz.webp', 'published', 1, '2026-06-01 10:18:44', '2026-06-01 03:18:49', '2026-06-01 03:18:49', NULL),
('5c6b17fa-8342-5aec-9b43-8882f65deed6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Sukses mengadakan Pelatihan Pemulasaran Jenazah Desa Martopuro', 'sukses-mengadakan-pelatihan-pemulasaran-jenazah-desa-martopuro', 'Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.', '<p>Pemerintah Desa Martopuro mengadakan pelatihan pemulasaran jenazah untuk meningkatkan pengetahuan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('5c6d5abd-f674-48f9-ab24-eaeb13ff158e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro', 'pembangunan-tpt-lapangan-panutan-dana-desa-desa-martopuro-mpunqm30-542cc998', 'Merealisasikan Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro', '<p>Merealisasikan Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285022/richtext/images/sedang-1744554541-483832498-1014016673940580-1927601296939003760-n_vzhkxi.webp\" alt=\"sedang_1744554541_483832498_1014016673940580_1927601296939003760_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285025/martopuro/news/covers/sedang-1744554541-485594337-1014017410607173-7125520853822788019-n_rhowgp.webp', 'published', 1, '2026-06-01 10:37:06', '2026-06-01 03:37:10', '2026-06-01 03:37:10', NULL),
('5cd8dd9b-fe05-4a9b-a69e-d4143da2ca91', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.', 'verifikasi-proyek-lapangan-rkp-2026-desa-martopuro-mpurvcr5-08d28a0d', 'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.', '<p>Verifikasi proyek lapangan RKP 2026 Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291965/martopuro/news/covers/sedang-1764727923-578366012-1193201209355458-5327593835911938498-n_i66htw.webp', 'published', 1, '2026-06-01 12:32:46', '2026-06-01 05:32:49', '2026-06-01 05:32:49', NULL),
('5d8096bc-eb95-5638-9799-69ed0c7e7759', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.', 'verifikasi-proyek-lapangan-rkp-2026-desa-martopuro', 'Verifikasi proyek lapangan RKP 2026 Desa Martopuro.', '<p>Verifikasi proyek lapangan RKP 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-08.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-08 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('5e4aa5d8-2b92-41ed-b439-0129f6174af9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembentukan Tim 11 RKP Desa Martopuro.', 'pembentukan-tim-11-rkp-desa-martopuro-mq86zdu3-7c5cc9bc', 'Pembentukan Tim 11 RKP Desa Martopuro.', '<p>Pembentukan Tim 11 RKP Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103410/martopuro/news/covers/718676998-1356955502980027-8478629670218940950-n_ezeeft.webp', 'published', 1, '2026-06-10 21:56:48', '2026-06-10 14:56:54', '2026-06-10 14:56:54', NULL),
('5e992740-596b-48a9-9db8-5c2d73608bac', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan Gerai KDMP Martopuro.', 'pembangunan-gerai-kdmp-martopuro-mpusdasq-2163a3ba', 'Pembangunan Gerai KDMP Martopuro.', '<p>Pembangunan Gerai KDMP Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292802/martopuro/news/covers/sedang-1770517950-600227940-1222620713080174-3828065981247877601-n_jbafz8.webp', 'published', 1, '2026-06-01 12:46:43', '2026-06-01 05:46:47', '2026-06-01 05:46:47', NULL),
('5fbe0d5f-3d1a-4424-a158-95bcc2b97f92', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025', 'desa-martopuro-termasuk-perwakilan-desa-di-kabupaten-pasuruan-yang-mengikuti-pelatihan-tata-kelola-desa-2025-mpurqt4x-60d8dcfc', 'Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025', '<p>Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291753/martopuro/news/covers/sedang-1764728122-571211865-1185355033473409-7840619008880629552-n_hj5mjo.webp', 'published', 1, '2026-06-01 12:29:14', '2026-06-01 05:29:17', '2026-06-01 05:29:17', NULL),
('6070b7fc-e04e-569d-b739-e2910ffd5090', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Turnamen Bola Voly Martopuro Cup Resmi dibuka diikuti Tim dari berbagai Kota, Pasuruan dan Sekitarnya', 'turnamen-bola-voly-martopuro-cup-resmi-dibuka-diikuti-tim-dari-berbagai-kota-pasuruan-dan-sekitarnya', 'Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.', '<p>Turnamen Bola Voli Martopuro Cup 2025 resmi dibuka dan diikuti tim dari berbagai kota sekitar Pasuruan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-09-07.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-09-07 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('615d532d-e8fb-45e1-bb7b-4edbab7ad8ef', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan Jembatan Jalan Usaha Tani Dusun Karangasem Desa Martopuro.', 'pembangunan-jembatan-jalan-usaha-tani-dusun-karangasem-desa-martopuro-mq8712ix-ff4cf9c7', 'Pembangunan Jembatan Jalan Usaha Tani Dusun Karangasem Desa Martopuro.', '<p>Pembangunan Jembatan Jalan Usaha Tani Dusun Karangasem Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103488/martopuro/news/covers/721804683-1358561649486079-1994796045204338177-n_nryppm.webp', 'published', 1, '2026-06-10 21:58:07', '2026-06-10 14:58:13', '2026-06-10 14:58:13', NULL),
('65906799-b51a-452f-95b5-d1883487ec95', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.', 'pembangunan-tpt-jembatan-dusun-klojen-desa-martopuro-mpuqqk36-88062135', 'Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.', '<p>Pembangunan TPT Jembatan Dusun Klojen Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290062/martopuro/news/covers/sedang-1754040687-524052671-1110965247579055-3026384232942075827-n_t73z6d.webp', 'published', 1, '2026-06-01 12:01:02', '2026-06-01 05:01:06', '2026-06-01 05:01:06', NULL),
('66211d0f-cc6d-4a76-8084-078ebec7cb1f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.', 'pemasangan-speed-bump-jalan-dusun-klojen-desa-martopuro-mpupk416-341f5356', 'Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.', '<p>Pemasangan Speed Bump Jalan Dusun Klojen Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288081/martopuro/news/covers/sedang-1751362919-515102463-1090316439643936-966704497949553273-n_w64cj6.webp', 'published', 1, '2026-06-01 11:28:02', '2026-06-01 04:28:05', '2026-06-01 04:28:05', NULL),
('669442fa-2d82-574d-a13e-a80bc0b6c09b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dcb17bd5-8af2-5484-86fe-e6bee5e15a38', 'Siap Menerima Siswa Baru Paud Tunas Bangsa Martopuro', 'siap-menerima-siswa-baru-paud-tunas-bangsa-martopuro', 'Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.', '<p>Pendaftaran siswa baru PAUD Tunas Bangsa Martopuro tahun ajaran 2025/2026 telah dibuka.</p><p>Berita ini termasuk kategori PAUD Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('6803ca49-8946-5386-86a8-257563dfb328', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembinaan Karang Taruna \"Permata Karya\" Desa Martopuro.', 'pembinaan-karang-taruna-permata-karya-desa-martopuro', 'Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.', '<p>Pembinaan Karang Taruna Permata Karya Desa Martopuro berhasil dilaksanakan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-26.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-26 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('68d97ecd-8f43-592e-9a84-c151b1626e11', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Kades Martopuro Menjawab dengan Lounching Website Resmi Desa', 'kades-martopuro-menjawab-dengan-lounching-website-resmi-desa', 'Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.', '<p>Kepala Desa Martopuro meluncurkan website resmi desa sebagai inovasi menjawab kebutuhan informasi masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('690da950-e796-5869-b702-769a14174c0d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Plesterisasi Belakang Kios Desa Martopuro Timur Pasar.', 'plesterisasi-belakang-kios-desa-martopuro-timur-pasar', 'Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.', '<p>Proses plesterisasi belakang kios Desa Martopuro Timur Pasar.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('6cf21661-78fe-45da-9b85-bf6966280a03', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.', 'monev-giat-fisik-semester-2-tahun-2025-oleh-kecamatan-dan-ta-kabupatendana-desa-desa-martopuro-mpuraqdr-98dd1564', 'Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.', '<p>Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291000/richtext/images/sedang-1756522272-539205184-1134882531853993-4310562655144364961-n_fjkfhe.webp\" alt=\"sedang_1756522272_539205184_1134882531853993_4310562655144364961_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291003/martopuro/news/covers/sedang-1756522272-538135063-1134883458520567-8250854570593818234-n_c15lgn.webp', 'published', 1, '2026-06-01 12:16:44', '2026-06-01 05:16:47', '2026-06-01 05:16:47', NULL),
('6dac5caf-5fd1-5024-947f-612840cdfe03', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pengecatan Gedung PAUD Desa Martopuro.', 'pengecatan-gedung-paud-desa-martopuro', 'Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.', '<p>Pengecatan Gedung PAUD Desa Martopuro sebagai peningkatan fasilitas pendidikan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('70898464-e84f-49cf-a72b-acedca8a8d75', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro', 'merealisasikan-pavingisasi-pemukiman-dusun-karangasem-desa-martopuro-mpunycks-5d75cdca', 'Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro', '<p>Merealisasikan Pavingisasi Pemukiman Dusun Karangasem Desa Martopuro&nbsp;</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285383/richtext/images/sedang-1744554024-490145533-1031289158879998-53684666583100672-n_bqfkqc.webp\" alt=\"sedang_1744554024_490145533_1031289158879998_53684666583100672_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285385/martopuro/news/covers/sedang-1744554024-490125814-1031289708879943-4816653497285744710-n_zhlobl.webp', 'published', 1, '2026-06-01 10:43:07', '2026-06-01 03:43:11', '2026-06-01 03:43:11', NULL),
('716d2798-4298-5677-8de2-a849e97e0e4e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan TPT Depan Gerai KDMP Martopuro.', 'pembangunan-tpt-depan-gerai-kdmp-martopuro', 'Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.', '<p>Pembangunan TPT depan Gerai KDMP Martopuro sebagai bagian dari peningkatan infrastruktur desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-30.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-30 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7190b957-3b9c-54eb-812e-5e4f87d0486e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.', 'rianto-kepala-desa-martopuro-mengikuti-bimbingan-teknis-administrasi-pemerintahan-desa', 'Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.', '<p>Kepala Desa Martopuro mengikuti bimbingan teknis administrasi pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-11-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7297bdb9-65d3-5e8b-a567-4c433e23c766', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Progres Pembangunan MCK dan Kios Desa Martopuro', 'progres-pembangunan-mck-dan-kios-desa-martopuro', 'Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.', '<p>Progres pembangunan MCK dan kios Desa Martopuro di lokasi sekitar embung.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('742001dc-5a14-5b31-a224-e799ceed78da', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pavingisasi Makam Umum Desa Martopuro', 'pavingisasi-makam-umum-desa-martopuro', 'Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.', '<p>Pavingisasi area makam umum Desa Martopuro untuk meningkatkan akses dan kenyamanan masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-25.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-25 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('74b839a4-3c8c-487d-a9a5-145f548e70a1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.', 'rianto-kepala-desa-martopuro-mengikuti-bimbingan-teknis-administrasi-pemerintahan-desa-mpurw5df-4c6eee09', 'Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.', '<p>Rianto Kepala Desa Martopuro mengikuti bimbingan Teknis Administrasi Pemerintahan Desa.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292002/martopuro/news/covers/sedang-1764727824-582523861-1198759798799599-2044909975416048706-n_j9kuj8.webp', 'published', 1, '2026-06-01 12:33:23', '2026-06-01 05:33:27', '2026-06-01 05:33:27', NULL);
INSERT INTO `news` (`id`, `tenant_id`, `category_id`, `title`, `slug`, `description_card`, `description_content`, `cover_url`, `status`, `read_time`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga', 'hadirnya-martopuro-selection-fc-bentuk-pemerintah-desa-ingin-menggali-potensi-sdm-dibidang-olahrga', 'Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.', '<p>Martopuro Selection FC hadir sebagai upaya pemerintah desa menggali potensi SDM di bidang olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('769da44b-8943-579c-aadf-f4cfbf063172', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Desa Martopuro termasuk perwakilan Desa di Kabupaten Pasuruan yang mengikuti Pelatihan Tata Kelola Desa 2025', 'desa-martopuro-termasuk-perwakilan-desa-di-kabupaten-pasuruan-yang-mengikuti-pelatihan-tata-kelola-desa-2025', 'Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.', '<p>Desa Martopuro menjadi perwakilan desa di Kabupaten Pasuruan dalam Pelatihan Tata Kelola Desa 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-29.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-29 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7779f973-7f37-4a6d-8dcd-a23f2d9d9f4c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Kunjungan Haji Pemdes Martopuro.', 'giat-kunjungan-haji-pemdes-martopuro-mpupp6ja-9120b26f', 'Alhamdulillah bisa mengunjungi warga yang telah pulang dari ibadah haji (makkah dan madinah) semoga menjadi haji yanag mabrur Aamiin, Giat Kunjungan Haji Pemdes Martopuro.', '<p>Alhamdulillah bisa mengunjungi warga yang telah pulang dari ibadah haji (makkah dan madinah) semoga menjadi haji yanag mabrur Aamiin, Giat Kunjungan Haji Pemdes Martopuro.</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288318/martopuro/news/covers/sedang-1752407900-517426879-1098413962167517-2788784172792686588-n_wzfwht.webp', 'published', 1, '2026-06-01 11:31:59', '2026-06-01 04:32:02', '2026-06-01 04:32:02', NULL),
('790d87a5-2ae9-5430-840a-83736bee1d62', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'a3218aa8-f025-5b89-b870-d100001f417b', 'Realisasi APBDes Desa Martopuro 2024', 'realisasi-apbdes-desa-martopuro-2024', 'Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.', '<p>Informasi realisasi APBDes Desa Martopuro Kecamatan Purwosari tahun anggaran 2024.</p><p>Berita ini termasuk kategori APBDes Desa Martopuro dan dipublikasikan pada 2025-04-14.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-14 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7969e1ae-86fa-516c-90fc-e15f0a2a548c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro', 'musyawarah-desa-khusus-musdesus-desa-martopuro', 'Musyawarah Desa Khusus (Musdesus) Desa Martopuro.', '<p>Musyawarah Desa Khusus (Musdesus) Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Hebohnya Parade Karnaval Martopuro 2025, Mengalir Apresiasi SUKSES dan Permintaan diadakan lagi Tahun Depan', 'hebohnya-parade-karnaval-martopuro-2025-mengalir-apresiasi-sukses-dan-permintaan-diadakan-lagi-tahun-depan', 'Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.', '<p>Parade Karnaval Martopuro 2025 dalam rangka HUT RI ke-80 mendapat apresiasi dan permintaan agar digelar kembali tahun depan.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-08-24.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-24 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7f3337b0-02b3-48e6-81e0-a75bd6084ea9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.', 'pembangunan-tpt-pertanian-dusun-kemantren-rw04-desa-martopuro-mpupj0ks-3c00eac2', 'Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.', '<p>Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.</p><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288030/martopuro/news/covers/sedang-1751362683-515085431-1090180322990881-6671053845825868436-n_bvlxtj.webp', 'published', 1, '2026-06-01 11:27:11', '2026-06-01 04:27:15', '2026-06-01 04:27:15', NULL),
('80db5a2e-efdb-48b2-8148-b63b1c72b89e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', '27 RW siap Mensukseskan Karnaval Martopuro 2025', '27-rw-siap-mensukseskan-karnaval-martopuro-2025-mpuplo7h-433ee772', '27 RW siap Mensukseskan Karnaval Martopuro 2025', '<p>pemerintah desa martopuro bersama karangtaruna mengumpulkan seluruh RW se desa martopuro untuk musyawarah terkait kegiatan peringatan hari besar nasiona, memperingati kemerdekaan republik indonesia yang ke 80 tahun, dan pada tahun ini karangtaruna mengonsep kegiatan itu dengan karnaval dan turnamen sepak bola antar kampung, namun pembahasan pada hari rabu, 09 juli 2024 dimulai pukul 20.00 wib, fokus membahas terkait kesepakatan mensukseskan karnaval.</p><p>kepala desa martopuro menekankan kepada seluruh rw untuk bisa terlibat dan mensukseskan kegitan tersebut. adapun hasil dari musyawarah semalam menghasilak beberapa kesepakatan dan evaluasi yang perlu dipertimbangkan panitia untuk mensukses kegiatan tersebut.<br></p><p>Hasil Rakor Pemdes , Katar, Ketua RW se Desa Martopuro</p><p>Hasil Musyawarah 9 Juli 2025</p><p>- Disepakati Karnaval 24 Agustus 2025<br>- 10 Agustus Technical Meeting<br>- Tarkam InsyaAllah Bulan September<br>- Menyepakati Persyaratan Karnaval<br>- disepakati Peserta Per RW &amp; Subsidi 1 000.000<br>- Tiap RW membentuk Susunan Panitia Lokal tiap RW untuk pelaporan APBD<br>- Pengumpulan Susunan Kepanitiaan per RW terakhir hari Rabu tanggal 16 Juli 2025<br>- Pencairan dana subsidi ketika setelah setor kepanitiaan lokal RW<br>- Pak Kades dan Perangkat wajib On Time hadir dalam Pemberangkatan karnval 09.00 Wib<br>- Peserta hanya diperbolehkan untuk Perform di pos yang sudah di tentukan Panitia (Finis)<br>- Juri mendatangkan dari Profesional seni dan kebudayaan<br>- Panitia menyiapkan anggota untuk mengatur lalulintas agar tidak terlalu jauh jarak tiap peserta<br>- Di Perketat untuk pemberangkatan peserta agar on time tidak molor (masuk dalam penilaian)</p><p><br>Semoga karnaval tahun ini berjalan sukses dan lebih meriah Aamiin.<br>selebihnya informasi bisa dicek di poster dibawah</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288154/martopuro/news/covers/sedang-1752115815-untitled-1_bdxrqg.webp', 'published', 2, '2026-06-01 11:29:15', '2026-06-01 04:29:18', '2026-06-01 04:29:18', NULL),
('838dcc0a-b872-46b8-9d03-809ea392c667', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro', 'bumdes-berupaya-untuk-optimal-dalam-program-ketahanan-pangan-desa-martopuro-mpurl4j8-4b923024', 'Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa MartopuroBumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro', '<p>Bumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa MartopuroBumdes berupaya untuk optimal dalam program Ketahanan Pangan Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291488/martopuro/news/covers/sedang-1764728519-561325022-1173416008000645-6302788988409644531-n_ynuqnd.webp', 'published', 1, '2026-06-01 12:24:49', '2026-06-01 05:24:52', '2026-06-01 05:24:52', NULL),
('85923343-5bc2-47b6-8098-ded6a436a108', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.', 'penyaluran-blt-dana-desa-bulan-juli-agustus-2025-desa-martopuro-mpur0r6a-fa146676', 'Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.', '<p>Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290533/richtext/images/sedang-1755828789-536275027-1128858165789763-646067462744295419-n_limoml.webp\" alt=\"sedang_1755828789_536275027_1128858165789763_646067462744295419_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290537/martopuro/news/covers/sedang-1755828789-536272717-1128858212456425-6226277653469695151-n_bjewcu.webp', 'published', 1, '2026-06-01 12:08:58', '2026-06-01 05:09:02', '2026-06-01 05:09:02', NULL),
('85add9c7-533d-4ac0-aad8-2d6c0ed022ef', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.', 'serah-terima-aset-koperasi-desa-merah-putih-kdmp-ke-pemdes-martopuro-mput4ogm-ee3f0b56', 'Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.', '<p>Serah Terima Aset Koperasi Desa Merah Putih ( KDMP ) ke Pemdes Martopuro.</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780294065/richtext/images/sedang-1779155776-700708427-1339943934681184-2371708735377060474-n-1_vih1xj.webp\" alt=\"sedang_1779155776_700708427_1339943934681184_2371708735377060474_n (1).jpg\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780294077/richtext/images/sedang-1779155776-702764615-1339943768014534-3013305737483254325-n-1_tk1zdb.webp\" alt=\"sedang_1779155776_702764615_1339943768014534_3013305737483254325_n (1).jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780294080/martopuro/news/covers/sedang-1779155776-700506355-1339943901347854-3727692882221577314-n-1_pla1sz.webp', 'published', 1, '2026-06-01 13:08:00', '2026-06-01 06:08:05', '2026-06-01 06:08:05', NULL),
('876b91c3-c511-4b5a-9e33-5824a8c36673', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Monitoring Pajak Bumi & Bangunan oleh tim Monitoring Kecamatan Purwosari.', 'monitoring-pajak-bumi-bangunan-oleh-tim-monitoring-kecamatan-purwosari-mpurs1ng-3e6c0c66', 'Monitoring Pajak Bumi & Bangunan oleh tim Monitoring Kecamatan Purwosari.', '<p>Monitoring Pajak Bumi &amp; Bangunan oleh tim Monitoring Kecamatan Purwosari.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291811/martopuro/news/covers/sedang-1764728032-574565442-1186521863356726-755229496891113583-n_jxa356.webp', 'published', 1, '2026-06-01 12:30:11', '2026-06-01 05:30:15', '2026-06-01 05:30:15', NULL),
('89e6969a-b520-46f6-8455-e78851167504', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pavingisasi Makam Umum Desa Martopuro', 'pavingisasi-makam-umum-desa-martopuro-mpusnppy-b8aca757', 'Pavingisasi Makam Umum Desa Martopuro', '<p>Pavingisasi Makam Umum Desa Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293288/martopuro/news/covers/sedang-1777519661-680271247-1320638323278412-5187780141223512381-n_y2x17n.webp', 'published', 1, '2026-06-01 12:54:49', '2026-06-01 05:54:52', '2026-06-01 05:54:52', NULL),
('8a01ce05-ab85-473f-8ba4-c8acc36cb7c9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.', 'musyawarah-desa-penyusunan-rencana-kerja-pembangunan-desa-martopuro-2026-mpus7mjo-0c5df76c', 'Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.', '<p>Musyawarah Desa Penyusunan Rencana Kerja Pembangunan Desa Martopuro 2026.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292537/martopuro/news/covers/sedang-1770517629-596673546-1216803140328598-4782761673317246379-n_csxgbr.webp', 'published', 1, '2026-06-01 12:42:18', '2026-06-01 05:42:22', '2026-06-01 05:42:22', NULL),
('8b180121-8129-4c20-bc1c-9b6c47c4adaf', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Skrining TBC Dinkes Kab.Pasuruan di Desa Martopuro.', 'giat-skrining-tbc-dinkes-kabpasuruan-di-desa-martopuro-mq86ys0l-843bca72', 'Giat Skrining TBC Dinkes Kab.Pasuruan di Desa Martopuro.', '<p>Giat Skrining TBC Dinkes Kab.Pasuruan di Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103382/martopuro/news/covers/712543905-1352447340097510-8692180961330865429-n_kre4uw.webp', 'published', 1, '2026-06-10 21:56:20', '2026-06-10 14:56:25', '2026-06-10 14:56:25', NULL),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Merealisasikan TPT & Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro', 'merealisasikan-tpt-dan-pavingisasi-pemukiman-dusun-puntir-dana-desa-martopuro', 'Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.', '<p>Realisasi TPT dan pavingisasi pemukiman Dusun Puntir melalui Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-24.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-24 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('8d9a0bf7-0371-56d2-b5df-c00099b22b88', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembinaan Linmas Desa Martopuro.', 'pembinaan-linmas-desa-martopuro', 'Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.', '<p>Pembinaan Linmas Desa Martopuro untuk penguatan kesiapsiagaan dan ketertiban lingkungan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-27.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-27 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Sukses mengadakan Donor Darah Sebelum Bulan Puasa, Agenda Rutin 3bulan sekali Karang Taruna Permata Karya Desa Martopuro', 'sukses-mengadakan-donor-darah-sebelum-bulan-puasa-agenda-rutin-3bulan-sekali-karang-taruna-permata-karya-desa-martopuro', 'Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.', '<p>Karang Taruna Permata Karya Desa Martopuro kembali menggelar kegiatan sosial donor darah menjelang bulan puasa.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2026-02-08.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-02-08 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('8fd48cd4-c4cc-4c03-b031-45b1cf409659', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama PT.Indolakto', 'sukses-mengadakan-santunan-105-anak-yatim-desa-martopuro-oleh-kepala-desa-martopuro-bersama-ptindolakto-mpunu6jy-3dd211f0', 'Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama  PT.IndolaktoSukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama  PT.Indolakto Purwosari', '<p>Sukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama &nbsp;PT.IndolaktoSukses mengadakan Santunan 105 Anak Yatim Desa Martopuro oleh Kepala Desa Martopuro bersama &nbsp;PT.Indolakto Purwosari</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285189/richtext/images/sedang-1744553428-486610822-1020383916637189-8801666334798858554-n_tjyfsa.webp\" alt=\"sedang_1744553428_486610822_1020383916637189_8801666334798858554_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285192/martopuro/news/covers/sedang-1744553428-486611200-1020368339972080-624990683532063750-n_brz1o9.webp', 'published', 1, '2026-06-01 10:39:53', '2026-06-01 03:39:56', '2026-06-01 03:39:56', NULL),
('8fe40173-2173-4961-a74c-f8ff0e7507f4', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Turnamen Bola Voly Martopuro Cup Resmi dibuka diikuti Tim dari berbagai Kota, Pasuruan dan Sekitarnya', 'turnamen-bola-voly-martopuro-cup-resmi-dibuka-diikuti-tim-dari-berbagai-kota-pasuruan-dan-sekitarnya-mpure1g9-ab677c7a', 'Dalam rangka memperingati Hari Ulang Tahun (HUT) ke-80 Republik Indonesia, Pemerintah Desa (Pemdes) Martopuro', '<p>Dalam rangka memperingati Hari Ulang Tahun (HUT) ke-80 Republik Indonesia, Pemerintah Desa (Pemdes) Martopuro bersama Karang Taruna PERMATA KARYA Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, resmi menggelar Turnamen Bola Voli Martopuro Cup 2025.</p><p>Kegiatan ini diharapkan dapat menjadi ajang pencarian bibit atlet bola voli berbakat di wilayah setempat.</p><p>Turut hadir dalam acara pembukaan, Camat Purwosari Munif Triatmoko, Kapolsek Purwosari Iptu Yusuf, Danramil 0819/21 Purwosari Mukrab, Kepala Desa Martopuro Rianto, Ketua BPD Martopuro, serta Ketua Karang Taruna PERMATA KARYA Desa Martopuro, pada Minggu (7/9).</p><p>Turnamen Martopuro Cup 2025 dibuka secara resmi oleh Camat Purwosari Munif Triatmoko di Lapangan Bola Voli Dusun Pakem. Dalam sambutannya, ia menyampaikan bahwa kegiatan ini tidak hanya sebagai peringatan HUT ke-80 Republik Indonesia, tetapi juga dalam rangka memperingati Hari Jadi Kabupaten Pasuruan.</p><p>“Dengan adanya turnamen ini, diharapkan lahir bibit-bibit atlet voli yang handal dan mampu mengharumkan nama Desa Martopuro, Kecamatan Purwosari, hingga Kabupaten Pasuruan. Dengan mengucap bismillah, Turnamen Bola Voli Martopuro Cup 2025 saya nyatakan resmi dibuka. Selamat bertanding, junjung tinggi sportivitas,” ujar Munif.</p><p>Sementara itu, Kepala Desa Martopuro Rianto menyampaikan, apresiasi kepada masyarakat, khususnya warga Dusun Pakem, atas dukungan penuh terhadap terselenggaranya kegiatan tersebut. Menurutnya, turnamen ini sekaligus menjadi sarana untuk meningkatkan kesadaran masyarakat akan pentingnya olahraga.</p><p>“Turnamen ini diharapkan mampu mengurangi kegiatan negatif di masyarakat, serta memperkuat persatuan dan kerukunan warga. Semoga seluruh rangkaian kegiatan dapat berjalan aman, lancar, dan mendapat ridha Allah SWT,” tutur Rianto.</p><p>Di sisi lain, Adi Darmawan selaku perwakilan Karangtaruna Permata Karya yang membuka turnamen, menegaskan bahwa Martopuro Cup telah menjadi agenda yang menjadi tolak ukuran produktifitas dibidang olahraga untuk mencari bakat minat masyarakat martopuro dan sekitarnya, agenda ini menjadi agenda tahunan. dan alhamdulillah Pada tahun ini, kita bisa mengadakan turnamen antar kampung (tarkam) yang diikuti oleh 32 tim Putra dan 16 Tim Putri dari berbagai kota diluar kota kabupaten pasuruan. “Kami berharap seluruh tim dapat menjunjung tinggi sportivitas. Untuk para supporter, mari bersama menjaga kondusivitas demi kelancaran dan kesuksesan turnamen ini, dan semoga menjadi bagian dari sesuai tema turnamen pada tahun ini \"Menumbuhkan Sportivitas Sehat, Mewujudkan Generasi Berjaya&nbsp; Tanpa Narkoba\".</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291157/martopuro/news/covers/sedang-1757313016-a_zg2rcl.webp', 'published', 2, '2026-06-01 12:19:18', '2026-06-01 05:19:23', '2026-06-01 05:19:23', NULL),
('90753d65-2026-5e82-b69a-39c3d7d6840a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Rehab Kantor HIPPA ( Himpunan Petani Pemakai Air ) Desa Martopuro', 'rehab-kantor-hippa-himpunan-petani-pemakai-air-desa-martopuro', 'Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.', '<p>Rehabilitasi Kantor HIPPA Desa Martopuro agar dapat dimanfaatkan lebih baik.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-30 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('9198aa9c-915c-582d-8e20-608ec82b6c1c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '6009b765-2f64-50fd-951d-07a709ad1119', 'Lembaga di Desa Martopuro', 'lembaga-di-desa-martopuro', 'Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.', '<p>Informasi lembaga desa seperti BPD, LPMD, PKK, dan unsur kelembagaan lainnya di Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Lembaga Desa Martopuro dan dipublikasikan pada 2025-04-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('92677901-c5ac-595a-8835-27d8ed0af3f0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', '4 Tahun Pengabdian & Karya Nyata Kepala Desa Martopuro', '4-tahun-pengabdian-dan-karya-nyata-kepala-desa-martopuro', 'Empat tahun pengabdian menjadi momentum apresiasi atas karya nyata Kepala Desa Martopuro bersama masyarakat.', '<p>Empat tahun bukan waktu yang singkat untuk mengabdi dan membersamai masyarakat.<br>Terima kasih yang sebesar-besarnya kami sampaikan kepada Kepala Desa Rianto atas dedikasi, kerja keras, dan pengabdian selama 4 tahun memimpin Desa Martopuro.</p><p>Berbagai pembangunan, pelayanan, serta perhatian kepada masyarakat telah menjadi bagian dari perjalanan kepemimpinan yang penuh tanggung jawab. Semoga setiap langkah dan perjuangan yang telah dilakukan menjadi amal kebaikan dan membawa manfaat nyata bagi seluruh warga desa.</p><p>Terima kasih atas ketulusan dalam melayani, kesabaran dalam memimpin, dan semangat dalam membangun desa menuju kemajuan yang lebih baik.<br>Semoga Desa Martopuro semakin maju, harmonis, dan sejahtera di bawah kepemimpinan yang amanah.</p><p>“Pemimpin yang baik bukan hanya dikenang karena jabatannya, tetapi karena pengabdiannya untuk masyarakat.”<br><br></p><h2><strong>4 TAHUN PENGABDIAN &amp; KARYA NYATA</strong></h2><h3><strong>TERIMA KASIH</strong></h3><p>Kepada<br>Rianto<br>Kepala Desa Martopuro</p><p>Atas dedikasi, kerja keras, dan pengabdian<br>dalam membangun desa serta melayani masyarakat<br>selama 4 tahun kepemimpinan.</p><h3><strong>CAPAIAN &amp; PRESTASI</strong></h3><p>✅ Peningkatan pembangunan infrastruktur desa<br>✅ Perbaikan jalan lingkungan dan fasilitas umum<br>✅ Penguatan pelayanan masyarakat yang lebih baik<br>✅ Peningkatan kualitas SDM melalui kegiatan pendidikan, pelatihan, dan pemberdayaan warga<br>✅ Pengembangan UMKM dan ekonomi masyarakat desa<br>✅ Peningkatan pendapatan desa dan pengelolaan potensi desa<br>✅ Penguatan kegiatan sosial, keagamaan, dan kepemudaan<br>✅ Mendorong terciptanya desa yang lebih maju, tertata, dan harmonis</p><p>Terima kasih atas ketulusan dalam mengabdi<br>dan semangat membangun demi kemajuan bersama.</p><h3><strong>“Bersama Membangun Desa,</strong></h3><p>Bersama Mewujudkan Martopuro yang Lebih Maju &amp; Sejahtera.”</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780283544/richtext/images/sedang-1778560271-whatsapp-image-2026-05-12-at-11-26-44_ymdqsd.webp\" alt=\"sedang_1778560271_WhatsApp_Image_2026-05-12_at_11.26.44.jpeg\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780283557/richtext/images/sedang-1778560271-whatsapp-image-2026-05-12-at-11-26-40_y97hug.webp\" alt=\"sedang_1778560271_WhatsApp_Image_2026-05-12_at_11.26.40.jpeg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780149654/martopuro/news/covers/sedang-1778560271-chatgpt-image-12-mei-2026-11-30-55_susey7.webp', 'published', 2, '2026-06-01 10:12:40', '2026-05-21 01:30:02', '2026-06-01 03:12:45', NULL),
('93b7ab59-b0ac-5d18-96a2-e07db2776730', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Buka Bersama Keluarga Besar Pemdes Martopuro.', 'buka-bersama-keluarga-besar-pemdes-martopuro', 'Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.', '<p>Buka bersama keluarga besar Pemerintah Desa Martopuro sebagai momentum silaturahmi dan kebersamaan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-03-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-03-01 09:00:00', '2026-05-21 01:30:02', '2026-05-30 14:01:34', '2026-05-30 14:01:34'),
('9427ff79-8c0f-4f89-8ee2-9863c7e309cc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Polsek Purwosari Kerahkan Personel Dukung BUMDes Martopuro Garap Lahan Ketahanan Pangan', 'polsek-purwosari-kerahkan-personel-dukung-bumdes-martopuro-garap-lahan-ketahanan-pangan-mpuqs959-05628765', 'Dalam rangka mendukung program ketahanan pangan di wilayah hukum Polsek Purwosari', '<p>Dalam rangka mendukung program ketahanan pangan di wilayah hukum Polsek Purwosari, Kapolsek Purwosari&nbsp; menurunkan sejumlah personel untuk membantu Badan Usaha Milik Desa (BUMDes) Purwosari dalam kegiatan pengolahan lahan pertanian milik desa, yang akan ditanami jagung.Rabu (06/08/2025).</p><p>Kapolsek Purwosari mengatakan kegiatan ini berlangsung di lahan milik desa seluas hampir 1 hektare yang terletak di wilayah Dusun Pakem, Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan.</p><p>Personel Polsek Purwosari tampak bergotong royong bersama pengurus BUMDes, Kepala Desa Serta Kepala Dusun, Bersama Komandan Koramel, serta warga sekitar dalam pengolahan awal lahan.</p><p>“Keterlibatan anggota kami ini merupakan bentuk dukungan terhadap upaya pemerintah dalam penguatan ketahanan pangan melalui sinergitas antara aparat keamanan dan masyarakat.” ujar Kapolsek.</p><p>“Kami tidak hanya menjaga keamanan, tapi juga hadir langsung membantu masyarakat dalam kegiatan produktif seperti ini. Apalagi ini bagian dari upaya BUMDes untuk membangkitkan ekonomi desa pasca pandemi,” tambah Kapolsek.</p><p>Pengelola BUMDes Purwosari dan kepala desa martopuro menyambut positif dukungan dari Polsek Purwosari dengan harapan sinergi ini bisa berkelanjutan dan menjadi contoh bagi desa lain.</p><p>“Ini bentuk upaya kalaborasi ddalam mensukseskan program pemerintah terkait ketahanan pangan dan Ini menunjukkan bahwa Pemerintah, TNI-Polri benar-benar hadir di tengah masyarakat bukan hanya dalam konteks keamanan saja, tapi juga pembangunan,” kata Camat Purwosari dalam sambutannya.</p><p>Sementara itu, jajaran Forkopimcam turut hadir meninjau kegiatan tersebut, mengapresiasi kolaborasi antara BUMDes, aparat desa, dan unsur TNI-Polri.</p><p>Dengan ditanamnya jagung di lahan tersebut, diharapkan akan ada peningkatan produksi pangan lokal dan menambah pendapatan desa, sekaligus menjadi langkah awal menuju kemandirian ekonomi masyarakat.</p><p>Polsek Purwosari Kerahkan Personel Dukung BUMDes Martopuro Garap Lahan Ketahanan Pangan</p><p>Dalam rangka mendukung program ketahanan pangan di wilayah hukum Polsek Purwosari, Kapolsek Bayongbong AKP Dadan menurunkan sejumlah personel untuk membantu Badan Usaha Milik Desa (BUMDes) Purwosari dalam kegiatan pengolahan lahan pertanian milik desa, yang akan ditanami jagung.Rabu (06/08/2025).</p><p>Kapolsek Purwosari mengatakan kegiatan ini berlangsung di lahan milik desa seluas hampir 1 hektare yang terletak di wilayah Dusun Pakem, Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan.</p><p>Personel Polsek Purwosari tampak bergotong royong bersama pengurus BUMDes, Kepala Desa Serta Kepala Dusun, Bersama Komandan Koramel, serta warga sekitar dalam pengolahan awal lahan.</p><p>“Keterlibatan anggota kami ini merupakan bentuk dukungan terhadap upaya pemerintah dalam penguatan ketahanan pangan melalui sinergitas antara aparat keamanan dan masyarakat.” ujar Kapolsek.</p><p>“Kami tidak hanya menjaga keamanan, tapi juga hadir langsung membantu masyarakat dalam kegiatan produktif seperti ini. Apalagi ini bagian dari upaya BUMDes untuk membangkitkan ekonomi desa pasca pandemi,” tambah Kapolsek.</p><p>Pengelola BUMDes Purwosari dan kepala desa martopuro menyambut positif dukungan dari Polsek Purwosari dengan harapan sinergi ini bisa berkelanjutan dan menjadi contoh bagi desa lain.</p><p>“Ini bentuk upaya kalaborasi ddalam mensukseskan program pemerintah terkait ketahanan pangan dan Ini menunjukkan bahwa Pemerintah, TNI-Polri benar-benar hadir di tengah masyarakat bukan hanya dalam konteks keamanan saja, tapi juga pembangunan,” kata Camat Purwosari dalam sambutannya.</p><p>Sementara itu, jajaran Forkopimcam turut hadir meninjau kegiatan tersebut, mengapresiasi kolaborasi antara BUMDes, aparat desa, dan unsur TNI-Polri.</p><p>Dengan ditanamnya jagung di lahan tersebut, diharapkan akan ada peningkatan produksi pangan lokal dan menambah pendapatan desa, sekaligus menjadi langkah awal menuju kemandirian ekonomi masyarakat.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290141/martopuro/news/covers/sedang-1754449404-963948d4-e568-4da6-8e84-7a545c614665_eequ7n.webp', 'published', 3, '2026-06-01 12:02:22', '2026-06-01 05:02:25', '2026-06-01 05:02:25', NULL),
('943d16c5-7f8b-4f3d-b840-79a33d47341a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembinaan Karang Taruna \"Permata Karya\" Desa Martopuro.', 'pembinaan-karang-taruna-permata-karya-desa-martopuro-mpuqkpbk-35210de9', 'Pembinaan Karang Taruna \"Permata Karya\" Desa Martopuro. sukses dilaksanakan dan ditutup dengan simbolis penyeragan kaos MCF 2025 ke kepala desa', '<p>Pembinaan Karang Taruna \"Permata Karya\" Desa Martopuro. sukses dilaksanakan dan ditutup dengan simbolis penyeragan kaos MCF 2025 ke kepala desa , bentuk Siap melaksanakan dan memeriahkan kegiatan Peringatan hari besar nasional PHBN memperingati dirgahayu republik indonesia ke 80 tahun dengan event akbar martopuro culture fest 2025, semoga bisa berjalan lancar dan sukses&nbsp;</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780289789/martopuro/news/covers/sedang-1753619828-524614306-1109088187766761-8710977693144954047-n_wmbr9k.webp', 'published', 1, '2026-06-01 11:56:29', '2026-06-01 04:56:33', '2026-06-01 04:56:33', NULL),
('95574412-da92-4b47-b5c1-a534b099adf3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembinaan RT&RW Desa Martopuro Semester 1 2025', 'pembinaan-rtrw-desa-martopuro-semester-1-2025-mpup0qyr-7d435724', 'Pembinaan Ketua Rukun Warga (RW) & Ketua Rukun Tetangga (RT) Desa Martopuro Kec.Purwosari Kab.Pasuruan.Semester 1 2025', '<p>Pembinaan Ketua Rukun Warga (RW)<br>&amp; Ketua Rukun Tetangga (RT) Desa Martopuro Kec.Purwosari Kab.Pasuruan.Semester 1 2025</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287174/richtext/images/sedang-1749829889-506462098-1077077457634501-1771569227210308015-n_eqchym.webp\" alt=\"sedang_1749829889_506462098_1077077457634501_1771569227210308015_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287177/martopuro/news/covers/sedang-1749829889-506735127-1077078160967764-1511871686337315013-n_tor20c.webp', 'published', 1, '2026-06-01 11:12:59', '2026-06-01 04:13:02', '2026-06-01 04:13:02', NULL),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dc0a287d-c539-5407-b1af-83479bbde6b3', 'Musyawarah Desa Martopuro RKP Tahun 2026', 'musyawarah-desa-martopuro-rkp-tahun-2026', 'Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.', '<p>Musyawarah Desa Martopuro membahas RKP tahun 2026, termasuk pencermatan RPJM Desa dan agenda pembangunan.</p><p>Berita ini termasuk kategori BPD Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('9725e507-3b88-4fef-901d-1c294738ec53', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro', 'musyawarah-desa-khusus-musdesus-desa-martopuro-mpun954p-a45bce0a', 'Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro', '<p>Musyawarah Desa Khusus ( Musdesus ) Desa Martopuro</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284205/richtext/images/sedang-1744697044-480569229-996048469070734-7967971617934426804-n_h8tnvj.webp\" alt=\"sedang_1744697044_480569229_996048469070734_7967971617934426804_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284210/martopuro/news/covers/sedang-1744697044-480465311-996048545737393-5541269772237999676-n_rgbiyr.webp', 'published', 1, '2026-06-01 10:23:31', '2026-06-01 03:23:35', '2026-06-01 03:23:35', NULL),
('97ad3f42-b363-4bf3-b7eb-94f7b9d37655', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Business Matching Kab.Pasuruan.', 'giat-business-matching-kabpasuruan-mpus9u7h-ee259ab0', 'Giat Business Matching Kab.Pasuruan.', '<p>Giat Business Matching Kab.Pasuruan.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292641/martopuro/news/covers/sedang-1770517766-596861424-1218313763510869-971277024492880376-n_xddlcf.webp', 'published', 1, '2026-06-01 12:44:02', '2026-06-01 05:44:05', '2026-06-01 05:44:05', NULL),
('9a2e7ab7-88f1-4e60-9369-9835a0388f08', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Progres pavingisasi barat lapangan Desa Martopuro', 'progres-pavingisasi-barat-lapangan-desa-martopuro-mpuohd9k-c99d4aa7', 'Dalam akhir akhir ini kepala desa martopuro (Bpk.Rianto) / pemerintah desa martopuro dari akhir tahun 2024', '<p>Dalam akhir akhir ini kepala desa martopuro (Bpk.Rianto) / pemerintah desa martopuro dari akhir tahun 2024 sampai bulan ini 2025 banyak sekali perkembangan dalam perbaikan Lapangan martopuro, sampai detik ini masih berlanjut , dalam tahap ini sudah mulai progres pavingisasi barat lapangan panutan Desa Martopuro. Harapan pak kades semoga lapangan ini bisa jadi nilai aset produktif dalam pengembangan dibidang olahraga maupun sarana yang memadai untuk pertumbuhan desa martopuro.&nbsp;</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286272/richtext/images/sedang-1745387879-492361368-1040842267924687-4597046285932482033-n_eidjj2.webp\" alt=\"sedang_1745387879_492361368_1040842267924687_4597046285932482033_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286274/martopuro/news/covers/sedang-1745387879-493099933-1040842434591337-5883974128698306831-n_vu2xd3.webp', 'published', 1, '2026-06-01 10:57:54', '2026-06-01 03:57:58', '2026-06-01 03:57:58', NULL),
('9acd95c9-dbf9-4558-869d-a788e5b39bf9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyerahan BLT DD Bulan April Mei 2025 Desa Martopuro.', 'penyerahan-blt-dd-bulan-april-mei-2025-desa-martopuro-mpuoounx-1c79d7df', 'Penyerahan Bantuan Langsung Tunai Dana Desa (BLT-DD) Tahun 2025 Kepada 41 KPM Keluarga Miskin Desa Martopuro Kec.Purwosari Kab.Pasuruan', '<p>Penyerahan Bantuan Langsung Tunai Dana Desa (BLT-DD) Tahun 2025 Kepada 41 KPM Keluarga Miskin Desa Martopuro Kec.Purwosari Kab.Pasuruan</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286623/martopuro/news/covers/sedang-1749737051-497622883-1054883159853931-2538353425675521993-n_xtmv6a.webp', 'published', 1, '2026-06-01 11:03:44', '2026-06-01 04:03:47', '2026-06-01 04:03:47', NULL),
('9b1728a0-64b6-4f96-9e35-4bf000f80ecb', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran Bantuan Pangan Desa Martopuro.', 'penyaluran-bantuan-pangan-desa-martopuro-mpus17mh-0b0e49ba', 'Penyaluran Bantuan Pangan Desa Martopuro.', '<p>Penyaluran Bantuan Pangan Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292238/martopuro/news/covers/sedang-1765168329-595376723-1213258307349748-5055715011229485179-n_evvfzn.webp', 'published', 1, '2026-06-01 12:37:19', '2026-06-01 05:37:23', '2026-06-01 05:37:23', NULL),
('9bd335b4-71c8-5489-958f-434540bdc86c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Kunjungan Haji Pemdes Martopuro.', 'giat-kunjungan-haji-pemdes-martopuro', 'Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.', '<p>Pemerintah Desa Martopuro mengunjungi warga yang telah pulang dari ibadah haji.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('9dadaee9-719d-548b-8238-f4fe52022f8c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran BLT Dana Desa Bulan Juli-Agustus 2025 Desa Martopuro.', 'penyaluran-blt-dana-desa-bulan-juli-agustus-2025-desa-martopuro', 'Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.', '<p>Penyaluran BLT Dana Desa bulan Juli-Agustus 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pavingisasi Depan Gerai KDMP Desa Martopuro.', 'pavingisasi-depan-gerai-kdmp-desa-martopuro', 'Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.', '<p>Pavingisasi depan Gerai KDMP Desa Martopuro untuk menunjang akses dan kenyamanan area koperasi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-04.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203061/martopuro/news/covers/sedang-1778211308-2aa46fc9-e6ea-453b-9aa8-ba9bf851be4e_t0pzet.webp', 'published', 1, '2026-05-04 16:00:00', '2026-05-21 01:30:02', '2026-05-31 04:51:06', NULL),
('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '0dc3abf2-de70-5cef-b90c-c6872b5f8816', 'Laporan Pertanggungjawaban BUMDES \"Karya Usaha Mandiri\" Desa Martopuro Tahun Anggaran 2025.', 'laporan-pertanggungjawaban-bumdes-karya-usaha-mandiri-desa-martopuro-tahun-anggaran-2025', 'Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.', '<p>Laporan pertanggungjawaban BUMDes Karya Usaha Mandiri Desa Martopuro tahun anggaran 2025.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2026-01-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('a32f4017-70d6-48fb-abc4-3c4c2d1672fc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun di Desa Martopuro di masa kepemimpinan Kepala Desa Rianto', 'manaqib-dzikir-ghofilin-rutin-di-agendakan-setiap-tahun-di-desa-martopuro-di-masa-kepemimpinan-kepala-desa-rianto-mpup9gk5-f1af9131', 'Alhamdulillah Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun dilingkungan desa martopuro sebagai bentuk doa bersama', '<p>Alhamdulillah Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun dilingkungan desa martopuro sebagai bentuk doa bersama selamatan warga / masyarakat desa martopuro, jangan lupa insyallah tahun ini 2025, akan diadakan pada tanggal 06 Juli 2025, di lapangan Puntir desa martopuro, harapan kami pemerintah desa martopuro, doa bersama ini bisa menghadirkan kebaikan kebaikan di lingkungan desa martopuro dan menjadi agenda yang bisa merekatkan hubungan silaturrahmi antar seluruh warga martopuro melalui doa bersama manaqib dzikir ghofilin. Aamiin</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287584/martopuro/news/covers/sedang-1750308127-banner-iklan_avcy1u.webp', 'published', 1, '2026-06-01 11:19:45', '2026-06-01 04:19:49', '2026-06-01 04:19:49', NULL),
('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Pengukuran Dimensi dan Titik Gawang Lapangan Panutan Desa Martopuro.', 'giat-pengukuran-dimensi-dan-titik-gawang-lapangan-panutan-desa-martopuro', 'Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.', '<p>Pengukuran dimensi dan titik gawang Lapangan Panutan Desa Martopuro untuk penataan fasilitas olahraga.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-14.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-14 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('a6926834-c014-45e2-817c-a1e3fda225f3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', '4 Tahun Pengabdian & Karya Nyata Kepala Desa Martopuro', '4-tahun-pengabdian-karya-nyata-kepala-desa-martopuro-mput2qz4-9cea699a', 'Empat tahun bukan waktu yang singkat untuk mengabdi dan membersamai masyarakat. Terima kasih yang sebesar-besarnya kami sampaikan kepada Kepala Desa Rianto atas dedikasi, kerja keras, dan pengabdian selama 4 tahun memimpin Desa Martopuro.', '<p>Empat tahun bukan waktu yang singkat untuk mengabdi dan membersamai masyarakat.<br>Terima kasih yang sebesar-besarnya kami sampaikan kepada Kepala Desa Rianto atas dedikasi, kerja keras, dan pengabdian selama 4 tahun memimpin Desa Martopuro.</p><p>Berbagai pembangunan, pelayanan, serta perhatian kepada masyarakat telah menjadi bagian dari perjalanan kepemimpinan yang penuh tanggung jawab. Semoga setiap langkah dan perjuangan yang telah dilakukan menjadi amal kebaikan dan membawa manfaat nyata bagi seluruh warga desa.</p><p>Terima kasih atas ketulusan dalam melayani, kesabaran dalam memimpin, dan semangat dalam membangun desa menuju kemajuan yang lebih baik.<br>Semoga Desa Martopuro semakin maju, harmonis, dan sejahtera di bawah kepemimpinan yang amanah.</p><p>“Pemimpin yang baik bukan hanya dikenang karena jabatannya, tetapi karena pengabdiannya untuk masyarakat.”<br><br></p><h2><strong>4 TAHUN PENGABDIAN &amp; KARYA NYATA</strong></h2><h3><strong>TERIMA KASIH</strong></h3><p>Kepada<br>Rianto<br>Kepala Desa Martopuro</p><p>Atas dedikasi, kerja keras, dan pengabdian<br>dalam membangun desa serta melayani masyarakat<br>selama 4 tahun kepemimpinan.</p><h3><strong>CAPAIAN &amp; PRESTASI</strong></h3><p>✅ Peningkatan pembangunan infrastruktur desa<br>✅ Perbaikan jalan lingkungan dan fasilitas umum<br>✅ Penguatan pelayanan masyarakat yang lebih baik<br>✅ Peningkatan kualitas SDM melalui kegiatan pendidikan, pelatihan, dan pemberdayaan warga<br>✅ Pengembangan UMKM dan ekonomi masyarakat desa<br>✅ Peningkatan pendapatan desa dan pengelolaan potensi desa<br>✅ Penguatan kegiatan sosial, keagamaan, dan kepemudaan<br>✅ Mendorong terciptanya desa yang lebih maju, tertata, dan harmonis</p><p>Terima kasih atas ketulusan dalam mengabdi<br>dan semangat membangun demi kemajuan bersama.</p><h3><strong>“Bersama Membangun Desa,</strong></h3><p>Bersama Mewujudkan Martopuro yang Lebih Maju &amp; Sejahtera.”<br><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293990/martopuro/news/covers/sedang-1778560271-chatgpt-image-12-mei-2026-11-30-55-1_p7e5bx.webp', 'published', 2, '2026-06-01 13:06:30', '2026-06-01 06:06:34', '2026-06-01 06:06:34', NULL),
('a71c4075-f75f-5679-9e9f-f92a1c40688a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Warga Padati Tarkam Bola Voly Martopuro Cup 2025, Pemain Proliga Turun Lapangan, Apresiasi Sukses Luar Biasa', 'warga-padati-tarkam-bola-voly-martopuro-cup-2025-pemain-proliga-turun-lapangan-apresiasi-sukses-luar-biasa', 'Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.', '<p>Semarak final Turnamen Bola Voli Martopuro Cup 2025 dipadati warga dan mendapat apresiasi luas.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-10-04.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-04 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('a9d605f6-deff-5623-945e-97f2db2ec56f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Sosialisasi dan Edukasi Kesehatan dari PT.Tea Fun Community Indonesia.', 'sosialisasi-dan-edukasi-kesehatan-dari-pt-tea-fun-community-indonesia', 'Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.', '<p>Sosialisasi dan edukasi kesehatan dari PT. Tea Fun Community Indonesia bagi warga Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-05-08.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780201829/martopuro/news/covers/sedang-1778561426-690745846-1331084455567132-1643283762637915006-n_vcyeog.webp', 'published', 1, '2026-05-08 16:00:00', '2026-05-21 01:30:02', '2026-05-31 04:30:32', NULL),
('ab737371-da5c-527f-9a79-9c0c2f45675a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '176d3564-eaa3-5485-8dcf-b21dd51a3670', 'Sejarah Desa Martopuro', 'sejarah-desa-martopuro', 'Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.', '<p>Sejarah Desa Martopuro masih dalam penelusuran informasi dan menjadi bagian dari profil desa.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', '27 RW siap Mensukseskan Karnaval Martopuro 2025', '27-rw-siap-mensukseskan-karnaval-martopuro-2025', 'Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.', '<p>Pemerintah Desa Martopuro bersama Karang Taruna mengumpulkan seluruh RW untuk menyukseskan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-07-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('ad96b442-3513-573f-bc25-4b8090a7cd48', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Santunan Dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro dan Pengajian rutin TP PKK Kab. Pasuruan', 'santunan-dhuafa-oleh-ibu-bupati-pasuruan-di-desa-martopuro-dan-pengajian-rutin-tp-pkk-kab-pasuruan', 'Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.', '<p>Santunan dhuafa oleh Ibu Bupati Pasuruan di Desa Martopuro serta pengajian rutin TP PKK Kabupaten Pasuruan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-16.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-16 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('ae3eaefb-4324-4180-957e-6a0b300e9e4d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga', 'hadirnya-martopuro-selection-fc-bentuk-pemerintah-desa-ingin-menggali-potensi-sdm-dibidang-olahrga-mpuquuq5-11451da4', 'Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga', '<p>Hadirnya Martopuro Selection FC bentuk pemerintah desa ingin menggali potensi SDM dibidang olahrga, laga sparing persiapan mengikuti turnamen di kayoman cup 2025 yang insyaAllah akan berlaga di tanggal 26 Agustus 2025 tepatnya setelah selesai karnaval martopuro 24 Agustus 2025, semoga tim ini memberikan warna baru di persepakbolaan indonesia khususnya kabupaten pasuruan.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290262/martopuro/news/covers/sedang-1755226459-530805985-1121995946475985-3875527738725850545-n_zkxsyu.webp', 'published', 1, '2026-06-01 12:04:23', '2026-06-01 05:04:26', '2026-06-01 05:04:26', NULL),
('ae99d98e-0fde-5894-bac8-4b5b13111604', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Business Matching Kab.Pasuruan.', 'giat-business-matching-kab-pasuruan', 'Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.', '<p>Desa Martopuro mengikuti giat Business Matching Kabupaten Pasuruan untuk membuka peluang kerja sama dan pengembangan ekonomi.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-12.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-12 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL);
INSERT INTO `news` (`id`, `tenant_id`, `category_id`, `title`, `slug`, `description_card`, `description_content`, `cover_url`, `status`, `read_time`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('b4df81e5-62e1-4be5-80fb-005b9936f970', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.', 'penyaluran-blt-dana-desa-bulan-september-oktober-desa-martopuro-2025-mpurid6o-e933fc46', 'Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.', '<p>Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291359/martopuro/news/covers/sedang-1759980091-560138653-1168180615190851-8231126175154476738-n_bcmsgq.webp', 'published', 1, '2026-06-01 12:22:40', '2026-06-01 05:22:44', '2026-06-01 05:22:44', NULL),
('b60dc01c-6683-40cb-9857-fd2293a8ff67', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Khotmil Qur\'an Jum\'at Legi Kantor Desa Martopuro Bulan Agustus 2025', 'giat-khotmil-quran-jumat-legi-kantor-desa-martopuro-bulan-agustus-2025-mpur4gjo-f07538ab', 'Giat Khotmil Qur\'an Jum\'at Legi Kantor Desa Martopuro Bulan Agustus 2025', '<p>Giat Khotmil Qur\'an Jum\'at Legi Kantor Desa Martopuro Bulan Agustus 2025</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290710/martopuro/news/covers/sedang-1755828908-536557999-1129539179054995-1680231157759224475-n_x3pyqi.webp', 'published', 1, '2026-06-01 12:11:51', '2026-06-01 05:11:54', '2026-06-01 05:11:54', NULL),
('b64e58e2-d4ad-4c27-a555-8f6f070ea501', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Tasyakuran Awal Pelaksanaan Dana Desa tahap 2 tahun 2025', 'tasyakuran-awal-pelaksanaan-dana-desa-tahap-2-tahun-2025-mpupdgef-d7bd519b', 'sebelum Doa Tasyakuran dan potongn tumpeng, Bapak Rianto selaku Kepala Desa Martopuro mengucapkan terimakasih', '<p>sebelum Doa Tasyakuran dan potongn tumpeng, Bapak Rianto selaku Kepala Desa Martopuro mengucapkan terimakasih kepada seluruh perangkat desa dan element yang lain yang telah bekerjasama dengan baik khususnya pengurus koperasi merah putih karena tolak ukur pengajuan mengacu kepada selesainya legalitas koperasi sehingga pengajuan tahap 2 ini berjalan dengan baik, dan alhamdulillah desa kita menjadi yang pertama, semoga disiplin prestasi ini bisa dijaga dengan baik, dan program program tahap 2 berjalan dengan baik. Aamiin</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287767/richtext/images/sedang-1750521043-0bf33ba9-cfba-4b02-ad72-b15340cf13e6_r2f9mz.webp\" alt=\"sedang_1750521043_0bf33ba9-cfba-4b02-ad72-b15340cf13e6.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287770/martopuro/news/covers/sedang-1750521043-81e58625-19ee-422a-a93c-d5adc99d2054_e0zjbm.webp', 'published', 1, '2026-06-01 11:22:51', '2026-06-01 04:22:55', '2026-06-01 04:22:55', NULL),
('b7fd0c91-64a2-4f63-ae82-8824e47c1581', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Mengikuti Pelatihan Manajemen Data Kampung Keluarga Berencana.', 'mengikuti-pelatihan-manajemen-data-kampung-keluarga-berencana-mpurpvrm-bdbb9b95', 'Manajemen Data Kampung Keluarga Berencana.', '<p>Manajemen Data Kampung Keluarga Berencana.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291710/martopuro/news/covers/sedang-1764728174-571760796-1184257963583116-8783957058261700918-n_uadvxb.webp', 'published', 1, '2026-06-01 12:28:30', '2026-06-01 05:28:34', '2026-06-01 05:28:34', NULL),
('b8c6cb03-34cd-585e-a83d-85ecd115c79b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Info Event Karangtaruna Permata karya', 'info-event-karangtaruna-permata-karya', 'Informasi event Karang Taruna Permata Karya Desa Martopuro.', '<p>Informasi event Karang Taruna Permata Karya Desa Martopuro.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2024-08-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2024-08-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('b9c6e7b5-1424-40f1-8303-adc206835270', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Jambanisasi Warga Desa Martopuro APBDes 2025', 'jambanisasi-warga-desa-martopuro-apbdes-2025-mpuq6vop-0c62b31d', 'Jambanisasi Warga Desa Martopuro APBDes 2025', '<p>Jambanisasi Warga Desa Martopuro APBDes 2025</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780289144/martopuro/news/covers/sedang-1753155768-523099735-1105656784776568-5206467502312002410-n_i5jtt4.webp', 'published', 1, '2026-06-01 11:45:44', '2026-06-01 04:45:48', '2026-06-01 04:45:48', NULL),
('ba88c68c-686d-4eea-842f-106a3f393435', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Realisasi APBDes Desa Martopuro 2024', 'realisasi-apbdes-desa-martopuro-2024-mpuo6far-4b9f788a', 'Realisasi Anggaran Pendapatan & Belanja Desa (APBDes) Desa Martopuro Kecamatan Purwosari Tahun Anggaran 2024', '<img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285743/richtext/images/cuplikan-layar-2026-06-01-104711_dsrhvi.webp\" alt=\"Cuplikan layar 2026-06-01 104711.png\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285758/richtext/images/cuplikan-layar-2026-06-01-104817_keswus.webp\" alt=\"Cuplikan layar 2026-06-01 104817.png\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285763/martopuro/news/covers/sedang-1744590008-22b44ca5-8994-4d51-a193-f3f029f518aa_ca7mm2.webp', 'published', 1, '2026-06-01 10:49:24', '2026-06-01 03:49:28', '2026-06-01 03:49:28', NULL),
('bb782d66-56fd-4bf4-8ffb-661975b557f2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Louncing Panen Jagung Bumdes \" Karya Usaha Mandiri\" Desa Martopuro.', 'louncing-panen-jagung-bumdes-karya-usaha-mandiri-desa-martopuro-mpuryq9t-7ef13d8b', 'Louncing Panen Jagung Bumdes \" Karya Usaha Mandiri\" Desa Martopuro.', '<p>Louncing Panen Jagung Bumdes \" Karya Usaha Mandiri\" Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292122/martopuro/news/covers/sedang-1764727608-591149785-1210614810947431-2025109922850079143-n_hz1jms.webp', 'published', 1, '2026-06-01 12:35:23', '2026-06-01 05:35:27', '2026-06-01 05:35:27', NULL),
('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran BLT Dana Desa Bulan Juni 2025 Desa Martopuro.', 'penyaluran-blt-dana-desa-bulan-juni-2025-desa-martopuro', 'Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.', '<p>Penyerahan Bantuan Langsung Tunai Dana Desa bulan Juni 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-11.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-11 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('bb7e432c-15cb-47ea-8f90-0e9ad2c6eacc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran BLT Dana Desa Bulan Juni 2025 Desa Martopuro.', 'penyaluran-blt-dana-desa-bulan-juni-2025-desa-martopuro-mpuovmvq-19ba82c7', 'Penyerahan Bantuan Langsung Tunai Dana Desa (BLT-DD) Tahun 2025 Kepada 41 KPM Keluarga Miskin Desa Martopuro Kec.Purwosari Kab.Pasuruan', '<p>Penyerahan Bantuan Langsung Tunai Dana Desa (BLT-DD) Tahun 2025 Kepada 41 KPM Keluarga Miskin Desa Martopuro Kec.Purwosari Kab.Pasuruan</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286937/richtext/images/sedang-1749737381-505907043-1075262347816012-6916272313840512702-n_hptzc3.webp\" alt=\"sedang_1749737381_505907043_1075262347816012_6916272313840512702_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286940/martopuro/news/covers/sedang-1749737381-506296633-1075262397816007-9189814054637965097-n_tnoara.webp', 'published', 1, '2026-06-01 11:09:00', '2026-06-01 04:09:04', '2026-06-01 04:09:04', NULL),
('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa.', 'musyawarah-pemdes-martopuro-dengan-pengelola-kios-desa', 'Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.', '<p>Musyawarah Pemerintah Desa Martopuro dengan pengelola kios desa untuk memperkuat kerja sama.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-11.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-11 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('bd211baf-c721-434f-8f2f-2d16f4d642a0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa.', 'musyawarah-pemdes-martopuro-dengan-pengelola-kios-desa-mpupns1k-07f6945c', 'Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa, harapannya untuk bisa bekerjasama / koperatif dan produktif.', '<p>Musyawarah Pemdes Martopuro dengan Pengelola Kios Desa, harapannya untuk bisa bekerjasama / koperatif dan produktif.&nbsp;</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288253/martopuro/news/covers/sedang-1752407989-518288685-1097886988886881-1105874910495269763-n_zdvtnx.webp', 'published', 1, '2026-06-01 11:30:53', '2026-06-01 04:30:57', '2026-06-01 04:30:57', NULL),
('bd292bd8-2f0c-4c4c-9136-28e8c2c08694', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Monev Dana Desa Semester 1 2026 Desa Martopuro.', 'monev-dana-desa-semester-1-2026-desa-martopuro-mq870233-fb581b3b', 'Monev Dana Desa Semester 1 2026 Desa Martopuro.', '<p>Monev Dana Desa Semester 1 2026 Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1781103441/martopuro/news/covers/720973187-1357671256241785-641492823602789607-n_tetyox.webp', 'published', 1, '2026-06-10 21:57:20', '2026-06-10 14:57:25', '2026-06-10 14:57:25', NULL),
('be5f7134-0e81-4485-9c8e-bfa24025bcdd', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Giat Rembug Stunting Desa Martopuro 2025.', 'giat-rembug-stunting-desa-martopuro-2025-mpuqz5a0-af76903a', 'Giat Rembug Stunting Desa Martopuro 2025.', '<p>Giat Rembug Stunting Desa Martopuro 2025.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780290462/martopuro/news/covers/sedang-1755237658-533486574-1124075989601314-7140840960238293737-n_tccbzh.webp', 'published', 1, '2026-06-01 12:07:43', '2026-06-01 05:07:46', '2026-06-01 05:07:46', NULL),
('be9fa729-5936-4b8c-a130-f110ad102b90', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Apel Peringatan Hari Desa Nasional Desa Martopuro.', 'apel-peringatan-hari-desa-nasional-desa-martopuro-mpunbuiq-5b406e03', 'Apel Peringatan Hari Desa Nasional Desa Martopuro yang di ikuti oleh semua perangkat desa maupun lembaga diwilayah desa martopuro diantaranya karangtaruna, BPD, Babinsa, Bhabinkabtimnas dan lain', '<p>Apel Peringatan Hari Desa Nasional Desa Martopuro yang di ikuti oleh semua perangkat desa maupun lembaga diwilayah desa martopuro diantaranya karangtaruna, BPD, Babinsa, Bhabinkabtimnas dan lain</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284333/richtext/images/sedang-1744696951-480958465-996663259009255-7896217917209512747-n_xdixfe.webp\" alt=\"sedang_1744696951_480958465_996663259009255_7896217917209512747_n.jpg\"><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284337/martopuro/news/covers/sedang-1744696951-480519678-996663585675889-6495072531596498759-n_vcbege.webp', 'published', 1, '2026-06-01 10:25:37', '2026-06-01 03:25:41', '2026-06-01 03:25:41', NULL),
('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', 'Wes Siap ta Dulur, Karnaval Martopuro 2025, Ini Persyaratan dan Waktunya', 'wes-siap-ta-dulur-karnaval-martopuro-2025-ini-persyaratan-dan-waktunya', 'Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.', '<p>Informasi persyaratan dan waktu pelaksanaan Karnaval Martopuro 2025.</p><p>Berita ini termasuk kategori Karang Taruna Desa Martopuro dan dipublikasikan pada 2025-06-30.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-30 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Sukses digelar Peringatan Hari Santri 2025 di Desa Martopuro', 'sukses-digelar-peringatan-hari-santri-2025-di-desa-martopuro', 'Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.', '<p>Peringatan Hari Santri 2025 di Desa Martopuro sukses digelar dengan antusiasme masyarakat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Rencana lokasi Pembangunan Gerai KDMP ( Koperasi Desa Merah Putih ) Martopuro.', 'rencana-lokasi-pembangunan-gerai-kdmp-koperasi-desa-merah-putih-martopuro', 'Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.', '<p>Rencana lokasi pembangunan Gerai KDMP Martopuro sebagai bagian dari penguatan koperasi desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-03.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-03 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran Bantuan Pangan Desa Martopuro.', 'penyaluran-bantuan-pangan-desa-martopuro', 'Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.', '<p>Penyaluran bantuan pangan di Desa Martopuro untuk masyarakat penerima manfaat.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-05.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-05 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c6ec6cba-1456-478c-837c-ad0a8491d14a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Merealisasikan TPT & Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro', 'merealisasikan-tpt-pavingisasi-pemukiman-dusun-puntir-dana-desa-martopuro-mpuns7yj-e757f555', 'Merealisasikan TPT & Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro, gambar sudah tercantum before dan after pembangunan', '<p>Merealisasikan TPT &amp; Pavingisasi Pemukiman Dusun Puntir Dana Desa Martopuro, gambar sudah tercantum before dan after pembangunan</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285098/richtext/images/sedang-1744554295-485877691-1018292943512953-8414362394757239926-n_rgwmho.webp\" alt=\"sedang_1744554295_485877691_1018292943512953_8414362394757239926_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285101/martopuro/news/covers/sedang-1744554295-486215472-1018292496846331-170353198884850693-n_q7j3mn.webp', 'published', 1, '2026-06-01 10:38:21', '2026-06-01 03:38:25', '2026-06-01 03:38:25', NULL),
('c95d0ff1-76f4-5468-af55-c1d5333efd91', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.', 'musyawarah-desa-penetapan-indeks-desa-martopuro-2025', 'Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.', '<p>Pemerintah Desa Martopuro mengadakan Musyawarah Desa Penetapan Indeks Desa Martopuro 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-07.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-07 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Manaqib Dzikir Ghofilin Rutin di agendakan Setiap tahun di Desa Martopuro di masa kepemimpinan Kepala Desa Rianto', 'manaqib-dzikir-ghofilin-rutin-di-agendakan-setiap-tahun-di-desa-martopuro-di-masa-kepemimpinan-kepala-desa-rianto', 'Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.', '<p>Manaqib Dzikir Ghofilin rutin diagendakan setiap tahun di lingkungan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-19.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-19 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) & Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.', 'laporan-keterangan-penyelenggaraan-pemerintah-desa-lkppd-dan-laporan-penyelenggaraan-pemerintah-desa-lppd-desa-martopuro', 'LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.', '<p>LKPPD dan LPPD Desa Martopuro sebagai bagian dari pelaporan penyelenggaraan pemerintahan desa.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-01-27.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-01-27 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('cc79da3a-a218-4612-9dab-da718f6feac0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Warga Padati Tarkam Bola Voly Martopuro Cup 2025, Pemain Proliga Turun Lapangan, Apresiasi Sukses Luar Biasa', 'warga-padati-tarkam-bola-voly-martopuro-cup-2025-pemain-proliga-turun-lapangan-apresiasi-sukses-luar-biasa-mpurfzr2-4fe5157e', 'Semarak Turnamen Bola Voly Martopuro Cup 2025 Warga Padati Lapangan Dusun Pakem untuk Saksikan Final Bola Voli Ratusan pasang mata terpaku di Lapangan Dusun Pakem, Desa Martopuro, Sabtu malam (4/10/2025), saat para atlet voli', '<h3><strong>Semarak Turnamen Bola Voly Martopuro Cup 2025<br>Warga Padati Lapangan Dusun Pakem untuk Saksikan Final Bola Voli</strong></h3><p>Ratusan pasang mata terpaku di <strong>Lapangan Dusun Pakem, Desa Martopuro</strong>, Sabtu malam (4/10/2025), saat para atlet voli terbaik dari berbagai kota di jawa timur berlaga dalam&nbsp;<strong>Turnamen Bola Voly Martopuro Cup 2025 kategori Putra 32 Tim dan Putri 16 Tim</strong></p><p>Tidak sekadar ajang pertandingan, kejuaraan ini menjadi simbol semangat kebersamaan dan sportivitas warga desa. Turnamen yang digelar oleh <strong>Karang Taruna Permata Karya</strong> desa martopuro ini sukses menghadirkan antusiasme tinggi dari masyarakat, menjadikan suasana desa kian meriah dan penuh semangat kekeluargaan.</p><p>Turnamen Martopuro Cup 2025 ini merupakan ajang tahunan yang mempertemukan tim-tim voli terbaik dari semula berbagai dusun di Desa Martopuro, kemarin kita mengadakan dari berbagai Kota di Jawa Timur. Selain untuk mencari bibit atlet potensial, kegiatan ini juga menjadi wadah mempererat tali silaturahmi antarwarga.</p><p>Adi Darmawan, Panitia Martopuro Cup 2025, dalam pembukaannya menyampaikan bahwa kegiatan ini merupakan bentuk nyata dari semangat pemuda dan dukungan pemerintah desa dalam menghidupkan kegiatan positif di masyarakat.</p><p>“Turnamen ini bukan hanya tentang menang atau kalah, tapi tentang bagaimana warga Martopuro bisa bersatu, bersemangat, dan terus mengembangkan olahraga di tingkat desa,” ujarnya.</p><p>Menariknya, lokasi pertandingan yang digelar di <strong>Lapangan Dusun Pakem</strong> memberikan nuansa berbeda. Selain berada di tengah pemukiman warga, lapangan ini menjadi pusat kegiatan masyarakat yang kini dimanfaatkan secara maksimal untuk kegiatan olahraga dan hiburan rakyat.</p><p>“Kami ingin menunjukkan bahwa di desa martopuro banyak sekali kegiatan positif dan produktif. salah satunya dalam bidang olahraga&nbsp; / Lapangan&nbsp; menjadi simbol kebersamaan dan semangat pemuda Martopuro khususnya,” tambah Adi Darmawan selaku konseptor event martopuroculturefest</p><p>Antusiasme masyarakat terlihat sejak awal pembukaan hingga babak final. Sorak-sorai penonton, gemuruh, dan teriakan dukungan dari setiap sudut lapangan membuat suasana semakin semarak, apalagi dari mulai semi final - final banyak kejutan tim bintang proliga turun ke lapangan, menjadi antusias yang sangat luar biasa, bagi penonton untuk menyaksikan seksama dan menantikan bisa foto bersama dengan pemain bintangnya.</p><p>Setiap dusun mengirimkan tim terbaiknya untuk berlaga di kategori <strong>putra dan putri</strong>. Setelah melalui pertandingan sengit selama 24 hari, akhirnya diumumkan para juara Martopuro Cup 2025:</p><ul><li><p><strong>Kategori Putra:</strong> Juara 1 Etira STJ, Juara 2 JPA Puntir Martopuro, Juara 3 Yanmar Pandaan, Juara 4 Bahana Muda malang</p></li><li><p><strong>Kategori Putri:</strong> Juara 1 Galaxy hans Singosari, Juara 2 Putri Kencana Sidoarjo, Juara 3 Kalisoerak Lawang, Juara 4 Angkasa Pakis</p></li></ul><p>Kepala Desa Martopuro dalam kesempatan penutupan turnamen turut menyampaikan apresiasi kepada seluruh pihak yang terlibat.“Kegiatan seperti ini perlu terus kita dukung. Selain mempererat persaudaraan, juga bisa menjadi sarana pembinaan bakat olahraga di desa,” ungkapnya. Rianto (Kepala Desa Martopuro)</p><p>Dengan berakhirnya Turnamen Bola Voly <strong>Martopuro Cup 2025</strong>, semangat olahraga di Desa Martopuro diharapkan semakin hidup. Panitia pun berkomitmen menjadikan event ini sebagai agenda rutin tahunan yang dinanti-nanti warga setiap tahunnya.</p><p>&nbsp;“Kami berharap Martopuro Cup terus menjadi wadah kebersamaan dan semangat sportif bagi seluruh warga,” pungkas Imron dan Aris (Ketua &amp; Wakil Pelaksana / Kordinator bidang Olahraga Karangataruna Permata Karya.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291248/martopuro/news/covers/sedang-1759633487-91403401-1631977060274873-4250381910515122176-n_yxi4m9.webp', 'published', 3, '2026-06-01 12:20:49', '2026-06-01 05:20:53', '2026-06-01 05:20:53', NULL),
('d03c5512-5d45-43a3-beb6-890066b0094b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pavingisasi Depan Gerai KDMP Desa Martopuro.', 'pavingisasi-depan-gerai-kdmp-desa-martopuro-mpusxlv4-3168c3be', 'Pavingisasi Depan Gerai KDMP Desa Martopuro.', '<p>Pavingisasi Depan Gerai KDMP Desa Martopuro.</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293747/richtext/images/sedang-1778211308-686530508-1328058075869770-6839637228125326136-n_t1tcec.webp\" alt=\"sedang_1778211308_686530508_1328058075869770_6839637228125326136_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293750/martopuro/news/covers/sedang-1778211308-2aa46fc9-e6ea-453b-9aa8-ba9bf851be4e-1_v2dffo.webp', 'published', 1, '2026-06-01 13:02:31', '2026-06-01 06:02:34', '2026-06-01 06:02:34', NULL),
('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Tasyakuran Awal Pelaksanaan Dana Desa tahap 2 tahun 2025', 'tasyakuran-awal-pelaksanaan-dana-desa-tahap-2-tahun-2025', 'Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.', '<p>Tasyakuran awal pelaksanaan Dana Desa tahap 2 tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-21.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-21 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d153e8c3-01bd-4ae5-8b5b-6cf1ed053810', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Sosialisasi Akuntabilitas Pengelolaan Dana Desa.', 'sosialisasi-akuntabilitas-pengelolaan-dana-desa-mpusppgw-0bf453bc', 'Sosialisasi Akuntabilitas Pengelolaan Dana Desa.', '<p>Sosialisasi Akuntabilitas Pengelolaan Dana Desa.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293381/martopuro/news/covers/sedang-1777519770-686609197-1324727302869514-2220145943708962727-n_kkzob2.webp', 'published', 1, '2026-06-01 12:56:22', '2026-06-01 05:56:25', '2026-06-01 05:56:25', NULL),
('d41479a0-fd39-5334-b206-08e45fd69a44', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Giat Pemindahan Tiang Bendera Lapangan Panutan Desa Martopuro.', 'giat-pemindahan-tiang-bendera-lapangan-panutan-desa-martopuro', 'Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.', '<p>Giat pemindahan tiang bendera Lapangan Panutan Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Kerja Bakti Lapangan Panutan Desa Martopuro Persiapan Upacara Kemerdekaan Se Kecamatan Purwosari , 17 Agustus 2025', 'kerja-bakti-lapangan-panutan-desa-martopuro-persiapan-upacara-kemerdekaan-se-kecamatan-purwosari-17-agustus-2025', 'Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.', '<p>Kerja bakti Lapangan Panutan Desa Martopuro untuk persiapan upacara kemerdekaan se-Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d545b75f-5e33-5840-bbb8-75a04f3b81f8', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Louncing Panen Jagung Bumdes \" Karya Usaha Mandiri\" Desa Martopuro.', 'louncing-panen-jagung-bumdes-karya-usaha-mandiri-desa-martopuro', 'Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.', '<p>Launching panen jagung BUMDes Karya Usaha Mandiri Desa Martopuro dalam program ketahanan pangan.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Terbentuknya Pengurus Koperasi Desa Merah Putih Martopuro', 'terbentuknya-pengurus-koperasi-desa-merah-putih-martopuro', 'Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.', '<p>Musyawarah desa khusus 2025 membahas percepatan pembentukan Koperasi Desa Merah Putih Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-23.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-23 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran BLT Dana Desa Bulan September-Oktober Desa Martopuro 2025.', 'penyaluran-blt-dana-desa-bulan-september-oktober-desa-martopuro-2025', 'Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.', '<p>Penyaluran BLT Dana Desa bulan September-Oktober tahun 2025 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-10-09.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-10-09 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d94820bc-e2b3-5365-b15d-2918dcb35469', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Kerja Bakti Lingkungan Desa Martopuro', 'kerja-bakti-lingkungan-desa-martopuro', 'Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.', '<p>Kerja bakti lingkungan di masing-masing dusun Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-02-23.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-02-23 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Jambanisasi Warga Desa Martopuro APBDes 2025', 'jambanisasi-warga-desa-martopuro-apbdes-2025', 'Program jambanisasi warga Desa Martopuro melalui APBDes 2025.', '<p>Program jambanisasi warga Desa Martopuro melalui APBDes 2025.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-22.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-22 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d9fc8dea-53d7-4e22-88a1-80f58ff8e87e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Keseriusan Pemerintah Desa Martopuro di Bawah Kepemimpinan Kepala Desa Rianto: Satu Tahun Kerja, Satu Tahun Bukti', 'keseriusan-pemerintah-desa-martopuro-di-bawah-kepemimpinan-kepala-desa-rianto-satu-tahun-kerja-satu-tahun-bukti-mpus5a4b-1dcde9b5', 'Dalam satu tahun terakhir, Pemerintah Desa Martopuro menunjukkan komitmen kuat untuk menghadirkan perubahan nyata bagi masyarakat.', '<p>Dalam satu tahun terakhir, Pemerintah Desa Martopuro menunjukkan komitmen kuat untuk menghadirkan perubahan nyata bagi masyarakat. Di bawah kepemimpinan&nbsp;<strong>Kepala Desa Rianto</strong>, berbagai program pembangunan, pemberdayaan, dan pelayanan publik terus digenjot agar manfaatnya dapat dirasakan langsung oleh warga. Melalui kerja yang terarah, transparan, dan berkelanjutan, Martopuro perlahan menegaskan diri sebagai desa yang progresif serta siap mengikuti perkembangan zaman.</p><p>Seluruh capaian dan kegiatan tersebut kini <strong>terdokumentasi dan terupdate</strong> melalui <strong>Website Resmi Desa Martopuro</strong>, sebagai bentuk keterbukaan informasi publik sekaligus sarana komunikasi antara pemerintah desa dan masyarakat.</p><hr><h2><strong>1. Pembangunan Fisik yang Terarah dan Berdampak</strong></h2><p>Pemerintah Desa Martopuro memprioritaskan pembangunan infrastruktur sebagai fondasi penting pertumbuhan desa. Dalam satu tahun ini, beberapa program unggulan berhasil dijalankan antara lain:</p><ul><li><p>Perbaikan jalan desa untuk meningkatkan aksesibilitas warga.</p></li><li><p>Rehabilitasi fasilitas umum demi kenyamanan kegiatan masyarakat.</p></li><li><p>Penguatan jaringan drainase guna mengurangi potensi banjir saat musim hujan.</p></li></ul><p>Setiap pembangunan dikelola dengan prinsip <em>transparansi anggaran</em>, yang dapat dipantau oleh masyarakat melalui laporan-laporan yang dipublikasikan di website desa.</p><hr><h2><strong>2. Pemberdayaan Masyarakat sebagai Fokus Utama</strong></h2><p>Kepemimpinan Kepala Desa Rianto tidak hanya menitikberatkan pada pembangunan fisik, tetapi juga pada <strong>penguatan kualitas sumber daya manusia (SDM)</strong>. Berbagai program pemberdayaan masyarakat terus didorong, seperti:</p><ul><li><p>Pelatihan UMKM dan kewirausahaan bagi ibu rumah tangga dan pemuda.</p></li><li><p>Pemberdayaan kelompok tani dan penguatan sektor pertanian produktif.</p></li><li><p>Program edukasi dan peningkatan literasi digital untuk mendukung ekonomi kreatif.</p></li></ul><p>Upaya ini menjadi bukti bahwa pemerintah desa memandang penting peran aktif masyarakat dalam memajukan desa.</p><hr><h2><strong>3. Pelayanan Publik yang Semakin Mudah dan Cepat</strong></h2><p>Komitmen untuk menghadirkan pelayanan publik yang <strong>responsif dan modern</strong> menjadi salah satu ciri kuat pemerintahan Desa Martopuro saat ini. Melalui digitalisasi layanan—seperti pengajuan administrasi desa, penyampaian informasi penting, hingga publikasi kegiatan—warga kini bisa mengakses berbagai kebutuhan secara lebih mudah.</p><p>Website resmi desa hadir sebagai pusat informasi yang <strong>terupdate</strong>, berisi:</p><ul><li><p>Agenda kegiatan desa</p></li><li><p>Laporan pembangunan</p></li><li><p>Informasi bantuan pemerintah</p></li><li><p>Profil perangkat desa</p></li><li><p>Berita-berita terbaru terkait program</p></li><li><p>Dokumentasi lengkap kegiatan dalam satu tahun terakhir</p></li></ul><p>Semua ini menjadi bukti bahwa pemerintah desa serius dalam meningkatkan keterbukaan informasi publik dan kualitas layanan.</p><hr><h2><strong>4. Kepemimpinan yang Tegas, Transparan, dan Berorientasi Hasil</strong></h2><p>Kepala Desa Rianto dikenal tegas dalam memastikan setiap program berjalan sesuai rencana dan bermanfaat bagi masyarakat. Dalam periode satu tahun ini, beliau menekankan beberapa prinsip:</p><ul><li><p><strong>Transparansi anggaran</strong></p></li><li><p><strong>Akurasi data dan pelaporan</strong></p></li><li><p><strong>Kerja sama antar lembaga desa</strong></p></li><li><p><strong>Partisipasi aktif masyarakat</strong></p></li></ul><p>Hasilnya, program desa dapat berjalan konsisten dan mendapat dukungan luas dari warga.</p><hr><h2><strong>5. Website Desa: Pusat Dokumentasi dan Layanan Masyarakat</strong></h2><p>Salah satu langkah modernisasi yang sangat penting adalah pengembangan <strong>Website Resmi Desa Martopuro</strong>. Melalui platform ini, seluruh perkembangan dalam satu tahun dapat dipantau dengan mudah oleh warga dan pihak luar yang membutuhkan informasi.</p><p>Website ini menjadi simbol keseriusan Pemerintah Desa Martopuro dalam:</p><ul><li><p>Menjaga <strong>keterbukaan</strong></p></li><li><p>Meningkatkan <strong>konektivitas</strong> dengan warga</p></li><li><p>Memperkuat <strong>akurasi informasi</strong></p></li><li><p>Mendukung <strong>akuntabilitas publik</strong></p></li></ul><p>Dengan adanya website ini, Martopuro semakin siap bergerak menuju desa digital yang maju dan berdaya.</p><hr><h1><strong>Penutup</strong></h1><p>Satu tahun kerja Pemerintah Desa Martopuro di bawah kepemimpinan Kepala Desa Rianto telah memberikan banyak perubahan positif bagi masyarakat. Pembangunan yang merata, pemberdayaan yang berkelanjutan, serta layanan publik yang semakin modern menjadi bukti nyata keseriusan pemerintah desa dalam bekerja untuk kemajuan wilayahnya.</p><p>Melalui website ini, seluruh masyarakat dapat memantau perkembangan desa secara langsung dan ikut berpartisipasi dalam setiap proses pembangunan. Martopuro terus melangkah maju—transparan, progresif, dan berorientasi pada masa depan.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292427/martopuro/news/covers/sedang-1765169333-untitled-1_ameozk.webp', 'published', 3, '2026-06-01 12:40:29', '2026-06-01 05:40:32', '2026-06-01 05:40:32', NULL),
('db1914b1-a569-54c6-9947-c394dbb9be82', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '0dc3abf2-de70-5cef-b90c-c6872b5f8816', 'Louncing Ketahanan Pangan Bumdes\" Karya Usaha Mandiri\" Desa Martopuro.', 'louncing-ketahanan-pangan-bumdes-karya-usaha-mandiri-desa-martopuro', 'Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.', '<p>Launching ketahanan pangan BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-08-06.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-06 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyaluran BLT DD Bulan Januari-April 2026 Desa Martopuro.', 'penyaluran-blt-dd-bulan-januari-april-2026-desa-martopuro', 'Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.', '<p>Penyerahan Bantuan Langsung Tunai Dana Desa tahun 2026 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2026-04-24.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2026-04-24 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Monev Giat Fisik Semester 2 Tahun 2025 oleh Kecamatan dan TA Kabupaten.Dana Desa Desa Martopuro.', 'monev-giat-fisik-semester-2-tahun-2025-oleh-kecamatan-dan-ta-kabupaten-dana-desa-desa-martopuro', 'Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.', '<p>Monitoring dan evaluasi kegiatan fisik semester 2 tahun 2025 oleh Kecamatan dan TA Kabupaten untuk Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-30.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-30 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('de43dc9d-c33d-501f-a100-518c0d4f1802', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Penyerahan BLT DD Bulan April Mei 2025 Desa Martopuro.', 'penyerahan-blt-dd-bulan-april-mei-2025-desa-martopuro', 'Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.', '<p>Penyerahan BLT Dana Desa bulan April-Mei 2025 kepada KPM keluarga miskin Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-05-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-05-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e017b699-665d-4dd9-a205-98c0affc834a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Penetapan APBDes Desa Martopuro 2026.', 'musyawarah-penetapan-apbdes-desa-martopuro-2026-mpus8j2v-5f49fa1c', 'Musyawarah Penetapan APBDes Desa Martopuro 2026.', '<p>Musyawarah Penetapan APBDes Desa Martopuro 2026.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292579/martopuro/news/covers/sedang-1770517681-597114167-1216993303642915-5577535811276484625-n_qbehfp.webp', 'published', 1, '2026-06-01 12:43:01', '2026-06-01 05:43:04', '2026-06-01 05:43:04', NULL),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan TPT Pertanian Dusun Kemantren RW.04 Desa Martopuro.', 'pembangunan-tpt-pertanian-dusun-kemantren-rw-04-desa-martopuro', 'Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.', '<p>Pembangunan TPT pertanian Dusun Kemantren RW 04 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-07-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-07-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Laporan Pertanggungjawaban Kepala Desa Martopuro Akhir Tahun Anggaran 2024', 'laporan-pertanggungjawaban-kepala-desa-martopuro-akhir-tahun-anggaran-2024', 'Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.', '<p>Laporan pertanggungjawaban Kepala Desa Martopuro akhir tahun anggaran 2024.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-01-15.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-01-15 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e234c8ce-3c68-5078-858b-028ecb8131c7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Musdes Penetapan KPM BLT DD Tahun 2026 Desa Martopuro.', 'musdes-penetapan-kpm-blt-dd-tahun-2026-desa-martopuro', 'Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.', '<p>Musyawarah desa penetapan KPM BLT DD tahun 2026 Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-12-08.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-12-08 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e376fa17-a90f-4c4e-a1a3-1bd73fb8982a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pengecatan Gedung PAUD Desa Martopuro.', 'pengecatan-gedung-paud-desa-martopuro-mpuq21sf-0d533f52', 'Pengecatan Gedung PAUD Desa Martopuro.', '<p>Pengecatan Gedung PAUD Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780288918/martopuro/news/covers/sedang-1753155695-520455855-1105707664771480-8758772032304630183-n_zdicua.webp', 'published', 1, '2026-06-01 11:41:59', '2026-06-01 04:42:02', '2026-06-01 04:42:02', NULL),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Desa Martopuro Juara 2 lomba Samroh TP PKK Kecamatan Purwosari', 'desa-martopuro-juara-2-lomba-samroh-tp-pkk-kecamatan-purwosari', 'Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.', '<p>Desa Martopuro meraih Juara 2 lomba Samroh yang diadakan oleh TP PKK Kecamatan Purwosari.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-08-01.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-08-01 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e443442d-8563-5fd5-991d-b26695297919', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '0dc3abf2-de70-5cef-b90c-c6872b5f8816', 'Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.', 'zoom-meeting-bumdes-karya-usaha-mandiri-desa-martopuro', 'Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.', '<p>Zoom meeting BUMDes Karya Usaha Mandiri Desa Martopuro.</p><p>Berita ini termasuk kategori BUMDES Desa Martopuro dan dipublikasikan pada 2025-11-03.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-11-03 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e4b3d968-5661-4df8-a885-72c8cc5bc4e1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro.', 'pembangunan-tandon-air-lapangan-panutan-anggaran-pad-desa-martopuro-mpup3mvj-8e3c7b41', 'Proses Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro', '<p>Proses Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro. sudah selesai sebagai bentuk melengkapi fasilitas penunjang perawatan lapangan panutan.&nbsp;</p><p><br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287312/martopuro/news/covers/sedang-1750044920-506320358-1078067440868836-1971353934108807188-n_vqlu72.webp', 'published', 1, '2026-06-01 11:15:13', '2026-06-01 04:15:17', '2026-06-01 04:15:17', NULL),
('e73885a1-fa04-4f73-8bbf-df720814ff73', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Musyawarah Desa Martopuro RKP Tahun 2026', 'musyawarah-desa-martopuro-rkp-tahun-2026-mpupbrll-11da4c07', 'Musyawarah Desa (MUSDES) Martopuro Membahasa beberapa point diantaranya : Pencermatan RPJM Desa Martopuro', '<p>Musyawarah Desa (MUSDES) Martopuro Membahasa beberapa point diantaranya :</p><ol><li><p>Pencermatan RPJM Desa Martopuro</p></li><li><p>Pembentukan Tim Penyusun RKP Tahun 2026</p></li><li><p>Pembentukan Tim Verifikasi RKP Tahun 2026</p></li><li><p>Usulan Rencan Kerja Pemerintah Desa (RKP) Tahun 2026</p></li></ol><p>Sabtu, 21 Juni 2025 , dihadiri perwakilan kecamatan purwosari dan pendamping lokal desa dan seluruh element yang di undang BPD..Tokoh agama, Perangkat desa, Karangtaruna, LPM, Perwakilan Perempuan, dll</p><p>Dalam kegiatan tersebuti diawali sambutan kepala desa martopuro Bapak Rianto, dalam penyampaiannya dititik tekankan dalam mensukseskan 4 point yang dibahas, mengkaji mencermati dan menambahkan apabila ada yang perlu ditambahkan dalam rencana kerja pemerintah desa (RKP) tahun 2026</p><p>Sambutan kedua disampaikan oleh perwakilan kecamatan, dalam sambutannya mengapresiasi desa martopuro karena menjadi pelaksana pertama desa yang melaksanakan musdes RKP tahun 2026, semoga prestasi ini bisa tetap dipertahankan dan membawa kemajuan untuk desa martopuro dibawah kepemimpinan kepala desa martopuro bapak rianto.</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287688/richtext/images/sedang-1750513129-img-20250621-202028_qo9kxp.webp\" alt=\"sedang_1750513129_IMG_20250621_202028.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287692/martopuro/news/covers/sedang-1750521018-0bf33ba9-cfba-4b02-ad72-b15340cf13e6_ffl9qi.webp', 'published', 1, '2026-06-01 11:21:33', '2026-06-01 04:21:37', '2026-06-01 04:21:37', NULL),
('e777b1f4-7186-4c41-bdc6-cb92b88c1877', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Semenjak Kepemimpinan Kades Rianto, Khataman Qur\'an menjadi Agenda Rutin Jumat legi Pemerintah Desa', 'semenjak-kepemimpinan-kades-rianto-khataman-quran-menjadi-agenda-rutin-jumat-legi-pemerintah-desa-mpuowxem-73dde138', 'Sudah berjalan rutin di kepemimpinan Kepala Desa Rianto, Khataman Qur\'an Jumat Legi Pemerintah Desa di ikuti kades, perangkat, kasun dan mudin, dll', '<p>Sudah berjalan rutin di kepemimpinan Kepala Desa Rianto, Khataman Qur\'an Jumat Legi Pemerintah Desa di ikuti kades, perangkat, kasun dan mudin, dll</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286997/richtext/images/sedang-1749821998-506394750-1076727564336157-6652346570491097259-n_ocab7z.webp\" alt=\"sedang_1749821998_506394750_1076727564336157_6652346570491097259_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287000/martopuro/news/covers/sedang-1749821998-505847380-1076727627669484-3005354591011879650-n_c6yvyz.webp', 'published', 1, '2026-06-01 11:10:00', '2026-06-01 04:10:04', '2026-06-01 04:10:04', NULL),
('e85d52b3-c0d2-41ad-8044-08e28bbfae14', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Siap Menerima Siswa Baru Paud Tunas Bangsa Martopuro', 'siap-menerima-siswa-baru-paud-tunas-bangsa-martopuro-mpuoelvc-a09df4b0', 'Penerimaan Pendaftaran siswa baru paud tunas bangsa martopuro tahun ajaran 2025 / 2026 sudah dibuka', '<p>Penerimaan Pendaftaran siswa baru paud tunas bangsa martopuro tahun ajaran 2025 / 2026 sudah dibuka bisa dicek posternya untuk persyaratan atau bisa langsung ke kantor paud tunas bangsa martopuro lokasi Jl.Epek Raya timur Pos Polisi Purwosari Desa Martopuro Purwosari, atau bisa langsung&nbsp;hubungi dengan klik salah satu nama dibawah ini akan menuju whatsapp bersangkutan</p><p>Informasi Lengkap :</p><ul><li><p><a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"https://martopuro.berdesa.id/web/form/wa.me/6281545539004\">Bu Kom</a></p></li><li><p><a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"https://martopuro.berdesa.id/web/form/wa.me/6285648502261\">Bu Nikma</a></p></li><li><p><a target=\"_blank\" rel=\"noopener noreferrer nofollow\" href=\"https://martopuro.berdesa.id/web/form/wa.me/6281459154223\">Bu Ima</a></p></li></ul><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286142/richtext/images/sedang-1745224189-cbdf9138-dda9-4799-b4a3-2d22b6e353b6_ihkry7.webp\" alt=\"sedang_1745224189_cbdf9138-dda9-4799-b4a3-2d22b6e353b6.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780286145/martopuro/news/covers/sedang-1745212453-480690786-1779365062919121-3658240893895783274-n_k5rzsw.webp', 'published', 1, '2026-06-01 10:55:46', '2026-06-01 03:55:49', '2026-06-01 03:55:49', NULL),
('e90bcc81-1615-475b-af7c-5a1704c3458f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro.', 'pengecatan-tempat-parkir-kantor-sumber-pad-pendapatan-asli-desa-desa-martopuro-mpup7dfp-b4db32f9', 'Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro)', '<p>Pengecatan Tempat Parkir Kantor sumber PAD ( Pendapatan Asli Desa Desa Martopuro.</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287483/richtext/images/sedang-1750126543-508573193-1079603290715251-5053865372670282886-n_wddsxi.webp\" alt=\"sedang_1750126543_508573193_1079603290715251_5053865372670282886_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780287486/martopuro/news/covers/sedang-1750126543-508562498-1079603340715246-2743464982523124765-n_etzrnu.webp', 'published', 1, '2026-06-01 11:18:08', '2026-06-01 04:18:11', '2026-06-01 04:18:11', NULL),
('ea008a2a-f6ba-4658-a4b7-6146468a9e55', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro', 'rapat-koordinasi-rutin-tiap-senin-pemdes-martopuro-mpurxaho-4c8f3004', 'Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro', '<p>Rapat Koordinasi Rutin tiap Senin Pemdes Martopuro</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292056/martopuro/news/covers/sedang-1764727712-584767102-1200406795301566-6305411022073036762-n_yjn6v1.webp', 'published', 1, '2026-06-01 12:34:16', '2026-06-01 05:34:20', '2026-06-01 05:34:20', NULL);
INSERT INTO `news` (`id`, `tenant_id`, `category_id`, `title`, `slug`, `description_card`, `description_content`, `cover_url`, `status`, `read_time`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '176d3564-eaa3-5485-8dcf-b21dd51a3670', 'Visi dan Misi', 'visi-dan-misi', 'Informasi visi dan misi Desa Martopuro.', '<p>Informasi visi dan misi Desa Martopuro.</p><p>Berita ini termasuk kategori Profil Desa Martopuro dan dipublikasikan pada 2025-04-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('f08dfc48-80bf-52ea-9942-e801bb198c64', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan TPT lapangan Panutan Dana Desa Desa Martopuro', 'pembangunan-tpt-lapangan-panutan-dana-desa-desa-martopuro', 'Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.', '<p>Pembangunan TPT Lapangan Panutan menggunakan Dana Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-03-18.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-03-18 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Serah terima unit truk KDMP ( Koperasi Desa Merah Putih ) Martopuro.', 'serah-terima-unit-truk-kdmp-koperasi-desa-merah-putih-martopuro', 'Serah terima unit truk KDMP Martopuro sebagai dukungan operasional koperasi desa.', '<p>Serah terima unit truk KDMP ( Koperasi Desa Merah Putih ) Martopuro.</p><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780283674/richtext/images/sedang-1778561485-690767035-1331782602163984-3290237328237187963-n_pyalez.webp\" alt=\"sedang_1778561485_690767035_1331782602163984_3290237328237187963_n.jpg\"><p></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780283685/richtext/images/sedang-1778561485-690768903-1331342595541318-4681726014524716710-n_ujgywd.webp\" alt=\"sedang_1778561485_690768903_1331342595541318_4681726014524716710_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780202974/martopuro/news/covers/sedang-1778561485-689524461-1331342492207995-539456844175051007-n-1_ore6b0.webp', 'published', 1, '2026-06-01 13:05:05', '2026-05-21 01:30:02', '2026-06-01 06:05:07', NULL),
('f65c9345-599b-4b20-985d-ef22fcf666aa', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro', 'penyaluran-bantuan-langsung-tunai-triwulan-i-tahun-2025-desa-martopuro-mpunmci7-927235af', 'Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro.', '<p>Penyaluran Bantuan Langsung Tunai Triwulan I Tahun 2025 Desa Martopuro.</p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284823/richtext/images/sedang-1744554699-483931936-1009735394368708-2316452043221928271-n_aa3ugl.webp\" alt=\"sedang_1744554699_483931936_1009735394368708_2316452043221928271_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780284826/martopuro/news/covers/sedang-1744554699-483511411-1009735907701990-1291606208148502337-n-1_rrqik7.webp', 'published', 1, '2026-06-01 10:33:47', '2026-06-01 03:33:51', '2026-06-01 03:33:51', NULL),
('f92a3aeb-f9c5-46d2-a1b7-d6ae613991ee', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Penyerahan THR Tahun 2026 BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan', 'penyerahan-thr-tahun-2026-bpd-perangkat-desa-pengurus-tp-pkk-rt-rw-linmas-kader-posyandu-modin-desa-martopuro-kecpurwosari-kabpasuruan-mpuslu8z-8d128a54', 'Alhamdulillah berjalan lancar Penyerahan THR Tahun 2026 BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan', '<p>Alhamdulillah berjalan lancar Penyerahan THR Tahun 2026<br>BPD, Perangkat Desa, Pengurus TP PKK, RT-RW, Linmas, Kader Posyandu, Modin Desa Martopuro Kec.Purwosari Kab.Pasuruan<br></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780293201/martopuro/news/covers/sedang-1773291070-650353308-1285532623455649-5528956012488381129-n_hjfkha.webp', 'published', 1, '2026-06-01 12:53:22', '2026-06-01 05:53:25', '2026-06-01 05:53:25', NULL),
('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Semenjak Kepemimpinan Kades Rianto, Khataman Qur\'an menjadi Agenda Rutin Jumat legi Pemerintah Desa', 'semenjak-kepemimpinan-kades-rianto-khataman-quran-menjadi-agenda-rutin-jumat-legi-pemerintah-desa', 'Khataman Qur\'an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.', '<p>Khataman Qur&#x27;an Jumat Legi menjadi agenda rutin Pemerintah Desa Martopuro pada masa kepemimpinan Kades Rianto.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-13.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-13 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('fb4fff82-a2d2-47ba-ae1d-800a034b6c01', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.', 'zoom-meeting-bumdes-karya-usaha-mandiri-desa-martopuro-mpurtxk0-b5a470d2', 'Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.', '<p>Zoom meeting Bumdes Karya Usaha Mandiri Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780291898/martopuro/news/covers/sedang-1764727960-573326389-1189036776438568-9193473172584306371-n_cfqot6.webp', 'published', 1, '2026-06-01 12:31:39', '2026-06-01 05:31:43', '2026-06-01 05:31:43', NULL),
('fbccd0a6-50c2-4ae4-aa63-9cf6e1a5a9e9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro', 'merealisasikan-pembangunan-pavingisasi-depan-kios-desa-utara-pasar-purwosari-desa-martopuro-mpunwmx6-7ba5316b', 'Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro', '<p>Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro&nbsp;</p><p><br></p><img src=\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285304/richtext/images/sedang-1744553738-489795239-1032176452124602-291302859845833052-n_micxf2.webp\" alt=\"sedang_1744553738_489795239_1032176452124602_291302859845833052_n.jpg\"><p></p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780285307/martopuro/news/covers/sedang-1744553738-489772863-1031287578880156-2972766755814135236-n_mfpcex.webp', 'published', 1, '2026-06-01 12:41:47', '2026-06-01 03:41:51', '2026-06-01 06:01:03', NULL),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Merealisasikan Pembangunan Pavingisasi Depan Kios Desa Utara Pasar Purwosari Desa Martopuro', 'merealisasikan-pembangunan-pavingisasi-depan-kios-desa-utara-pasar-purwosari-desa-martopuro', 'Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.', '<p>Realisasi pembangunan pavingisasi depan kios desa utara Pasar Purwosari Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-04-10.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-04-10 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('ff4f34ae-5084-4956-ab3e-16c8ae43f1d6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7fb8eebc-c99f-4c84-8985-9485f2800b3b', 'Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) & Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.', 'laporan-keterangan-penyelenggaraan-pemerintah-desa-lkppd-laporan-penyelenggaraan-pemerintah-desa-lppd-desa-martopuro-mpusgk0p-3aed760f', 'Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) & Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.', '<p>Laporan Keterangan Penyelenggaraan Pemerintah Desa ( LKPPD ) &amp; Laporan Penyelenggaraan Pemerintah Desa ( LPPD ) Desa Martopuro.</p>', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780292954/martopuro/news/covers/sedang-1770525877-622875814-1251647033510875-3175543423983744748-n_uoumj1.webp', 'published', 1, '2026-06-01 12:49:15', '2026-06-01 05:49:18', '2026-06-01 05:49:18', NULL),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '593eb4c5-7faf-565a-8503-e32028a43526', 'Pembangunan Tandon Air lapangan Panutan Anggaran PAD Desa Martopuro.', 'pembangunan-tandon-air-lapangan-panutan-anggaran-pad-desa-martopuro', 'Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.', '<p>Pembangunan tandon air Lapangan Panutan menggunakan anggaran PAD Desa Martopuro.</p><p>Berita ini termasuk kategori Berita Desa Desa Martopuro dan dipublikasikan pada 2025-06-16.</p>', '/assets/images/village/martopuro-hero.jpg', 'published', 1, '2025-06-16 09:00:00', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `news_categories`
--

CREATE TABLE `news_categories` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `name` varchar(140) NOT NULL,
  `slug` varchar(160) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_categories`
--

INSERT INTO `news_categories` (`id`, `tenant_id`, `name`, `slug`, `description`, `sort_order`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
('0dc3abf2-de70-5cef-b90c-c6872b5f8816', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BUMDES', 'bumdes', 'Informasi BUMDes Karya Usaha Mandiri dan ekonomi desa.', 3, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('176d3564-eaa3-5485-8dcf-b21dd51a3670', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Profil', 'profil', 'Informasi profil, sejarah, visi, dan misi Desa Martopuro.', 8, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('31e99a10-9b90-5af4-b124-cfbf5a9a4dfe', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Karang Taruna', 'karang-taruna', 'Kegiatan kepemudaan dan Karang Taruna Permata Karya Desa Martopuro.', 2, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('593eb4c5-7faf-565a-8503-e32028a43526', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Berita Desa', 'berita-desa', 'Informasi umum dan kegiatan Pemerintah Desa Martopuro.', 1, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('6009b765-2f64-50fd-951d-07a709ad1119', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Berita Lembaga', 'berita-lembaga', 'Informasi lembaga desa dan organisasi kemasyarakatan.', 6, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('7fb8eebc-c99f-4c84-8985-9485f2800b3b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Informasi Desa', 'informasi-desa', NULL, 0, 'active', '2026-06-01 03:18:48', '2026-06-01 03:18:48', NULL),
('a3218aa8-f025-5b89-b870-d100001f417b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'APBDes', 'apbdes', 'Informasi anggaran, realisasi, dan transparansi APBDes.', 7, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('dc0a287d-c539-5407-b1af-83479bbde6b3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BPD', 'bpd', 'Informasi Badan Permusyawaratan Desa Martopuro.', 4, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('dcb17bd5-8af2-5484-86fe-e6bee5e15a38', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'PAUD', 'paud', 'Informasi pendidikan PAUD Tunas Bangsa Martopuro.', 5, 'active', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `news_tags`
--

CREATE TABLE `news_tags` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `name` varchar(120) NOT NULL,
  `slug` varchar(140) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_tags`
--

INSERT INTO `news_tags` (`id`, `tenant_id`, `name`, `slug`, `created_at`, `updated_at`, `deleted_at`) VALUES
('0333eed5-745f-4196-af8e-b392503e70ae', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'jagung', 'jagung', '2026-06-01 05:35:28', '2026-06-01 05:35:28', NULL),
('07f43c64-a846-40fb-8343-f5f6e523e5a3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'karangtaruna', 'karangtaruna', '2026-06-01 03:18:49', '2026-06-01 03:18:49', NULL),
('09be1efe-4ac5-4be4-aa5b-c05faae800b2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'musyawarah', 'musyawarah', '2026-06-01 03:23:35', '2026-06-01 03:23:35', NULL),
('09dd780e-e4de-4ffa-99fc-6ac691fad505', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'verifikasi', 'verifikasi', '2026-06-01 05:32:50', '2026-06-01 05:32:50', NULL),
('0a846a1a-a519-4b34-b355-3c9f8d0ccab1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'manaqib', 'manaqib', '2026-06-01 04:19:49', '2026-06-01 04:19:49', NULL),
('125ab8e9-24ab-4299-b2f5-4c0573ae0062', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'musdes', 'musdes', '2026-06-01 05:38:24', '2026-06-01 05:38:24', NULL),
('16311492-68fe-4845-b5cc-78a9d1d5ca16', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pelatihan', 'pelatihan', '2026-06-01 04:41:17', '2026-06-01 04:41:17', NULL),
('17e3ba00-1829-4285-8eff-28ba40c61557', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'battle', 'battle', '2026-06-01 05:18:11', '2026-06-01 05:18:11', NULL),
('19a1d581-ca4d-4299-b26e-011bf3d3ba5b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'launching', 'launching', '2026-06-01 03:44:56', '2026-06-01 03:44:56', NULL),
('1f45c1db-1acd-4eff-ae78-1aa3d8debe52', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pembangunan tpt', 'pembangunan-tpt', '2026-06-01 04:27:15', '2026-06-01 04:27:15', NULL),
('1fd988f4-4834-5c01-9381-be463e47cc4f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pembangunan', 'pembangunan', '2026-05-21 01:30:02', '2026-05-31 04:51:09', NULL),
('2084f594-0d4d-446d-b4ed-1446e849837d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'blt dana', 'blt-dana', '2026-06-01 04:09:04', '2026-06-01 04:09:04', NULL),
('214fee5b-67a0-5f2d-b02d-83e714b7362a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'ketahanan pangan', 'ketahanan-pangan', '2026-05-21 01:30:02', '2026-06-01 05:03:29', NULL),
('21605b75-ef9b-4b65-b8f1-22bd942d9531', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'penyaluran', 'penyaluran', '2026-06-01 03:33:52', '2026-06-01 03:33:52', NULL),
('294e4ed3-5aa5-4b37-a5a3-a3a1175ec759', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'rutinitas', 'rutinitas', '2026-06-01 04:10:04', '2026-06-01 04:10:04', NULL),
('2c6b6f8f-396b-4182-9c73-6dc7e7632e6f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'desa', 'desa', '2026-06-01 05:40:33', '2026-06-01 05:40:33', NULL),
('321baa1e-6741-4959-a7fb-47e8fe7f54b1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pengecatan', 'pengecatan', '2026-06-01 04:18:12', '2026-06-01 04:18:12', NULL),
('356138ea-a420-5abe-8455-a6484baf6480', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'PKK', 'pkk', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('36bd52c1-6845-4529-b883-9a817eda4bd6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pasar', 'pasar', '2026-06-01 04:16:49', '2026-06-01 04:16:49', NULL),
('388ecf63-2f90-49d6-91ad-8d41737ae810', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'event', 'event', '2026-06-01 03:18:50', '2026-06-01 03:18:50', NULL),
('3c2fde03-a3f9-4686-90da-f9432198045b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'speed bump', 'speed-bump', '2026-06-01 04:28:06', '2026-06-01 04:28:06', NULL),
('3d1fded6-2be2-5c4e-bd89-9756efb00c6e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Dana Desa', 'dana-desa', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('3d2f6091-f202-4d19-b3f4-e1c0f2ca4e0c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'turnamen', 'turnamen', '2026-06-01 05:19:24', '2026-06-01 05:19:24', NULL),
('3fa8db3f-dec2-4764-a585-15e05d95f305', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'giat', 'giat', '2026-06-01 05:16:48', '2026-06-01 05:16:48', NULL),
('4241153b-8f82-4835-a4a3-14832d6dbaf5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bukber', 'bukber', '2026-06-01 05:52:40', '2026-06-01 05:52:40', NULL),
('43b46d00-92db-4255-aa2a-003835d89178', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'lokasi', 'lokasi', '2026-06-01 05:36:21', '2026-06-01 05:36:21', NULL),
('45225e5f-e6ce-48c6-971a-bbee3c92a4b5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'proyek', 'proyek', '2026-06-01 05:32:50', '2026-06-01 05:32:50', NULL),
('469fae83-5477-431d-b359-2196dfac48fc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tempat parkir', 'tempat-parkir', '2026-06-01 04:18:12', '2026-06-01 04:18:12', NULL),
('480b1434-ad8a-48fa-8806-d61b344edc6a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bussiness', 'bussiness', '2026-06-01 05:44:05', '2026-06-01 05:44:05', NULL),
('48fbd2d1-f678-4055-aeef-d39fb8c62ef7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'voli', 'voli', '2026-06-01 05:19:24', '2026-06-01 05:19:24', NULL),
('4a2460ed-ff8c-448c-a0f3-82c20a852a95', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pembinaan', 'pembinaan', '2026-06-01 04:13:03', '2026-06-01 04:13:03', NULL),
('4b798f55-fff7-5df0-8421-c0837952f619', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BLT', 'blt', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('4c987579-3be3-4b96-9394-e866a8b38f3a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'sosialisasi', 'sosialisasi', '2026-06-01 05:56:26', '2026-06-01 05:56:26', NULL),
('4ea0c137-7d9b-40be-8e4e-50d7ad02d6a3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kantor hippa', 'kantor-hippa', '2026-06-01 04:24:52', '2026-06-01 04:24:52', NULL),
('4fb8f738-feda-48d0-8304-bbbd1be4b4f1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'aktivitas', 'aktivitas', '2026-06-01 05:11:55', '2026-06-01 05:11:55', NULL),
('52f90b50-df2d-4df2-b90a-629c42ad0f76', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'meeting', 'meeting', '2026-06-01 05:31:44', '2026-06-01 05:31:44', NULL),
('585d0caa-a31b-49e3-ab31-a73cfd35f47b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kades', 'kades', '2026-06-01 03:44:56', '2026-06-01 03:44:56', NULL),
('5948f38d-9074-4bbb-b487-4509c35db4c7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pengurus', 'pengurus', '2026-06-01 04:00:03', '2026-06-01 04:00:03', NULL),
('5ea28419-e7e9-494f-a777-1aef37b5f75b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pemindahan', 'pemindahan', '2026-06-01 04:14:19', '2026-06-01 04:14:19', NULL),
('5f8fea8c-bec4-4529-afb8-484dd2181dc2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pemerintahan', 'pemerintahan', '2026-06-01 03:21:47', '2026-06-01 03:21:47', NULL),
('60a92088-37b0-43e0-9694-0ecabf135990', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kios', 'kios', '2026-06-01 04:16:49', '2026-06-01 04:16:49', NULL),
('637d4cfd-6000-4d6a-844f-e352bea46836', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'idul adha', 'idul-adha', '2026-06-01 04:07:36', '2026-06-01 04:07:36', NULL),
('67a4246a-bade-4969-b525-27ea2f1320ee', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'psbindu', 'psbindu', '2026-06-01 05:45:25', '2026-06-01 05:45:25', NULL),
('6c25e8e0-2160-4dfc-a76c-9ba978fc4c29', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bantuan', 'bantuan', '2026-06-01 03:33:51', '2026-06-01 03:33:51', NULL),
('6c6300a3-a9da-426f-9ef1-256122d907c7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'jambanisasi', 'jambanisasi', '2026-06-01 04:45:48', '2026-06-01 04:45:48', NULL),
('6fa3f7a8-9f87-436a-a092-b75e4eedbe61', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'lomba', 'lomba', '2026-06-01 05:11:02', '2026-06-01 05:11:02', NULL),
('708c9a6e-f638-433a-aaa4-c79bed33d44c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'apresiasi', 'apresiasi', '2026-06-01 05:20:53', '2026-06-01 05:20:53', NULL),
('719f0c43-1399-42ae-a4dc-d8af3796dc1f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'koordinasi', 'koordinasi', '2026-06-01 05:34:21', '2026-06-01 05:34:21', NULL),
('71e967b0-3cb5-463c-9483-1af3cd674417', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'plesterisasi', 'plesterisasi', '2026-06-01 04:16:48', '2026-06-01 04:16:48', NULL),
('76f9468e-a240-4559-b497-873896e93ea7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tp pkk', 'tp-pkk', '2026-06-01 05:00:01', '2026-06-01 05:00:01', NULL),
('79ea38f3-5208-4434-9c99-edd84e5ace40', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'perangkat desa', 'perangkat-desa', '2026-06-01 05:53:26', '2026-06-01 05:53:26', NULL),
('7a57a525-5f1d-4046-af8c-1f5093b48dad', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'apel', 'apel', '2026-06-01 03:25:41', '2026-06-01 03:25:41', NULL),
('7c7274c8-7817-5742-b1d2-7ae33479da4e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bumdes', 'bumdes', '2026-05-21 01:30:02', '2026-06-01 05:24:53', NULL),
('7ca76548-e436-4bd0-bb58-472295a6c0ff', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'anak yatim', 'anak-yatim', '2026-06-01 03:39:57', '2026-06-01 03:39:57', NULL),
('7dd3ddd2-1f97-56d7-b2fe-9245318ce91a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tpt', 'tpt', '2026-05-21 01:30:02', '2026-06-01 03:37:11', NULL),
('81819de5-118a-49fc-b372-f6799ad50498', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tandon', 'tandon', '2026-06-01 04:15:18', '2026-06-01 04:15:18', NULL),
('8290c4c7-7327-50b6-9d8a-fcc22bbc6b22', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BPD', 'bpd', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('857bb874-2eb5-5b80-8dd3-e308485fe400', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'APBDes', 'apbdes', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('8c3338e4-8a08-4145-a9f8-2a4555342855', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kopdes', 'kopdes', '2026-06-01 04:00:02', '2026-06-01 04:00:02', NULL),
('8f73d144-48c5-405b-86af-ad470dccd84a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dhuafa', 'dhuafa', '2026-06-01 05:25:54', '2026-06-01 05:25:54', NULL),
('91357d15-e607-56c6-a6d7-f44d06338356', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'paud', 'paud', '2026-05-21 01:30:02', '2026-06-01 03:55:50', NULL),
('946ca2a3-cb91-4e60-9f99-0092a6c0b362', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pertanian', 'pertanian', '2026-06-01 05:35:27', '2026-06-01 05:35:27', NULL),
('9678a8fc-fbc5-4dea-94ee-ca7ba72b2bfb', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dukungan polse', 'dukungan-polse', '2026-06-01 05:02:26', '2026-06-01 05:02:26', NULL),
('989e549e-6046-4cd7-b3eb-ad4b95f91887', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'reboisasi', 'reboisasi', '2026-06-01 05:52:03', '2026-06-01 05:52:03', NULL),
('9a6cdcda-b193-47d2-a299-96dc111495af', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pemasangan', 'pemasangan', '2026-06-01 04:28:06', '2026-06-01 04:28:06', NULL),
('9ba60f88-4a36-50be-9e73-7983cacecca0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Karang Taruna', 'karang-taruna', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('9c97d560-3f09-46a0-a3cf-af5712d58784', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'competition', 'competition', '2026-06-01 05:18:11', '2026-06-01 05:18:11', NULL),
('9cd88a63-e223-48be-9849-a4c579b6ac98', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'mck', 'mck', '2026-06-01 03:54:10', '2026-06-01 03:54:10', NULL),
('9fc6ad6d-a8dd-4698-8457-b278502f245c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'lapangan', 'lapangan', '2026-06-01 03:57:59', '2026-06-01 03:57:59', NULL),
('a1535f9f-aa95-492b-9514-031077e4f0db', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'lingkungan', 'lingkungan', '2026-06-01 03:29:05', '2026-06-01 03:29:05', NULL),
('a22ae8d5-e0ab-5082-ae3c-df1b2b557177', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'hari santri', 'hari-santri', '2026-05-21 01:30:02', '2026-06-01 05:27:51', NULL),
('a22be5be-3af1-4b2c-b6d1-9c1ec19416e9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'apbd', 'apbd', '2026-06-01 03:49:28', '2026-06-01 03:49:28', NULL),
('a2415f13-124b-490b-bdcf-10eb67c488cb', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tasyakuran', 'tasyakuran', '2026-06-01 04:22:56', '2026-06-01 04:22:56', NULL),
('a2a354db-0948-5096-ad72-bc86ac5faba2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kesehatan', 'kesehatan', '2026-05-21 01:30:02', '2026-05-31 04:30:33', NULL),
('a2eabaed-252f-4d4c-8aed-6e5da1fcd0a1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'anggaran', 'anggaran', '2026-06-01 03:49:29', '2026-06-01 03:49:29', NULL),
('a2f8ef7f-8aa4-41e7-afc3-83eaff564d42', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'blt dd', 'blt-dd', '2026-06-01 05:54:14', '2026-06-01 05:54:14', NULL),
('a3eda259-210c-5699-8e03-60d569ed4e60', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'martopuro', 'martopuro', '2026-05-21 01:30:02', '2026-05-24 09:41:39', NULL),
('a42a0420-9540-5dda-a676-87ece5869b3a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kdmp', 'kdmp', '2026-05-21 01:30:02', '2026-05-24 09:41:39', NULL),
('a51a29e8-1948-45d6-8d3f-b46a6089df96', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'football', 'football', '2026-06-01 05:04:27', '2026-06-01 05:04:27', NULL),
('a5f4ff91-7ddd-53d7-b564-3f29521a7c26', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'koperasi desa', 'koperasi-desa', '2026-05-21 01:30:02', '2026-05-24 09:41:39', NULL),
('a79d6aed-21b7-4388-b490-cbb84a44f40d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'rencana', 'rencana', '2026-06-01 05:36:20', '2026-06-01 05:36:20', NULL),
('a8d47bff-3ed1-4b69-8fc6-dece77f120b7', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bltdd', 'bltdd', '2026-06-01 04:03:48', '2026-06-01 04:03:48', NULL),
('a9a6c593-ad2c-54a7-8377-affa7b4b2022', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'donor darah', 'donor-darah', '2026-05-21 01:30:02', '2026-06-01 04:05:25', NULL),
('aa78b156-dc81-4c27-9785-6b3a36be0a4c', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'thr', 'thr', '2026-06-01 05:53:25', '2026-06-01 05:53:25', NULL),
('acec22b2-65f6-496a-9cbf-6642d5311c2e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'index', 'index', '2026-06-01 04:01:12', '2026-06-01 04:01:12', NULL),
('af1826d1-f216-412c-a1fa-7d5b2663d50f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'monitoring', 'monitoring', '2026-06-01 05:30:15', '2026-06-01 05:30:15', NULL),
('b29a5b4e-5967-5d40-bf93-5b57bd786ef0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pavingisasi', 'pavingisasi', '2026-05-21 01:30:02', '2026-05-31 04:51:08', NULL),
('b6cad41e-d432-4e05-b24c-e3701b9ebdd3', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kunjungan', 'kunjungan', '2026-06-01 04:32:02', '2026-06-01 04:32:02', NULL),
('b719046d-d642-46c7-8fa3-135b370f4843', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'hari desa', 'hari-desa', '2026-06-01 03:25:42', '2026-06-01 03:25:42', NULL),
('ba5d2fa0-6744-4f2c-8db5-08a70c03fb08', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'santunan', 'santunan', '2026-06-01 03:39:57', '2026-06-01 03:39:57', NULL),
('ba7593f4-1683-53ab-b3cc-6b5da019b289', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'RT RW', 'rt-rw', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('bd8fd9d9-a673-4c78-819e-824714535089', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'monev', 'monev', '2026-06-01 04:06:23', '2026-06-01 04:06:23', NULL),
('bda96326-5d8a-5592-9623-c593475f0475', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pemerintahan desa', 'pemerintahan-desa', '2026-05-21 01:30:02', '2026-06-01 06:06:34', NULL),
('c22e43ad-7c79-4c4a-96bb-c587cd705d58', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'bimbingan', 'bimbingan', '2026-06-01 05:33:27', '2026-06-01 05:33:27', NULL),
('c2bfa8c6-5e15-454a-a1d3-64d2d37053ac', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'laporan', 'laporan', '2026-06-01 03:21:46', '2026-06-01 03:21:46', NULL),
('c34e42b1-da01-44e5-8f53-44d1f51d20ac', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'puasa', 'puasa', '2026-06-01 05:52:41', '2026-06-01 05:52:41', NULL),
('c43008e6-cb44-4a13-81a1-30530fd45fc6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'rehab', 'rehab', '2026-06-01 04:24:51', '2026-06-01 04:24:51', NULL),
('c527ef85-e872-427d-8963-7bccd709bcfa', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'qurban', 'qurban', '2026-06-01 04:07:37', '2026-06-01 04:07:37', NULL),
('ccb4382e-65c4-4086-bd43-13fdb8bb3f0f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dana blt', 'dana-blt', '2026-06-01 05:22:45', '2026-06-01 05:22:45', NULL),
('cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Olahraga', 'olahraga', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('d2538c4d-cafd-4492-966d-46e841098b81', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'musholla', 'musholla', '2026-06-01 04:33:43', '2026-06-01 04:33:43', NULL),
('d38fac0f-9b47-44fb-998b-a3767f046136', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tata kelola', 'tata-kelola', '2026-06-01 05:29:18', '2026-06-01 05:29:18', NULL),
('da360318-3485-5a37-bc5c-916286bcb002', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'berita desa', 'berita-desa', '2026-05-21 01:30:02', '2026-05-24 09:41:39', NULL),
('de78b720-c3b7-4081-af2d-83f0213247bd', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'penyerahan', 'penyerahan', '2026-06-01 04:03:48', '2026-06-01 04:03:48', NULL),
('e2ec2732-77b8-5a6a-b01c-a543ca4951b5', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'karnaval', 'karnaval', '2026-05-21 01:30:02', '2026-06-01 04:25:57', NULL),
('e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Musyawarah Desa', 'musyawarah-desa', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e6b1c78b-7e84-51b8-901c-06c2c7d131b2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Profil Desa', 'profil-desa', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('e957062d-cc6a-4288-b154-08b69df5c696', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'rapat', 'rapat', '2026-06-01 05:34:20', '2026-06-01 05:34:20', NULL),
('eb954789-628c-4714-a916-48aad5a086ce', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'juara', 'juara', '2026-06-01 05:00:00', '2026-06-01 05:00:00', NULL),
('ebf4a429-a801-4f08-a628-0d62c59c63da', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'kerja bakti', 'kerja-bakti', '2026-06-01 03:29:04', '2026-06-01 03:29:04', NULL),
('ef78fa45-da83-4717-b8a2-8bd3372f9b22', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'siswa baru', 'siswa-baru', '2026-06-01 03:55:50', '2026-06-01 03:55:50', NULL),
('f2df34b8-1c11-4581-8d05-2bf0c063648d', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'realisasi', 'realisasi', '2026-06-01 03:38:25', '2026-06-01 03:38:25', NULL),
('f35a6780-4006-49e4-875a-1a156468f4f0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pengukuran', 'pengukuran', '2026-06-01 05:46:07', '2026-06-01 05:46:07', NULL),
('f89dce11-6aa2-5881-a3e1-ba18c1c3f79e', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Lembaga Desa', 'lembaga-desa', '2026-05-21 01:30:02', '2026-05-21 01:30:02', NULL),
('f90b8c5c-0feb-49c9-a18e-714b5cf8a644', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'stunting', 'stunting', '2026-06-01 05:07:47', '2026-06-01 05:07:47', NULL),
('f9186399-961e-5bc6-a27d-2b2c45361f07', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'khotmil quran', 'khotmil-quran', '2026-05-21 01:30:02', '2026-06-01 04:03:00', NULL),
('fa005f15-fbba-4a30-8d85-c90269057134', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'penetapan', 'penetapan', '2026-06-01 05:38:25', '2026-06-01 05:38:25', NULL),
('fa54f909-65cc-4763-a1f2-7017ac25bf03', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'upacara', 'upacara', '2026-06-01 03:25:42', '2026-06-01 03:25:42', NULL),
('fc32df4a-f6f0-4819-b170-410eea827a93', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'administrasi', 'administrasi', '2026-06-01 05:33:28', '2026-06-01 05:33:28', NULL),
('fdec5925-2f0b-476a-98a7-64b2675de29b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'dzikir', 'dzikir', '2026-06-01 04:19:50', '2026-06-01 04:19:50', NULL),
('fdf83b80-f0da-4f36-ab0a-b06e09f2d035', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'pemdes', 'pemdes', '2026-06-01 04:32:03', '2026-06-01 04:32:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `news_tag_map`
--

CREATE TABLE `news_tag_map` (
  `news_id` char(36) NOT NULL,
  `tag_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_tag_map`
--

INSERT INTO `news_tag_map` (`news_id`, `tag_id`) VALUES
('bb782d66-56fd-4bf4-8ffb-661975b557f2', '0333eed5-745f-4196-af8e-b392503e70ae'),
('5ae7096e-679e-410a-ab61-ce0a2c9bbb0a', '07f43c64-a846-40fb-8343-f5f6e523e5a3'),
('2a693bbe-b6d7-4fb8-ae79-a12033e2d3e3', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('35683772-c594-481a-8eb1-eaee4d1b12a8', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('43fcbd6d-ca10-40f2-a643-00c97c9c2238', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('5344407f-87d5-47ed-867d-a360cb9056d4', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('8a01ce05-ab85-473f-8ba4-c8acc36cb7c9', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('9725e507-3b88-4fef-901d-1c294738ec53', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('bd211baf-c721-434f-8f2f-2d16f4d642a0', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('e017b699-665d-4dd9-a205-98c0affc834a', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('e73885a1-fa04-4f73-8bbf-df720814ff73', '09be1efe-4ac5-4be4-aa5b-c05faae800b2'),
('5cd8dd9b-fe05-4a9b-a69e-d4143da2ca91', '09dd780e-e4de-4ffa-99fc-6ac691fad505'),
('a32f4017-70d6-48fb-abc4-3c4c2d1672fc', '0a846a1a-a519-4b34-b355-3c9f8d0ccab1'),
('0be41b32-d04a-4b97-ac59-4385697d1057', '125ab8e9-24ab-4299-b2f5-4c0573ae0062'),
('2ffc1f6c-fd0a-46ce-9602-7dd4870bbb56', '16311492-68fe-4845-b5cc-78a9d1d5ca16'),
('5fbe0d5f-3d1a-4424-a158-95bcc2b97f92', '16311492-68fe-4845-b5cc-78a9d1d5ca16'),
('b7fd0c91-64a2-4f63-ae82-8824e47c1581', '16311492-68fe-4845-b5cc-78a9d1d5ca16'),
('0746ae12-f1da-4333-b821-8c0f8ca7e73b', '17e3ba00-1829-4285-8eff-28ba40c61557'),
('030ca3a3-ae2d-43d6-b218-e67932a17cdb', '19a1d581-ca4d-4299-b26e-011bf3d3ba5b'),
('278b6e8c-47e0-4217-96fb-70a391fd8307', '19a1d581-ca4d-4299-b26e-011bf3d3ba5b'),
('7f3337b0-02b3-48e6-81e0-a75bd6084ea9', '1f45c1db-1acd-4eff-ae78-1aa3d8debe52'),
('00124a2b-cd8c-5c07-a9b0-802a23f37540', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('00663ec6-efdb-5deb-ab2a-890e9b41b300', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('0d88cc0f-991a-5abd-b92a-b87fba44bf44', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('14ac0d2b-754c-536c-99cf-15cc577f0e4e', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('367ccb5e-c6d1-4568-bf13-71c3d551456a', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('38de09ff-57e4-4f30-b432-025b26f16922', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('51f681e3-6898-57ff-90af-38c7da75782e', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('59c2d5ca-09b0-41c5-b067-be89d9c44a90', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('5c6d5abd-f674-48f9-ab24-eaeb13ff158e', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('5e992740-596b-48a9-9db8-5c2d73608bac', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('65906799-b51a-452f-95b5-d1883487ec95', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('690da950-e796-5869-b702-769a14174c0d', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('716d2798-4298-5677-8de2-a849e97e0e4e', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('7297bdb9-65d3-5e8b-a567-4c433e23c766', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('742001dc-5a14-5b31-a224-e799ceed78da', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('90753d65-2026-5e82-b69a-39c3d7d6840a', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('e4b3d968-5661-4df8-a885-72c8cc5bc4e1', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('fbccd0a6-50c2-4ae4-aa63-9cf6e1a5a9e9', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', '1fd988f4-4834-5c01-9381-be463e47cc4f'),
('020bab30-db2f-4388-aee3-a8a74d015634', '2084f594-0d4d-446d-b4ed-1446e849837d'),
('85923343-5bc2-47b6-8098-ded6a436a108', '2084f594-0d4d-446d-b4ed-1446e849837d'),
('bb7e432c-15cb-47ea-8f90-0e9ad2c6eacc', '2084f594-0d4d-446d-b4ed-1446e849837d'),
('0e1ac83c-6448-5299-ad51-0f738729c829', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('278b6e8c-47e0-4217-96fb-70a391fd8307', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('314b723c-3f8d-5166-bfa5-72aa7043a5a9', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('838dcc0a-b872-46b8-9d03-809ea392c667', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('d545b75f-5e33-5840-bbb8-75a04f3b81f8', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('db1914b1-a569-54c6-9947-c394dbb9be82', '214fee5b-67a0-5f2d-b02d-83e714b7362a'),
('020bab30-db2f-4388-aee3-a8a74d015634', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('2dc65dc5-2352-4053-9cfd-32b649f6efa7', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('85923343-5bc2-47b6-8098-ded6a436a108', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('9b1728a0-64b6-4f96-9e35-4bf000f80ecb', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('b4df81e5-62e1-4be5-80fb-005b9936f970', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('bb7e432c-15cb-47ea-8f90-0e9ad2c6eacc', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('f65c9345-599b-4b20-985d-ef22fcf666aa', '21605b75-ef9b-4b65-b8f1-22bd942d9531'),
('e777b1f4-7186-4c41-bdc6-cb92b88c1877', '294e4ed3-5aa5-4b37-a5a3-a3a1175ec759'),
('2ba41ebe-04db-485f-8258-2163848cd3da', '2c6b6f8f-396b-4182-9c73-6dc7e7632e6f'),
('d9fc8dea-53d7-4e22-88a1-80f58ff8e87e', '2c6b6f8f-396b-4182-9c73-6dc7e7632e6f'),
('1374e553-0b7a-4d8f-a799-56fe0a66fa5b', '321baa1e-6741-4959-a7fb-47e8fe7f54b1'),
('e376fa17-a90f-4c4e-a1a3-1bd73fb8982a', '321baa1e-6741-4959-a7fb-47e8fe7f54b1'),
('e90bcc81-1615-475b-af7c-5a1704c3458f', '321baa1e-6741-4959-a7fb-47e8fe7f54b1'),
('37298592-f182-5f74-b78c-b3ec4bbc6131', '356138ea-a420-5abe-8455-a6484baf6480'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', '356138ea-a420-5abe-8455-a6484baf6480'),
('9198aa9c-915c-582d-8e20-608ec82b6c1c', '356138ea-a420-5abe-8455-a6484baf6480'),
('ad96b442-3513-573f-bc25-4b8090a7cd48', '356138ea-a420-5abe-8455-a6484baf6480'),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', '356138ea-a420-5abe-8455-a6484baf6480'),
('0e470769-7ccd-49b5-9b2e-504c65501484', '36bd52c1-6845-4529-b883-9a817eda4bd6'),
('5ae7096e-679e-410a-ab61-ce0a2c9bbb0a', '388ecf63-2f90-49d6-91ad-8d41737ae810'),
('66211d0f-cc6d-4a76-8084-078ebec7cb1f', '3c2fde03-a3f9-4686-90da-f9432198045b'),
('037e60f1-d579-5c99-955f-eb8ef6fa50c5', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('0de3d276-823d-583f-99c9-238dd1192685', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('1a44dc93-7a2d-5c4b-a91f-59b24b558625', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('4fa40dea-5ca9-5e8b-91b6-61b784917577', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('790d87a5-2ae9-5430-840a-83736bee1d62', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('9dadaee9-719d-548b-8238-f4fe52022f8c', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('de43dc9d-c33d-501f-a100-518c0d4f1802', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('e234c8ce-3c68-5078-858b-028ecb8131c7', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', '3d1fded6-2be2-5c4e-bd89-9756efb00c6e'),
('8fe40173-2173-4961-a74c-f8ff0e7507f4', '3d2f6091-f202-4d19-b3f4-e1c0f2ca4e0c'),
('6cf21661-78fe-45da-9b85-bf6966280a03', '3fa8db3f-dec2-4764-a585-15e05d95f305'),
('2432d3ab-2ca7-42cd-a482-cb3eb7524a66', '4241153b-8f82-4835-a4a3-14832d6dbaf5'),
('59c2d5ca-09b0-41c5-b067-be89d9c44a90', '43b46d00-92db-4255-aa2a-003835d89178'),
('5cd8dd9b-fe05-4a9b-a69e-d4143da2ca91', '45225e5f-e6ce-48c6-971a-bbee3c92a4b5'),
('e90bcc81-1615-475b-af7c-5a1704c3458f', '469fae83-5477-431d-b359-2196dfac48fc'),
('97ad3f42-b363-4bf3-b7eb-94f7b9d37655', '480b1434-ad8a-48fa-8806-d61b344edc6a'),
('8fe40173-2173-4961-a74c-f8ff0e7507f4', '48fbd2d1-f678-4055-aeef-d39fb8c62ef7'),
('cc79da3a-a218-4612-9dab-da718f6feac0', '48fbd2d1-f678-4055-aeef-d39fb8c62ef7'),
('4a11404b-31fe-4605-b39c-3219f1a67028', '4a2460ed-ff8c-448c-a0f3-82c20a852a95'),
('943d16c5-7f8b-4f3d-b840-79a33d47341a', '4a2460ed-ff8c-448c-a0f3-82c20a852a95'),
('95574412-da92-4b47-b5c1-a534b099adf3', '4a2460ed-ff8c-448c-a0f3-82c20a852a95'),
('086e5012-1bce-5e52-8e64-b1dadc98f553', '4b798f55-fff7-5df0-8421-c0837952f619'),
('4fa40dea-5ca9-5e8b-91b6-61b784917577', '4b798f55-fff7-5df0-8421-c0837952f619'),
('9dadaee9-719d-548b-8238-f4fe52022f8c', '4b798f55-fff7-5df0-8421-c0837952f619'),
('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', '4b798f55-fff7-5df0-8421-c0837952f619'),
('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', '4b798f55-fff7-5df0-8421-c0837952f619'),
('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', '4b798f55-fff7-5df0-8421-c0837952f619'),
('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', '4b798f55-fff7-5df0-8421-c0837952f619'),
('de43dc9d-c33d-501f-a100-518c0d4f1802', '4b798f55-fff7-5df0-8421-c0837952f619'),
('e234c8ce-3c68-5078-858b-028ecb8131c7', '4b798f55-fff7-5df0-8421-c0837952f619'),
('3355a1ee-dcfa-4644-b6d2-2ae6e1407e12', '4c987579-3be3-4b96-9394-e866a8b38f3a'),
('d153e8c3-01bd-4ae5-8b5b-6cf1ed053810', '4c987579-3be3-4b96-9394-e866a8b38f3a'),
('2a5d579f-941a-46c2-9287-15adb4eb2751', '4ea0c137-7d9b-40be-8e4e-50d7ad02d6a3'),
('b60dc01c-6683-40cb-9857-fd2293a8ff67', '4fb8f738-feda-48d0-8304-bbbd1be4b4f1'),
('fb4fff82-a2d2-47ba-ae1d-800a034b6c01', '52f90b50-df2d-4df2-b90a-629c42ad0f76'),
('030ca3a3-ae2d-43d6-b218-e67932a17cdb', '585d0caa-a31b-49e3-ab31-a73cfd35f47b'),
('4c7b3e0e-9429-4f03-9d43-624c8f18d5a6', '5948f38d-9074-4bbb-b487-4509c35db4c7'),
('3f50d240-10a1-4e26-96d6-43f00be57750', '5ea28419-e7e9-494f-a777-1aef37b5f75b'),
('311b93f0-f8b3-4c80-9cbf-1fa765bd1848', '5f8fea8c-bec4-4529-afb8-484dd2181dc2'),
('d9fc8dea-53d7-4e22-88a1-80f58ff8e87e', '5f8fea8c-bec4-4529-afb8-484dd2181dc2'),
('0e470769-7ccd-49b5-9b2e-504c65501484', '60a92088-37b0-43e0-9694-0ecabf135990'),
('28b53495-85c2-4a29-a7b1-38a9146b05cc', '637d4cfd-6000-4d6a-844f-e352bea46836'),
('54516f96-faac-4ea0-96f6-304835999627', '67a4246a-bade-4969-b525-27ea2f1320ee'),
('9b1728a0-64b6-4f96-9e35-4bf000f80ecb', '6c25e8e0-2160-4dfc-a76c-9ba978fc4c29'),
('f65c9345-599b-4b20-985d-ef22fcf666aa', '6c25e8e0-2160-4dfc-a76c-9ba978fc4c29'),
('b9c6e7b5-1424-40f1-8303-adc206835270', '6c6300a3-a9da-426f-9ef1-256122d907c7'),
('22712218-926b-48bf-ac6c-f25402df5309', '6fa3f7a8-9f87-436a-a092-b75e4eedbe61'),
('cc79da3a-a218-4612-9dab-da718f6feac0', '708c9a6e-f638-433a-aaa4-c79bed33d44c'),
('ea008a2a-f6ba-4658-a4b7-6146468a9e55', '719f0c43-1399-42ae-a4dc-d8af3796dc1f'),
('0e470769-7ccd-49b5-9b2e-504c65501484', '71e967b0-3cb5-463c-9483-1af3cd674417'),
('06122912-1963-43b7-815c-7c97b52faf3c', '76f9468e-a240-4559-b497-873896e93ea7'),
('f92a3aeb-f9c5-46d2-a1b7-d6ae613991ee', '79ea38f3-5208-4434-9c99-edd84e5ace40'),
('be9fa729-5936-4b8c-a130-f110ad102b90', '7a57a525-5f1d-4046-af8c-1f5093b48dad'),
('0e1ac83c-6448-5299-ad51-0f738729c829', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('314b723c-3f8d-5166-bfa5-72aa7043a5a9', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('838dcc0a-b872-46b8-9d03-809ea392c667', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('d545b75f-5e33-5840-bbb8-75a04f3b81f8', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('db1914b1-a569-54c6-9947-c394dbb9be82', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('e443442d-8563-5fd5-991d-b26695297919', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('fb4fff82-a2d2-47ba-ae1d-800a034b6c01', '7c7274c8-7817-5742-b1d2-7ae33479da4e'),
('8fd48cd4-c4cc-4c03-b031-45b1cf409659', '7ca76548-e436-4bd0-bb58-472295a6c0ff'),
('00663ec6-efdb-5deb-ab2a-890e9b41b300', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('5c6d5abd-f674-48f9-ab24-eaeb13ff158e', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('716d2798-4298-5677-8de2-a849e97e0e4e', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('c6ec6cba-1456-478c-837c-ad0a8491d14a', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', '7dd3ddd2-1f97-56d7-b2fe-9245318ce91a'),
('e4b3d968-5661-4df8-a885-72c8cc5bc4e1', '81819de5-118a-49fc-b372-f6799ad50498'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),
('9198aa9c-915c-582d-8e20-608ec82b6c1c', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', '8290c4c7-7327-50b6-9d8a-fcc22bbc6b22'),
('037e60f1-d579-5c99-955f-eb8ef6fa50c5', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('0de3d276-823d-583f-99c9-238dd1192685', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('51f681e3-6898-57ff-90af-38c7da75782e', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('790d87a5-2ae9-5430-840a-83736bee1d62', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', '857bb874-2eb5-5b80-8dd3-e308485fe400'),
('47f7d6e6-271e-4a54-8046-a015f83eda9f', '8c3338e4-8a08-4145-a9f8-2a4555342855'),
('4a164b15-6037-42ac-ac3e-a271f5a92f95', '8c3338e4-8a08-4145-a9f8-2a4555342855'),
('4c7b3e0e-9429-4f03-9d43-624c8f18d5a6', '8c3338e4-8a08-4145-a9f8-2a4555342855'),
('85add9c7-533d-4ac0-aad8-2d6c0ed022ef', '8c3338e4-8a08-4145-a9f8-2a4555342855'),
('235958bb-f030-4537-a8c6-fc549b8019bc', '8f73d144-48c5-405b-86af-ad470dccd84a'),
('669442fa-2d82-574d-a13e-a80bc0b6c09b', '91357d15-e607-56c6-a6d7-f44d06338356'),
('6dac5caf-5fd1-5024-947f-612840cdfe03', '91357d15-e607-56c6-a6d7-f44d06338356'),
('e85d52b3-c0d2-41ad-8044-08e28bbfae14', '91357d15-e607-56c6-a6d7-f44d06338356'),
('bb782d66-56fd-4bf4-8ffb-661975b557f2', '946ca2a3-cb91-4e60-9f99-0092a6c0b362'),
('9427ff79-8c0f-4f89-8ee2-9863c7e309cc', '9678a8fc-fbc5-4dea-94ee-ca7ba72b2bfb'),
('0aa19503-fb6a-434c-b002-873032bcae51', '989e549e-6046-4cd7-b3eb-ad4b95f91887'),
('66211d0f-cc6d-4a76-8084-078ebec7cb1f', '9a6cdcda-b193-47d2-a299-96dc111495af'),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('3a7b5d24-4b34-530e-a244-98c85a32780d', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('6070b7fc-e04e-569d-b739-e2910ffd5090', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('6803ca49-8946-5386-86a8-257563dfb328', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('a71c4075-f75f-5679-9e9f-f92a1c40688a', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('b8c6cb03-34cd-585e-a83d-85ecd115c79b', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', '9ba60f88-4a36-50be-9e73-7983cacecca0'),
('0746ae12-f1da-4333-b821-8c0f8ca7e73b', '9c97d560-3f09-46a0-a3cf-af5712d58784'),
('367ccb5e-c6d1-4568-bf13-71c3d551456a', '9cd88a63-e223-48be-9849-a4c579b6ac98'),
('3f50d240-10a1-4e26-96d6-43f00be57750', '9fc6ad6d-a8dd-4698-8457-b278502f245c'),
('9a2e7ab7-88f1-4e60-9369-9835a0388f08', '9fc6ad6d-a8dd-4698-8457-b278502f245c'),
('16e2a5a9-8086-4a57-8a76-6b08cd10769d', 'a1535f9f-aa95-492b-9514-031077e4f0db'),
('4a829d74-5b10-4e89-8c47-08ba47dbe561', 'a22ae8d5-e0ab-5082-ae3c-df1b2b557177'),
('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'a22ae8d5-e0ab-5082-ae3c-df1b2b557177'),
('1de35778-7c09-4d4b-9ddb-3129cb9f85c9', 'a22be5be-3af1-4b2c-b6d1-9c1ec19416e9'),
('b9c6e7b5-1424-40f1-8303-adc206835270', 'a22be5be-3af1-4b2c-b6d1-9c1ec19416e9'),
('ba88c68c-686d-4eea-842f-106a3f393435', 'a22be5be-3af1-4b2c-b6d1-9c1ec19416e9'),
('b64e58e2-d4ad-4c27-a555-8f6f070ea501', 'a2415f13-124b-490b-bdcf-10eb67c488cb'),
('0202d245-a266-545f-9162-d6eea1ab2925', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('a9d605f6-deff-5623-945e-97f2db2ec56f', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'a2a354db-0948-5096-ad72-bc86ac5faba2'),
('1de35778-7c09-4d4b-9ddb-3129cb9f85c9', 'a2eabaed-252f-4d4c-8aed-6e5da1fcd0a1'),
('ba88c68c-686d-4eea-842f-106a3f393435', 'a2eabaed-252f-4d4c-8aed-6e5da1fcd0a1'),
('2dc65dc5-2352-4053-9cfd-32b649f6efa7', 'a2f8ef7f-8aa4-41e7-afc3-83eaff564d42'),
('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('00663ec6-efdb-5deb-ab2a-890e9b41b300', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0202d245-a266-545f-9162-d6eea1ab2925', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('027f21be-9112-5401-a8b7-f4138b7c972e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('037e60f1-d579-5c99-955f-eb8ef6fa50c5', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('086e5012-1bce-5e52-8e64-b1dadc98f553', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0b3e53f9-c8a2-50b5-9846-8639df57da24', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0d88cc0f-991a-5abd-b92a-b87fba44bf44', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0de3d276-823d-583f-99c9-238dd1192685', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0e1ac83c-6448-5299-ad51-0f738729c829', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0f5169fe-c105-5392-9ce6-eb8bce734ce9', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('1200c374-aa7b-5f70-966a-6f94b09c9f1b', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('1a44dc93-7a2d-5c4b-a91f-59b24b558625', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('27efc7fe-a3de-5fd9-b18b-339c8ced838f', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('314b723c-3f8d-5166-bfa5-72aa7043a5a9', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('37298592-f182-5f74-b78c-b3ec4bbc6131', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('37876a11-2d4b-5e70-8b61-474ab4551ae5', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('3cca2173-6c5b-46ed-91b2-930f421e961e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('3d5a8754-c917-5892-8545-2f03ef4746ed', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('4b70b27d-1a42-519d-af06-141de67515c7', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('4e2acb6e-09d3-589c-80a4-d7683ee2eb57', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('4fa40dea-5ca9-5e8b-91b6-61b784917577', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('51f681e3-6898-57ff-90af-38c7da75782e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('53d1a069-6c1b-5559-b7f0-88fc9215eeec', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('5c6b17fa-8342-5aec-9b43-8882f65deed6', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('6070b7fc-e04e-569d-b739-e2910ffd5090', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('669442fa-2d82-574d-a13e-a80bc0b6c09b', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('6803ca49-8946-5386-86a8-257563dfb328', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('68d97ecd-8f43-592e-9a84-c151b1626e11', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('690da950-e796-5869-b702-769a14174c0d', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('6dac5caf-5fd1-5024-947f-612840cdfe03', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('716d2798-4298-5677-8de2-a849e97e0e4e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('7190b957-3b9c-54eb-812e-5e4f87d0486e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('7297bdb9-65d3-5e8b-a567-4c433e23c766', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('742001dc-5a14-5b31-a224-e799ceed78da', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('769da44b-8943-579c-aadf-f4cfbf063172', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('790d87a5-2ae9-5430-840a-83736bee1d62', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('90753d65-2026-5e82-b69a-39c3d7d6840a', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('9198aa9c-915c-582d-8e20-608ec82b6c1c', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('92677901-c5ac-595a-8835-27d8ed0af3f0', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('93b7ab59-b0ac-5d18-96a2-e07db2776730', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('9bd335b4-71c8-5489-958f-434540bdc86c', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('9dadaee9-719d-548b-8238-f4fe52022f8c', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('a2b9a81a-33b2-5ff3-a9d9-f19c5d4f1f06', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('a71c4075-f75f-5679-9e9f-f92a1c40688a', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('a9d605f6-deff-5623-945e-97f2db2ec56f', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ab737371-da5c-527f-9a79-9c0c2f45675a', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ad96b442-3513-573f-bc25-4b8090a7cd48', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ae99d98e-0fde-5894-bac8-4b5b13111604', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('b8c6cb03-34cd-585e-a83d-85ecd115c79b', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d41479a0-fd39-5334-b206-08e45fd69a44', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d545b75f-5e33-5840-bbb8-75a04f3b81f8', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d94820bc-e2b3-5365-b15d-2918dcb35469', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('db1914b1-a569-54c6-9947-c394dbb9be82', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('de43dc9d-c33d-501f-a100-518c0d4f1802', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('e234c8ce-3c68-5078-858b-028ecb8131c7', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('e443442d-8563-5fd5-991d-b26695297919', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'a3eda259-210c-5699-8e03-60d569ed4e60'),
('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('716d2798-4298-5677-8de2-a849e97e0e4e', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a42a0420-9540-5dda-a676-87ece5869b3a'),
('ae3eaefb-4324-4180-957e-6a0b300e9e4d', 'a51a29e8-1948-45d6-8d3f-b46a6089df96'),
('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('12e93598-3a78-591f-a50a-1722d6fa50f8', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'a5f4ff91-7ddd-53d7-b564-3f29521a7c26'),
('59c2d5ca-09b0-41c5-b067-be89d9c44a90', 'a79d6aed-21b7-4388-b490-cbb84a44f40d'),
('9acd95c9-dbf9-4558-869d-a788e5b39bf9', 'a8d47bff-3ed1-4b69-8fc6-dece77f120b7'),
('06310a4b-a9a2-4262-b974-b6a2bf1f2de9', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022'),
('122a034f-a3e0-407b-9646-8124da939ebe', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022'),
('3a7b5d24-4b34-530e-a244-98c85a32780d', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022'),
('8eca8b9e-1818-5380-85dc-41dc5b06dfbf', 'a9a6c593-ad2c-54a7-8377-affa7b4b2022'),
('f92a3aeb-f9c5-46d2-a1b7-d6ae613991ee', 'aa78b156-dc81-4c27-9785-6b3a36be0a4c'),
('43fcbd6d-ca10-40f2-a643-00c97c9c2238', 'acec22b2-65f6-496a-9cbf-6642d5311c2e'),
('876b91c3-c511-4b5a-9e33-5824a8c36673', 'af1826d1-f216-412c-a1fa-7d5b2663d50f'),
('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('51f681e3-6898-57ff-90af-38c7da75782e', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('70898464-e84f-49cf-a72b-acedca8a8d75', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('742001dc-5a14-5b31-a224-e799ceed78da', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('89e6969a-b520-46f6-8455-e78851167504', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('9a2e7ab7-88f1-4e60-9369-9835a0388f08', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('c6ec6cba-1456-478c-837c-ad0a8491d14a', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('d03c5512-5d45-43a3-beb6-890066b0094b', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('fbccd0a6-50c2-4ae4-aa63-9cf6e1a5a9e9', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'b29a5b4e-5967-5d40-bf93-5b57bd786ef0'),
('7779f973-7f37-4a6d-8dcd-a23f2d9d9f4c', 'b6cad41e-d432-4e05-b24c-e3701b9ebdd3'),
('be9fa729-5936-4b8c-a130-f110ad102b90', 'b719046d-d642-46c7-8fa3-135b370f4843'),
('235958bb-f030-4537-a8c6-fc549b8019bc', 'ba5d2fa0-6744-4f2c-8db5-08a70c03fb08'),
('8fd48cd4-c4cc-4c03-b031-45b1cf409659', 'ba5d2fa0-6744-4f2c-8db5-08a70c03fb08'),
('037e60f1-d579-5c99-955f-eb8ef6fa50c5', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('314b723c-3f8d-5166-bfa5-72aa7043a5a9', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('37298592-f182-5f74-b78c-b3ec4bbc6131', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('4b70b27d-1a42-519d-af06-141de67515c7', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('769da44b-8943-579c-aadf-f4cfbf063172', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('790d87a5-2ae9-5430-840a-83736bee1d62', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'ba7593f4-1683-53ab-b3cc-6b5da019b289'),
('0688f468-777f-41ba-b8a5-a07ab6d8fed1', 'bd8fd9d9-a673-4c78-819e-824714535089'),
('6cf21661-78fe-45da-9b85-bf6966280a03', 'bd8fd9d9-a673-4c78-819e-824714535089'),
('a6926834-c014-45e2-817c-a1e3fda225f3', 'bda96326-5d8a-5592-9623-c593475f0475'),
('74b839a4-3c8c-487d-a9a5-145f548e70a1', 'c22e43ad-7c79-4c4a-96bb-c587cd705d58'),
('311b93f0-f8b3-4c80-9cbf-1fa765bd1848', 'c2bfa8c6-5e15-454a-a1d3-64d2d37053ac'),
('3defa28f-1983-40e9-9681-d0880123d8ad', 'c2bfa8c6-5e15-454a-a1d3-64d2d37053ac'),
('ff4f34ae-5084-4956-ab3e-16c8ae43f1d6', 'c2bfa8c6-5e15-454a-a1d3-64d2d37053ac'),
('2432d3ab-2ca7-42cd-a482-cb3eb7524a66', 'c34e42b1-da01-44e5-8f53-44d1f51d20ac'),
('2a5d579f-941a-46c2-9287-15adb4eb2751', 'c43008e6-cb44-4a13-81a1-30530fd45fc6'),
('2ba41ebe-04db-485f-8258-2163848cd3da', 'c43008e6-cb44-4a13-81a1-30530fd45fc6'),
('28b53495-85c2-4a29-a7b1-38a9146b05cc', 'c527ef85-e872-427d-8963-7bccd709bcfa'),
('b4df81e5-62e1-4be5-80fb-005b9936f970', 'ccb4382e-65c4-4086-bd43-13fdb8bb3f0f'),
('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('6070b7fc-e04e-569d-b739-e2910ffd5090', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('a71c4075-f75f-5679-9e9f-f92a1c40688a', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('d41479a0-fd39-5334-b206-08e45fd69a44', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'cd0ac65f-01f7-57cc-86cd-1c3f7153f1e9'),
('1374e553-0b7a-4d8f-a799-56fe0a66fa5b', 'd2538c4d-cafd-4492-966d-46e841098b81'),
('5fbe0d5f-3d1a-4424-a158-95bcc2b97f92', 'd38fac0f-9b47-44fb-998b-a3767f046136'),
('00124a2b-cd8c-5c07-a9b0-802a23f37540', 'da360318-3485-5a37-bc5c-916286bcb002'),
('00663ec6-efdb-5deb-ab2a-890e9b41b300', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0202d245-a266-545f-9162-d6eea1ab2925', 'da360318-3485-5a37-bc5c-916286bcb002'),
('027f21be-9112-5401-a8b7-f4138b7c972e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('086e5012-1bce-5e52-8e64-b1dadc98f553', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0b3e53f9-c8a2-50b5-9846-8639df57da24', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0d88cc0f-991a-5abd-b92a-b87fba44bf44', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0de3d276-823d-583f-99c9-238dd1192685', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0f5169fe-c105-5392-9ce6-eb8bce734ce9', 'da360318-3485-5a37-bc5c-916286bcb002'),
('0f7e67fe-98ec-5a99-a2bb-b1bdafd103f9', 'da360318-3485-5a37-bc5c-916286bcb002'),
('1200c374-aa7b-5f70-966a-6f94b09c9f1b', 'da360318-3485-5a37-bc5c-916286bcb002'),
('12e93598-3a78-591f-a50a-1722d6fa50f8', 'da360318-3485-5a37-bc5c-916286bcb002'),
('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('1a44dc93-7a2d-5c4b-a91f-59b24b558625', 'da360318-3485-5a37-bc5c-916286bcb002'),
('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'da360318-3485-5a37-bc5c-916286bcb002'),
('1dc553b6-966d-5ee6-b20b-7c9cc52afab2', 'da360318-3485-5a37-bc5c-916286bcb002'),
('27efc7fe-a3de-5fd9-b18b-339c8ced838f', 'da360318-3485-5a37-bc5c-916286bcb002'),
('28b6535e-30c4-5d14-8e1e-9e3239c752ec', 'da360318-3485-5a37-bc5c-916286bcb002'),
('28f7c0a9-08c4-5bb4-9525-f63edc7afe37', 'da360318-3485-5a37-bc5c-916286bcb002'),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'da360318-3485-5a37-bc5c-916286bcb002'),
('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'da360318-3485-5a37-bc5c-916286bcb002'),
('37298592-f182-5f74-b78c-b3ec4bbc6131', 'da360318-3485-5a37-bc5c-916286bcb002'),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'da360318-3485-5a37-bc5c-916286bcb002'),
('37876a11-2d4b-5e70-8b61-474ab4551ae5', 'da360318-3485-5a37-bc5c-916286bcb002'),
('38e4ea81-5af1-58ff-9b2e-ee5ef5400bd5', 'da360318-3485-5a37-bc5c-916286bcb002'),
('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'da360318-3485-5a37-bc5c-916286bcb002'),
('3d5a8754-c917-5892-8545-2f03ef4746ed', 'da360318-3485-5a37-bc5c-916286bcb002'),
('4b70b27d-1a42-519d-af06-141de67515c7', 'da360318-3485-5a37-bc5c-916286bcb002'),
('4e2acb6e-09d3-589c-80a4-d7683ee2eb57', 'da360318-3485-5a37-bc5c-916286bcb002'),
('4fa40dea-5ca9-5e8b-91b6-61b784917577', 'da360318-3485-5a37-bc5c-916286bcb002'),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'da360318-3485-5a37-bc5c-916286bcb002'),
('51f681e3-6898-57ff-90af-38c7da75782e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('52c08d85-b677-54bc-8fd2-b479c48ce2bf', 'da360318-3485-5a37-bc5c-916286bcb002'),
('53d1a069-6c1b-5559-b7f0-88fc9215eeec', 'da360318-3485-5a37-bc5c-916286bcb002'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', 'da360318-3485-5a37-bc5c-916286bcb002'),
('5c6b17fa-8342-5aec-9b43-8882f65deed6', 'da360318-3485-5a37-bc5c-916286bcb002'),
('5d8096bc-eb95-5638-9799-69ed0c7e7759', 'da360318-3485-5a37-bc5c-916286bcb002'),
('6803ca49-8946-5386-86a8-257563dfb328', 'da360318-3485-5a37-bc5c-916286bcb002'),
('68d97ecd-8f43-592e-9a84-c151b1626e11', 'da360318-3485-5a37-bc5c-916286bcb002'),
('690da950-e796-5869-b702-769a14174c0d', 'da360318-3485-5a37-bc5c-916286bcb002'),
('6dac5caf-5fd1-5024-947f-612840cdfe03', 'da360318-3485-5a37-bc5c-916286bcb002'),
('716d2798-4298-5677-8de2-a849e97e0e4e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('7190b957-3b9c-54eb-812e-5e4f87d0486e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('7297bdb9-65d3-5e8b-a567-4c433e23c766', 'da360318-3485-5a37-bc5c-916286bcb002'),
('742001dc-5a14-5b31-a224-e799ceed78da', 'da360318-3485-5a37-bc5c-916286bcb002'),
('74d2c451-82c4-53e2-b1fa-77b7d91ed0bd', 'da360318-3485-5a37-bc5c-916286bcb002'),
('769da44b-8943-579c-aadf-f4cfbf063172', 'da360318-3485-5a37-bc5c-916286bcb002'),
('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'da360318-3485-5a37-bc5c-916286bcb002'),
('8d7a3ff8-f997-5b48-818a-935b6c184fb6', 'da360318-3485-5a37-bc5c-916286bcb002'),
('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'da360318-3485-5a37-bc5c-916286bcb002'),
('90753d65-2026-5e82-b69a-39c3d7d6840a', 'da360318-3485-5a37-bc5c-916286bcb002'),
('92677901-c5ac-595a-8835-27d8ed0af3f0', 'da360318-3485-5a37-bc5c-916286bcb002'),
('93b7ab59-b0ac-5d18-96a2-e07db2776730', 'da360318-3485-5a37-bc5c-916286bcb002'),
('9bd335b4-71c8-5489-958f-434540bdc86c', 'da360318-3485-5a37-bc5c-916286bcb002'),
('9dadaee9-719d-548b-8238-f4fe52022f8c', 'da360318-3485-5a37-bc5c-916286bcb002'),
('9f6d00a1-7abe-5365-87a9-23732bc1880d', 'da360318-3485-5a37-bc5c-916286bcb002'),
('a477d8b1-8c78-59db-b976-5ac5fcb2b3e0', 'da360318-3485-5a37-bc5c-916286bcb002'),
('a9d605f6-deff-5623-945e-97f2db2ec56f', 'da360318-3485-5a37-bc5c-916286bcb002'),
('ad96b442-3513-573f-bc25-4b8090a7cd48', 'da360318-3485-5a37-bc5c-916286bcb002'),
('ae99d98e-0fde-5894-bac8-4b5b13111604', 'da360318-3485-5a37-bc5c-916286bcb002'),
('bb7a5901-0339-5235-8f4f-fad4cf2e30e9', 'da360318-3485-5a37-bc5c-916286bcb002'),
('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c35d0e2d-8916-5c4f-ad4a-c8a64cc801e4', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c6b5b015-20c7-517d-8f1e-e088d5ef310d', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c6e56753-5bf7-5dd4-b25c-6deaeb2f851e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c98eb0f9-c04a-5be8-8402-f4b1b6b7c432', 'da360318-3485-5a37-bc5c-916286bcb002'),
('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d10f7b8e-635b-5b8f-be54-9da7a60eb1eb', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d41479a0-fd39-5334-b206-08e45fd69a44', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d4bb0bbd-d85b-516e-ae9b-9622be28e88e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d545b75f-5e33-5840-bbb8-75a04f3b81f8', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d9157e08-e6de-5b47-8bb3-d7edf5b6a53f', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d94820bc-e2b3-5365-b15d-2918dcb35469', 'da360318-3485-5a37-bc5c-916286bcb002'),
('d9e26aa1-4b56-5542-8dfd-5bf0b9aec4ff', 'da360318-3485-5a37-bc5c-916286bcb002'),
('dbc3c585-bbc3-5ca5-8adc-f8f8277772c0', 'da360318-3485-5a37-bc5c-916286bcb002'),
('dbd545fb-0f53-5937-85ca-5d8f48b79aa7', 'da360318-3485-5a37-bc5c-916286bcb002'),
('de43dc9d-c33d-501f-a100-518c0d4f1802', 'da360318-3485-5a37-bc5c-916286bcb002'),
('e10f4c82-65d9-532f-ad6a-3dae598123ce', 'da360318-3485-5a37-bc5c-916286bcb002'),
('e1e3eacd-eb83-5ef5-a86e-077945a4f60a', 'da360318-3485-5a37-bc5c-916286bcb002'),
('e234c8ce-3c68-5078-858b-028ecb8131c7', 'da360318-3485-5a37-bc5c-916286bcb002'),
('e37bc81d-7c20-50a6-9f03-fd3169b9037a', 'da360318-3485-5a37-bc5c-916286bcb002'),
('f08dfc48-80bf-52ea-9942-e801bb198c64', 'da360318-3485-5a37-bc5c-916286bcb002'),
('f3e92d7f-9732-5b25-b6a7-0b29ab4da1e1', 'da360318-3485-5a37-bc5c-916286bcb002'),
('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'da360318-3485-5a37-bc5c-916286bcb002'),
('fd8458dc-aed4-5935-b3c1-ae08ba062a28', 'da360318-3485-5a37-bc5c-916286bcb002'),
('ff5c9117-7d47-500b-bcf1-a037ea526e7f', 'da360318-3485-5a37-bc5c-916286bcb002'),
('9acd95c9-dbf9-4558-869d-a788e5b39bf9', 'de78b720-c3b7-4081-af2d-83f0213247bd'),
('35454365-c241-40f1-aef6-60126f166177', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('3cca2173-6c5b-46ed-91b2-930f421e961e', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('7bf4d498-afe0-51fd-a3d8-9f30661d1ddd', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('80db5a2e-efdb-48b2-8148-b63b1c72b89e', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('ab8ca591-b4ed-5433-80b7-86b0aab4cfa7', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('bf3db79c-50cc-583d-b0f0-d0682ee9e38b', 'e2ec2732-77b8-5a6a-b01c-a543ca4951b5'),
('0de3d276-823d-583f-99c9-238dd1192685', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('14ac0d2b-754c-536c-99cf-15cc577f0e4e', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('2cf090c9-5ec7-5998-813e-24ff8cda4d03', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('377c2f8a-ce9a-5e09-a2e0-8517acb511ef', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('3d5a8754-c917-5892-8545-2f03ef4746ed', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('50c43074-eb60-58bd-8cc8-6d88cb42e367', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('7969e1ae-86fa-516c-90fc-e15f0a2a548c', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('bc39ef8d-d9f4-5e36-8e70-0c0fca1aa9b5', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('c95d0ff1-76f4-5468-af55-c1d5333efd91', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('d7cbd547-e969-58f3-be32-be1fc60baeb8', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('e234c8ce-3c68-5078-858b-028ecb8131c7', 'e68b281b-e4fc-5786-a95e-3d8e5cbd9dc2'),
('ab737371-da5c-527f-9a79-9c0c2f45675a', 'e6b1c78b-7e84-51b8-901c-06c2c7d131b2'),
('ef049b76-b3e1-553c-8b3e-c26bd0bd27bd', 'e6b1c78b-7e84-51b8-901c-06c2c7d131b2'),
('ea008a2a-f6ba-4658-a4b7-6146468a9e55', 'e957062d-cc6a-4288-b154-08b69df5c696'),
('06122912-1963-43b7-815c-7c97b52faf3c', 'eb954789-628c-4714-a916-48aad5a086ce'),
('16e2a5a9-8086-4a57-8a76-6b08cd10769d', 'ebf4a429-a801-4f08-a628-0d62c59c63da'),
('43107ae5-57d8-45f1-bc84-a3d714815420', 'ebf4a429-a801-4f08-a628-0d62c59c63da'),
('e85d52b3-c0d2-41ad-8044-08e28bbfae14', 'ef78fa45-da83-4717-b8a2-8bd3372f9b22'),
('70898464-e84f-49cf-a72b-acedca8a8d75', 'f2df34b8-1c11-4581-8d05-2bf0c063648d'),
('c6ec6cba-1456-478c-837c-ad0a8491d14a', 'f2df34b8-1c11-4581-8d05-2bf0c063648d'),
('058b0705-9d56-440e-a9fd-dd97a4f3ba74', 'f35a6780-4006-49e4-875a-1a156468f4f0'),
('1ae0a0ed-b919-57c2-a986-f619ada9e2f0', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('3d5a8754-c917-5892-8545-2f03ef4746ed', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('5447f892-ba7a-5ab1-b257-84ce92e64849', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('8d9a0bf7-0371-56d2-b5df-c00099b22b88', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('90753d65-2026-5e82-b69a-39c3d7d6840a', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('9198aa9c-915c-582d-8e20-608ec82b6c1c', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('955c076e-9b6f-5209-a5e6-f05cc68dae4c', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('c9bf39bb-e9d6-5bf6-ad60-7eeb2d2ce04f', 'f89dce11-6aa2-5881-a3e1-ba18c1c3f79e'),
('be5f7134-0e81-4485-9c8e-bfa24025bcdd', 'f90b8c5c-0feb-49c9-a18e-714b5cf8a644'),
('027f21be-9112-5401-a8b7-f4138b7c972e', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('2db2fdd3-52bd-51dc-a579-590db3bd4c21', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('39d2b2b8-be48-40c2-8b8e-7ef599d2577f', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('3ca099fa-59dd-57ee-9d62-eb8a3d23e060', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('b60dc01c-6683-40cb-9857-fd2293a8ff67', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('f944d1a0-ac97-5b93-89b7-b3b2a2bcc49e', 'f9186399-961e-5bc6-a27d-2b2c45361f07'),
('0be41b32-d04a-4b97-ac59-4385697d1057', 'fa005f15-fbba-4a30-8d85-c90269057134'),
('be9fa729-5936-4b8c-a130-f110ad102b90', 'fa54f909-65cc-4763-a1f2-7017ac25bf03'),
('74b839a4-3c8c-487d-a9a5-145f548e70a1', 'fc32df4a-f6f0-4819-b170-410eea827a93'),
('a32f4017-70d6-48fb-abc4-3c4c2d1672fc', 'fdec5925-2f0b-476a-98a7-64b2675de29b'),
('7779f973-7f37-4a6d-8dcd-a23f2d9d9f4c', 'fdf83b80-f0da-4f36-ab0a-b06e09f2d035');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` char(36) NOT NULL,
  `code` varchar(120) NOT NULL,
  `module` varchar(80) NOT NULL,
  `action` varchar(80) NOT NULL,
  `name` varchar(160) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `code`, `module`, `action`, `name`, `description`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
('32ad0260-4de4-11f1-a9c1-44a3bb6ab520', 'tenant.read', 'tenant', 'read', 'Read Tenant', 'Melihat data tenant.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0825-4de4-11f1-a9c1-44a3bb6ab520', 'tenant.manage', 'tenant', 'manage', 'Manage Tenant', 'Mengelola tenant.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad09bb-4de4-11f1-a9c1-44a3bb6ab520', 'user.read', 'user', 'read', 'Read User', 'Melihat data user.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520', 'user.create', 'user', 'create', 'Create User', 'Membuat user.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0b77-4de4-11f1-a9c1-44a3bb6ab520', 'user.update', 'user', 'update', 'Update User', 'Mengubah user.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0c4f-4de4-11f1-a9c1-44a3bb6ab520', 'user.delete', 'user', 'delete', 'Delete User', 'Menghapus user.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0d22-4de4-11f1-a9c1-44a3bb6ab520', 'rbac.read', 'rbac', 'read', 'Read RBAC', 'Melihat role dan permission.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0de9-4de4-11f1-a9c1-44a3bb6ab520', 'rbac.manage', 'rbac', 'manage', 'Manage RBAC', 'Mengelola role dan permission.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0eba-4de4-11f1-a9c1-44a3bb6ab520', 'news.read', 'news', 'read', 'Read News', 'Melihat berita.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520', 'news.create', 'news', 'create', 'Create News', 'Membuat berita.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad10c3-4de4-11f1-a9c1-44a3bb6ab520', 'news.update', 'news', 'update', 'Update News', 'Mengubah berita.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad1198-4de4-11f1-a9c1-44a3bb6ab520', 'news.delete', 'news', 'delete', 'Delete News', 'Menghapus berita.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad1262-4de4-11f1-a9c1-44a3bb6ab520', 'site.read', 'site', 'read', 'Read Site Config', 'Melihat konfigurasi website.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32ad132b-4de4-11f1-a9c1-44a3bb6ab520', 'site.update', 'site', 'update', 'Update Site Config', 'Mengubah konfigurasi website.', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` char(36) NOT NULL,
  `code` varchar(80) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `scope` enum('global','tenant') NOT NULL DEFAULT 'tenant',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `code`, `name`, `description`, `scope`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', 'super_admin', 'Super Admin', 'Memiliki akses penuh ke semua tenant dan semua fitur.', 'global', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', 'admin_tenant', 'Admin Tenant', 'Mengelola data dan konten pada tenant tertentu.', 'tenant', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('32a4be24-4de4-11f1-a9c1-44a3bb6ab520', 'user', 'User', 'Pengguna umum dengan akses dasar.', 'tenant', 'active', '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` char(36) NOT NULL,
  `permission_id` char(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`, `created_at`) VALUES
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0260-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0825-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad09bb-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0b77-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0c4f-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0d22-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0de9-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0eba-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad10c3-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad1198-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad1262-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', '32ad132b-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad0260-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad09bb-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad0a9d-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad0b77-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad0eba-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad0fb3-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad10c3-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad1198-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad1262-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4b5a7-4de4-11f1-a9c1-44a3bb6ab520', '32ad132b-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4be24-4de4-11f1-a9c1-44a3bb6ab520', '32ad0260-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4be24-4de4-11f1-a9c1-44a3bb6ab520', '32ad0eba-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12'),
('32a4be24-4de4-11f1-a9c1-44a3bb6ab520', '32ad1262-4de4-11f1-a9c1-44a3bb6ab520', '2026-05-12 09:23:12');

-- --------------------------------------------------------

--
-- Table structure for table `structure_organizations`
--

CREATE TABLE `structure_organizations` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `chart_id` char(36) NOT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `name` varchar(180) NOT NULL,
  `slug` varchar(220) NOT NULL,
  `position_title` varchar(180) NOT NULL,
  `position_code` varchar(120) DEFAULT NULL,
  `organization_unit` varchar(180) DEFAULT NULL,
  `photo_url` varchar(700) DEFAULT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`content_json`)),
  `phone` varchar(80) DEFAULT NULL,
  `whatsapp` varchar(80) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  `node_type` enum('person','position','department','division','unit','group','placeholder','custom') NOT NULL DEFAULT 'person',
  `shape_type` enum('card','rounded_rect','rect','circle','avatar_card','custom') NOT NULL DEFAULT 'card',
  `x` decimal(12,2) NOT NULL DEFAULT 0.00,
  `y` decimal(12,2) NOT NULL DEFAULT 0.00,
  `width` decimal(12,2) NOT NULL DEFAULT 220.00,
  `height` decimal(12,2) NOT NULL DEFAULT 110.00,
  `rotation` decimal(8,2) NOT NULL DEFAULT 0.00,
  `scale_x` decimal(8,3) NOT NULL DEFAULT 1.000,
  `scale_y` decimal(8,3) NOT NULL DEFAULT 1.000,
  `fill_color` varchar(40) DEFAULT NULL,
  `border_color` varchar(40) DEFAULT NULL,
  `border_width` decimal(8,2) NOT NULL DEFAULT 1.00,
  `text_color` varchar(40) DEFAULT NULL,
  `accent_color` varchar(40) DEFAULT NULL,
  `font_family` varchar(120) DEFAULT NULL,
  `name_font_size` int(10) UNSIGNED NOT NULL DEFAULT 16,
  `position_font_size` int(10) UNSIGNED NOT NULL DEFAULT 13,
  `photo_shape` enum('circle','rounded_rect','rect') NOT NULL DEFAULT 'circle',
  `photo_width` decimal(12,2) NOT NULL DEFAULT 56.00,
  `photo_height` decimal(12,2) NOT NULL DEFAULT 56.00,
  `draggable` tinyint(1) NOT NULL DEFAULT 1,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `konva_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`konva_config`)),
  `style_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`style_config`)),
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`social_config`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `structure_organizations`
--

INSERT INTO `structure_organizations` (`id`, `tenant_id`, `chart_id`, `parent_id`, `name`, `slug`, `position_title`, `position_code`, `organization_unit`, `photo_url`, `icon`, `short_description`, `content_html`, `content_json`, `phone`, `whatsapp`, `email`, `term_start`, `term_end`, `node_type`, `shape_type`, `x`, `y`, `width`, `height`, `rotation`, `scale_x`, `scale_y`, `fill_color`, `border_color`, `border_width`, `text_color`, `accent_color`, `font_family`, `name_font_size`, `position_font_size`, `photo_shape`, `photo_width`, `photo_height`, `draggable`, `locked`, `visible`, `konva_config`, `style_config`, `social_config`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('2e60da78-c874-4f62-bd81-b13dd34586a1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Nisya Puspita Sari', 'nisya-puspita-sari', 'Kasi Kesejahteraan', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 300.78, 377.84, 240.00, 124.00, 0.00, 1.000, 1.000, '#f1f9f2', '#d0fecd', 1.00, '#111827', '#5ee64c', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#f1f9f2\",\"borderColor\":\"#d0fecd\",\"textColor\":\"#111827\",\"accentColor\":\"#5ee64c\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 4, '2026-05-31 15:58:37', '2026-05-31 15:58:37', NULL),
('39cd5625-c628-4d13-aa44-756215d7c1a2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Rianto', 'rianto', 'Kepala Desa', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 567.00, 154.00, 240.00, 124.00, 0.00, 1.000, 1.000, '#f8fafc', '#c7d2fe', 1.00, '#111827', '#4f46e5', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#f8fafc\",\"borderColor\":\"#c7d2fe\",\"textColor\":\"#111827\",\"accentColor\":\"#4f46e5\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 1, '2026-05-31 07:47:16', '2026-05-31 07:47:16', NULL),
('4304aa31-9438-4d26-ac52-de09d9b11540', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Rania Eka Sari', 'rania-eka-sari', 'Kaur Tata Usaha dan Umum', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 832.97, 380.19, 240.00, 124.00, 0.00, 1.000, 1.000, '#fdf2f2', '#f7bbbb', 1.00, '#111827', '#a2161d', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#fdf2f2\",\"borderColor\":\"#f7bbbb\",\"textColor\":\"#111827\",\"accentColor\":\"#a2161d\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 6, '2026-05-31 15:58:39', '2026-05-31 15:58:39', NULL),
('50c51aa1-7563-4c2d-a0cc-259c7097f0e1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Mega Laily R', 'mega-laily-r', 'Kasi Pemerintahan', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 41.71, 376.92, 240.00, 124.00, 0.00, 1.000, 1.000, '#f2fdf3', '#d1fbd0', 1.00, '#111827', '#29db47', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#f2fdf3\",\"borderColor\":\"#d1fbd0\",\"textColor\":\"#111827\",\"accentColor\":\"#29db47\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 3, '2026-05-31 15:58:36', '2026-05-31 15:58:36', NULL),
('71986052-e92f-4b8b-97d3-26e637223a19', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Avinda Alfianindita', 'avinda-alfianindita', 'Kaur Keuangan', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 1087.23, 381.88, 240.00, 124.00, 0.00, 1.000, 1.000, '#ecfeff', '#a5f3fc', 1.00, '#111827', '#0891b2', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#ecfeff\",\"borderColor\":\"#a5f3fc\",\"textColor\":\"#111827\",\"accentColor\":\"#0891b2\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 7, '2026-05-31 15:58:40', '2026-05-31 15:58:40', NULL),
('a002885f-6f31-4ec7-ae4e-b64b1e18e1c0', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Siti Muzayan', 'siti-muzayan', 'Kasi Pelayanan', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 560.92, 380.83, 240.00, 124.00, 0.00, 1.000, 1.000, '#ebffed', '#a9feba', 1.00, '#111827', '#10e90c', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#ebffed\",\"borderColor\":\"#a9feba\",\"textColor\":\"#111827\",\"accentColor\":\"#10e90c\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 5, '2026-05-31 15:58:38', '2026-05-31 15:58:38', NULL),
('a4288ae6-a64c-4d4f-81e8-a6f733d9bfc9', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Djoko Sulistijo', 'djoko-sulistijo', 'Sekertartis', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 968.50, 167.64, 240.00, 124.00, 0.00, 1.000, 1.000, '#ffffff', '#dbeafe', 1.00, '#111827', '#2563eb', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#ffffff\",\"borderColor\":\"#dbeafe\",\"textColor\":\"#111827\",\"accentColor\":\"#2563eb\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 2, '2026-05-31 15:58:35', '2026-05-31 15:58:35', NULL),
('bb7884d0-d914-4901-80dd-bee4b9e9450f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Nuril Alfan', 'nuril-alfan', 'Kaur Perencanaan', NULL, NULL, NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 1341.38, 385.52, 240.00, 124.00, 0.00, 1.000, 1.000, '#fff7ed', '#fed7aa', 1.00, '#111827', '#ea580c', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#fff7ed\",\"borderColor\":\"#fed7aa\",\"textColor\":\"#111827\",\"accentColor\":\"#ea580c\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'active', 0, 8, '2026-05-31 15:58:41', '2026-05-31 15:58:41', NULL),
('ff136c15-4478-4d44-ae01-21946b46572b', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', NULL, 'Ninno', 'ninno', 'Fullstack Engineer', NULL, NULL, 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780214638/martopuro/structure-organizations/photos/frame-2-1_jqhcan.webp', 'solar:user-rounded-bold-duotone', NULL, NULL, '{}', NULL, NULL, NULL, NULL, NULL, 'person', 'card', 583.00, 87.00, 240.00, 124.00, 0.00, 1.000, 1.000, '#f8fafc', '#c7d2fe', 1.00, '#111827', '#4f46e5', NULL, 16, 13, 'circle', 56.00, 56.00, 1, 0, 1, '{}', '{\"cornerRadius\":22,\"padding\":16,\"fillColor\":\"#f8fafc\",\"borderColor\":\"#c7d2fe\",\"textColor\":\"#111827\",\"accentColor\":\"#4f46e5\"}', '{}', '{\"cornerRadius\":22,\"padding\":16}', 'inactive', 0, 2, '2026-05-31 08:04:23', '2026-05-31 15:58:32', '2026-05-31 15:58:32');

-- --------------------------------------------------------

--
-- Table structure for table `structure_organization_charts`
--

CREATE TABLE `structure_organization_charts` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `title` varchar(180) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` varchar(700) DEFAULT NULL,
  `chart_type` enum('organization','department','school','pesantren','company','committee','custom') NOT NULL DEFAULT 'organization',
  `layout_engine` enum('manual','tree','dagre','grid','radial','custom') NOT NULL DEFAULT 'manual',
  `layout_direction` enum('top-bottom','bottom-top','left-right','right-left','free') NOT NULL DEFAULT 'top-bottom',
  `canvas_width` int(10) UNSIGNED NOT NULL DEFAULT 1200,
  `canvas_height` int(10) UNSIGNED NOT NULL DEFAULT 800,
  `background_color` varchar(40) DEFAULT NULL,
  `background_image_url` varchar(700) DEFAULT NULL,
  `grid_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `grid_size` int(10) UNSIGNED NOT NULL DEFAULT 20,
  `snap_to_grid` tinyint(1) NOT NULL DEFAULT 0,
  `zoom_min` decimal(5,2) NOT NULL DEFAULT 0.25,
  `zoom_max` decimal(5,2) NOT NULL DEFAULT 2.50,
  `initial_scale` decimal(5,2) NOT NULL DEFAULT 1.00,
  `node_default_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`node_default_config`)),
  `edge_default_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`edge_default_config`)),
  `konva_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`konva_config`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `status` enum('draft','published','archived','inactive') NOT NULL DEFAULT 'published',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `structure_organization_charts`
--

INSERT INTO `structure_organization_charts` (`id`, `tenant_id`, `title`, `slug`, `description`, `chart_type`, `layout_engine`, `layout_direction`, `canvas_width`, `canvas_height`, `background_color`, `background_image_url`, `grid_enabled`, `grid_size`, `snap_to_grid`, `zoom_min`, `zoom_max`, `initial_scale`, `node_default_config`, `edge_default_config`, `konva_config`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('7866650e-f3b0-4019-84fd-53c57630487f', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Struktur Organisasi', 'struktur-organisasi', 'Bagan struktur organisasi tenant.', 'organization', 'manual', 'top-bottom', 1600, 1000, '#ffffff', NULL, 1, 40, 0, 0.25, 2.50, 1.00, '{\"cornerRadius\":22,\"padding\":16,\"width\":240,\"height\":124}', '{\"stroke\":\"#94a3b8\",\"strokeWidth\":2,\"lineCap\":\"round\",\"lineJoin\":\"round\"}', '{\"scale\":0.6650571136223362,\"x\":390.2756388488641,\"y\":37.98176486911595}', '{\"source\":\"app-structure-organization\",\"nodeCount\":8,\"edgeCount\":7}', 'published', 1, 0, '2026-05-31 07:47:14', '2026-05-31 16:16:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `structure_organization_edges`
--

CREATE TABLE `structure_organization_edges` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `chart_id` char(36) NOT NULL,
  `source_node_id` char(36) NOT NULL,
  `target_node_id` char(36) NOT NULL,
  `edge_type` enum('hierarchy','assistant','coordination','dotted','custom') NOT NULL DEFAULT 'hierarchy',
  `label` varchar(160) DEFAULT NULL,
  `line_type` enum('straight','orthogonal','bezier','step','custom') NOT NULL DEFAULT 'orthogonal',
  `stroke_color` varchar(40) DEFAULT NULL,
  `stroke_width` decimal(8,2) NOT NULL DEFAULT 2.00,
  `stroke_dash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`stroke_dash`)),
  `arrow_start` tinyint(1) NOT NULL DEFAULT 0,
  `arrow_end` tinyint(1) NOT NULL DEFAULT 0,
  `points_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`points_config`)),
  `konva_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`konva_config`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `structure_organization_edges`
--

INSERT INTO `structure_organization_edges` (`id`, `tenant_id`, `chart_id`, `source_node_id`, `target_node_id`, `edge_type`, `label`, `line_type`, `stroke_color`, `stroke_width`, `stroke_dash`, `arrow_start`, `arrow_end`, `points_config`, `konva_config`, `metadata`, `status`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('2b6b6cb9-703a-4344-82bf-28743ea18f74', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', '39cd5625-c628-4d13-aa44-756215d7c1a2', '50c51aa1-7563-4c2d-a0cc-259c7097f0e1', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":678,\"y\":188},{\"x\":678.36,\"y\":278},{\"x\":162.35,\"y\":276.92},{\"x\":160.71,\"y\":374.92}]}', 'active', 3, '2026-05-31 15:58:46', '2026-05-31 16:16:38', NULL),
('31316d05-0595-42a7-9456-e9bb3ab83b28', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', 'a4288ae6-a64c-4d4f-81e8-a6f733d9bfc9', '71986052-e92f-4b8b-97d3-26e637223a19', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":1088.5,\"y\":291.64},{\"x\":1088.86,\"y\":329.64},{\"x\":1209.87,\"y\":328.88},{\"x\":1209.23,\"y\":382.88}]}', 'active', 5, '2026-05-31 15:58:48', '2026-05-31 16:16:40', NULL),
('3c723cb4-e9ea-4f5e-bd95-11f506412214', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', '39cd5625-c628-4d13-aa44-756215d7c1a2', 'a002885f-6f31-4ec7-ae4e-b64b1e18e1c0', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":678,\"y\":188},{\"x\":678,\"y\":284.41499999999996},{\"x\":678.92,\"y\":380.41},{\"x\":680.92,\"y\":380.83}]}', 'active', 1, '2026-05-31 15:58:44', '2026-05-31 16:16:35', NULL),
('5c1e80d7-165b-4b64-bc5a-3b605399a4e1', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', '39cd5625-c628-4d13-aa44-756215d7c1a2', '2e60da78-c874-4f62-bd81-b13dd34586a1', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":678,\"y\":188},{\"x\":678.89,\"y\":279},{\"x\":421.89,\"y\":277.84},{\"x\":420.78,\"y\":377.84}]}', 'active', 2, '2026-05-31 15:58:45', '2026-05-31 16:16:36', NULL),
('99ec60cd-2927-4612-8ef5-aaa8ff9b98a6', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', 'a4288ae6-a64c-4d4f-81e8-a6f733d9bfc9', 'bb7884d0-d914-4901-80dd-bee4b9e9450f', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":1088.5,\"y\":291.64},{\"x\":1086.94,\"y\":329.64},{\"x\":1459.94,\"y\":329.52},{\"x\":1461.38,\"y\":385.52}]}', 'active', 6, '2026-05-31 15:58:49', '2026-05-31 16:16:41', NULL),
('a0a95c89-f22c-4c01-9277-b3d995a5fbdc', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', 'a4288ae6-a64c-4d4f-81e8-a6f733d9bfc9', '4304aa31-9438-4d26-ac52-de09d9b11540', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\",\"manualPoints\":[{\"x\":1088.5,\"y\":291.64},{\"x\":1087.74,\"y\":329.64},{\"x\":952.73,\"y\":330.19},{\"x\":952.97,\"y\":380.19}]}', 'active', 4, '2026-05-31 15:58:47', '2026-05-31 16:16:39', NULL),
('a3f8026a-2288-4ea3-9678-afbca119afe2', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', 'a4288ae6-a64c-4d4f-81e8-a6f733d9bfc9', '39cd5625-c628-4d13-aa44-756215d7c1a2', 'hierarchy', NULL, '', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"left\",\"targetAnchor\":\"bottom\",\"manualPoints\":[{\"x\":968.5,\"y\":243.17},{\"x\":678.9,\"y\":244.67},{\"x\":678.25,\"y\":229},{\"x\":678,\"y\":93.27}]}', 'active', 0, '2026-05-31 15:58:43', '2026-05-31 16:16:34', NULL),
('aa2d3be3-f6fe-4b16-a718-28792c073c4a', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '7866650e-f3b0-4019-84fd-53c57630487f', 'ff136c15-4478-4d44-ae01-21946b46572b', '39cd5625-c628-4d13-aa44-756215d7c1a2', 'hierarchy', NULL, 'orthogonal', '#94a3b8', 2.00, '[]', 0, 0, '{}', '{}', '{\"sourceAnchor\":\"bottom\",\"targetAnchor\":\"top\"}', 'inactive', 0, '2026-05-31 08:04:24', '2026-05-31 15:58:31', '2026-05-31 15:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

CREATE TABLE `tenants` (
  `id` char(36) NOT NULL,
  `name` varchar(160) NOT NULL,
  `display_name` varchar(160) DEFAULT NULL,
  `slug` varchar(120) NOT NULL,
  `tenant_type` enum('village','school','pesantren','company','custom') NOT NULL DEFAULT 'custom',
  `domain` varchar(190) DEFAULT NULL,
  `site_url` varchar(255) DEFAULT NULL,
  `logo_url` varchar(700) DEFAULT NULL,
  `favicon_url` varchar(700) DEFAULT NULL,
  `og_image_url` varchar(700) DEFAULT NULL,
  `primary_color` varchar(40) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `subscription_plan` enum('free','basic','pro','enterprise','custom') NOT NULL DEFAULT 'basic',
  `subscription_status` enum('trialing','active','past_due','paused','canceled','expired') NOT NULL DEFAULT 'active',
  `subscription_started_at` datetime DEFAULT NULL,
  `subscription_ends_at` datetime DEFAULT NULL,
  `trial_ends_at` datetime DEFAULT NULL,
  `subscription_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `feature_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `theme_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `seo_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `hero_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `statistic_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `culture_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `warta_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `footer_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `navigation_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`id`, `name`, `display_name`, `slug`, `tenant_type`, `domain`, `site_url`, `logo_url`, `favicon_url`, `og_image_url`, `primary_color`, `description`, `status`, `subscription_plan`, `subscription_status`, `subscription_started_at`, `subscription_ends_at`, `trial_ends_at`, `subscription_config`, `feature_config`, `metadata`, `theme_config`, `seo_config`, `hero_config`, `contact_config`, `statistic_config`, `culture_config`, `warta_config`, `footer_config`, `navigation_config`, `social_config`, `created_at`, `updated_at`, `deleted_at`) VALUES
('37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Desa Martopuro', 'Martopuro', 'martopuro', 'village', 'martopuro.com', 'https://martopuro.com', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198336/martopuro/site/martopuro-logo_m9hyzn.webp', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198330/martopuro/site/martopuro-logo_f8kmbq.webp', 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198342/martopuro/site/martopuro-hero_r9guox.webp', '#2563eb', 'Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.', 'active', 'basic', 'active', '2026-05-14 11:51:26', '2027-05-14 23:59:59', NULL, '{}', '{\"news\":true,\"finance\":false,\"letterC\":false,\"onlineLetter\":false}', '{\"aboutHtml\":\"\",\"themeNote\":\"\",\"defaultLogo\":\"/assets/images/logo-martopuro.png\"}', '{\"primaryColor\":\"#2563eb\",\"note\":\"\"}', '{\"title\":\"Martopuro\",\"description\":\"Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.\",\"ogImage\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198342/martopuro/site/martopuro-hero_r9guox.webp\"}', '{\"brand\":\"Desa Martopuro\",\"stats\":[{\"label\":\"UMKM\",\"value\":\"35+\"},{\"label\":\"Layanan\",\"value\":\"12\"},{\"label\":\"Agenda\",\"value\":\"Aktif\"}],\"badges\":[{\"icon\":\"lucide:file-check-2\",\"label\":\"Surat Keterangan\"},{\"icon\":\"lucide:store\",\"label\":\"Direktori UMKM\"},{\"icon\":\"lucide:calendar-days\",\"label\":\"Agenda Desa\"},{\"icon\":\"lucide:map-pin\",\"label\":\"Wisata\"}],\"quicks\":[{\"icon\":\"lucide:clock-3\",\"label\":\"Jam Layanan Kantor\",\"value\":\"Senin窶笛umat 窶｢ 08.00窶?15.00\"},{\"icon\":\"lucide:store\",\"label\":\"UMKM Terdaftar\",\"value\":\"35 usaha lokal aktif\"},{\"icon\":\"lucide:phone-call\",\"label\":\"Nomor Darurat\",\"value\":\"112 窶｢ 0812-xxxx-xxxx\"}],\"waIntl\":\"6289563836\",\"bgImage\":\"/assets/images/village/martopuro-hero.jpg\",\"tagline\":\"Portal Resmi Pemerintah Desa\",\"subtitle\":\"Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.\",\"titleMain\":\"Selamat Datang di Desa \",\"ctaPrimary\":{\"href\":\"/layanan\",\"label\":\"Ajukan Surat Online\"},\"ctaSecondary\":{\"href\":\"/profile\",\"label\":\"Lihat Profil Desa\"},\"titleHighlight\":\"Martopuro\",\"searchPlaceholder\":\"Cari layanan, berita, agenda, UMKM...\",\"title\":\"\",\"heading\":\"\",\"highlight\":\"\",\"description\":\"Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.\",\"imageUrl\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198353/martopuro/site/martopuro-hero_pbibrx.webp\",\"image\":\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198353/martopuro/site/martopuro-hero_pbibrx.webp\",\"ctaLabel\":\"\",\"ctaHref\":\"\",\"primaryCta\":{\"label\":\"\",\"href\":\"\"},\"contentHtml\":\"\"}', '{\"email\":\"team.sencra@gmail.com\",\"phone\":\"0343-591234\",\"waIntl\":\"6289563836\",\"address\":\"Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur\",\"mapsQuery\":\"Kantor Desa Martopuro, Pasuruan\",\"officeName\":\"Kantor Desa Martopuro\",\"mapEmbedSrc\":\"\",\"officeSubtitle\":\"Pemerintah Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan\",\"whatsapp\":\"\",\"mapUrl\":\"\",\"mapsUrl\":\"\"}', '{\"title\":\"Ringkasan Kinerja & APBDes 2026\",\"ctaHref\":\"/apbdes\",\"eyebrow\":\"Statistik Desa\",\"ctaLabel\":\"Lihat APBDes Lengkap\",\"subtitle\":\"Pantau statistik layanan, data aparatur, dan ringkasan APBDes secara ringkas, transparan, dan mudah dipahami masyarakat.\"}', '{\"title\":\"Budaya, Musik, & Kuliner \",\"images\":[\"https://martopuro.sencra.io/assets/culturefest/2.JPG\",\"https://martopuro.sencra.io/assets/culturefest/0.JPG\",\"https://martopuro.sencra.io/assets/culturefest/1.JPG\",\"https://martopuro.sencra.io/assets/culturefest/2.JPG\"],\"eyebrow\":\"Martopuro Culture Fest\",\"subtitle\":\"Parade seni tradisi, UMKM lokal, pentas musik, lomba warga, dan kuliner khas dalam satu perayaan meriah.\",\"highlight\":\"Martopuro!\",\"instagram\":\"@martopuroculturefest\",\"eyebrowIcon\":\"lucide:ticket\",\"floatingBadge\":\"Festival Desa Digital\"}', '{\"limit\":12,\"title\":\"Artikel Pilihan & Terbaru\",\"eyebrow\":\"Warta Martopuro\",\"subtitle\":\"Ikuti informasi terbaru dari Desa Martopuro, mulai dari pelayanan publik, kegiatan warga, UMKM, kesehatan, pendidikan, hingga agenda desa.\",\"viewAllHref\":\"/news\",\"viewAllLabel\":\"Lihat Semua\"}', '{\"text\":\"\",\"copyright\":\"\"}', '[]', '{\"email\":\"team.sencra@gmail.com\",\"youtube\":\"\",\"facebook\":\"\",\"whatsapp\":\"https://wa.me/6289563836\",\"instagram\":\"https://instagram.com/martopuroculturefest\",\"tiktok\":\"\"}', '2026-05-12 09:09:02', '2026-05-31 03:41:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant_facilities`
--

CREATE TABLE `tenant_facilities` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `facility_type` enum('health','market','education','sport','emergency','transport','water','public_service','office','worship','tourism','security','custom') NOT NULL DEFAULT 'custom',
  `title` varchar(180) NOT NULL,
  `subtitle` varchar(500) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `logo_url` varchar(700) DEFAULT NULL,
  `image_url` varchar(700) DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `whatsapp` varchar(80) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `operational_hours` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenant_facilities`
--

INSERT INTO `tenant_facilities` (`id`, `tenant_id`, `facility_type`, `title`, `subtitle`, `slug`, `icon`, `logo_url`, `image_url`, `content_html`, `content_json`, `address`, `latitude`, `longitude`, `email`, `phone`, `whatsapp`, `website_url`, `contact_config`, `operational_hours`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('b1127b76-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'health', 'Kesehatan', 'Fasilitas layanan kesehatan masyarakat desa.', 'kesehatan', 'lucide:hospital', '', '', '<p>Fasilitas kesehatan desa mendukung pelayanan kesehatan dasar, pemeriksaan rutin, posyandu, serta kegiatan kesehatan masyarakat.</p><p></p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan kesehatan masyarakat desa.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, '', '', '', '', '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"images\":[]}', 'active', 1, 1, '2026-05-14 10:14:28', '2026-05-24 09:17:03', NULL),
('b112e33d-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'market', 'Pasar', 'Fasilitas perdagangan dan aktivitas ekonomi warga.', 'pasar', 'lucide:store', NULL, NULL, '<p>Pasar menjadi pusat aktivitas ekonomi masyarakat, tempat jual beli kebutuhan harian, produk lokal, dan hasil usaha warga.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas perdagangan dan aktivitas ekonomi warga.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 2, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL),
('b1130aa1-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'education', 'Pendidikan', 'Fasilitas pendidikan dan pembelajaran masyarakat.', 'pendidikan', 'lucide:school', NULL, NULL, '<p>Fasilitas pendidikan mendukung proses belajar masyarakat mulai dari pendidikan anak usia dini hingga kegiatan pembelajaran warga.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas pendidikan dan pembelajaran masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 3, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL),
('b113126b-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'sport', 'Lapangan', 'Sarana olahraga dan kegiatan masyarakat desa.', 'lapangan', 'lucide:map', NULL, NULL, '<p>Lapangan desa digunakan untuk olahraga, kegiatan warga, upacara, lomba, dan acara masyarakat.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Sarana olahraga dan kegiatan masyarakat desa.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 4, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL),
('b113152c-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'emergency', 'Ambulance', 'Layanan kendaraan darurat untuk kebutuhan kesehatan warga.', 'ambulance', 'lucide:ambulance', NULL, NULL, '<p>Ambulance desa membantu kebutuhan transportasi darurat kesehatan warga menuju fasilitas layanan kesehatan.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Layanan kendaraan darurat untuk kebutuhan kesehatan warga.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 5, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL),
('b11317f1-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'transport', 'Mobil Siaga', 'Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.', 'mobil-siaga', 'lucide:car', NULL, NULL, '<p>Mobil siaga desa digunakan untuk mendukung kebutuhan mendesak masyarakat dan operasional pelayanan desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 6, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL),
('b1131ac6-4f7d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'water', 'HIPAM', 'Fasilitas layanan air bersih masyarakat.', 'hipam', 'lucide:droplets', NULL, NULL, '<p>HIPAM mendukung pengelolaan dan distribusi air bersih bagi masyarakat desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan air bersih masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 7, '2026-05-14 10:14:28', '2026-05-14 10:14:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant_institutions`
--

CREATE TABLE `tenant_institutions` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `title` varchar(180) NOT NULL,
  `subtitle` varchar(500) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `logo_url` varchar(700) DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenant_institutions`
--

INSERT INTO `tenant_institutions` (`id`, `tenant_id`, `title`, `subtitle`, `slug`, `icon`, `logo_url`, `content_html`, `content_json`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('31e430ff-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BPD', 'Badan Permusyawaratan Desa', 'bpd', 'solar:book-bold-duotone', NULL, '<ul><li><p><strong><em>adsjkfnajkfajkjkadjadabjkadj</em></strong></p></li><li><p></p></li></ul><p></p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"bulletList\", \"content\": [{\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"adsjkfnajkfajkjkadjadabjkadj\", \"type\": \"text\", \"marks\": [{\"type\": \"bold\"}, {\"type\": \"italic\"}]}]}]}, {\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\"}]}]}, {\"type\": \"paragraph\"}]}', 'active', 1, 1, '2026-05-14 08:45:01', '2026-05-14 10:23:37', NULL),
('31e4c4a3-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'LPMD', 'Lembaga Pemberdayaan Masyarakat Desa', 'lpmd', 'solar:widget-5-bold-duotone', NULL, '<p>Lembaga Pemberdayaan Masyarakat Desa</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Lembaga Pemberdayaan Masyarakat Desa\", \"type\": \"text\"}]}]}', 'active', 1, 2, '2026-05-14 08:45:01', '2026-05-14 09:09:46', NULL),
('31e4d181-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BHABINKAMTIBMAS', 'Bhayangkara Pembina Keamanan dan Ketertiban Masyarakat', 'bhabinkamtibmas', 'solar:shield-check-bold-duotone', NULL, '<p>BHABINKAMTIBMAS mendukung keamanan, ketertiban, dan pembinaan masyarakat di wilayah desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Bhayangkara Pembina Keamanan dan Ketertiban Masyarakat\", \"type\": \"text\"}]}]}', 'active', 1, 3, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4da04-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'PKK', 'Pemberdayaan Kesejahteraan Keluarga', 'pkk', 'solar:heart-bold-duotone', NULL, '<p>PKK berfokus pada pemberdayaan keluarga, kesehatan, pendidikan, dan kesejahteraan masyarakat.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pemberdayaan Kesejahteraan Keluarga\", \"type\": \"text\"}]}]}', 'active', 1, 4, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4ded6-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BABINSA', 'Bintara Pembina Desa', 'babinsa', 'solar:shield-user-bold-duotone', NULL, '<p>BABINSA mendukung pembinaan teritorial, keamanan, dan koordinasi masyarakat desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Bintara Pembina Desa\", \"type\": \"text\"}]}]}', 'active', 1, 5, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4e416-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'LINMAS', 'Perlindungan Masyarakat', 'linmas', 'solar:shield-bold-duotone', NULL, '<p>LINMAS berperan dalam perlindungan masyarakat, ketertiban, dan kesiapsiagaan lingkungan.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Perlindungan Masyarakat\", \"type\": \"text\"}]}]}', 'active', 1, 6, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4e84a-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'HIPPA', 'Himpunan Petani Pemakai Air', 'hippa', 'solar:water-bold-duotone', NULL, '<p>HIPPA mengelola kepentingan petani dalam penggunaan dan distribusi air irigasi.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Himpunan Petani Pemakai Air\", \"type\": \"text\"}]}]}', 'active', 1, 7, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4ec24-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'HIPPAM', 'Himpunan Penduduk Pemakai Air Minum', 'hippam', 'solar:dropper-bold-duotone', NULL, '<p>HIPPAM berperan dalam pengelolaan layanan air minum masyarakat.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Himpunan Penduduk Pemakai Air Minum\", \"type\": \"text\"}]}]}', 'active', 1, 8, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4efd0-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'GAPOKTAN', 'Gabungan Kelompok Tani', 'gapoktan', 'solar:users-group-rounded-bold-duotone', NULL, '<p>GAPOKTAN menjadi wadah koordinasi kelompok tani dalam pengembangan pertanian desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Gabungan Kelompok Tani\", \"type\": \"text\"}]}]}', 'active', 1, 9, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4f373-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'KOPWAN', 'Koperasi Wanita', 'kopwan', 'solar:users-group-two-rounded-bold-duotone', NULL, '<p>KOPWAN mendukung pemberdayaan ekonomi perempuan melalui aktivitas koperasi.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Koperasi Wanita\", \"type\": \"text\"}]}]}', 'active', 1, 10, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4f736-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'KARANGTARUNA', 'Organisasi Desa', 'karangtaruna', 'solar:users-group-rounded-bold-duotone', NULL, '<p>Karang Taruna menjadi wadah kreativitas, kepemudaan, sosial, dan kegiatan masyarakat desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Organisasi Desa\", \"type\": \"text\"}]}]}', 'active', 1, 11, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4facd-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'PUSTU', 'Puskesmas Pembantu', 'pustu', 'solar:heart-pulse-bold-duotone', NULL, '<p>PUSTU membantu pelayanan kesehatan dasar masyarakat di tingkat desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Puskesmas Pembantu\", \"type\": \"text\"}]}]}', 'active', 1, 12, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e4fe90-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'POSYANDU', 'Pos Pelayanan Terpadu', 'posyandu', 'solar:health-bold-duotone', NULL, '<p>POSYANDU memberikan layanan kesehatan ibu, anak, gizi, dan pemantauan tumbuh kembang.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pos Pelayanan Terpadu\", \"type\": \"text\"}]}]}', 'active', 1, 13, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e50226-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'PAUD', 'Pendidikan Anak Usia Dini', 'paud', 'solar:book-2-bold-duotone', NULL, '<p>PAUD menjadi lembaga pendidikan awal bagi anak usia dini di lingkungan desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pendidikan Anak Usia Dini\", \"type\": \"text\"}]}]}', 'active', 1, 14, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL),
('31e50599-4f71-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'BUMDES', 'Badan Usaha Milik Desa', 'bumdes', 'solar:briefcase-bold-duotone', NULL, '<p>BUMDES mendukung pengembangan ekonomi desa melalui unit usaha dan pengelolaan potensi lokal.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Badan Usaha Milik Desa\", \"type\": \"text\"}]}]}', 'active', 1, 15, '2026-05-14 08:45:01', '2026-05-14 08:45:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant_organizations`
--

CREATE TABLE `tenant_organizations` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `organization_type` enum('government','village_government','bumdes','youth','women','community','religious','education','health','umkm','tourism','culture','security','custom') NOT NULL DEFAULT 'custom',
  `name` varchar(180) NOT NULL,
  `display_name` varchar(180) DEFAULT NULL,
  `slug` varchar(180) NOT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo_url` varchar(700) DEFAULT NULL,
  `cover_url` varchar(700) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `whatsapp` varchar(80) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `operational_hours` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenant_organizations`
--

INSERT INTO `tenant_organizations` (`id`, `tenant_id`, `parent_id`, `organization_type`, `name`, `display_name`, `slug`, `short_description`, `description`, `logo_url`, `cover_url`, `email`, `phone`, `whatsapp`, `website_url`, `address`, `latitude`, `longitude`, `contact_config`, `address_config`, `social_config`, `operational_hours`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('6355beda-4f5d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', NULL, 'village_government', 'Pemerintah Desa Martopuro', 'Pemerintah Desa Martopuro', 'pemerintah-desa-martopuro', 'Pusat layanan pemerintahan, administrasi, dan informasi resmi Desa Martopuro.', '<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>', NULL, 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203396/martopuro/organizations/cover/martopuro-hero_lhelnc.webp', NULL, NULL, NULL, 'https://martopuro.com', 'Desa Martopuro', NULL, NULL, '{\"email\":null,\"phone\":null,\"whatsapp\":null}', NULL, '{\"instagram\":null,\"facebook\":null,\"youtube\":null,\"tiktok\":null}', '{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}', '{\"icon\":\"solar:buildings-3-bold-duotone\",\"images\":[\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780203396/martopuro/organizations/cover/martopuro-hero_lhelnc.webp\",\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780150886/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_slfraf.webp\"],\"source\":\"seed\",\"section\":\"hero\",\"instagram\":null,\"updatedFrom\":\"app-organizations\",\"descriptionHtml\":\"<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>\",\"descriptionJson\":{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"content\":[{\"type\":\"text\",\"text\":\"Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.\"}]}]},\"facebook\":null,\"youtube\":null,\"tiktok\":null}', 'active', 1, 1, '2026-05-14 06:23:14', '2026-05-31 04:56:45', NULL),
('63574156-4f5d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', NULL, 'culture', 'Martopuro Culture Fest', 'Martopuro Culture Fest', 'martopuro-culture-fest', 'Wadah kegiatan budaya, musik, UMKM, dan kuliner lokal Martopuro.', 'Martopuro Culture Fest menjadi ruang kolaborasi warga untuk memperkenalkan budaya, musik, kuliner, UMKM, serta potensi lokal desa.', NULL, 'https://martopuro.sencra.io/assets/culturefest/2.JPG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"ctaHref\": \"https://instagram.com/martopuroculturefest\", \"ctaLabel\": \"Buka Instagram\", \"instagram\": \"@martopuroculturefest\"}', 'active', 1, 2, '2026-05-14 06:23:14', '2026-05-30 13:59:03', '2026-05-30 13:59:03'),
('63599780-4f5d-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', NULL, 'umkm', 'UMKM Desa Martopuro', 'UMKM Desa Martopuro', 'umkm-desa-martopuro', 'Komunitas pelaku usaha lokal dan produk unggulan desa.', '<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>', NULL, 'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198106/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_hgaouu.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"email\":null,\"phone\":null,\"whatsapp\":null}', NULL, '{\"instagram\":null,\"facebook\":null,\"youtube\":null,\"tiktok\":null}', NULL, '{\"icon\":\"solar:shop-2-bold-duotone\",\"focus\":\"Produk lokal, kuliner, dan ekonomi warga\",\"images\":[\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1780198106/martopuro/organizations/cover/69dfb91a58d73-koperasi-desakelurahan-merah-putih-di-kecamatan-kebonpedes-sukabumi-banyuwangi_hgaouu.webp\"],\"instagram\":null,\"updatedFrom\":\"app-organizations\",\"descriptionHtml\":\"<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>\",\"descriptionJson\":{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"content\":[{\"type\":\"text\",\"text\":\"UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.\"}]}]},\"facebook\":null,\"youtube\":null,\"tiktok\":null}', 'active', 1, 3, '2026-05-14 06:23:14', '2026-05-31 03:28:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant_potentials`
--

CREATE TABLE `tenant_potentials` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `potential_type` enum('agriculture','livestock','fishery','umkm','tourism','culture','natural_resource','human_resource','industry','creative_economy','food','craft','custom') NOT NULL DEFAULT 'custom',
  `title` varchar(180) NOT NULL,
  `subtitle` varchar(500) DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `logo_url` varchar(700) DEFAULT NULL,
  `image_url` varchar(700) DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `owner_name` varchar(180) DEFAULT NULL,
  `manager_name` varchar(180) DEFAULT NULL,
  `production_capacity` varchar(180) DEFAULT NULL,
  `production_unit` varchar(80) DEFAULT NULL,
  `market_reach` varchar(255) DEFAULT NULL,
  `estimated_value` decimal(18,2) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `whatsapp` varchar(80) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `contact_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `statistic_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenant_potentials`
--

INSERT INTO `tenant_potentials` (`id`, `tenant_id`, `potential_type`, `title`, `subtitle`, `slug`, `icon`, `logo_url`, `image_url`, `content_html`, `content_json`, `address`, `latitude`, `longitude`, `owner_name`, `manager_name`, `production_capacity`, `production_unit`, `market_reach`, `estimated_value`, `email`, `phone`, `whatsapp`, `website_url`, `contact_config`, `statistic_config`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('bf94213e-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'agriculture', 'Pertanian', 'Potensi hasil pertanian dan komoditas pangan desa.', 'pertanian', 'lucide:wheat', NULL, NULL, '<p>Potensi pertanian desa mencakup komoditas pangan, hasil panen warga, serta peluang pengembangan ekonomi berbasis lahan dan produksi lokal.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi hasil pertanian dan komoditas pangan desa.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Musiman', 'Komoditas', 'Pasar lokal dan wilayah sekitar', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi hasil pertanian dan komoditas pangan desa.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 1, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL),
('bf9487f2-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'livestock', 'Peternakan', 'Potensi peternakan warga sebagai bagian dari ekonomi desa.', 'peternakan', 'mdi:storefront', NULL, NULL, '<p>Potensi peternakan dapat mencakup sapi, kambing, ayam, bebek, dan berbagai usaha ternak warga yang mendukung ekonomi keluarga.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Berkala', 'Ekor', 'Pasar lokal', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\"}', '{\"images\":[]}', 'active', 1, 2, '2026-05-14 10:29:11', '2026-05-24 10:27:26', NULL),
('bf949d7a-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'fishery', 'Perikanan', 'Potensi perikanan dan budidaya ikan masyarakat.', 'perikanan', 'lucide:fish', NULL, NULL, '<p>Potensi perikanan mencakup budidaya ikan air tawar, kolam warga, serta peluang pengembangan produk olahan berbasis ikan.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi perikanan dan budidaya ikan masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Berkala', 'Kg', 'Pasar lokal', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi perikanan dan budidaya ikan masyarakat.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 3, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL),
('bf94aa1b-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'umkm', 'UMKM Desa', 'Potensi usaha mikro, kecil, dan menengah masyarakat.', 'umkm', 'lucide:store', NULL, NULL, '<p>UMKM desa menjadi salah satu penggerak ekonomi masyarakat melalui produk makanan, kerajinan, jasa, dan perdagangan lokal.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Aktif', 'Unit usaha', 'Desa dan kecamatan sekitar', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 4, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL),
('bf94b4c7-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'tourism', 'Wisata Desa', 'Potensi wisata lokal, alam, edukasi, dan budaya desa.', 'wisata-desa', 'lucide:map-pin', NULL, NULL, '<p>Potensi wisata desa dapat dikembangkan melalui keunikan lingkungan, budaya lokal, edukasi masyarakat, dan daya tarik khas desa.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Berkembang', 'Destinasi', 'Pengunjung lokal dan regional', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 5, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL),
('bf94bee1-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'culture', 'Budaya Lokal', 'Potensi budaya, tradisi, dan kegiatan masyarakat.', 'budaya-lokal', 'lucide:landmark', NULL, NULL, '<p>Budaya lokal menjadi identitas desa yang dapat dikembangkan melalui kegiatan masyarakat, tradisi, seni, dan nilai gotong royong.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Berkala', 'Kegiatan', 'Masyarakat desa', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 6, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL),
('bf94cccf-4f7f-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'creative_economy', 'Ekonomi Kreatif', 'Potensi kreativitas warga dalam produk dan jasa bernilai tambah.', 'ekonomi-kreatif', 'lucide:palette', NULL, NULL, '<p>Ekonomi kreatif desa meliputi produk kreatif, desain, kerajinan, konten lokal, dan inovasi warga yang memiliki nilai jual.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\", \"type\": \"text\"}]}]}', 'Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan', NULL, NULL, NULL, NULL, 'Aktif', 'Produk', 'Online dan lokal', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}', '{\"summary\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\"}', '{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 7, '2026-05-14 10:29:11', '2026-05-14 10:29:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tenant_public_metrics`
--

CREATE TABLE `tenant_public_metrics` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `metric_group` varchar(80) NOT NULL,
  `metric_key` varchar(120) NOT NULL,
  `label` varchar(160) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `value_decimal` decimal(18,2) DEFAULT NULL,
  `value_text` varchar(190) DEFAULT NULL,
  `value_unit` varchar(40) DEFAULT NULL,
  `comparison_value` decimal(10,2) DEFAULT NULL,
  `comparison_unit` varchar(40) DEFAULT NULL,
  `comparison_direction` enum('up','down','same') DEFAULT NULL,
  `period_type` enum('realtime','daily','weekly','monthly','yearly','custom') NOT NULL DEFAULT 'realtime',
  `period_start` datetime DEFAULT NULL,
  `period_end` datetime DEFAULT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `source_type` enum('manual','analytics','system','api','import') NOT NULL DEFAULT 'manual',
  `source_name` varchar(160) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `tenant_public_metrics`
--

INSERT INTO `tenant_public_metrics` (`id`, `tenant_id`, `metric_group`, `metric_key`, `label`, `description`, `value_decimal`, `value_text`, `value_unit`, `comparison_value`, `comparison_unit`, `comparison_direction`, `period_type`, `period_start`, `period_end`, `icon`, `color`, `source_type`, `source_name`, `metadata`, `status`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('35ec3954-4f85-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'visitor_statistics', 'today_visitors', 'Hari ini', 'Jumlah pengunjung hari ini', 37.00, NULL, 'visitor', 12.10, '%', 'up', 'realtime', NULL, NULL, 'solar:pulse-2-bold-duotone', '#2563EB', 'manual', 'seed', '{\"badge\": \"realtime\", \"display\": \"37\"}', 'active', 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35ece653-4f85-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'visitor_statistics', 'yesterday_visitors', 'Kemarin', 'Jumlah pengunjung kemarin', 33.00, NULL, 'visitor', NULL, NULL, NULL, 'daily', NULL, NULL, 'solar:calendar-bold-duotone', '#64748B', 'manual', 'seed', '{\"display\": \"33\"}', 'active', 2, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35ecf2c7-4f85-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'visitor_statistics', 'total_visitors', 'Jumlah pengunjung', 'Total seluruh pengunjung website', 6141.00, NULL, 'visitor', NULL, NULL, NULL, 'realtime', NULL, NULL, 'solar:users-group-rounded-bold-duotone', '#0F172A', 'manual', 'seed', '{\"display\": \"6.141\"}', 'active', 3, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `name` varchar(160) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `avatar_url` varchar(700) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `email_verified_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `avatar_url`, `phone`, `status`, `email_verified_at`, `last_login_at`, `metadata`, `created_at`, `updated_at`, `deleted_at`) VALUES
('32b21afe-4de4-11f1-a9c1-44a3bb6ab520', 'Super Admin', 'superadmin@obayan.id', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NULL, NULL, 'active', '2026-05-12 16:23:12', NULL, NULL, '2026-05-12 09:23:12', '2026-05-12 09:23:12', NULL),
('3370aa46-0450-4ed3-9998-af956e7d721f', 'User Martopuro', 'user@martopuro.com', '$2b$10$SpDan018aCxyxgD2l56BVOVU/S4Tn6bWVWbwD7PikaV0T0pufn3Pa', NULL, NULL, 'active', NULL, NULL, NULL, '2026-05-13 02:20:02', '2026-05-13 02:20:02', NULL),
('4902b8e3-5381-4ce4-9856-582008b7aa20', 'Admin martopuro', 'admin@martopuro.com', '$2b$10$qXWvlbMMkuuqxoQgkY2RKuS4U8wEkIaHf9HVtwIU2vHbz3msdoGfq', NULL, NULL, 'active', NULL, '2026-05-24 11:04:01', NULL, '2026-05-13 02:10:14', '2026-05-24 11:04:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `role_id` char(36) NOT NULL,
  `tenant_id` char(36) DEFAULT NULL,
  `assigned_by` char(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `tenant_id`, `assigned_by`, `created_at`, `deleted_at`) VALUES
('289529c0-7610-44b1-8a27-dc6fee275192', '4902b8e3-5381-4ce4-9856-582008b7aa20', '32a4be24-4de4-11f1-a9c1-44a3bb6ab520', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', NULL, '2026-05-13 02:10:14', NULL),
('32b514dd-4de4-11f1-a9c1-44a3bb6ab520', '32b21afe-4de4-11f1-a9c1-44a3bb6ab520', '32a48a5b-4de4-11f1-a9c1-44a3bb6ab520', NULL, NULL, '2026-05-12 09:23:12', NULL),
('80c412c4-1584-4f9d-a3ef-07fd1219483a', '3370aa46-0450-4ed3-9998-af956e7d721f', '32a4be24-4de4-11f1-a9c1-44a3bb6ab520', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', NULL, '2026-05-13 02:20:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `village_budget_lines`
--

CREATE TABLE `village_budget_lines` (
  `id` char(36) NOT NULL,
  `budget_period_id` char(36) NOT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `line_type` enum('revenue','expense','financing') NOT NULL,
  `line_group` varchar(120) DEFAULT NULL,
  `line_code` varchar(80) DEFAULT NULL,
  `title` varchar(220) NOT NULL,
  `slug` varchar(240) NOT NULL,
  `description` varchar(700) DEFAULT NULL,
  `budget_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `realized_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(80) DEFAULT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `village_budget_lines`
--

INSERT INTO `village_budget_lines` (`id`, `budget_period_id`, `parent_id`, `line_type`, `line_group`, `line_code`, `title`, `slug`, `description`, `budget_amount`, `realized_amount`, `unit`, `icon`, `color`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('35f4751c-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'revenue', 'Pendapatan per Sumber', 'PADESA-LAIN', 'Lain-Lain PADesa', 'lain-lain-padesa', 'Pendapatan asli desa dari lain-lain PADesa.', 65000000.00, 0.00, 'rupiah', 'solar:wallet-money-bold-duotone', '#2563EB', '{\"source\": \"seed\", \"displayBudget\": \"Rp 65.000.000\"}', 'active', 1, 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f48bd4-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'revenue', 'Pendapatan per Sumber', 'DD', 'Dana Desa', 'dana-desa', 'Pendapatan transfer Dana Desa.', 1656078000.00, 0.00, 'rupiah', 'solar:banknote-bold-duotone', '#2563EB', '{\"source\": \"seed\", \"displayBudget\": \"Rp 1.656.078.000\"}', 'active', 1, 2, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f49085-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'revenue', 'Pendapatan per Sumber', 'BHP-RETRIBUSI', 'Bagi Hasil Pajak & Retribusi', 'bagi-hasil-pajak-retribusi', 'Pendapatan bagi hasil pajak dan retribusi.', 254416000.00, 0.00, 'rupiah', 'solar:bill-list-bold-duotone', '#2563EB', '{\"source\": \"seed\", \"displayBudget\": \"Rp 254.416.000\"}', 'active', 1, 3, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f49360-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'revenue', 'Pendapatan per Sumber', 'ADD', 'Alokasi Dana Desa (ADD)', 'alokasi-dana-desa-add', 'Pendapatan dari Alokasi Dana Desa.', 442958000.00, 0.00, 'rupiah', 'solar:buildings-3-bold-duotone', '#2563EB', '{\"source\": \"seed\", \"displayBudget\": \"Rp 442.958.000\"}', 'active', 1, 4, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f49679-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'revenue', 'Pendapatan per Sumber', 'BANKABKOTA', 'Bantuan Keuangan Kab/Kota', 'bantuan-keuangan-kab-kota', 'Bantuan keuangan dari kabupaten atau kota.', 366000000.00, 0.00, 'rupiah', 'solar:hand-money-bold-duotone', '#2563EB', '{\"source\": \"seed\", \"displayBudget\": \"Rp 366.000.000\"}', 'active', 1, 5, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f499a5-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'expense', 'Belanja per Bidang', '01', 'Penyelenggaraan Pemerintahan Desa', 'penyelenggaraan-pemerintahan-desa', 'Belanja bidang penyelenggaraan pemerintahan desa.', 1159164470.00, 0.00, 'rupiah', 'solar:buildings-bold-duotone', '#0EA5E9', '{\"source\": \"seed\", \"displayBudget\": \"Rp 1.159.164.470\"}', 'active', 1, 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f49c3f-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'expense', 'Belanja per Bidang', '02', 'Pelaksanaan Pembangunan Desa', 'pelaksanaan-pembangunan-desa', 'Belanja bidang pelaksanaan pembangunan desa.', 1286368100.00, 0.00, 'rupiah', 'solar:home-2-bold-duotone', '#0EA5E9', '{\"source\": \"seed\", \"displayBudget\": \"Rp 1.286.368.100\"}', 'active', 1, 2, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f49eea-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'expense', 'Belanja per Bidang', '03', 'Pembinaan Kemasyarakatan Desa', 'pembinaan-kemasyarakatan-desa', 'Belanja bidang pembinaan kemasyarakatan desa.', 136430000.00, 0.00, 'rupiah', 'solar:users-group-rounded-bold-duotone', '#0EA5E9', '{\"source\": \"seed\", \"displayBudget\": \"Rp 136.430.000\"}', 'active', 1, 3, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f4a19a-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'expense', 'Belanja per Bidang', '04', 'Pemberdayaan Masyarakat Desa', 'pemberdayaan-masyarakat-desa', 'Belanja bidang pemberdayaan masyarakat desa.', 90055500.00, 0.00, 'rupiah', 'solar:hand-heart-bold-duotone', '#0EA5E9', '{\"source\": \"seed\", \"displayBudget\": \"Rp 90.055.500\"}', 'active', 1, 4, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f4a42b-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'expense', 'Belanja per Bidang', '05', 'Penanggulangan Bencana/Darurat', 'penanggulangan-bencana-darurat', 'Belanja bidang penanggulangan bencana, keadaan darurat, dan mendesak desa.', 150900000.00, 0.00, 'rupiah', 'solar:shield-warning-bold-duotone', '#0EA5E9', '{\"source\": \"seed\", \"displayBudget\": \"Rp 150.900.000\"}', 'active', 1, 5, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL),
('35f4a6c6-4f85-11f1-ab3a-40c2ba92d539', '35f0acc1-4f85-11f1-ab3a-40c2ba92d539', NULL, 'financing', 'Pembiayaan', 'FINANCING', 'Pembiayaan Desa', 'pembiayaan-desa', 'Pembiayaan desa tahun berjalan.', 38466070.00, 0.00, 'rupiah', 'solar:pie-chart-2-bold-duotone', '#64748B', '{\"source\": \"seed\", \"displayBudget\": \"Rp 38.466.070\"}', 'active', 1, 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `village_budget_periods`
--

CREATE TABLE `village_budget_periods` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `budget_year` year(4) NOT NULL,
  `title` varchar(180) NOT NULL,
  `subtitle` varchar(500) DEFAULT NULL,
  `currency_code` char(3) NOT NULL DEFAULT 'IDR',
  `legal_basis` varchar(255) DEFAULT NULL,
  `source_name` varchar(190) DEFAULT NULL,
  `source_url` varchar(700) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'published',
  `is_current` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `village_budget_periods`
--

INSERT INTO `village_budget_periods` (`id`, `tenant_id`, `budget_year`, `title`, `subtitle`, `currency_code`, `legal_basis`, `source_name`, `source_url`, `notes`, `metadata`, `status`, `is_current`, `created_at`, `updated_at`, `deleted_at`) VALUES
('35f0acc1-4f85-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', '2026', 'APBDes 2026', 'Realisasi dibandingkan anggaran', 'IDR', NULL, 'APBDes Desa', NULL, 'Data dapat disesuaikan dengan sumber resmi desa atau API APBDes agar masyarakat mendapat informasi terbaru.', '{\"ui\": {\"tabs\": [\"Ringkas\", \"Pendapatan\", \"Belanja\"], \"variant\": \"summary-finance\"}, \"source\": \"seed\", \"tenant\": \"martopuro\"}', 'published', 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `village_officials`
--

CREATE TABLE `village_officials` (
  `id` char(36) NOT NULL,
  `tenant_id` char(36) NOT NULL,
  `name` varchar(180) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `position_title` varchar(180) NOT NULL,
  `position_code` varchar(120) DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `content_html` longtext DEFAULT NULL,
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `photo_url` varchar(700) DEFAULT NULL,
  `icon` varchar(160) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `whatsapp` varchar(80) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `attendance_status` enum('present','away','leave','inactive','unknown') NOT NULL DEFAULT 'unknown',
  `attendance_label` varchar(80) DEFAULT NULL,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  `social_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `village_officials`
--

INSERT INTO `village_officials` (`id`, `tenant_id`, `name`, `slug`, `position_title`, `position_code`, `short_description`, `content_html`, `content_json`, `photo_url`, `icon`, `phone`, `whatsapp`, `email`, `attendance_status`, `attendance_label`, `term_start`, `term_end`, `social_config`, `metadata`, `status`, `is_featured`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
('35eeec22-4f85-11f1-ab3a-40c2ba92d539', '37eba1a0-4de2-11f1-a9c1-44a3bb6ab520', 'Rianto', 'rianto', 'Kepala Desa', 'kepala-desa', 'Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan, dan pemberdayaan warga.', '<p>Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.</p>', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Memimpin penyelenggaraan pemerintahan desa, pembinaan masyarakat, pembangunan desa, dan pemberdayaan warga.\", \"type\": \"text\"}]}]}', NULL, 'solar:user-rounded-bold-duotone', NULL, NULL, NULL, 'present', 'Hadir', NULL, NULL, '{}', '{\"source\": \"seed\", \"tenant\": \"martopuro\"}', 'active', 1, 1, '2026-05-14 11:08:17', '2026-05-14 11:08:17', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_news_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_news_tenant_status_published` (`tenant_id`,`status`,`published_at`),
  ADD KEY `idx_news_category` (`category_id`);
ALTER TABLE `news` ADD FULLTEXT KEY `ft_news_search` (`title`,`description_card`,`description_content`);

--
-- Indexes for table `news_categories`
--
ALTER TABLE `news_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_news_categories_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_news_categories_tenant_status` (`tenant_id`,`status`);

--
-- Indexes for table `news_tags`
--
ALTER TABLE `news_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_news_tags_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_news_tags_tenant` (`tenant_id`);

--
-- Indexes for table `news_tag_map`
--
ALTER TABLE `news_tag_map`
  ADD PRIMARY KEY (`news_id`,`tag_id`),
  ADD KEY `idx_news_tag_map_tag` (`tag_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_permissions_code` (`code`),
  ADD KEY `idx_permissions_module_action` (`module`,`action`),
  ADD KEY `idx_permissions_status` (`status`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_code` (`code`),
  ADD KEY `idx_roles_scope_status` (`scope`,`status`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_role_permissions_permission` (`permission_id`);

--
-- Indexes for table `structure_organizations`
--
ALTER TABLE `structure_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_structure_org_node_chart_slug` (`chart_id`,`slug`),
  ADD KEY `idx_structure_org_nodes_tenant_status` (`tenant_id`,`status`,`sort_order`),
  ADD KEY `idx_structure_org_nodes_chart_status` (`chart_id`,`status`,`sort_order`),
  ADD KEY `idx_structure_org_nodes_parent` (`parent_id`),
  ADD KEY `idx_structure_org_nodes_position_code` (`tenant_id`,`chart_id`,`position_code`),
  ADD KEY `fk_structure_org_nodes_chart` (`chart_id`,`tenant_id`);

--
-- Indexes for table `structure_organization_charts`
--
ALTER TABLE `structure_organization_charts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_structure_org_charts_tenant_slug` (`tenant_id`,`slug`),
  ADD UNIQUE KEY `uq_structure_org_charts_id_tenant` (`id`,`tenant_id`),
  ADD KEY `idx_structure_org_charts_tenant_status` (`tenant_id`,`status`,`sort_order`),
  ADD KEY `idx_structure_org_charts_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`);

--
-- Indexes for table `structure_organization_edges`
--
ALTER TABLE `structure_organization_edges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_structure_org_edge_unique` (`chart_id`,`source_node_id`,`target_node_id`,`edge_type`),
  ADD KEY `idx_structure_org_edges_chart_status` (`chart_id`,`status`,`sort_order`),
  ADD KEY `idx_structure_org_edges_source` (`source_node_id`),
  ADD KEY `idx_structure_org_edges_target` (`target_node_id`),
  ADD KEY `fk_structure_org_edges_tenant` (`tenant_id`),
  ADD KEY `fk_structure_org_edges_chart` (`chart_id`,`tenant_id`);

--
-- Indexes for table `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenants_slug` (`slug`),
  ADD UNIQUE KEY `uq_tenants_domain` (`domain`),
  ADD KEY `idx_tenants_status` (`status`),
  ADD KEY `idx_tenants_type_status` (`tenant_type`,`status`),
  ADD KEY `idx_tenants_subscription_status` (`subscription_plan`,`subscription_status`,`subscription_ends_at`);

--
-- Indexes for table `tenant_facilities`
--
ALTER TABLE `tenant_facilities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenant_facilities_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_tenant_facilities_tenant_status` (`tenant_id`,`status`),
  ADD KEY `idx_tenant_facilities_tenant_type` (`tenant_id`,`facility_type`,`status`),
  ADD KEY `idx_tenant_facilities_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  ADD KEY `idx_tenant_facilities_sort` (`tenant_id`,`sort_order`,`created_at`);

--
-- Indexes for table `tenant_institutions`
--
ALTER TABLE `tenant_institutions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenant_institutions_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_tenant_institutions_tenant_status` (`tenant_id`,`status`),
  ADD KEY `idx_tenant_institutions_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  ADD KEY `idx_tenant_institutions_sort` (`tenant_id`,`sort_order`,`created_at`);

--
-- Indexes for table `tenant_organizations`
--
ALTER TABLE `tenant_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenant_organizations_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_tenant_organizations_tenant_status` (`tenant_id`,`status`),
  ADD KEY `idx_tenant_organizations_tenant_type` (`tenant_id`,`organization_type`,`status`),
  ADD KEY `idx_tenant_organizations_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  ADD KEY `idx_tenant_organizations_parent` (`parent_id`);

--
-- Indexes for table `tenant_potentials`
--
ALTER TABLE `tenant_potentials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenant_potentials_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_tenant_potentials_tenant_status` (`tenant_id`,`status`),
  ADD KEY `idx_tenant_potentials_tenant_type` (`tenant_id`,`potential_type`,`status`),
  ADD KEY `idx_tenant_potentials_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`),
  ADD KEY `idx_tenant_potentials_sort` (`tenant_id`,`sort_order`,`created_at`);
ALTER TABLE `tenant_potentials` ADD FULLTEXT KEY `ft_tenant_potentials_search` (`title`,`subtitle`,`content_html`,`address`,`owner_name`,`manager_name`,`market_reach`);

--
-- Indexes for table `tenant_public_metrics`
--
ALTER TABLE `tenant_public_metrics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenant_public_metrics_key` (`tenant_id`,`metric_group`,`metric_key`,`period_type`,`period_start`),
  ADD KEY `idx_tenant_public_metrics_group_status` (`tenant_id`,`metric_group`,`status`,`sort_order`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_status` (`status`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_roles_user` (`user_id`),
  ADD KEY `idx_user_roles_role` (`role_id`),
  ADD KEY `idx_user_roles_tenant` (`tenant_id`),
  ADD KEY `idx_user_roles_user_tenant` (`user_id`,`tenant_id`),
  ADD KEY `fk_user_roles_assigned_by` (`assigned_by`);

--
-- Indexes for table `village_budget_lines`
--
ALTER TABLE `village_budget_lines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_village_budget_line_period_slug` (`budget_period_id`,`slug`),
  ADD KEY `idx_village_budget_lines_type_status` (`budget_period_id`,`line_type`,`status`,`sort_order`),
  ADD KEY `idx_village_budget_lines_parent` (`parent_id`);

--
-- Indexes for table `village_budget_periods`
--
ALTER TABLE `village_budget_periods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_village_budget_period_tenant_year` (`tenant_id`,`budget_year`),
  ADD KEY `idx_village_budget_period_current` (`tenant_id`,`is_current`,`status`);

--
-- Indexes for table `village_officials`
--
ALTER TABLE `village_officials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_village_officials_tenant_slug` (`tenant_id`,`slug`),
  ADD KEY `idx_village_officials_tenant_status` (`tenant_id`,`status`,`sort_order`),
  ADD KEY `idx_village_officials_featured` (`tenant_id`,`is_featured`,`status`,`sort_order`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `fk_news_category` FOREIGN KEY (`category_id`) REFERENCES `news_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_news_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news_categories`
--
ALTER TABLE `news_categories`
  ADD CONSTRAINT `fk_news_categories_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news_tags`
--
ALTER TABLE `news_tags`
  ADD CONSTRAINT `fk_news_tags_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news_tag_map`
--
ALTER TABLE `news_tag_map`
  ADD CONSTRAINT `fk_news_tag_map_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_news_tag_map_tag` FOREIGN KEY (`tag_id`) REFERENCES `news_tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `structure_organizations`
--
ALTER TABLE `structure_organizations`
  ADD CONSTRAINT `fk_structure_org_nodes_chart` FOREIGN KEY (`chart_id`,`tenant_id`) REFERENCES `structure_organization_charts` (`id`, `tenant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_structure_org_nodes_parent` FOREIGN KEY (`parent_id`) REFERENCES `structure_organizations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_structure_org_nodes_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `structure_organization_charts`
--
ALTER TABLE `structure_organization_charts`
  ADD CONSTRAINT `fk_structure_org_charts_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `structure_organization_edges`
--
ALTER TABLE `structure_organization_edges`
  ADD CONSTRAINT `fk_structure_org_edges_chart` FOREIGN KEY (`chart_id`,`tenant_id`) REFERENCES `structure_organization_charts` (`id`, `tenant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_structure_org_edges_source` FOREIGN KEY (`source_node_id`) REFERENCES `structure_organizations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_structure_org_edges_target` FOREIGN KEY (`target_node_id`) REFERENCES `structure_organizations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_structure_org_edges_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tenant_facilities`
--
ALTER TABLE `tenant_facilities`
  ADD CONSTRAINT `fk_tenant_facilities_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tenant_institutions`
--
ALTER TABLE `tenant_institutions`
  ADD CONSTRAINT `fk_tenant_institutions_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tenant_organizations`
--
ALTER TABLE `tenant_organizations`
  ADD CONSTRAINT `fk_tenant_organizations_parent` FOREIGN KEY (`parent_id`) REFERENCES `tenant_organizations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tenant_organizations_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tenant_potentials`
--
ALTER TABLE `tenant_potentials`
  ADD CONSTRAINT `fk_tenant_potentials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tenant_public_metrics`
--
ALTER TABLE `tenant_public_metrics`
  ADD CONSTRAINT `fk_tenant_public_metrics_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_assigned_by` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `village_budget_lines`
--
ALTER TABLE `village_budget_lines`
  ADD CONSTRAINT `fk_village_budget_lines_parent` FOREIGN KEY (`parent_id`) REFERENCES `village_budget_lines` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_village_budget_lines_period` FOREIGN KEY (`budget_period_id`) REFERENCES `village_budget_periods` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `village_budget_periods`
--
ALTER TABLE `village_budget_periods`
  ADD CONSTRAINT `fk_village_budget_periods_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `village_officials`
--
ALTER TABLE `village_officials`
  ADD CONSTRAINT `fk_village_officials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
