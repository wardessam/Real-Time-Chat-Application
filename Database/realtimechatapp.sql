-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2022 at 03:21 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `realtimechatapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `msg_id` int(11) NOT NULL,
  `sender_name` varchar(50) NOT NULL,
  `receiver_name` varchar(50) NOT NULL,
  `msg` varchar(1000) NOT NULL,
  `attachment` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`msg_id`, `sender_name`, `receiver_name`, `msg`, `attachment`) VALUES
(9, 'Lala', 'Wardshan Essam', 'null', 'avatar-g84b457cd8_640.png'),
(10, 'Wardshan Essam', 'Lala', 'null', 'hith-art-heists-scream-2.jpg'),
(11, 'Lala', 'Wardshan Essam', 'ggggggggg', 'null'),
(12, 'Lala', 'Wardshan Essam', 'jjjj', 'null'),
(13, 'Lala', 'Wardshan Essam', 'hhh', 'null'),
(14, 'Wardshan Essam', 'Lala', 'hi', 'null'),
(15, 'Wardshan Essam', 'Lala', 'ok', 'null'),
(16, 'Wardshan Essam', 'Lala', ';;;', 'null'),
(17, 'Wardshan Essam', 'Lala', 'ok', 'null'),
(18, 'Lala', 'Wardshan Essam', '?', 'null'),
(19, 'Wardshan Essam', 'Lala', '??', 'null'),
(20, 'Lala', 'Wardshan Essam', 'null', 'hith-art-heists-scream-2.jpg'),
(21, 'Wardshan Essam', 'Lala', 'hi', 'null'),
(22, 'Lala', 'Wardshan Essam', 'hi', 'null'),
(23, 'Wardshan Essam', 'Lala', 'ok', 'null'),
(24, 'Lala', 'Wardshan Essam', 'okayyyyyy', 'null'),
(25, 'Wardshan Essam', 'Lala', 'null', 'hith-art-heists-scream-2.jpg'),
(26, 'Lala', 'Wardshan Essam', 'null', 'avatar-g84b457cd8_640.png'),
(27, 'Mohamed Abdullah', 'Wardshan Essam', 'hi ward', 'null'),
(28, 'Mohamed Abdullah', 'Wardshan Essam', 'null', 'avatar-g84b457cd8_640.png'),
(29, 'Wardshan Essam', 'Mohamed Abdullah', 'hi mohamed', 'null'),
(30, 'Wardshan Essam', 'Mohamed Abdullah', 'null', 'hith-art-heists-scream-2.jpg'),
(31, 'Lala', 'Wardshan Essam', 'hi ward', 'null'),
(32, 'Mohamed Abdullah', 'Wardshan Essam', '??', 'null'),
(33, 'Wardshan Essam', 'Lala', 'hi lala', 'null');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(7, 'Wardshan Essam', 'rose.essam38@gmail.com', '123'),
(12, 'Lala', 'la@gmail.com', '12'),
(15, 'Mohamed Rashid', 'mo@gmail.com', '123456'),
(16, 'Mohamed Fathy', 'mo22@gmail.com', '123'),
(17, 'Mohamed Abdullah', 'mohamed@gmail.com', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`msg_id`),
  ADD KEY `sender_name` (`sender_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_name`) REFERENCES `users` (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
