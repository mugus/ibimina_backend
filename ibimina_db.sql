-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2021 at 08:29 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ibimina_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `ikimina_id` int(11) NOT NULL,
  `admin_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `member_id`, `ikimina_id`, `admin_on`) VALUES
(1, 1, 1, '2021-03-23 09:34:11'),
(2, 2, 14, '2021-03-23 11:05:37'),
(4, 2, 16, '2021-03-23 11:52:41'),
(5, 2, 17, '2021-03-23 11:59:19'),
(6, 2, 18, '2021-03-23 12:00:14'),
(7, 2, 19, '2021-03-23 12:01:58'),
(8, 2, 20, '2021-03-23 12:03:04'),
(9, 2, 21, '2021-03-23 12:04:57'),
(10, 2, 22, '2021-03-23 12:06:03'),
(11, 2, 23, '2021-03-23 22:08:27'),
(12, 1, 24, '2021-03-24 08:27:23'),
(13, 1, 25, '2021-03-26 14:36:26'),
(14, 1, 26, '2021-03-26 14:42:47');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `dep_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `ikimina_id` int(11) NOT NULL,
  `amount` varchar(110) NOT NULL,
  `dep_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`dep_id`, `member_id`, `ikimina_id`, `amount`, `dep_date`) VALUES
(1, 4, 24, '3000', '2021-03-30 18:08:31');

-- --------------------------------------------------------

--
-- Table structure for table `ibimina`
--

CREATE TABLE `ibimina` (
  `ikimina_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `brand_name` varchar(110) NOT NULL,
  `address` varchar(110) NOT NULL,
  `phone` int(11) NOT NULL,
  `about` varchar(200) NOT NULL,
  `ikimina_type` int(11) NOT NULL DEFAULT 3,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ibimina`
--

INSERT INTO `ibimina` (`ikimina_id`, `member_id`, `brand_name`, `address`, `phone`, `about`, `ikimina_type`, `created_at`) VALUES
(1, 1, 'Tech', 'kigali', 87987645, '', 0, '2021-03-12 13:00:08'),
(14, 2, 'urugero', 'kigali', 808967648, '', 0, '2021-03-23 11:05:37'),
(16, 2, 'test', 'kigali', 2147483647, '', 0, '2021-03-23 11:52:41'),
(17, 2, 'urukundo', 'kigali', 2147483647, '', 0, '2021-03-23 11:59:19'),
(18, 2, 'tuzamurane', 'kigali', 2147483647, '', 0, '2021-03-23 12:00:14'),
(19, 2, 'iwacu', 'kigali', 2147483647, '', 0, '2021-03-23 12:01:58'),
(20, 2, 'ikaze', 'kigali', 2147483647, '', 0, '2021-03-23 12:03:04'),
(21, 2, 'tuza', 'kigali', 2147483647, '', 0, '2021-03-23 12:04:57'),
(22, 2, 'hamwe', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for hamwe ikimina', 0, '2021-03-23 12:06:03'),
(23, 2, 'hehe', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for hamwe ikimina', 0, '2021-03-23 22:08:27'),
(24, 1, 'ihaha', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for ihaha online ikimina', 0, '2021-03-24 08:27:23'),
(25, 1, 'ihaha Tech', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for ihaha online ikimina', 0, '2021-03-26 14:36:26'),
(26, 1, 'New Move', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for New Move online ikimina', 3, '2021-03-26 14:42:47'),
(27, 4, 'Cope', 'kigali', 2147483647, 'join us guys, this is for testing purpose only for Cope online ikimina', 3, '2021-03-30 18:17:11');

-- --------------------------------------------------------

--
-- Table structure for table `ikimina_type`
--

CREATE TABLE `ikimina_type` (
  `id` int(11) NOT NULL,
  `type_code` int(11) NOT NULL,
  `type_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ikimina_type`
--

INSERT INTO `ikimina_type` (`id`, `type_code`, `type_name`) VALUES
(1, 1, 'dialy'),
(2, 2, 'weekly'),
(3, 3, 'monthly'),
(4, 4, 'year');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `firstname` varchar(110) NOT NULL,
  `lastname` varchar(110) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(110) NOT NULL,
  `email` varchar(110) NOT NULL,
  `password` varchar(110) NOT NULL,
  `status` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `firstname`, `lastname`, `phone`, `address`, `email`, `password`, `status`) VALUES
(1, 'mugus', 'ioivgaerysdtf', 65987885, 'kigali', 'mugus@gmail.com', '$2b$10$xnxUqSOuwEpbYcDrhCN8f.qmKwC8vpu9SkD89CfP1jxs2K7FdxhEa', 1),
(2, '0', 'ioivgaerysdtf', 65987885, 'kigali', 'mfifi@gmail.com', '$2b$10$PcEO6n92ZFz9LYmYpJ4L8uTwC.ZRhYzWA/wAnplXPue7dtD0Euelu', 1),
(3, 'Move', 'New', 2147483647, 'kigali', 'ikimina@iki.com', '$2b$10$rXWvWt2ncKuU7UcAFlTjJuUDzJ7HCKvUMdpX4ZEonOFU1YnsAif6u', 0),
(4, 'Gustavo', 'Mugus', 2147483647, 'kigali', 'ikimina@gmail.com', '$2b$10$F5gga1pdmJqS7PPM8aq0vOKoGn/F6U8rjnQ9coVCCchkFNntUx2hi', 1);

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `id` int(11) NOT NULL,
  `ikimina_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `join_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `membership`
--

INSERT INTO `membership` (`id`, `ikimina_id`, `member_id`, `join_at`) VALUES
(1, 16, 2, '2021-03-23 11:52:41'),
(2, 17, 2, '2021-03-23 11:59:19'),
(3, 18, 2, '2021-03-23 12:00:14'),
(4, 19, 2, '2021-03-23 12:01:58'),
(5, 20, 2, '2021-03-23 12:03:04'),
(6, 21, 2, '2021-03-23 12:04:57'),
(7, 22, 2, '2021-03-23 12:06:03'),
(8, 23, 2, '2021-03-23 22:08:27'),
(9, 24, 1, '2021-03-24 08:27:24'),
(10, 25, 1, '2021-03-26 14:36:26'),
(11, 26, 1, '2021-03-26 14:42:47'),
(12, 26, 4, '2021-03-30 13:20:32'),
(13, 27, 4, '2021-03-30 18:17:11');

-- --------------------------------------------------------

--
-- Table structure for table `membership_request`
--

CREATE TABLE `membership_request` (
  `request_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `ikimina_id` int(11) NOT NULL,
  `requested_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `membership_request`
--

INSERT INTO `membership_request` (`request_id`, `member_id`, `ikimina_id`, `requested_on`) VALUES
(1, 4, 24, '2021-03-30 17:58:30');

-- --------------------------------------------------------

--
-- Table structure for table `required_payment`
--

CREATE TABLE `required_payment` (
  `id` int(11) NOT NULL,
  `ikimina_id` int(11) NOT NULL,
  `amount` varchar(200) NOT NULL,
  `ikimina_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_code` int(11) NOT NULL,
  `status_name` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_code`, `status_name`) VALUES
(1, 0, 'Pending'),
(2, 1, 'verified'),
(3, 2, 'unavialable'),
(4, 3, 'stopped');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `ikimina_id` (`ikimina_id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`dep_id`),
  ADD KEY `dep_id` (`dep_id`,`member_id`),
  ADD KEY `ikimina_id` (`ikimina_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `ibimina`
--
ALTER TABLE `ibimina`
  ADD PRIMARY KEY (`ikimina_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `ikimina_type`
--
ALTER TABLE `ikimina_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ikimina_id` (`ikimina_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `membership_request`
--
ALTER TABLE `membership_request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `ikimina_id` (`ikimina_id`);

--
-- Indexes for table `required_payment`
--
ALTER TABLE `required_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ikimina_id` (`ikimina_id`),
  ADD KEY `ikimina_type` (`ikimina_type`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `dep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ibimina`
--
ALTER TABLE `ibimina`
  MODIFY `ikimina_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ikimina_type`
--
ALTER TABLE `ikimina_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `membership_request`
--
ALTER TABLE `membership_request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `required_payment`
--
ALTER TABLE `required_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`ikimina_id`) REFERENCES `ibimina` (`ikimina_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `admins_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `deposits_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ibimina`
--
ALTER TABLE `ibimina`
  ADD CONSTRAINT `ibimina_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON UPDATE CASCADE;

--
-- Constraints for table `membership`
--
ALTER TABLE `membership`
  ADD CONSTRAINT `membership_ibfk_1` FOREIGN KEY (`ikimina_id`) REFERENCES `ibimina` (`ikimina_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membership_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `membership_request`
--
ALTER TABLE `membership_request`
  ADD CONSTRAINT `membership_request_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membership_request_ibfk_2` FOREIGN KEY (`ikimina_id`) REFERENCES `ibimina` (`ikimina_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `required_payment`
--
ALTER TABLE `required_payment`
  ADD CONSTRAINT `required_payment_ibfk_1` FOREIGN KEY (`ikimina_id`) REFERENCES `ibimina` (`ikimina_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
