-- phpMyAdmin SQL Dump
-- version 5.3.0-dev
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 02, 2022 at 06:39 PM
-- Server version: 8.0.31-0ubuntu0.20.04.1
-- PHP Version: 7.4.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mightytaxi`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_fees`
--

CREATE TABLE `additional_fees` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `site_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_favicon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_description` longtext COLLATE utf8mb4_unicode_ci,
  `site_copyright` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language_option` json DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `help_support_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_settings` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`id`, `site_name`, `site_email`, `site_logo`, `site_favicon`, `site_description`, `site_copyright`, `facebook_url`, `instagram_url`, `twitter_url`, `linkedin_url`, `language_option`, `contact_email`, `contact_number`, `help_support_url`, `notification_settings`, `created_at`, `updated_at`) VALUES
(1, 'Mighty Taxi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[\"en\"]', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` bigint UNSIGNED NOT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `rider_id` bigint UNSIGNED DEFAULT NULL,
  `complaint_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'rider, driver',
  `subject` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ride_request_id` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'pending, investigation, resolved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'all,first_ride,region_wise,service_wise',
  `usage_limit_per_rider` bigint UNSIGNED DEFAULT NULL,
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'fixed,percentage',
  `discount` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `minimum_amount` double DEFAULT NULL,
  `maximum_discount` double DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint DEFAULT NULL,
  `region_ids` text COLLATE utf8mb4_unicode_ci,
  `service_ids` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'driver' COMMENT 'driver',
  `is_required` tinyint DEFAULT NULL,
  `has_expiry_date` tinyint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_documents`
--

CREATE TABLE `driver_documents` (
  `id` bigint UNSIGNED NOT NULL,
  `document_id` bigint UNSIGNED DEFAULT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `is_verified` tinyint DEFAULT '0' COMMENT '0-pending,1-approved,2-rejected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_services`
--

CREATE TABLE `driver_services` (
  `id` bigint UNSIGNED NOT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_04_28_130817_create_user_details_table', 1),
(6, '2022_04_29_063151_create_regions_table', 1),
(7, '2022_04_29_063230_create_services_table', 1),
(8, '2022_04_29_064239_create_ride_requests_table', 1),
(9, '2022_04_29_064325_create_driver_services_table', 1),
(10, '2022_04_29_064758_create_complaints_table', 1),
(11, '2022_04_29_064809_create_reviews_table', 1),
(12, '2022_05_02_061025_create_ride_request_histories_table', 1),
(13, '2022_05_02_102753_create_payment_gateways_table', 1),
(14, '2022_05_02_102825_create_payments_table', 1),
(15, '2022_05_02_120722_create_permission_tables', 1),
(16, '2022_05_04_100102_create_media_table', 1),
(17, '2022_05_18_095512_create_coupons_table', 1),
(18, '2022_05_18_095624_create_wallets_table', 1),
(19, '2022_05_18_096432_create_wallet_histories_table', 1),
(20, '2022_05_23_084042_create_notifications_table', 1),
(21, '2022_05_23_094130_create_settings_table', 1),
(22, '2022_05_23_104508_create_app_settings_table', 1),
(23, '2022_06_09_074731_create_additional_fees_table', 1),
(24, '2022_06_13_125956_create_documents_table', 1),
(25, '2022_06_13_130010_create_driver_documents_table', 1),
(26, '2022_08_05_071122_create_sos_table', 1),
(27, '2022_08_05_113139_create_ride_request_ratings_table', 1),
(28, '2022_08_08_052703_create_withdraw_requests_table', 1),
(29, '2022_08_08_090613_create_user_bank_accounts_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `rider_id` bigint UNSIGNED NOT NULL,
  `ride_request_id` bigint UNSIGNED NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `total_amount` double DEFAULT '0',
  `admin_commission` double DEFAULT '0',
  `received_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver_fee` double DEFAULT '0',
  `driver_tips` double DEFAULT '0',
  `driver_commission` double DEFAULT '0',
  `fleet_commission` double DEFAULT '0',
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'cash',
  `txn_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pending, paid, failed',
  `transaction_detail` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1' COMMENT '0- InActive, 1- Active',
  `is_test` tinyint DEFAULT '1' COMMENT '0-  No, 1- Yes',
  `test_value` json DEFAULT NULL,
  `live_value` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'role', 'web', NULL, '2022-11-02 06:05:42', NULL),
(2, 'role add', 'web', 1, '2022-11-02 06:05:42', NULL),
(3, 'role list', 'web', 1, '2022-11-02 06:05:42', NULL),
(4, 'permission', 'web', NULL, '2022-11-02 06:05:42', NULL),
(5, 'permission add', 'web', 4, '2022-11-02 06:05:42', NULL),
(6, 'permission list', 'web', 4, '2022-11-02 06:05:42', NULL),
(7, 'region', 'web', NULL, '2022-11-02 06:05:42', NULL),
(8, 'region list', 'web', 7, '2022-11-02 06:05:42', NULL),
(9, 'region add', 'web', 7, '2022-11-02 06:05:42', NULL),
(10, 'region edit', 'web', 7, '2022-11-02 06:05:42', NULL),
(11, 'region delete', 'web', 7, '2022-11-02 06:05:42', NULL),
(12, 'service', 'web', NULL, '2022-11-02 06:05:42', NULL),
(13, 'service list', 'web', 12, '2022-11-02 06:05:42', NULL),
(14, 'service add', 'web', 12, '2022-11-02 06:05:42', NULL),
(15, 'service edit', 'web', 12, '2022-11-02 06:05:42', NULL),
(16, 'service delete', 'web', 12, '2022-11-02 06:05:42', NULL),
(17, 'driver', 'web', NULL, '2022-11-02 06:05:42', NULL),
(18, 'driver list', 'web', 17, '2022-11-02 06:05:42', NULL),
(19, 'driver add', 'web', 17, '2022-11-02 06:05:42', NULL),
(20, 'driver edit', 'web', 17, '2022-11-02 06:05:42', NULL),
(21, 'driver delete', 'web', 17, '2022-11-02 06:05:42', NULL),
(22, 'rider', 'web', NULL, '2022-11-02 06:05:42', NULL),
(23, 'rider list', 'web', 22, '2022-11-02 06:05:42', NULL),
(24, 'rider add', 'web', 22, '2022-11-02 06:05:42', NULL),
(25, 'rider edit', 'web', 22, '2022-11-02 06:05:42', NULL),
(26, 'rider delete', 'web', 22, '2022-11-02 06:05:42', NULL),
(27, 'riderequest', 'web', NULL, '2022-11-02 06:05:42', NULL),
(28, 'riderequest list', 'web', 27, '2022-11-02 06:05:42', NULL),
(29, 'riderequest show', 'web', 27, '2022-11-02 06:05:42', NULL),
(30, 'riderequest delete', 'web', 27, '2022-11-02 06:05:42', NULL),
(31, 'pending driver', 'web', 17, '2022-11-02 06:05:42', NULL),
(32, 'document', 'web', NULL, '2022-11-02 06:05:42', NULL),
(33, 'document list', 'web', 32, '2022-11-02 06:05:42', NULL),
(34, 'document add', 'web', 32, '2022-11-02 06:05:42', NULL),
(35, 'document edit', 'web', 32, '2022-11-02 06:05:42', NULL),
(36, 'document delete', 'web', 32, '2022-11-02 06:05:42', NULL),
(37, 'driverdocument', 'web', NULL, '2022-11-02 06:05:42', NULL),
(38, 'driverdocument list', 'web', 37, '2022-11-02 06:05:42', NULL),
(39, 'driverdocument add', 'web', 37, '2022-11-02 06:05:42', NULL),
(40, 'driverdocument edit', 'web', 37, '2022-11-02 06:05:42', NULL),
(41, 'driverdocument delete', 'web', 37, '2022-11-02 06:05:42', NULL),
(42, 'coupon', 'web', NULL, '2022-11-02 06:05:42', NULL),
(43, 'coupon list', 'web', 42, '2022-11-02 06:05:42', NULL),
(44, 'coupon add', 'web', 42, '2022-11-02 06:05:42', NULL),
(45, 'coupon edit', 'web', 42, '2022-11-02 06:05:42', NULL),
(46, 'coupon delete', 'web', 42, '2022-11-02 06:05:42', NULL),
(47, 'additionalfees', 'web', NULL, '2022-11-02 06:05:42', NULL),
(48, 'additionalfees list', 'web', 47, '2022-11-02 06:05:42', NULL),
(49, 'additionalfees add', 'web', 47, '2022-11-02 06:05:42', NULL),
(50, 'additionalfees edit', 'web', 47, '2022-11-02 06:05:42', NULL),
(51, 'additionalfees delete', 'web', 47, '2022-11-02 06:05:42', NULL),
(52, 'sos', 'web', NULL, '2022-11-02 06:05:42', NULL),
(53, 'sos list', 'web', 52, '2022-11-02 06:05:42', NULL),
(54, 'sos add', 'web', 52, '2022-11-02 06:05:42', NULL),
(55, 'sos edit', 'web', 52, '2022-11-02 06:05:42', NULL),
(56, 'sos delete', 'web', 52, '2022-11-02 06:05:42', NULL),
(57, 'complaint', 'web', NULL, '2022-11-02 06:05:42', NULL),
(58, 'complaint list', 'web', 57, '2022-11-02 06:05:42', NULL),
(59, 'complaint add', 'web', 57, '2022-11-02 06:05:42', NULL),
(60, 'complaint edit', 'web', 57, '2022-11-02 06:05:42', NULL),
(61, 'complaint delete', 'web', 57, '2022-11-02 06:05:42', NULL),
(62, 'pages', 'web', NULL, '2022-11-02 06:05:42', NULL),
(63, 'terms condition', 'web', 62, '2022-11-02 06:05:42', NULL),
(64, 'privacy policy', 'web', 62, '2022-11-02 06:05:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `distance_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'km' COMMENT 'km,mile',
  `coordinates` polygon DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `timezone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'UTC',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `rider_id` bigint UNSIGNED DEFAULT NULL,
  `ride_request_id` bigint UNSIGNED DEFAULT NULL,
  `driver_rating` double DEFAULT '0',
  `rider_rating` double DEFAULT '0',
  `driver_review` text COLLATE utf8mb4_unicode_ci,
  `rider_review` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_requests`
--

CREATE TABLE `ride_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `rider_id` bigint UNSIGNED DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `is_schedule` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-regular, 1-schedule',
  `ride_attempt` int DEFAULT '0',
  `distance_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` double DEFAULT '0',
  `subtotal` double DEFAULT '0',
  `extra_charges_amount` double DEFAULT '0',
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `riderequest_in_driver_id` bigint UNSIGNED DEFAULT NULL,
  `riderequest_in_datetime` datetime DEFAULT NULL,
  `start_latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_address` text COLLATE utf8mb4_unicode_ci,
  `end_latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_address` text COLLATE utf8mb4_unicode_ci,
  `distance` double DEFAULT NULL,
  `base_distance` double DEFAULT NULL,
  `duration` double DEFAULT NULL,
  `seat_count` double DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `base_fare` double DEFAULT NULL,
  `minimum_fare` double DEFAULT NULL,
  `per_distance` double DEFAULT NULL,
  `per_distance_charge` double DEFAULT NULL,
  `per_minute_drive` double DEFAULT NULL,
  `per_minute_drive_charge` double DEFAULT NULL,
  `extra_charges` json DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `coupon_code` bigint UNSIGNED DEFAULT NULL,
  `coupon_data` json DEFAULT NULL,
  `otp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_by` enum('rider','driver','auto') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelation_charges` double DEFAULT NULL,
  `waiting_time` double DEFAULT NULL,
  `waiting_time_limit` double DEFAULT NULL,
  `tips` double DEFAULT NULL,
  `per_minute_waiting` double DEFAULT NULL,
  `per_minute_waiting_charge` double DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_driver_rated` tinyint(1) NOT NULL DEFAULT '0',
  `is_rider_rated` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_driver_ids` text COLLATE utf8mb4_unicode_ci,
  `service_data` json DEFAULT NULL,
  `max_time_for_find_driver_for_ride_request` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_request_histories`
--

CREATE TABLE `ride_request_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `ride_request_id` bigint UNSIGNED NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `history_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `history_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `history_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_request_ratings`
--

CREATE TABLE `ride_request_ratings` (
  `id` bigint UNSIGNED NOT NULL,
  `ride_request_id` bigint UNSIGNED NOT NULL,
  `rider_id` bigint UNSIGNED DEFAULT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `rating` double NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `rating_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', 1, '2022-11-02 06:05:42', NULL),
(2, 'rider', 'web', 1, '2022-11-02 06:05:42', NULL),
(3, 'driver', 'web', 1, '2022-11-02 06:05:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region_id` bigint UNSIGNED DEFAULT NULL,
  `capacity` bigint UNSIGNED DEFAULT '1',
  `base_fare` double DEFAULT NULL,
  `minimum_fare` double DEFAULT NULL,
  `minimum_distance` double DEFAULT NULL,
  `per_distance` double DEFAULT NULL,
  `per_minute_drive` double DEFAULT NULL,
  `per_minute_wait` double DEFAULT NULL,
  `waiting_time_limit` double DEFAULT NULL,
  `cancellation_fee` double DEFAULT NULL,
  `payment_method` enum('cash_wallet','cash','wallet') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `commission_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'fixed, percentage',
  `admin_commission` double DEFAULT '0',
  `fleet_commission` double DEFAULT '0',
  `status` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `type`, `value`) VALUES
(1, 'CURRENCY_CODE', 'CURRENCY', 'USD'),
(2, 'CURRENCY_POSITION', 'CURRENCY', 'left'),
(3, 'ONESIGNAL_APP_ID', 'ONESIGNAL', NULL),
(4, 'ONESIGNAL_REST_API_KEY', 'ONESIGNAL', NULL),
(5, 'DISTANCE_RADIUS', 'DISTANCE', '50');

-- --------------------------------------------------------

--
-- Table structure for table `sos`
--

CREATE TABLE `sos` (
  `id` bigint UNSIGNED NOT NULL,
  `region_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `added_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `player_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `fleet_id` bigint UNSIGNED DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_notification_seen` timestamp NULL DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_online` tinyint DEFAULT '0',
  `is_available` tinyint DEFAULT '1',
  `is_verified_driver` tinyint DEFAULT '0',
  `uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'UTC',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `contact_number`, `gender`, `email_verified_at`, `address`, `user_type`, `player_id`, `service_id`, `fleet_id`, `latitude`, `longitude`, `remember_token`, `last_notification_seen`, `status`, `is_online`, `is_available`, `is_verified_driver`, `uid`, `display_name`, `login_type`, `timezone`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Admin', 'admin@admin.com', 'admin', '$2y$10$v3mThprXjetTBwZYRqnfQefh6y2bsQ4rsHpj2LnrXnZBab6BqVcpu', '+919876543210', NULL, NULL, NULL, 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 0, 1, 0, NULL, 'Admin', NULL, 'UTC', '2022-11-02 06:05:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_bank_accounts`
--

CREATE TABLE `user_bank_accounts` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_holder_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `car_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_plate_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_production_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_address` text COLLATE utf8mb4_unicode_ci,
  `home_address` text COLLATE utf8mb4_unicode_ci,
  `work_latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `online_received` double DEFAULT NULL,
  `collected_cash` double DEFAULT NULL,
  `manual_received` double DEFAULT NULL,
  `total_withdrawn` double DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_histories`
--

CREATE TABLE `wallet_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'credit,debit',
  `transaction_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'credit- ,debit',
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double DEFAULT '0',
  `balance` double DEFAULT '0',
  `datetime` datetime DEFAULT NULL,
  `ride_request_id` bigint UNSIGNED DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT '0',
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '0' COMMENT '0-requested,1-approved,2-decline',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_fees`
--
ALTER TABLE `additional_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaints_rider_id_foreign` (`rider_id`),
  ADD KEY `complaints_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_documents`
--
ALTER TABLE `driver_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_documents_driver_id_foreign` (`driver_id`),
  ADD KEY `driver_documents_document_id_foreign` (`document_id`);

--
-- Indexes for table `driver_services`
--
ALTER TABLE `driver_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_services_driver_id_foreign` (`driver_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_rider_id_foreign` (`rider_id`),
  ADD KEY `payments_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_rider_id_foreign` (`rider_id`),
  ADD KEY `reviews_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_requests_rider_id_foreign` (`rider_id`);

--
-- Indexes for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_request_histories_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_request_ratings_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_region_id_foreign` (`region_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sos`
--
ALTER TABLE `sos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sos_region_id_foreign` (`region_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_bank_accounts_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`);

--
-- Indexes for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_histories_user_id_foreign` (`user_id`),
  ADD KEY `wallet_histories_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdraw_requests_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_fees`
--
ALTER TABLE `additional_fees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_documents`
--
ALTER TABLE `driver_documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_services`
--
ALTER TABLE `driver_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_requests`
--
ALTER TABLE `ride_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sos`
--
ALTER TABLE `sos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaints_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_documents`
--
ALTER TABLE `driver_documents`
  ADD CONSTRAINT `driver_documents_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_documents_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_services`
--
ALTER TABLE `driver_services`
  ADD CONSTRAINT `driver_services_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD CONSTRAINT `ride_requests_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  ADD CONSTRAINT `ride_request_histories_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  ADD CONSTRAINT `ride_request_ratings_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sos`
--
ALTER TABLE `sos`
  ADD CONSTRAINT `sos_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD CONSTRAINT `user_bank_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  ADD CONSTRAINT `wallet_histories_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wallet_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD CONSTRAINT `withdraw_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
