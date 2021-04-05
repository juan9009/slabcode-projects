-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para proyectos
CREATE DATABASE IF NOT EXISTS `proyectos` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `proyectos`;

-- Volcando estructura para tabla proyectos.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.clientes: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `user_id`, `nombres`, `apellidos`, `documento`, `telefono`, `email`, `direccion`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, NULL, 'Juan Guillermo', 'Leal Parra', '1067891941', '(+57)3014993529', 'juanglealp@gmail.com', 'Barrio la Pradera, Montería', '2020-12-12 19:04:42', '2020-12-14 01:42:25', NULL),
	(2, NULL, 'Juan Guillermo', 'Leal Parra', '1067891942', '(+57)3014993527', 'juanglealp2@gmail.com', 'Barrio la Pradera, Montería', '2020-12-14 01:33:54', '2020-12-14 01:33:54', NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.facturas
DROP TABLE IF EXISTS `facturas`;
CREATE TABLE IF NOT EXISTS `facturas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `clientes_id` int(11) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientes_id` (`clientes_id`),
  CONSTRAINT `clientes_id_fkey` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.facturas: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` (`id`, `clientes_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, '2020-12-14 08:04:59', '2020-12-14 08:04:59', NULL),
	(2, 2, '2020-12-14 08:05:16', '2020-12-14 08:05:16', NULL);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.failed_jobs: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.items_factura
DROP TABLE IF EXISTS `items_factura`;
CREATE TABLE IF NOT EXISTS `items_factura` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `facturas_id` int(11) unsigned NOT NULL,
  `sku` varchar(50) NOT NULL,
  `cantidad` int(5) unsigned NOT NULL,
  `valor_unitario_producto` double unsigned NOT NULL COMMENT 'Sin IVA',
  `iva` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `subtotal_productos` double unsigned NOT NULL,
  `valor_total_productos` double unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.items_factura: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `items_factura` DISABLE KEYS */;
INSERT INTO `items_factura` (`id`, `facturas_id`, `sku`, `cantidad`, `valor_unitario_producto`, `iva`, `subtotal_productos`, `valor_total_productos`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, '1-142577-1', 1, 20000, 0.19, 20000, 23800, '2020-12-14 08:04:59', '2020-12-14 08:04:59', NULL),
	(2, 1, '1-142577-2', 1, 20000, 0.19, 20000, 23800, '2020-12-14 08:04:59', '2020-12-14 08:04:59', NULL),
	(3, 1, '2-658158-1', 2, 75000, 0.19, 150000, 178500, '2020-12-14 08:04:59', '2020-12-14 08:04:59', NULL),
	(4, 2, '1-142577-1', 1, 20000, 0.19, 20000, 23800, '2020-12-14 08:05:16', '2020-12-14 08:05:16', NULL),
	(5, 2, '1-142577-2', 1, 20000, 0.19, 20000, 23800, '2020-12-14 08:05:16', '2020-12-14 08:05:16', NULL),
	(6, 2, '2-658158-2', 2, 75000, 0.19, 150000, 178500, '2020-12-14 08:05:16', '2020-12-14 08:05:16', NULL);
/*!40000 ALTER TABLE `items_factura` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.migrations: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
	(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
	(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
	(6, '2016_06_01_000004_create_oauth_clients_table', 1),
	(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
	(8, '2019_08_19_000000_create_failed_jobs_table', 1),
	(9, '2021_04_03_184234_create_permission_tables', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.model_has_permissions
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.model_has_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.model_has_roles
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.model_has_roles: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(2, 'App\\Models\\User', 2),
	(2, 'App\\Models\\User', 4),
	(2, 'App\\Models\\User', 5),
	(2, 'App\\Models\\User', 6),
	(2, 'App\\Models\\User', 7),
	(2, 'App\\Models\\User', 8),
	(2, 'App\\Models\\User', 9),
	(2, 'App\\Models\\User', 10),
	(2, 'App\\Models\\User', 11),
	(2, 'App\\Models\\User', 12),
	(2, 'App\\Models\\User', 13),
	(2, 'App\\Models\\User', 14),
	(2, 'App\\Models\\User', 15),
	(2, 'App\\Models\\User', 16),
	(2, 'App\\Models\\User', 17),
	(2, 'App\\Models\\User', 18),
	(1, 'App\\Models\\User', 19);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.oauth_access_tokens
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.oauth_access_tokens: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('0ba30b54fd0e71a279b61082250454dfc796bee23edf70613a78939db0a383ffd4a91646bad0ff9a', 2, 1, 'Personal Access Token', '[]', 0, '2021-04-04 13:44:56', '2021-04-04 13:44:56', '2021-04-11 13:44:56'),
	('0d3d5a13179d27ffb2135b7060054c1b2a7a2bc9999b08f782147a6659ce158ba42ec882041881f7', 2, 1, 'Personal Access Token', '[]', 0, '2021-04-04 13:54:26', '2021-04-04 13:54:26', '2021-04-11 13:54:26'),
	('1614e8912ac184854429462a2651716313d3df0b84c4a9172800adbb97dee9aeb4fbe9810a9cd65a', 18, 1, 'Personal Access Token', '[]', 0, '2021-04-05 03:37:25', '2021-04-05 03:37:25', '2021-04-12 03:37:25'),
	('3d6b342f99205b6a0ab4351ff55b297a5388f7b5e78337fa6e887dda49ed4e6a64fee39eea3dfa04', 19, 1, 'Personal Access Token', '[]', 0, '2021-04-05 04:27:50', '2021-04-05 04:27:50', '2021-04-12 04:27:50'),
	('4e7b7ad42fc1fdf6c45e27acef3a6d7e80c48c9ce43342c37f6bac357c16b3e332055fef439ca534', 2, 1, 'Personal Access Token', '[]', 0, '2021-04-05 04:35:44', '2021-04-05 04:35:44', '2021-04-12 04:35:44'),
	('7318f775ec1b5af6ce56218d82a0565783936ee1715ddc72b9bd94c4fb6e60fc614d64ebe2961565', 1, 1, 'Personal Access Token', '[]', 1, '2020-12-11 02:58:28', '2020-12-11 02:58:28', '2020-12-18 02:58:28'),
	('88e334a7ef554d6d318d55a1917c6d656bcad50e41d45ed5bcd1ac52522bcc265f59e24fffe48b58', 1, 1, 'Personal Access Token', '[]', 0, '2021-04-03 22:13:29', '2021-04-03 22:13:29', '2021-04-10 22:13:29'),
	('8e64f86ce36d9d68999ab8ded6e7cfa0f13d9a14b4859e3b32b42b2045e70a00aec2522a51533da5', 19, 1, 'Personal Access Token', '[]', 0, '2021-04-05 04:27:20', '2021-04-05 04:27:20', '2021-04-12 04:27:20'),
	('8e8c49afb75e79661fadcc1b2710f4d581fb620fefbe7b901e4a6f8be45337ad3a82814e2ef023a4', 18, 1, 'Personal Access Token', '[]', 0, '2021-04-05 03:37:30', '2021-04-05 03:37:30', '2021-04-12 03:37:30'),
	('8f532134f51bed3b52b4f6b72d08f3176ed72c9d2cf3d499ca8b058f86210302760d0cedeb3b6735', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-12 23:50:28', '2020-12-12 23:50:28', '2020-12-19 23:50:28'),
	('93b3bbde6f421361e9c18a8c8f7b09680fd8e3687e13d9b452d0d1d6e91400f68c4f6af32458ceeb', 2, 1, 'Personal Access Token', '[]', 0, '2021-04-04 14:02:43', '2021-04-04 14:02:43', '2021-04-11 14:02:43'),
	('95b0e72443c0bfb07e850b65b17b312d1429345400edfcfd396f24c9ac1437a1c516b28a2ecaa9bd', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-11 02:54:34', '2020-12-11 02:54:34', '2020-12-18 02:54:34'),
	('a54908c686bfc1e11f7c458b885d640352777dc63366f7431384b463f54534f0cf2eeb5ee7af1abd', 1, 1, 'Personal Access Token', '[]', 0, '2021-04-05 04:01:25', '2021-04-05 04:01:25', '2021-04-12 04:01:25'),
	('ac8db5863bd9ee1653dce84c055303b0a730f041c754581d1d93e6b793c1f5775ef2b68d1e1e5d92', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-12 23:54:11', '2020-12-12 23:54:11', '2020-12-19 23:54:12'),
	('ae8bfae2b50c44cd77c1b1d6d5a931cfdd7038ba43e4326f5c553b4c0d8830c4b1be0d5786777d85', 1, 1, 'Personal Access Token', '[]', 0, '2021-04-04 14:03:06', '2021-04-04 14:03:06', '2021-04-11 14:03:06'),
	('b4aa5e18dde0f2a5a1231fc526061ed58839ae47d824a01fd6c0a34f11a5dcd98547be4daf107f7d', 1, 1, 'Personal Access Token', '[]', 0, '2021-04-04 13:45:25', '2021-04-04 13:45:25', '2021-04-11 13:45:25'),
	('b56e795ad45c1221ad4b269a59c6d49ac1109719888ffcc4287f0314f1041441934f4909fa8a0dba', 1, 1, 'Personal Access Token', '[]', 0, '2021-04-04 13:54:29', '2021-04-04 13:54:29', '2021-04-11 13:54:29'),
	('c8d9eb4ab31dcbc642aafbfb2beb7c246a992d1c17e0f68794bfe2c903754c4e35380f2063432de2', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-12 19:02:37', '2020-12-12 19:02:37', '2020-12-19 19:02:37'),
	('dd2b7ae5a80310e90cc142ee036485c683bcdc77dbfc0b226a94e20213d29492ad4eadd306eace5e', 18, 1, 'Personal Access Token', '[]', 0, '2021-04-05 03:38:21', '2021-04-05 03:38:21', '2021-04-12 03:38:21');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.oauth_auth_codes
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.oauth_auth_codes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.oauth_clients
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.oauth_clients: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', 'RH1zMiWYn7m9UMAbklTPHFLlEIIE3nYRkVJ9J9Mn', NULL, 'http://localhost', 1, 0, 0, '2020-12-11 02:16:38', '2020-12-11 02:16:38'),
	(2, NULL, 'Laravel Password Grant Client', 'QWZq3D6f8V2qCBkfY5IwlzBdto9FrMFpFbfFU7Bk', 'users', 'http://localhost', 0, 1, 0, '2020-12-11 02:16:38', '2020-12-11 02:16:38');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.oauth_personal_access_clients
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.oauth_personal_access_clients: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2020-12-11 02:16:38', '2020-12-11 02:16:38');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.oauth_refresh_tokens
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.oauth_refresh_tokens: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.password_resets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.permissions
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.permissions: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin projects', 'web', '2021-04-03 21:57:53', '2021-04-03 21:57:53');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `referencia` varchar(50) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.productos: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`id`, `nombre`, `referencia`, `descripcion`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Casimeta Tipo Polo', '142577', 'La Camiseta para Hombre Tipo Polo le dará un toque formal a tu pinta ya que es manga corta, su silueta es slim fit, tiene cuello camisero con banda, es abierta totalmente en frente mediante botones a la vista. Está confeccionada en algodón polyester para brindar mayor frescura y comodidad. Disponible en nuestra tienda online.', '2020-12-13 03:56:42', '2020-12-13 03:59:14', NULL),
	(2, 'Pantalón Parsons Verde Oliva', '658158', '<ul><li>Pantalón.</li><li>Con bolsillos cargo.</li><li>Slim Fit, semi ajustado.</li><li>En algodón.</li><li>Con cremallera en frente y botón en cintura.</li></ul>', '2020-12-13 15:30:53', '2020-12-13 15:30:53', NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.projects
DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.projects: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` (`id`, `name`, `description`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'My first updated project', 'This is a description for my first project', '2021-06-01', '2021-12-31', 3, '2021-04-04 14:41:27', '2021-04-05 04:01:36', NULL),
	(2, 'My second project', 'This is a description for my second project', '2021-05-01', '2021-12-31', 3, '2021-04-04 14:44:52', '2021-04-05 04:32:17', NULL),
	(3, 'My new project', 'This is a description for my new project', '2021-05-01', '2021-12-31', 1, '2021-04-05 04:29:21', '2021-04-05 04:29:21', NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.roles: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'web', '2021-04-03 16:35:22', '2021-04-03 16:35:23'),
	(2, 'operator', 'web', '2021-04-03 16:35:41', '2021-04-03 16:35:42'),
	(3, 'other', 'web', '2021-04-03 21:57:53', '2021-04-03 21:57:53');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.role_has_permissions
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.role_has_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.status: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `description`) VALUES
	(1, 'Sin iniciar'),
	(2, 'En progreso'),
	(3, 'Finalizado');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.stock
DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `sku` varchar(100) NOT NULL,
  `cantidad` int(10) unsigned DEFAULT '0',
  `precio` double unsigned DEFAULT '0' COMMENT 'Sin IVA',
  `url_foto` varchar(100) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.stock: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`id`, `product_id`, `sku`, `cantidad`, `precio`, `url_foto`, `iva`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, '1-142577-1', 13, 20000, 'https://loremflickr.com/400/600', 0.19, '2020-12-13 05:19:40', '2020-12-13 05:19:40', NULL),
	(2, 1, '1-142577-2', 15, 20000, 'https://loremflickr.com/400/600', 0.19, '2020-12-13 05:20:12', '2020-12-13 05:20:12', NULL),
	(3, 1, '1-142577-1', 5, 20000, 'https://loremflickr.com/400/600', 0.19, '2020-12-13 05:27:24', '2020-12-13 05:27:24', NULL),
	(4, 2, '2-658158-1', 20, 75000, 'https://loremflickr.com/400/600', 0.19, '2020-12-13 15:31:28', '2020-12-13 15:31:28', NULL),
	(5, 2, '2-658158-2', 30, 75000, 'https://loremflickr.com/400/600', 0.19, '2020-12-13 17:22:00', '2020-12-13 17:22:00', NULL);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.tasks
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `execution_date` date NOT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '1',
  `projects_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla proyectos.tasks: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`, `name`, `description`, `execution_date`, `status`, `projects_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'My second task updated', 'This is a description for my second task', '2021-12-29', 3, 1, '2021-04-04 16:41:15', '2021-04-05 01:20:31', NULL),
	(2, 'My second task', 'This is a description for my second task', '2021-06-25', 3, 1, '2021-04-04 16:42:13', '2021-04-04 16:42:13', NULL),
	(3, 'My second task', 'This is a description for my second task', '2021-06-25', 1, 3, '2021-04-05 04:33:06', '2021-04-05 04:33:06', NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Volcando estructura para tabla proyectos.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla proyectos.users: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Juan Leal', 'gamesjglp@gmail.com', NULL, '$2y$10$TX80IFqJ7XCocm32esQy8e8z4qUm6urn6/4v3REZRC0oOaInRKP4G', NULL, '2021-04-03 21:57:53', '2021-04-05 03:37:16', NULL),
	(2, 'Operador', 'juanglealp@hotmail.com', NULL, '$2y$10$pukdhc8G/ldxhoc1Ksjugu.xNSjbtdIsyqwB0d5qlnS7amaB68yHG', NULL, '2021-04-03 22:10:47', '2021-04-05 04:34:57', NULL),
	(19, 'New Admin', 'juanglealp@gmail.com', NULL, '$2y$10$qMf.pEXxX.h2Fin1wOr8EeOKhdp.VdBeOfywZascjrl.X2HjV/oLG', NULL, '2021-04-05 04:26:28', '2021-04-05 04:27:36', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
