-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Pi 28.Feb 2025, 08:54
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
-- Štruktúra tabuľky pre tabuľku `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `logs`
--

INSERT INTO `logs` (`id`, `timestamp`, `message`) VALUES
(1, '2025-02-21 10:00:42', 'Otvorené dvere - hlavný vchod'),
(2, '2025-02-21 10:00:42', 'Otvorené okno - obývačka'),
(3, '2025-02-21 10:00:42', 'Zaznamenaný pohyb - chodba'),
(4, '2025-02-21 10:00:42', 'Otvorené dvere - zadný vchod'),
(5, '2025-02-21 10:00:42', 'Otvorené okno - spálňa'),
(6, '2025-02-21 10:00:42', 'Zaznamenaný pohyb - garáž'),
(7, '2025-02-21 10:07:20', 'Otvorené dvere - hlavný vchod'),
(8, '2025-02-21 10:07:20', 'Otvorené okno - obývačka'),
(9, '2025-02-21 10:07:20', 'Zaznamenaný pohyb - chodba'),
(10, '2025-02-21 10:07:20', 'Otvorené dvere - zadný vchod'),
(11, '2025-02-21 10:07:20', 'Otvorené okno - spálňa'),
(12, '2025-02-21 10:07:20', 'Zaznamenaný pohyb - garáž'),
(13, '2025-02-21 10:07:20', 'Otvorené dvere - hlavný vchod'),
(14, '2025-02-21 10:07:20', 'Otvorené okno - obývačka'),
(15, '2025-02-21 10:07:20', 'Zaznamenaný pohyb - chodba'),
(16, '2025-02-21 10:07:20', 'Otvorené dvere - zadný vchod'),
(17, '2025-02-21 10:07:20', 'Otvorené okno - spálňa'),
(18, '2025-02-21 10:07:20', 'Zaznamenaný pohyb - garáž');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `system`
--

CREATE TABLE `system` (
  `id` int(11) NOT NULL,
  `alarm` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `system`
--

INSERT INTO `system` (`id`, `alarm`) VALUES
(1, 0);

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pre tabuľku `system`
--
ALTER TABLE `system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
