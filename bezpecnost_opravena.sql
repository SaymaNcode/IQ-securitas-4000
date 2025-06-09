-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Po 09.Jún 2025, 16:25
-- Verzia serveru: 10.4.32-MariaDB
-- Verzia PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `bezpecnost`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `alarm_status`
--

CREATE TABLE `alarm_status` (
  `id` int(11) NOT NULL,
  `typ` varchar(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `čas` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `alarm_status`
--

INSERT INTO `alarm_status` (`id`, `typ`, `message`, `room`, `čas`) VALUES
(1, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(2, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(3, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(4, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(5, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(6, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(7, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(8, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(9, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(10, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(11, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(12, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(13, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(14, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(15, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(16, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(17, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(18, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(19, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(20, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(21, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(22, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(23, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(24, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(25, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(26, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(27, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(28, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(29, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(30, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(31, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(32, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(33, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(34, 'senzor', 'ALARM aktivovaný!', 'system', NULL),
(35, 'senzor', 'ALARM aktivovaný!', 'system', NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `typ` enum('senzor','okna','dvere') NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `room` enum('kuchyňa','garáž','obývačka','spálňa','detská izba','chodba') NOT NULL,
  `severity` enum('low','medium','high','critical') DEFAULT 'medium',
  `resolved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Štruktúra tabuľky pre tabuľku `sensors`
--

CREATE TABLE `sensors` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` enum('door','window','motion') NOT NULL,
  `room` enum('kuchyňa','garáž','obývačka','spálňa','detská izba','chodba') NOT NULL,
  `status` tinyint(1) DEFAULT 0,
  `last_triggered` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `key_name` varchar(50) NOT NULL,
  `value` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `settings`
--

INSERT INTO `settings` (`id`, `key_name`, `value`, `description`) VALUES
(1, 'alarm_enabled', '0', 'Celkový stav alarmového systému'),
(2, 'alarm_delay', '30', 'Oneskorenie pred spustením alarmu (v sekundách)'),
(3, 'motion_sensitivity', 'medium', 'Citlivosť pohybových senzorov');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `system_status`
--

CREATE TABLE `system_status` (
  `id` int(11) NOT NULL,
  `alarm_on` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'Neznámy',
  `uptime` varchar(255) NOT NULL DEFAULT '0s',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `alarm_state` enum('armed','disarmed','triggered') NOT NULL DEFAULT 'disarmed',
  `last_armed` timestamp NULL DEFAULT NULL,
  `last_triggered` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Štruktúra tabuľky pre tabuľku `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `role`, `last_login`) VALUES
(2, 'humajadam', '$2y$10$Efm1Mp5LRz61ekDwG0j2WezkmCBljjuo072Q9yvypHQQFDHWsov.O', 'Adam Humaj', 'admin', NULL),
(3, 'laukosimon', '$2y$10$i4Sg9ef4692l2F3M5RRJv.W6NQHc5QSltz1n9kQtwdHtSktlfGpMm', 'Simon Lauko', 'admin', NULL),
(6, 'admin', '$2y$10$Ar2GEd9smf.n73kG55hYJOwTq6NZ.8Uem9bFd1kYZHa9Qub2bLrMy', 'Administrátor', 'admin', NULL);

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `alarm_status`
--
ALTER TABLE `alarm_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `sensors`
--
ALTER TABLE `sensors`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_name` (`key_name`);

--
-- Indexy pre tabuľku `system_status`
--
ALTER TABLE `system_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `alarm_status`
--
ALTER TABLE `alarm_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pre tabuľku `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT pre tabuľku `sensors`
--
ALTER TABLE `sensors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pre tabuľku `system_status`
--
ALTER TABLE `system_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3313;

--
-- AUTO_INCREMENT pre tabuľku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
