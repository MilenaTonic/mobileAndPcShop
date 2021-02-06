/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `prodavnica`;
CREATE DATABASE IF NOT EXISTS `prodavnica` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `prodavnica`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'milena', '123'),
	(2, 'admin_test', '18F94E0E8472D0558A8B2C8BC832C7D22B378B50DF8DA2F0AC1F34FB4AF4EC85392B2B41A956153D86E87F7547C1B19BC9808C3F9878202F063399975852165D'),
	(3, 'mtonic', '6A4C0DC4FCC43BDEA28963DF73E4F8351BCDAE08FDA1516234E8D764AF8178A610BCCA2813D204DFF92A43F0511EB0016C7682CCF7B343D99E01739FC26EF104'),
	(5, 'milenatonic', '05A189B29FB30332E558C8FF2AD21192E7EEADE47E8264C22BF7A5909160A54A2728FE9927BDE6F9564C6CB658DFA2F18E96526005AFA4CF85944E710E4A5AA9'),
	(7, 'admin', '7FCF4BA391C48784EDDE599889D6E3F1E47A27DB36ECC050CC92F259BFAC38AFAD2C68A1AE804D77075E8FB722503F3ECA2B2C1006EE6F6C7B7628CB45FFFD1D'),
	(8, 'admin1', '58B5444CF1B6253A4317FE12DAFF411A78BDA0A95279B1D5768EBF5CA60829E78DA944E8A9160A0B6D428CB213E813525A72650DAC67B88879394FF624DA482F');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `excerpt` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('available','visible','hidden') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'available',
  `is_promoted` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(1, 'SEAGATE 8TB(GB)', 5, 'Kratak opis...', 'Detaljan opis...', 'available', 0, '2021-01-06 09:10:20'),
	(2, 'A SEAGATE HDD 1024GB', 5, 'Neki kratak tekst..._1', 'Neki malo duzi tekst..._2', 'visible', 1, '2021-01-06 10:35:47'),
	(3, 'ACER Laptop', 3, 'Kratak opis za laptop', 'Detaljniji opis za ACET laptop', 'available', 0, '2021-01-31 14:07:05'),
	(4, 'Lenovo Laptop', 3, 'Kratak opis', 'Neki detaljniji opis laptopa', 'available', 0, '2021-01-31 16:20:41'),
	(5, 'Samsung A71', 2, 'Neki kratak opis o Samsung A71', 'Neki malo detaljniji opis o Samsung A71', 'available', 0, '2021-02-05 18:09:46'),
	(6, 'Huawei P40 Lite', 2, 'Huawei P40 Lite', 'Neki detaljniji opis telefona Huawei P40 Lite', 'available', 0, '2021-02-05 18:12:20');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `Column 4` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `Column 4`) VALUES
	(1, 1, 1, '512GB'),
	(2, 1, 2, 'SATA 3.0'),
	(3, 1, 3, 'HDD'),
	(9, 2, 1, '1024GB'),
	(10, 2, 2, 'SATA 3.0'),
	(12, 3, 8, 'ACER'),
	(19, 3, 9, 'Nema OS'),
	(33, 4, 10, 'Lenovo'),
	(34, 4, 11, '15.6"'),
	(35, 4, 12, 'Nema OS');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_price`;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
	(1, 1, 60.00, '2021-01-06 09:23:18'),
	(2, 1, 45.00, '2021-01-06 09:23:27'),
	(3, 2, 63.20, '2021-01-06 10:35:49'),
	(4, 2, 57.11, '2021-01-29 13:04:22'),
	(5, 3, 720.00, '2021-01-31 14:07:30'),
	(6, 4, 720.00, '2021-01-31 16:21:05'),
	(7, 5, 310.00, '2021-02-05 18:10:21'),
	(8, 6, 300.00, '2021-02-05 18:12:46');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`) VALUES
	(1, 1, '2021-01-30 17:55:04'),
	(2, 1, '2021-01-30 18:01:05'),
	(3, 1, '2021-01-30 18:58:15'),
	(4, 1, '2021-01-30 18:59:12'),
	(5, 1, '2021-02-01 14:36:51'),
	(6, 5, '2021-02-06 18:19:33'),
	(7, 5, '2021-02-06 18:21:11'),
	(8, 5, '2021-02-06 18:22:47');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cat_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
INSERT INTO `cart_article` (`cart_article_id`, `cart_id`, `article_id`, `quantity`) VALUES
	(1, 1, 1, 4),
	(2, 1, 2, 2),
	(5, 2, 2, 2),
	(6, 3, 1, 2),
	(7, 4, 2, 1),
	(8, 4, 1, 3),
	(9, 5, 2, 1),
	(10, 5, 1, 3),
	(12, 6, 4, 1),
	(13, 7, 3, 1);
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Racunari i racunarske komponente', 'products/pr.jpg', NULL),
	(2, 'Mobilni telefoni', 'products/mobilephones.jpg', NULL),
	(3, 'Laptop racunari', 'products/pr/laptop.jpg', 1),
	(4, 'Memorijski mediji', 'products/pr/memory.jpg', 1),
	(5, 'Hard diskovi', 'products/pr/memory/hdd.jpg', 4);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(8, 'Ekran', 3),
	(1, 'Kapacitet', 5),
	(6, 'Napon', 2),
	(9, 'OS', 3),
	(12, 'OS', 4),
	(7, 'Proizvodjac', 3),
	(10, 'Proizvodjac', 4),
	(2, 'Proizvodjac', 5),
	(3, 'Tehnologija', 5),
	(11, 'Velicina ekrana', 4);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `status` enum('rejected','accepted','shipped','pending') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`order_id`, `created_at`, `cart_id`, `status`) VALUES
	(1, '2021-01-30 18:00:22', 1, 'shipped'),
	(2, '2021-01-30 18:58:08', 2, 'pending'),
	(3, '2021-01-30 18:58:54', 3, 'pending'),
	(4, '2021-02-01 14:36:01', 4, 'rejected'),
	(5, '2021-02-01 14:37:10', 5, 'accepted'),
	(6, '2021-02-06 18:20:01', 6, 'pending'),
	(7, '2021-02-06 18:21:22', 7, 'pending');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(8, 2, '2021128-7265442226-ssd2.jpg'),
	(11, 1, '202125-2947228837-ssd1.jpg'),
	(12, 3, '202125-2837731895-acer.png'),
	(13, 4, '202125-2882743691-lenovo.png'),
	(14, 5, '202125-7997234233-a71.png'),
	(15, 6, '202125-4544758782-p40.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  `forename` varchar(64) NOT NULL DEFAULT '0',
  `surname` varchar(64) NOT NULL DEFAULT '0',
  `phone_number` varchar(24) NOT NULL DEFAULT '0',
  `postal_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_address`) VALUES
	(1, 'test@test.rs', '8D2F4D9C7F87141F0810F1ACD6C0462FF0319BB049AA88EA4E310649628091DE316CF1392E19AF4F0A327826545F63E4E969838F5E7D572A475DE3255B738ACA', 'Pera', 'Peric', '+38166999999', 'Neka adresa, Grad, Drzava'),
	(3, 'test123@test.rs', 'C70B5DD9EBFB6F51D09D4132B7170C9D20750A7852F00680F65658F0310E810056E6763C34C9A00B0E940076F54495C169FC2302CCEB312039271C43469507DC', 'Milena', 'Test', '+38166123456', 'Test adresa, Grad, Drzava'),
	(4, 'milena@milena.com', '891C1DEFD1F33A63CD5E8A6C915691C3C1EEB5260FDF4BE7CF734FF2AFA2B0943F8933B66E9B95BAAB13D1B9DAB40130527EA194F92A6B5B4CC38DC50A9311A2', 'Milena', 'Test', '+381641234568', 'Arb BB, Srb'),
	(5, 'tonicmilena99@gmail.com', '00B4710B4F8783D12EDB11B1428CFBC8112E106D46BDC19494C489352BBC5EE3C542E0501A95DDD080C831074459EA9BBD34435540362A92F018A9C80E0CF4C2', 'Milena', 'Tonic', '+381629717705', 'Neka adresa, Arb\nSrbija');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

DROP TABLE IF EXISTS `user_token`;
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`),
  KEY `fk_user_token_user_id` (`user_id`),
  CONSTRAINT `fk_user_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `user_token`;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(1, 1, '2021-02-02 15:44:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTYxNDk1NTQ5My4wNjYsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI2LjEwIiwiaWF0IjoxNjEyMjc3MDkzfQ.GAM7ZEVoEyZKnh9Oq5dwF44gtl4n15e1E770wzqL9lw', '2021-03-05 14:44:53', 0),
	(2, 1, '2021-02-02 16:02:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTYxNDk1NjU0OS45MDIsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI2LjEwIiwiaWF0IjoxNjEyMjc4MTQ5fQ.8cO-POwgPVHAVqdk4gXA_kdSGdGlComDi375BgGv7Ds', '2021-03-05 15:02:29', 1),
	(3, 1, '2021-02-04 10:34:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTYxNTEwOTY1My41NjksImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODguMC40MzI0Ljk2IFNhZmFyaS81MzcuMzYgRWRnLzg4LjAuNzA1LjU2IiwiaWF0IjoxNjEyNDMxMjUzfQ.WRTfu9Pdz7eb2KX4LP0gpFW6Evln0gM1RhNlY-NOSDw', '2021-03-07 09:34:13', 1),
	(4, 4, '2021-02-05 12:47:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo0LCJpZGVudGl0eSI6Im1pbGVuYUBtaWxlbmEuY29tIiwiZXhwIjoxNjE1MjA0MDM4LjE3NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuOTYgU2FmYXJpLzUzNy4zNiBFZGcvODguMC43MDUuNTYiLCJpYXQiOjE2MTI1MjU2Mzh9.8Oga-eImEIZitGiEHXOgUjdU0splrnnrlMHlI9O5yXw', '2021-03-08 11:47:18', 1),
	(5, 4, '2021-02-05 12:50:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo0LCJpZGVudGl0eSI6Im1pbGVuYUBtaWxlbmEuY29tIiwiZXhwIjoxNjE1MjA0MjAxLjAwMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuOTYgU2FmYXJpLzUzNy4zNiBFZGcvODguMC43MDUuNTYiLCJpYXQiOjE2MTI1MjU4MDF9.eECFhknPSsu_K41VBo5vHthbwy0pdNfuPdkiBL2eCXg', '2021-03-08 11:50:01', 1),
	(6, 4, '2021-02-05 17:34:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo0LCJpZGVudGl0eSI6Im1pbGVuYUBtaWxlbmEuY29tIiwiZXhwIjoxNjE1MjIxMjk2LjcwNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuOTYgU2FmYXJpLzUzNy4zNiBFZGcvODguMC43MDUuNTYiLCJpYXQiOjE2MTI1NDI4OTZ9.i4zugScwQiVDmPBFKFKaBLWGQmN_tDjYf-wiY-jeGzI', '2021-03-08 16:34:56', 1),
	(7, 1, '2021-02-05 17:41:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTYxNTIyMTcxMS4yNDgsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI2LjEwIiwiaWF0IjoxNjEyNTQzMzExfQ.VYB6QPeopN5MTIfQFo4Jf_A6bQLqA0pj69ZFBvsUIpc', '2021-03-08 16:41:51', 1),
	(8, 4, '2021-02-05 17:46:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo0LCJpZGVudGl0eSI6Im1pbGVuYUBtaWxlbmEuY29tIiwiZXhwIjoxNjE1MjIxOTk0LjcxMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuOTYgU2FmYXJpLzUzNy4zNiBFZGcvODguMC43MDUuNTYiLCJpYXQiOjE2MTI1NDM1OTR9.TcVxa4HG57ab4DkL94goHZS8wC_LqWhP3F2naSgotVE', '2021-03-08 16:46:34', 1),
	(9, 5, '2021-02-05 18:19:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRvbmljbWlsZW5hOTlAZ21haWwuY29tIiwiZXhwIjoxNjE1MjIzOTk2LjUxMywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuOTYgU2FmYXJpLzUzNy4zNiBFZGcvODguMC43MDUuNTYiLCJpYXQiOjE2MTI1NDU1OTZ9.aQeRN6yKlfI1yaDuejUdHnHQ5uz7m2XRmF0a7Wy63Ps', '2021-03-08 17:19:56', 1),
	(10, 5, '2021-02-06 11:27:21', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRvbmljbWlsZW5hOTlAZ21haWwuY29tIiwiZXhwIjoxNjE1Mjg1NjQxLjI0NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuMTUwIFNhZmFyaS81MzcuMzYgRWRnLzg4LjAuNzA1LjYzIiwiaWF0IjoxNjEyNjA3MjQxfQ.HfSm_WSJ1WtudOjEKrD7KTgUdo5AdKKB_yUOfEhdOcw', '2021-03-09 10:27:21', 1),
	(11, 5, '2021-02-06 18:19:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRvbmljbWlsZW5hOTlAZ21haWwuY29tIiwiZXhwIjoxNjE1MzEwMzU4LjI2NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84OC4wLjQzMjQuMTUwIFNhZmFyaS81MzcuMzYgRWRnLzg4LjAuNzA1LjYzIiwiaWF0IjoxNjEyNjMxOTU4fQ.jgbWngGtYxUnswZL2e5sLFg0QyfsemBDTFM5FQPjQQk', '2021-03-09 17:19:18', 1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
