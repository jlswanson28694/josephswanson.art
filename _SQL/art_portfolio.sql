-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 27, 2020 at 03:36 AM
-- Server version: 5.7.24
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `art_portfolio`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `project_id`, `path`, `caption`, `created_at`, `updated_at`) VALUES
(1, 1, 'concept-art/Space Janitor final concept.png', '', '2020-05-15 09:58:32', '2020-05-15 09:58:32'),
(2, 2, 'concept-art/Lyla.png', '', '2020-05-15 05:36:55', '2020-05-15 05:36:55'),
(3, 3, 'concept-art/DnD Character Final.png', '', '2020-05-15 05:36:55', '2020-05-15 05:36:55'),
(4, 4, 'concept-art/Whopp Final.png', '', '2020-05-15 05:36:55', '2020-05-15 05:36:55'),
(5, 5, 'concept-art/Kenku Sketches.png', '', '2020-05-15 05:36:55', '2020-05-15 05:36:55'),
(6, 6, 'concept-art/Artemis Fowl.png', '', '2020-05-15 05:36:55', '2020-05-15 05:36:55'),
(7, 1, 'concept-art/Space Janitor Final Process Sheet.png', 'Design process', '2020-05-15 18:39:39', '2020-05-15 18:39:39'),
(8, 3, 'concept-art/Ornen Artstation3.png', 'Design process', '2020-05-15 18:39:39', '2020-05-15 18:39:39'),
(9, 7, '3D/FullUnityRender3.png', '', '2020-05-15 19:01:49', '2020-05-15 19:01:49'),
(10, 7, '3D/RadioUnityRender3.png', 'Close-up of the handheld radio. Tris: 4.2k', '2020-05-15 19:01:49', '2020-05-15 19:01:49'),
(11, 8, '3D/BellTowerRender.png', '', '2020-05-15 19:26:02', '2020-05-15 19:26:02'),
(12, 9, '3D/CharacterBust_Hi_to_Lo2.png', '', '2020-05-15 19:26:02', '2020-05-15 19:26:02'),
(13, 10, '3D/AgedBronzePortfolio.png', '', '2020-05-15 19:26:02', '2020-05-15 19:26:02'),
(14, 4, 'concept-art/WhoppSketches.png', 'Design process', '2020-05-15 19:59:34', '2020-05-15 19:59:34');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(6, '2020_05_15_031451_create_projects_table', 1),
(7, '2020_05_15_031837_create_images_table', 1),
(8, '2020_05_26_195230_create_thumbnails_table', 2),
(9, '2020_05_26_222354_drop_height_and_width_columns_from_images_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Space Janitor Claude', 'Concept Art', 'Personal project. Claude is the sole janitor on the Titan Star Cruise ship. Claude and his force of cleaning robots are responsible for cleaning the ship when it arrives back at port for maintenance. Being a fan of opera, his booming voice can be heard echoing throughout the empty vessel while he works. Claude is a friendly guy, but has a short temper when it comes to his robots.', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(2, 'Lyla', 'Concept Art', 'Personal design work. Lyla is a rare spirit that tends to the forest. There are many stories of her kind among the humans, but most don\'t actually believe the spirits exist.', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(3, 'Ornen Hazewind', 'Concept Art', 'Character design for a D&D campaign I took part in. Ornen is a Scourge Aasimar paladin. He has a burning desire to destroy all evil in the world. He sees all living creatures as vile and corrupt besides the Aasimar race, and wishes to annihilate all life and start over from scratch. Without the authority or power to enact his wishes, Ornen instead works as a bounty hunter so he can feed his desire for purification within the boundaries of the law, hoping one day other Aasimar might share his vision for a new world.', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(4, 'Whopp, Kenku Wizard', 'Concept Art', 'A design I made of a friend\'s D&D character. Whopp lived his life as a slave until he was offered illusionist powers by a chaotic god. To obtain these powers, Whopp gave up his soul, and was given one condition to win it back: become world famous. Whopp was instructed by this god to study under the well-respected and somewhat well-known wizard “The Hidden Hand.” He trained under this wizard for 6 years, at which point the wizard died of old age. Whopp was given the mantle of “The Hidden Hand” by his teacher during his final moments, and Whopp began the quest for fame with a substantial head start.\r\nHaving been a slave or a student his entire life, Whopp is submissive and somewhat reserved, making him an unlikely candidate for stardom, but he tries his best to stand out from the crowd.', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(5, 'Kenku Sketches', 'Concept Art', 'A few character design concepts of the Dungeons & Dragons race: the Kenku', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(6, 'Artemis Fowl', 'Concept Art', 'I challenged myself to paint how I imagined the main duo from the book Artemis Fowl.', '2020-05-15 03:48:40', '2020-05-15 03:48:40'),
(7, 'Small Unity Environment', '3D Art', 'A small environment in Unity done for an art test.\r\n<br>\r\n<br>\r\n-Modeled in Blender <br>\r\n-Hi-poly sculpts made in Zbrush <br>\r\n-Textures and bakes done in Substance Painter <br>\r\n-Rendered in Unity <br>', '2020-05-15 18:57:33', '2020-05-15 18:57:33'),
(8, 'Stylized Bell Tower', '3D Art', 'Asset created for my senior game project. \r\n<br>\r\n<br>\r\n-Modeled in Maya <br>\r\n-Textured in Substance Painter <br>\r\n-Materials created in Substance Designer <br>\r\n-Rendered in Eevee real-time engine <br>', '2020-05-15 18:57:33', '2020-05-15 18:57:33'),
(9, 'Ornen Character Bust', '3D Art', 'The head for a game-ready character model I am currently working on. The low poly model is 5,686 tris, not including the eyes, which are only placeholders. Check out the concept art for this model on my 2D Art page.\r\n<br>\r\n<br>\r\n-Sculpted in Zbrush <br>\r\n-Retopo in Blender <br>\r\n-Normal map baked in Substance Painter <br>\r\n-Rendered in Eevee real-time engine <br>', '2020-05-15 18:57:33', '2020-05-15 18:57:33'),
(10, 'Aged Bronze', '3D Art', 'I first created the realistic version of this texture before editing the material to look more stylized. Both textures were made procedurally in Substance Designer.', '2020-05-15 18:57:33', '2020-05-15 18:57:33');

-- --------------------------------------------------------

--
-- Table structure for table `thumbnails`
--

CREATE TABLE `thumbnails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `thumbnails`
--

INSERT INTO `thumbnails` (`id`, `project_id`, `path`, `order`, `height`, `width`, `created_at`, `updated_at`) VALUES
(1, 1, 'thumbnails/Space Janitor final concept.png', 1, 605, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(2, 2, 'thumbnails/Lyla.png', 2, 800, 638, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(3, 3, 'thumbnails/DnD Character Final.png', 3, 1176, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(4, 4, 'thumbnails/Whopp Final.png', 4, 1320, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(5, 5, 'thumbnails/Kenku Sketches.png', 5, 1423, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(6, 6, 'thumbnails/Artemis Fowl.png', 6, 800, 452, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(7, 7, 'thumbnails/FullUnityRender3.png', 1, 844, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(8, 8, 'thumbnails/BellTowerRender.png', 2, 1128, 1500, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(9, 9, 'thumbnails/CharacterBust_Hi_to_Lo2.png', 3, 800, 686, '2020-05-26 20:39:33', '2020-05-26 20:39:33'),
(10, 10, 'thumbnails/AgedBronzePortfolio.png', 4, 800, 631, '2020-05-26 20:39:33', '2020-05-26 20:39:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `images_project_id_foreign` (`project_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `thumbnails`
--
ALTER TABLE `thumbnails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thumbnails_project_id_foreign` (`project_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `thumbnails`
--
ALTER TABLE `thumbnails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `thumbnails`
--
ALTER TABLE `thumbnails`
  ADD CONSTRAINT `thumbnails_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
