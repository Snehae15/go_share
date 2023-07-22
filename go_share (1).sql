-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2023 at 12:58 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `go_share`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `log_id` int(11) NOT NULL,
  `time` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `complaint_id` int(11) NOT NULL,
  `complaint` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`log_id`, `time`, `date`, `complaint_id`, `complaint`) VALUES
(1, '09:00:00', '2023-10-01', 1, 'not good'),
(1, '09:00:00', '2023-10-01', 2, 'not good'),
(1, '00:00:00', '2023-07-04', 3, 'not good'),
(1, '00:00:00', '2023-07-04', 4, 'hello'),
(1, '00:00:00', '2023-07-04', 5, 'hhhhhhh'),
(1, '00:00:00', '2023-07-04', 6, ''),
(1, '9:00am', '2023-10-01', 7, 'not good'),
(1, '12:16 PM', '2023-07-04', 8, 'toooo baaadddddd'),
(1, '8:12 PM', '2023-07-11', 9, 'Gooood\n'),
(11, '10:58 AM', '2023-07-21', 10, 'ttsrt'),
(11, '12:54 PM', '2023-07-22', 11, 'very bad hospitality');

-- --------------------------------------------------------

--
-- Table structure for table `goods_movement`
--

CREATE TABLE `goods_movement` (
  `gm_id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `starting_point` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `vehicle_no` varchar(9) NOT NULL,
  `time` varchar(10) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goods_movement`
--

INSERT INTO `goods_movement` (`gm_id`, `log_id`, `starting_point`, `destination`, `vehicle_no`, `time`, `date`) VALUES
(1, 0, 'Peinthalmannna', 'kannur', 'KL53q3241', '9:30AM', '2023-10-01'),
(2, 0, 'pmna', 'calicut', 'kl53e7515', '9:00am', '0000-00-00'),
(3, 0, 'pmna', 'calicut', 'kl53e7515', '9:00am', '0000-00-00'),
(4, 0, 'pmna', 'calicut', 'kl53e7515', '9:00am', '2023-10-01'),
(5, 0, 'pmna', 'mlprm', 'kl53q3241', '10:21 AM', '2023-07-19'),
(6, 1, 'Peinthalmannna', 'Kasarkode', 'KL53q3241', '9:00am', '2023-10-01'),
(7, 1, 'perinthalmanna', 'kasarkode', 'kl53e7515', '12:50 AM', '2023-07-13'),
(11, 11, 'Kozhikkode ', 'Malappuram ', 'kl55g6754', '12:25 AM', '2023-07-23'),
(12, 11, 'Malappuram ', 'kochin ', 'kl67b5643', '6:00 PM', '2023-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `group_trip`
--

CREATE TABLE `group_trip` (
  `gt_id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  `mobile_no` bigint(20) NOT NULL,
  `starting_point` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `vehicle_no` varchar(15) NOT NULL,
  `vehicle_type` varchar(20) NOT NULL,
  `group_name` varchar(10) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_trip`
--

INSERT INTO `group_trip` (`gt_id`, `log_id`, `first_name`, `last_name`, `mobile_no`, `starting_point`, `destination`, `vehicle_no`, `vehicle_type`, `group_name`, `date`) VALUES
(3, 0, 'muhammed', 'Tanseer', 9947977759, 'Peinthalmannna', 'kannur', 'KL53q3241', 'Sedan', 'explore', '2023-07-01'),
(4, 0, 'muhammed', 'Tanseer', 9947977759, 'Peinthalmannna', 'Kasarkode', 'KL53q3241', 'sedan', 'explore', '2023-07-01'),
(5, 1, 'tanseer', 'k', 0, 'pmna', 'calicut', 'kl53e7515', '', 'explorado', '2023-07-20'),
(6, 1, 'tanseer', 'k', 0, 'pmna', 'udupi', 'kl53e7515', 'sedan', 'aloha', '2023-07-20'),
(7, 11, 'manu', 'm', 2147483647, 'Kozhikkode ', 'Malappuram ', 'kl56d5677', 'car', 'amigo', '2023-07-22'),
(8, 11, 'manu', 'm', 2147483647, 'kochin', 'trivandrum ', 'kl67b1234', 'car', 'goals ', '2023-07-22');

-- --------------------------------------------------------

--
-- Table structure for table `help`
--

CREATE TABLE `help` (
  `h_id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `lat` double NOT NULL,
  `long` double NOT NULL,
  `message` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `locality` varchar(20) NOT NULL,
  `street` varchar(25) NOT NULL,
  `sublocality` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `help`
--

INSERT INTO `help` (`h_id`, `log_id`, `lat`, `long`, `message`, `date`, `locality`, `street`, `sublocality`) VALUES
(31, 1, 10.962043, 76.2360948, '1', '2023-07-19 21:18:07', 'Perintalmanna', 'X66P+JQ2', 'Pathaikkara'),
(32, 1, 10.9620429, 76.236094, '2', '2023-07-19 21:18:32', 'Perintalmanna', 'X66P+JQ2', 'Pathaikkara'),
(33, 1, 10.9620429, 76.2360943, '3', '2023-07-19 21:18:39', 'Perintalmanna', 'X66P+JQ2', 'Pathaikkara'),
(34, 1, 10.9620428, 76.2360932, '4', '2023-07-19 21:18:47', 'Perintalmanna', 'X66P+JQ2', 'Pathaikkara'),
(35, 1, 37.4219983, -122.084, 'message', '2023-07-19 21:24:02', 'Mountain View', '1600 Amphitheatre Pkwy', ''),
(36, 11, 11.2659651, 75.8684641, 'very bad 👎 ', '2023-07-21 21:48:07', 'Kuttikkattoor', '7V89+CMG Orgin of Mampuzh', ''),
(37, 11, 11.2659651, 75.8684641, 'very bad 👎 ', '2023-07-21 21:48:07', 'Kuttikkattoor', '7V89+CMG Orgin of Mampuzh', '');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `locality` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `sublocality` varchar(50) NOT NULL,
  `subadminstrative` varchar(50) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `locality`, `street`, `sublocality`, `subadminstrative`, `latitude`, `longitude`) VALUES
(1, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '', ''),
(2, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '', ''),
(3, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(4, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(5, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(6, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(7, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(8, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(9, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(10, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(11, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(12, 'Angadipuram', 'X6H3+52P', 'Chanthully Paadam', '', '10.9779707', '76.2026113'),
(13, 'Angadipuram', 'X6H3+52P', 'Chanthully Paadam', '', '10.9779707', '76.2026113'),
(14, 'Angadipuram', 'X6H3+533', 'Chanthully Paadam', '', '10.9779133', '76.2026252'),
(15, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(16, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(17, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(18, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(19, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(20, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(21, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(22, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(23, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(24, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(25, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(26, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(27, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(28, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(29, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(30, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(31, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(32, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(33, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(34, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(35, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(36, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(37, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(38, 'Mountain View', '1600 Amphitheatre Pkwy', '', 'Santa Clara County', '37.4219983', '-122.084'),
(39, 'Angadipuram', 'X6H3+52P', 'Chanthully Paadam', '', '10.9779236', '76.2026005'),
(40, 'Angadipuram', 'X6H3+533', 'Chanthully Paadam', '', '10.9779161', '76.2026115'),
(41, 'Angadipuram', 'X6H3+533', 'Chanthully Paadam', '', '10.9779161', '76.2026115'),
(42, 'Angadipuram', 'X6H3+533', 'Chanthully Paadam', '', '10.9779161', '76.2026115'),
(43, 'Angadipuram', 'X6H3+52P', 'Chanthully Paadam', '', '10.9779461', '76.2026206');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `log_id` int(11) NOT NULL,
  `email` varchar(35) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`log_id`, `email`, `password`) VALUES
(1, 'haris@gmail.com', 'haris@123'),
(2, '7788995544', '12345678'),
(10, 'manu@gmail.com', 'manu@123'),
(11, 'sneha@gmail.com', 'sneha'),
(12, 'athira@gmail.com', 'athira'),
(13, 'arya@gmail.com', 'arya'),
(14, 'hari@gmail.com', 'hari'),
(15, 'ladhi@gmail.com', 'ladhi'),
(16, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `my_rides`
--

CREATE TABLE `my_rides` (
  `log_id` int(11) NOT NULL,
  `ride_id` int(11) NOT NULL,
  `time` varchar(10) NOT NULL,
  `date` varchar(15) NOT NULL,
  `destination` varchar(30) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `my_rides`
--

INSERT INTO `my_rides` (`log_id`, `ride_id`, `time`, `date`, `destination`, `status`) VALUES
(1, 7, '10:29 AM', '2023-07-05', 'calicut', '');

-- --------------------------------------------------------

--
-- Table structure for table `offer`
--

CREATE TABLE `offer` (
  `offer_id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `company_name` varchar(30) NOT NULL,
  `voucher` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer`
--

INSERT INTO `offer` (`offer_id`, `log_id`, `company_name`, `voucher`) VALUES
(1, 11, 'softroniics', 'offer.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `offer_pool`
--

CREATE TABLE `offer_pool` (
  `log_id` int(11) NOT NULL,
  `pool_id` int(11) NOT NULL,
  `starting_point` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `vehicle_no` varchar(9) NOT NULL,
  `time` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `licenceno` varchar(45) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer_pool`
--

INSERT INTO `offer_pool` (`log_id`, `pool_id`, `starting_point`, `destination`, `vehicle_no`, `time`, `date`, `licenceno`, `status`) VALUES
(11, 1, 'Kozhikkode ', 'palakkad ', 'kl65g6789', '11:30 PM', '2023-07-26', '', 'completed'),
(11, 2, 'Kozhikkode ', 'kannu', 'lk78k9876', '12:30 PM', '2023-07-23', '', 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `register_id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `dp` longblob DEFAULT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `email` varchar(50) DEFAULT 'Add email',
  `mobile_no` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`register_id`, `log_id`, `dp`, `first_name`, `last_name`, `email`, `mobile_no`) VALUES
(1, 1, 0x73696e752e6a7067, 'muhammed', 'Thanseer', 'thanzeetnz83@gmail.com', '0'),
(2, 2, '', 'peter', 'griffin', NULL, '0'),
(6, 10, NULL, 'manu', 'm', 'manu@gmail.com', '2147483647'),
(7, 11, NULL, 'sneha', 'e', 'sneha@gmail.com', '2147483647'),
(8, 12, NULL, 'athira', 'k', 'athira@gmail.com', '9754978451'),
(9, 13, NULL, 'Arya ', 'ko', 'arya@gmail.com', '9608574123'),
(10, 14, NULL, 'harideep', 'h', 'hari@gmail.com', '9876421354'),
(11, 15, NULL, 'ladhi', 'mp', 'ladhi@gmail.com', '9633085278'),
(12, 16, NULL, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

CREATE TABLE `rent` (
  `rent_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mobile_no` bigint(10) NOT NULL,
  `price` int(11) NOT NULL,
  `vehicle_no` varchar(10) NOT NULL,
  `vehicle_model` varchar(15) NOT NULL,
  `vehicle_image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`rent_id`, `name`, `mobile_no`, `price`, `vehicle_no`, `vehicle_model`, `vehicle_image`) VALUES
(1, 'manu', 8943397231, 1000, 'KL11V5433', 'I10 neos', 'Hyundai-Grand-i10-Nios-200120231541.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `log_id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `review` varchar(50) NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`log_id`, `review_id`, `date`, `review`, `rating`) VALUES
(1, 1, '2023-10-01 09:00:00', 'not good', 2),
(1, 2, '2023-07-04 13:40:22', '', 5),
(1, 3, '2023-07-04 13:45:34', '', 3),
(1, 4, '2023-07-04 13:47:11', 'good\n', 3),
(11, 5, '2023-07-21 10:59:15', 'ghj', 5),
(11, 6, '2023-07-21 21:56:50', 'nice', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`complaint_id`);

--
-- Indexes for table `goods_movement`
--
ALTER TABLE `goods_movement`
  ADD PRIMARY KEY (`gm_id`);

--
-- Indexes for table `group_trip`
--
ALTER TABLE `group_trip`
  ADD PRIMARY KEY (`gt_id`);

--
-- Indexes for table `help`
--
ALTER TABLE `help`
  ADD PRIMARY KEY (`h_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`log_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `my_rides`
--
ALTER TABLE `my_rides`
  ADD PRIMARY KEY (`ride_id`);

--
-- Indexes for table `offer`
--
ALTER TABLE `offer`
  ADD PRIMARY KEY (`offer_id`);

--
-- Indexes for table `offer_pool`
--
ALTER TABLE `offer_pool`
  ADD PRIMARY KEY (`pool_id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`register_id`);

--
-- Indexes for table `rent`
--
ALTER TABLE `rent`
  ADD PRIMARY KEY (`rent_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `goods_movement`
--
ALTER TABLE `goods_movement`
  MODIFY `gm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `group_trip`
--
ALTER TABLE `group_trip`
  MODIFY `gt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `help`
--
ALTER TABLE `help`
  MODIFY `h_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `my_rides`
--
ALTER TABLE `my_rides`
  MODIFY `ride_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `offer`
--
ALTER TABLE `offer`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `offer_pool`
--
ALTER TABLE `offer_pool`
  MODIFY `pool_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `register_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `rent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
