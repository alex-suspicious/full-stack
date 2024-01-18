-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 08, 2023 at 06:58 PM
-- Server version: 5.7.33
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `plots`
--

CREATE TABLE `plots` (
  `plot_id` bigint(19) UNSIGNED NOT NULL,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `billing` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `number` varchar(10) NOT NULL DEFAULT '',
  `size` smallint(3) UNSIGNED NOT NULL DEFAULT '0',
  `price` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `base_fixed` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `electricity_t1` float(11,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `electricity_t2` float(11,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `updated` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `plots`
--

INSERT INTO `plots` (`plot_id`, `status`, `billing`, `number`, `size`, `price`, `base_fixed`, `electricity_t1`, `electricity_t2`, `updated`) VALUES
(1, 2, 1, '1', 13, 2064378, 0, 0.00, 0.00, 1682233937),
(2, 2, 1, '2', 10, 3367020, 0, 1813.27, 822.59, 1680507313),
(3, 2, 1, '3', 8, 3300000, 0, 0.00, 0.00, 1680514598),
(4, 2, 0, '4', 9, 3025626, 0, 0.00, 0.00, 1677858220),
(5, 2, 0, '5', 21, 6795138, 0, 100.00, 0.00, 1668015240),
(6, 2, 1, '7', 88, 25215000, 1, 0.00, 0.00, 1680514641),
(7, 2, 1, '8', 40, 12500000, 1, 0.00, 0.00, 1680514650),
(8, 2, 1, '9', 43, 13300000, 1, 18637.77, 8762.21, 1680507541),
(9, 0, 1, '10', 41, 15500000, 1, 0.00, 0.00, 1679915811),
(10, 2, 1, '11', 35, 8672101, 1, 0.00, 0.00, 1680514657),
(11, 0, 0, '12', 28, 9900000, 1, 0.00, 0.00, 1680517298),
(12, 2, 1, '18', 18, 4152100, 0, 0.00, 0.00, 1680514669),
(13, 2, 1, '19', 17, 4408000, 0, 12966.18, 5275.78, 1680508300),
(14, 2, 1, '20', 17, 4408000, 0, 0.00, 0.00, 1680514678),
(15, 2, 1, '21', 20, 5200900, 0, 1944.13, 1230.12, 1680508369),
(16, 2, 1, '22', 20, 5200900, 0, 0.00, 0.00, 1680514686),
(17, 2, 1, '23', 17, 4046000, 0, 0.00, 0.00, 1680514704),
(18, 2, 1, '24', 16, 3808000, 0, 0.00, 0.00, 1680514788),
(19, 2, 1, '25', 16, 3808000, 0, 0.00, 0.00, 1680514780),
(20, 2, 1, '26', 15, 3570000, 0, 0.00, 0.00, 1680514774),
(21, 2, 1, '27', 16, 3808000, 0, 0.00, 0.00, 1680514769),
(22, 2, 1, '29', 22, 4473000, 0, 0.00, 0.00, 1680514764),
(23, 2, 1, '30', 12, 2700000, 0, 0.00, 0.00, 1680514759),
(24, 2, 1, '31', 12, 2610000, 0, 515.49, 339.39, 1680508971),
(25, 2, 1, '32', 12, 2610000, 0, 0.00, 0.00, 1680514726),
(26, 2, 1, '33', 10, 2470900, 0, 0.00, 0.00, 1680507739),
(27, 2, 1, '34', 12, 2610000, 0, 6883.92, 3795.69, 1680508516),
(28, 2, 1, '35', 14, 2765700, 0, 0.00, 0.00, 1680514752),
(29, 2, 1, '36', 11, 2390800, 0, 0.00, 0.00, 1680514746),
(30, 0, 0, '37', 45, 9972400, 0, 0.00, 0.00, 1653841036);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sid` bigint(19) UNSIGNED NOT NULL,
  `user_id` bigint(19) UNSIGNED NOT NULL DEFAULT '0',
  `token` char(40) NOT NULL DEFAULT '',
  `access` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `tz` smallint(4) NOT NULL DEFAULT '0',
  `created` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `logged` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `updated` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`sid`, `user_id`, `token`, `access`, `tz`, `created`, `logged`, `updated`) VALUES
(1, 1, 'ab8dc1e93d4b8fc87647c34e792b95e0902b491c', 1, 240, 1686239445, 1686239445, 1686239882);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(19) UNSIGNED NOT NULL,
  `village_id` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `plot_id` varchar(255) NOT NULL DEFAULT '',
  `access` tinyint(1) NOT NULL DEFAULT '0',
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `phone` bigint(14) UNSIGNED NOT NULL DEFAULT '0',
  `phone_code` varchar(4) NOT NULL DEFAULT '',
  `phone_attempts_code` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `phone_attempts_sms` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `updated` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `last_login` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `village_id`, `plot_id`, `access`, `first_name`, `last_name`, `email`, `phone`, `phone_code`, `phone_attempts_code`, `phone_attempts_sms`, `updated`, `last_login`) VALUES
(1, 1, '1', 1, 'Carrol', 'Fernandez', 'test1@gmail.com', 971000000001, '1111', 0, 8, 0, 1686239445),
(2, 1, '2', 1, 'Martin', 'Kurian', 'test2@gmail.com', 971000000002, '1111', 0, 0, 0, 1686227116),
(3, 1, '3', 1, 'Nisha', 'Banchi', 'test3@gmail.com', 971000000003, '1111', 0, 0, 0, 1686227116),
(4, 1, '4', 1, 'Umang', 'Nayak', 'test4@gmail.com', 971000000004, '1111', 0, 0, 0, 1686227116),
(5, 1, '5', 1, 'Mahira', 'Hussain', 'test5@gmail.com', 971000000005, '1111', 0, 0, 0, 1686227116),
(6, 1, '6', 1, 'Muhammad ', 'Ali', 'test6@gmail.com', 971000000006, '1111', 0, 0, 0, 1686227116),
(7, 1, '7', 1, 'Yanina', 'Payares', 'test7@gmail.com', 971000000007, '1111', 0, 0, 0, 1686227116),
(8, 1, '8', 1, 'Iffat', 'Shahzad', 'test8@gmail.com', 971000000008, '1111', 0, 0, 0, 1686227116),
(9, 1, '9', 1, 'Izem', 'Yilmaz', 'test9@gmail.com', 971000000009, '1111', 0, 0, 0, 1686227116),
(10, 1, '5', 1, 'Mhiz', 'Brainy', 'test10@gmail.com', 971000000010, '1111', 0, 0, 0, 1686227116),
(11, 1, '7', 1, 'Nasir', 'Mughal', 'test11@gmail.com', 971000000011, '1111', 0, 0, 0, 1686227116),
(12, 1, '12', 1, 'Jorgen', 'Jorgensen', 'test12@gmail.com', 971000000012, '1111', 0, 0, 0, 1686227116),
(13, 1, '13', 1, 'Lennis', 'Nabalayo', 'test13@gmail.com', 971000000013, '1111', 0, 0, 0, 1686227116),
(14, 1, '5', 1, 'Vipul', 'Bansode', 'test14@gmail.com', 971000000014, '1111', 0, 0, 0, 1686227116),
(15, 1, '15', 1, 'Marina', 'Fonf', 'test15@gmail.com', 971000000015, '1111', 0, 0, 0, 1686227116),
(16, 1, '16', 1, 'Shamir', 'Khan', 'test16@gmail.com', 971000000016, '1111', 0, 0, 0, 1686227116),
(17, 1, '17', 1, 'Ricardo', 'Sabularse', 'test17@gmail.com', 971000000017, '1111', 0, 0, 0, 1686227116),
(18, 1, '18', 1, 'Roger', 'Alam', 'test18@gmail.com', 971000000018, '1111', 0, 0, 0, 1686227116),
(19, 1, '19', 1, 'Vam', 'Kannambra', 'test19@gmail.com', 971000000019, '1111', 0, 0, 0, 1686227116),
(20, 1, '20', 1, 'Naiel', 'Zemour', 'test20@gmail.com', 971000000020, '1111', 0, 0, 0, 1686227116),
(21, 1, '21', 1, 'Sajad', 'Bobs', 'test21@gmail.com', 971000000021, '1111', 0, 0, 0, 1686227116),
(22, 1, '20', 1, 'Mumtaz', 'Falak', 'test22@gmail.com', 971000000022, '1111', 0, 0, 0, 1686227116),
(23, 1, '23', 1, 'Nazia', 'Khan', 'test23@gmail.com', 971000000023, '1111', 0, 0, 0, 1686227116);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `plots`
--
ALTER TABLE `plots`
  ADD PRIMARY KEY (`plot_id`),
  ADD KEY `number` (`number`),
  ADD KEY `billing` (`billing`) USING BTREE;

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `phone` (`phone`),
  ADD KEY `plot_id` (`plot_id`(191)) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `plots`
--
ALTER TABLE `plots`
  MODIFY `plot_id` bigint(19) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `sid` bigint(19) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(19) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
