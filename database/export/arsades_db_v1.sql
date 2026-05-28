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
INSERT INTO `news` VALUES ('37f3a633-4de2-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','b8a308d1-4556-4067-986b-19e15f380367','Kegiatan Warga Desa Martopuro','kegiatan-warga-desa-martopuro','Informasi kegiatan terbaru warga Desa Martopuro.','<p>adjnajkdnajdnaldnaldnaklkdnkajdn</p>','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2AuSMidCOefnwQ5H4fpeVENgTUh6KRzrUPA&s','published',1,'2026-05-13 06:09:02','2026-05-12 09:09:02','2026-05-13 08:40:48',NULL);
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
INSERT INTO `news_categories` VALUES ('37f03dd5-4de2-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Kegiatan','kegiatan','Informasi kegiatan desa.',1,'active','2026-05-12 09:09:02','2026-05-12 09:09:02',NULL),('b8a308d1-4556-4067-986b-19e15f380367','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Kegiatan Desa','kegiatan-desa',NULL,0,'active','2026-05-13 08:11:27','2026-05-13 08:11:27',NULL);
/*!40000 ALTER TABLE `news_categories` ENABLE KEYS */;
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
INSERT INTO `news_tag_map` VALUES ('37f3a633-4de2-11f1-a9c1-44a3bb6ab520','37f1cdd5-4de2-11f1-a9c1-44a3bb6ab520'),('37f3a633-4de2-11f1-a9c1-44a3bb6ab520','37f1e4eb-4de2-11f1-a9c1-44a3bb6ab520');
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
INSERT INTO `news_tags` VALUES ('37f1cdd5-4de2-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','warga','warga','2026-05-12 09:09:02','2026-05-13 08:11:27',NULL),('37f1e4eb-4de2-11f1-a9c1-44a3bb6ab520','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','desa','desa','2026-05-12 09:09:02','2026-05-13 08:11:27',NULL);
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
  `content_json` json DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_config` json DEFAULT NULL,
  `operational_hours` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
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
  CONSTRAINT `fk_tenant_facilities_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_facilities`
--

LOCK TABLES `tenant_facilities` WRITE;
/*!40000 ALTER TABLE `tenant_facilities` DISABLE KEYS */;
INSERT INTO `tenant_facilities` VALUES ('b1127b76-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','health','Kesehatan','Fasilitas layanan kesehatan masyarakat desa.','kesehatan','lucide:hospital',NULL,NULL,'<p>Fasilitas kesehatan desa mendukung pelayanan kesehatan dasar, pemeriksaan rutin, posyandu, serta kegiatan kesehatan masyarakat.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan kesehatan masyarakat desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,1,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b112e33d-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','market','Pasar','Fasilitas perdagangan dan aktivitas ekonomi warga.','pasar','lucide:store',NULL,NULL,'<p>Pasar menjadi pusat aktivitas ekonomi masyarakat, tempat jual beli kebutuhan harian, produk lokal, dan hasil usaha warga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas perdagangan dan aktivitas ekonomi warga.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,2,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b1130aa1-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','education','Pendidikan','Fasilitas pendidikan dan pembelajaran masyarakat.','pendidikan','lucide:school',NULL,NULL,'<p>Fasilitas pendidikan mendukung proses belajar masyarakat mulai dari pendidikan anak usia dini hingga kegiatan pembelajaran warga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas pendidikan dan pembelajaran masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,3,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b113126b-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','sport','Lapangan','Sarana olahraga dan kegiatan masyarakat desa.','lapangan','lucide:map',NULL,NULL,'<p>Lapangan desa digunakan untuk olahraga, kegiatan warga, upacara, lomba, dan acara masyarakat.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Sarana olahraga dan kegiatan masyarakat desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,4,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b113152c-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','emergency','Ambulance','Layanan kendaraan darurat untuk kebutuhan kesehatan warga.','ambulance','lucide:ambulance',NULL,NULL,'<p>Ambulance desa membantu kebutuhan transportasi darurat kesehatan warga menuju fasilitas layanan kesehatan.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Layanan kendaraan darurat untuk kebutuhan kesehatan warga.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,5,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b11317f1-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','transport','Mobil Siaga','Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.','mobil-siaga','lucide:car',NULL,NULL,'<p>Mobil siaga desa digunakan untuk mendukung kebutuhan mendesak masyarakat dan operasional pelayanan desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Kendaraan siaga desa untuk kebutuhan pelayanan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,6,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL),('b1131ac6-4f7d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','water','HIPAM','Fasilitas layanan air bersih masyarakat.','hipam','lucide:droplets',NULL,NULL,'<p>HIPAM mendukung pengelolaan dan distribusi air bersih bagi masyarakat desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Fasilitas layanan air bersih masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,7,'2026-05-14 10:14:28','2026-05-14 10:14:28',NULL);
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
  `content_json` json DEFAULT NULL,
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
  CONSTRAINT `fk_tenant_institutions_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
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
  `contact_config` json DEFAULT NULL,
  `address_config` json DEFAULT NULL,
  `social_config` json DEFAULT NULL,
  `operational_hours` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
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
  CONSTRAINT `fk_tenant_organizations_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_organizations`
--

LOCK TABLES `tenant_organizations` WRITE;
/*!40000 ALTER TABLE `tenant_organizations` DISABLE KEYS */;
INSERT INTO `tenant_organizations` VALUES ('6355beda-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'village_government','Pemerintah Desa Martopuro','Pemerintah Desa Martopuro','pemerintah-desa-martopuro','Pusat layanan pemerintahan, administrasi, dan informasi resmi Desa Martopuro.','<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>',NULL,'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1778746340/martopuro/organizations/1719733806755-1_ohmwmw.webp',NULL,NULL,NULL,'https://martopuro.com','Desa Martopuro',NULL,NULL,'{\"email\": null, \"phone\": null, \"whatsapp\": null}',NULL,'{\"instagram\": null}','{\"friday\": \"08:00-15:00\", \"monday\": \"08:00-15:00\", \"tuesday\": \"08:00-15:00\", \"thursday\": \"08:00-15:00\", \"wednesday\": \"08:00-15:00\"}','{\"icon\": \"solar:buildings-3-bold-duotone\", \"images\": [\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1778746340/martopuro/organizations/1719733806755-1_ohmwmw.webp\", \"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1778746342/martopuro/organizations/img-20260425-103351-jpg_kgazpe.webp\"], \"source\": \"seed\", \"section\": \"hero\", \"instagram\": \"\", \"updatedFrom\": \"app-organizations\", \"descriptionHtml\": \"<p>Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.</p>\", \"descriptionJson\": {\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Pemerintah Desa Martopuro berperan dalam pelayanan administrasi, pembangunan desa, pemberdayaan masyarakat, pengelolaan informasi publik, dan koordinasi layanan warga.\", \"type\": \"text\"}]}]}}','active',1,1,'2026-05-14 06:23:14','2026-05-14 08:17:24',NULL),('63574156-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'culture','Martopuro Culture Fest','Martopuro Culture Fest','martopuro-culture-fest','Wadah kegiatan budaya, musik, UMKM, dan kuliner lokal Martopuro.','Martopuro Culture Fest menjadi ruang kolaborasi warga untuk memperkenalkan budaya, musik, kuliner, UMKM, serta potensi lokal desa.',NULL,'https://martopuro.sencra.io/assets/culturefest/2.JPG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"ctaHref\": \"https://instagram.com/martopuroculturefest\", \"ctaLabel\": \"Buka Instagram\", \"instagram\": \"@martopuroculturefest\"}','active',1,2,'2026-05-14 06:23:14','2026-05-14 06:23:14',NULL),('63599780-4f5d-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520',NULL,'umkm','UMKM Desa Martopuro','UMKM Desa Martopuro','umkm-desa-martopuro','Komunitas pelaku usaha lokal dan produk unggulan desa.','<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>',NULL,'https://res.cloudinary.com/dwbaxqjzr/image/upload/v1778745986/martopuro/organizations/655644604-18114008233676628-3828650543965241901-n_vgn9ae.webp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"email\": null, \"phone\": null, \"whatsapp\": null}',NULL,'{\"instagram\": null}',NULL,'{\"icon\": \"solar:shop-2-bold-duotone\", \"focus\": \"Produk lokal, kuliner, dan ekonomi warga\", \"images\": [\"https://res.cloudinary.com/dwbaxqjzr/image/upload/v1778745986/martopuro/organizations/655644604-18114008233676628-3828650543965241901-n_vgn9ae.webp\"], \"instagram\": \"\", \"updatedFrom\": \"app-organizations\", \"descriptionHtml\": \"<p>UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.</p>\", \"descriptionJson\": {\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"UMKM Desa Martopuro menjadi bagian dari penguatan ekonomi lokal melalui produk makanan, minuman, kerajinan, dan layanan warga.\", \"type\": \"text\"}]}]}}','active',1,3,'2026-05-14 06:23:14','2026-05-14 08:06:27',NULL);
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
  `content_json` json DEFAULT NULL,
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
  `contact_config` json DEFAULT NULL,
  `statistic_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
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
  CONSTRAINT `fk_tenant_potentials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_potentials`
--

LOCK TABLES `tenant_potentials` WRITE;
/*!40000 ALTER TABLE `tenant_potentials` DISABLE KEYS */;
INSERT INTO `tenant_potentials` VALUES ('bf94213e-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','agriculture','Pertanian','Potensi hasil pertanian dan komoditas pangan desa.','pertanian','lucide:wheat',NULL,NULL,'<p>Potensi pertanian desa mencakup komoditas pangan, hasil panen warga, serta peluang pengembangan ekonomi berbasis lahan dan produksi lokal.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi hasil pertanian dan komoditas pangan desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Musiman','Komoditas','Pasar lokal dan wilayah sekitar',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi hasil pertanian dan komoditas pangan desa.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,1,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf9487f2-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','livestock','Peternakan','Potensi peternakan warga sebagai bagian dari ekonomi desa.','peternakan','lucide:cow',NULL,NULL,'<p>Potensi peternakan dapat mencakup sapi, kambing, ayam, bebek, dan berbagai usaha ternak warga yang mendukung ekonomi keluarga.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Ekor','Pasar lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi peternakan warga sebagai bagian dari ekonomi desa.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,2,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf949d7a-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','fishery','Perikanan','Potensi perikanan dan budidaya ikan masyarakat.','perikanan','lucide:fish',NULL,NULL,'<p>Potensi perikanan mencakup budidaya ikan air tawar, kolam warga, serta peluang pengembangan produk olahan berbasis ikan.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi perikanan dan budidaya ikan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Kg','Pasar lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi perikanan dan budidaya ikan masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,3,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94aa1b-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','umkm','UMKM Desa','Potensi usaha mikro, kecil, dan menengah masyarakat.','umkm','lucide:store',NULL,NULL,'<p>UMKM desa menjadi salah satu penggerak ekonomi masyarakat melalui produk makanan, kerajinan, jasa, dan perdagangan lokal.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Aktif','Unit usaha','Desa dan kecamatan sekitar',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi usaha mikro, kecil, dan menengah masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,4,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94b4c7-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','tourism','Wisata Desa','Potensi wisata lokal, alam, edukasi, dan budaya desa.','wisata-desa','lucide:map-pin',NULL,NULL,'<p>Potensi wisata desa dapat dikembangkan melalui keunikan lingkungan, budaya lokal, edukasi masyarakat, dan daya tarik khas desa.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkembang','Destinasi','Pengunjung lokal dan regional',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi wisata lokal, alam, edukasi, dan budaya desa.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,5,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94bee1-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','culture','Budaya Lokal','Potensi budaya, tradisi, dan kegiatan masyarakat.','budaya-lokal','lucide:landmark',NULL,NULL,'<p>Budaya lokal menjadi identitas desa yang dapat dikembangkan melalui kegiatan masyarakat, tradisi, seni, dan nilai gotong royong.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Berkala','Kegiatan','Masyarakat desa',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi budaya, tradisi, dan kegiatan masyarakat.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,6,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL),('bf94cccf-4f7f-11f1-ab3a-40c2ba92d539','37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','creative_economy','Ekonomi Kreatif','Potensi kreativitas warga dalam produk dan jasa bernilai tambah.','ekonomi-kreatif','lucide:palette',NULL,NULL,'<p>Ekonomi kreatif desa meliputi produk kreatif, desain, kerajinan, konten lokal, dan inovasi warga yang memiliki nilai jual.</p>','{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\", \"type\": \"text\"}]}]}','Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan',NULL,NULL,NULL,NULL,'Aktif','Produk','Online dan lokal',NULL,NULL,NULL,NULL,NULL,'{\"email\": \"\", \"phone\": \"\", \"whatsapp\": \"\"}','{\"summary\": \"Potensi kreativitas warga dalam produk dan jasa bernilai tambah.\"}','{\"images\": [], \"source\": \"seed\", \"tenant\": \"martopuro\"}','active',1,7,'2026-05-14 10:29:11','2026-05-14 10:29:11',NULL);
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
  `metadata` json DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenant_public_metrics_key` (`tenant_id`,`metric_group`,`metric_key`,`period_type`,`period_start`),
  KEY `idx_tenant_public_metrics_group_status` (`tenant_id`,`metric_group`,`status`,`sort_order`),
  CONSTRAINT `fk_tenant_public_metrics_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
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
  `subscription_config` json DEFAULT NULL,
  `feature_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `theme_config` json DEFAULT NULL,
  `seo_config` json DEFAULT NULL,
  `hero_config` json DEFAULT NULL,
  `contact_config` json DEFAULT NULL,
  `statistic_config` json DEFAULT NULL,
  `culture_config` json DEFAULT NULL,
  `warta_config` json DEFAULT NULL,
  `footer_config` json DEFAULT NULL,
  `navigation_config` json DEFAULT NULL,
  `social_config` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tenants_slug` (`slug`),
  UNIQUE KEY `uq_tenants_domain` (`domain`),
  KEY `idx_tenants_status` (`status`),
  KEY `idx_tenants_type_status` (`tenant_type`,`status`),
  KEY `idx_tenants_subscription_status` (`subscription_plan`,`subscription_status`,`subscription_ends_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenants`
--

LOCK TABLES `tenants` WRITE;
/*!40000 ALTER TABLE `tenants` DISABLE KEYS */;
INSERT INTO `tenants` VALUES ('37eba1a0-4de2-11f1-a9c1-44a3bb6ab520','Desa Martopuro','Martopuro','martopuro','village','martopuro.com','https://martopuro.com','/assets/logo.png','/favicon.png','/og-obayan.png','#2563eb','Portal digital resmi Desa Martopuro untuk informasi, layanan administrasi, potensi desa, berita, dan kegiatan masyarakat.','active','basic','active','2026-05-14 11:51:26','2027-05-14 23:59:59',NULL,NULL,'{\"news\": true, \"finance\": false, \"letterC\": false, \"onlineLetter\": false}',NULL,NULL,NULL,'{\"brand\": \"Desa Martopuro\", \"stats\": [{\"label\": \"UMKM\", \"value\": \"35+\"}, {\"label\": \"Layanan\", \"value\": \"12\"}, {\"label\": \"Agenda\", \"value\": \"Aktif\"}], \"badges\": [{\"icon\": \"lucide:file-check-2\", \"label\": \"Surat Keterangan\"}, {\"icon\": \"lucide:store\", \"label\": \"Direktori UMKM\"}, {\"icon\": \"lucide:calendar-days\", \"label\": \"Agenda Desa\"}, {\"icon\": \"lucide:map-pin\", \"label\": \"Wisata\"}], \"quicks\": [{\"icon\": \"lucide:clock-3\", \"label\": \"Jam Layanan Kantor\", \"value\": \"Senin窶笛umat 窶｢ 08.00窶?15.00\"}, {\"icon\": \"lucide:store\", \"label\": \"UMKM Terdaftar\", \"value\": \"35 usaha lokal aktif\"}, {\"icon\": \"lucide:phone-call\", \"label\": \"Nomor Darurat\", \"value\": \"112 窶｢ 0812-xxxx-xxxx\"}], \"waIntl\": \"6289563836\", \"bgImage\": \"/assets/images/village/martopuro-hero.jpg\", \"tagline\": \"Portal Resmi Pemerintah Desa\", \"subtitle\": \"Akses informasi terbaru, layanan administrasi online, potensi UMKM, wisata, serta agenda kegiatan desa dalam satu portal digital yang cepat, rapi, dan transparan.\", \"titleMain\": \"Selamat Datang di Desa \", \"ctaPrimary\": {\"href\": \"/layanan\", \"label\": \"Ajukan Surat Online\"}, \"ctaSecondary\": {\"href\": \"/profile\", \"label\": \"Lihat Profil Desa\"}, \"titleHighlight\": \"Martopuro\", \"searchPlaceholder\": \"Cari layanan, berita, agenda, UMKM...\"}','{\"email\": \"team.sencra@gmail.com\", \"phone\": \"0343-591234\", \"waIntl\": \"6289563836\", \"address\": \"Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan, Jawa Timur\", \"mapsQuery\": \"Kantor Desa Martopuro, Pasuruan\", \"officeName\": \"Kantor Desa Martopuro\", \"mapEmbedSrc\": \"\", \"officeSubtitle\": \"Pemerintah Desa Martopuro, Kecamatan Purwosari, Kabupaten Pasuruan\"}','{\"title\": \"Ringkasan Kinerja & APBDes 2026\", \"ctaHref\": \"/apbdes\", \"eyebrow\": \"Statistik Desa\", \"ctaLabel\": \"Lihat APBDes Lengkap\", \"subtitle\": \"Pantau statistik layanan, data aparatur, dan ringkasan APBDes secara ringkas, transparan, dan mudah dipahami masyarakat.\"}','{\"title\": \"Budaya, Musik, & Kuliner \", \"images\": [\"https://martopuro.sencra.io/assets/culturefest/2.JPG\", \"https://martopuro.sencra.io/assets/culturefest/0.JPG\", \"https://martopuro.sencra.io/assets/culturefest/1.JPG\", \"https://martopuro.sencra.io/assets/culturefest/2.JPG\"], \"eyebrow\": \"Martopuro Culture Fest\", \"subtitle\": \"Parade seni tradisi, UMKM lokal, pentas musik, lomba warga, dan kuliner khas dalam satu perayaan meriah.\", \"highlight\": \"Martopuro!\", \"instagram\": \"@martopuroculturefest\", \"eyebrowIcon\": \"lucide:ticket\", \"floatingBadge\": \"Festival Desa Digital\"}','{\"limit\": 12, \"title\": \"Artikel Pilihan & Terbaru\", \"eyebrow\": \"Warta Martopuro\", \"subtitle\": \"Ikuti informasi terbaru dari Desa Martopuro, mulai dari pelayanan publik, kegiatan warga, UMKM, kesehatan, pendidikan, hingga agenda desa.\", \"viewAllHref\": \"/news\", \"viewAllLabel\": \"Lihat Semua\"}',NULL,NULL,'{\"email\": \"team.sencra@gmail.com\", \"youtube\": \"\", \"facebook\": \"\", \"whatsapp\": \"https://wa.me/6289563836\", \"instagram\": \"https://instagram.com/martopuroculturefest\"}','2026-05-12 09:09:02','2026-05-14 04:51:26',NULL);
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
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `idx_users_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('32b21afe-4de4-11f1-a9c1-44a3bb6ab520','Super Admin','superadmin@obayan.id','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',NULL,NULL,'active','2026-05-12 16:23:12',NULL,NULL,'2026-05-12 09:23:12','2026-05-12 09:23:12',NULL),('3370aa46-0450-4ed3-9998-af956e7d721f','User Martopuro','user@martopuro.com','$2b$10$SpDan018aCxyxgD2l56BVOVU/S4Tn6bWVWbwD7PikaV0T0pufn3Pa',NULL,NULL,'active',NULL,NULL,NULL,'2026-05-13 02:20:02','2026-05-13 02:20:02',NULL),('4902b8e3-5381-4ce4-9856-582008b7aa20','Admin martopuro','admin@martopuro.com','$2b$10$qXWvlbMMkuuqxoQgkY2RKuS4U8wEkIaHf9HVtwIU2vHbz3msdoGfq',NULL,NULL,'active',NULL,NULL,NULL,'2026-05-13 02:10:14','2026-05-13 02:10:14',NULL);
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
  `metadata` json DEFAULT NULL,
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
  CONSTRAINT `fk_village_budget_lines_period` FOREIGN KEY (`budget_period_id`) REFERENCES `village_budget_periods` (`id`) ON DELETE CASCADE
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
  `metadata` json DEFAULT NULL,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `is_current` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_village_budget_period_tenant_year` (`tenant_id`,`budget_year`),
  KEY `idx_village_budget_period_current` (`tenant_id`,`is_current`,`status`),
  CONSTRAINT `fk_village_budget_periods_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
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
  `content_json` json DEFAULT NULL,
  `photo_url` varchar(700) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_status` enum('present','away','leave','inactive','unknown') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `attendance_label` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  `social_config` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
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
  CONSTRAINT `fk_village_officials_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE
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

-- Dump completed on 2026-05-15  8:56:31
