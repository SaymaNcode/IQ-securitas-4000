-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Sun 08.Jún 2025, 16:30
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
  `typ` int(11) NOT NULL,
  `message` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  `čas` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `alarm_status`
--

INSERT INTO `alarm_status` (`id`, `typ`, `message`, `room`, `čas`) VALUES
(0, 0, 0, 0, '2025-06-08 14:26:24');

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
-- Sťahujem dáta pre tabuľku `logs`
--

INSERT INTO `logs` (`id`, `typ`, `message`, `timestamp`, `room`, `severity`, `resolved`) VALUES
(30, 'dvere', 'Dvere boli otvorené', '2025-06-08 14:26:25', '', 'medium', 0);

-- --------------------------------------------------------

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
-- Sťahujem dáta pre tabuľku `system_status`
--

INSERT INTO `system_status` (`id`, `alarm_on`, `status`, `uptime`, `timestamp`, `alarm_state`, `last_armed`, `last_triggered`) VALUES
(196, 1, 'Aktívny', '1749392511.306463s', '2025-06-08 14:21:51', 'disarmed', NULL, NULL),
(197, 1, 'Aktívny', '1749392512.306638s', '2025-06-08 14:21:52', 'disarmed', NULL, NULL),
(198, 1, 'Aktívny', '1749392513.309124s', '2025-06-08 14:21:53', 'disarmed', NULL, NULL),
(199, 1, 'Aktívny', '1749392514.308558s', '2025-06-08 14:21:54', 'disarmed', NULL, NULL),
(200, 1, 'Aktívny', '1749392515.307933s', '2025-06-08 14:21:55', 'disarmed', NULL, NULL),
(201, 1, 'Aktívny', '1749392516.311376s', '2025-06-08 14:21:56', 'disarmed', NULL, NULL),
(202, 1, 'Aktívny', '1749392517.311074s', '2025-06-08 14:21:57', 'disarmed', NULL, NULL),
(203, 1, 'Aktívny', '1749392518.314141s', '2025-06-08 14:21:58', 'disarmed', NULL, NULL),
(204, 1, 'Aktívny', '1749392519.313481s', '2025-06-08 14:21:59', 'disarmed', NULL, NULL),
(205, 1, 'Aktívny', '1749392520.312899s', '2025-06-08 14:22:00', 'disarmed', NULL, NULL),
(206, 1, 'Aktívny', '1749392521.317409s', '2025-06-08 14:22:01', 'disarmed', NULL, NULL),
(207, 1, 'Aktívny', '1749392522.316106s', '2025-06-08 14:22:02', 'disarmed', NULL, NULL),
(208, 1, 'Aktívny', '1749392523.31923s', '2025-06-08 14:22:03', 'disarmed', NULL, NULL),
(209, 1, 'Aktívny', '1749392524.31981s', '2025-06-08 14:22:04', 'disarmed', NULL, NULL),
(210, 1, 'Aktívny', '1749392525.322178s', '2025-06-08 14:22:05', 'disarmed', NULL, NULL),
(211, 1, 'Aktívny', '1749392526.322155s', '2025-06-08 14:22:06', 'disarmed', NULL, NULL),
(212, 1, 'Aktívny', '1749392527.321009s', '2025-06-08 14:22:07', 'disarmed', NULL, NULL),
(213, 1, 'Aktívny', '1749392528.324351s', '2025-06-08 14:22:08', 'disarmed', NULL, NULL),
(214, 1, 'Aktívny', '1749392529.323992s', '2025-06-08 14:22:09', 'disarmed', NULL, NULL),
(215, 1, 'Aktívny', '1749392530.327198s', '2025-06-08 14:22:10', 'disarmed', NULL, NULL),
(216, 0, 'Aktívny', '1749392531.326525s', '2025-06-08 14:22:11', 'disarmed', NULL, NULL),
(217, 1, 'Aktívny', '1749392532.326263s', '2025-06-08 14:22:12', 'disarmed', NULL, NULL),
(218, 0, 'Aktívny', '1749392533.32965s', '2025-06-08 14:22:13', 'disarmed', NULL, NULL),
(219, 1, 'Aktívny', '1749392534.329984s', '2025-06-08 14:22:14', 'disarmed', NULL, NULL),
(220, 0, 'Aktívny', '1749392535.332248s', '2025-06-08 14:22:15', 'disarmed', NULL, NULL),
(221, 0, 'Aktívny', '1749392536.332853s', '2025-06-08 14:22:16', 'disarmed', NULL, NULL),
(222, 0, 'Aktívny', '1749392537.331279s', '2025-06-08 14:22:17', 'disarmed', NULL, NULL),
(223, 0, 'Aktívny', '1749392538.335643s', '2025-06-08 14:22:18', 'disarmed', NULL, NULL),
(224, 1, 'Aktívny', '1749392539.335133s', '2025-06-08 14:22:19', 'disarmed', NULL, NULL),
(225, 1, 'Aktívny', '1749392540.33838s', '2025-06-08 14:22:20', 'disarmed', NULL, NULL),
(226, 1, 'Aktívny', '1749392541.337977s', '2025-06-08 14:22:21', 'disarmed', NULL, NULL),
(227, 1, 'Aktívny', '1749392542.340734s', '2025-06-08 14:22:22', 'disarmed', NULL, NULL),
(228, 1, 'Aktívny', '1749392543.340772s', '2025-06-08 14:22:23', 'disarmed', NULL, NULL),
(229, 1, 'Aktívny', '1749392544.33919s', '2025-06-08 14:22:24', 'disarmed', NULL, NULL),
(230, 1, 'Aktívny', '1749392545.342759s', '2025-06-08 14:22:25', 'disarmed', NULL, NULL),
(231, 1, 'Aktívny', '1749392546.341967s', '2025-06-08 14:22:26', 'disarmed', NULL, NULL),
(232, 1, 'Aktívny', '1749392547.345452s', '2025-06-08 14:22:27', 'disarmed', NULL, NULL),
(233, 1, 'Aktívny', '1749392548.344844s', '2025-06-08 14:22:28', 'disarmed', NULL, NULL),
(234, 1, 'Aktívny', '1749392549.344089s', '2025-06-08 14:22:29', 'disarmed', NULL, NULL),
(235, 1, 'Aktívny', '1749392550.34762s', '2025-06-08 14:22:30', 'disarmed', NULL, NULL),
(236, 1, 'Aktívny', '1749392551.347937s', '2025-06-08 14:22:31', 'disarmed', NULL, NULL),
(237, 1, 'Aktívny', '1749392552.351577s', '2025-06-08 14:22:32', 'disarmed', NULL, NULL),
(238, 1, 'Aktívny', '1749392553.350994s', '2025-06-08 14:22:33', 'disarmed', NULL, NULL),
(239, 1, 'Aktívny', '1749392554.353426s', '2025-06-08 14:22:34', 'disarmed', NULL, NULL),
(240, 1, 'Aktívny', '1749392555.340586s', '2025-06-08 14:22:35', 'disarmed', NULL, NULL),
(241, 1, 'Aktívny', '1749392555.856151s', '2025-06-08 14:22:35', 'disarmed', NULL, NULL),
(242, 1, 'Aktívny', '1749392556.856936s', '2025-06-08 14:22:36', 'disarmed', NULL, NULL),
(243, 1, 'Aktívny', '1749392557.855491s', '2025-06-08 14:22:37', 'disarmed', NULL, NULL),
(244, 1, 'Aktívny', '1749392558.854795s', '2025-06-08 14:22:38', 'disarmed', NULL, NULL),
(245, 0, 'Aktívny', '1749392559.859376s', '2025-06-08 14:22:39', 'disarmed', NULL, NULL),
(246, 1, 'Aktívny', '1749392560.858661s', '2025-06-08 14:22:40', 'disarmed', NULL, NULL),
(247, 1, 'Aktívny', '1749392561.861905s', '2025-06-08 14:22:41', 'disarmed', NULL, NULL),
(248, 1, 'Aktívny', '1749392562.860564s', '2025-06-08 14:22:42', 'disarmed', NULL, NULL),
(249, 1, 'Aktívny', '1749392563.861021s', '2025-06-08 14:22:43', 'disarmed', NULL, NULL),
(250, 1, 'Aktívny', '1749392564.863673s', '2025-06-08 14:22:44', 'disarmed', NULL, NULL),
(251, 1, 'Aktívny', '1749392565.862822s', '2025-06-08 14:22:45', 'disarmed', NULL, NULL),
(252, 1, 'Aktívny', '1749392566.867033s', '2025-06-08 14:22:46', 'disarmed', NULL, NULL),
(253, 1, 'Aktívny', '1749392567.865618s', '2025-06-08 14:22:47', 'disarmed', NULL, NULL),
(254, 1, 'Aktívny', '1749392568.869143s', '2025-06-08 14:22:48', 'disarmed', NULL, NULL),
(255, 1, 'Aktívny', '1749392569.868477s', '2025-06-08 14:22:49', 'disarmed', NULL, NULL),
(256, 1, 'Aktívny', '1749392570.868816s', '2025-06-08 14:22:50', 'disarmed', NULL, NULL),
(257, 1, 'Aktívny', '1749392571.872315s', '2025-06-08 14:22:51', 'disarmed', NULL, NULL),
(258, 1, 'Aktívny', '1749392572.871763s', '2025-06-08 14:22:52', 'disarmed', NULL, NULL),
(259, 1, 'Aktívny', '1749392573.875032s', '2025-06-08 14:22:53', 'disarmed', NULL, NULL),
(260, 1, 'Aktívny', '1749392574.874655s', '2025-06-08 14:22:54', 'disarmed', NULL, NULL),
(261, 1, 'Aktívny', '1749392575.874043s', '2025-06-08 14:22:55', 'disarmed', NULL, NULL),
(262, 1, 'Aktívny', '1749392576.877553s', '2025-06-08 14:22:56', 'disarmed', NULL, NULL),
(263, 1, 'Aktívny', '1749392577.876873s', '2025-06-08 14:22:57', 'disarmed', NULL, NULL),
(264, 1, 'Aktívny', '1749392578.880154s', '2025-06-08 14:22:58', 'disarmed', NULL, NULL),
(265, 1, 'Aktívny', '1749392579.879415s', '2025-06-08 14:22:59', 'disarmed', NULL, NULL),
(266, 1, 'Aktívny', '1749392580.878341s', '2025-06-08 14:23:00', 'disarmed', NULL, NULL),
(267, 1, 'Aktívny', '1749392581.881664s', '2025-06-08 14:23:01', 'disarmed', NULL, NULL),
(268, 1, 'Aktívny', '1749392582.882167s', '2025-06-08 14:23:02', 'disarmed', NULL, NULL),
(269, 1, 'Aktívny', '1749392583.884616s', '2025-06-08 14:23:03', 'disarmed', NULL, NULL),
(270, 1, 'Aktívny', '1749392584.884864s', '2025-06-08 14:23:04', 'disarmed', NULL, NULL),
(271, 1, 'Aktívny', '1749392585.887204s', '2025-06-08 14:23:05', 'disarmed', NULL, NULL),
(272, 1, 'Aktívny', '1749392586.886611s', '2025-06-08 14:23:06', 'disarmed', NULL, NULL),
(273, 1, 'Aktívny', '1749392587.886207s', '2025-06-08 14:23:07', 'disarmed', NULL, NULL),
(274, 1, 'Aktívny', '1749392588.889601s', '2025-06-08 14:23:08', 'disarmed', NULL, NULL),
(275, 1, 'Aktívny', '1749392589.889057s', '2025-06-08 14:23:09', 'disarmed', NULL, NULL),
(276, 1, 'Aktívny', '1749392590.893342s', '2025-06-08 14:23:10', 'disarmed', NULL, NULL),
(277, 1, 'Aktívny', '1749392591.892966s', '2025-06-08 14:23:11', 'disarmed', NULL, NULL),
(278, 1, 'Aktívny', '1749392592.892399s', '2025-06-08 14:23:12', 'disarmed', NULL, NULL),
(279, 1, 'Aktívny', '1749392593.894993s', '2025-06-08 14:23:13', 'disarmed', NULL, NULL),
(280, 1, 'Aktívny', '1749392594.894394s', '2025-06-08 14:23:14', 'disarmed', NULL, NULL),
(281, 1, 'Aktívny', '1749392595.897372s', '2025-06-08 14:23:15', 'disarmed', NULL, NULL),
(282, 1, 'Aktívny', '1749392596.896965s', '2025-06-08 14:23:16', 'disarmed', NULL, NULL),
(283, 1, 'Aktívny', '1749392597.90119s', '2025-06-08 14:23:17', 'disarmed', NULL, NULL),
(284, 1, 'Aktívny', '1749392598.900061s', '2025-06-08 14:23:18', 'disarmed', NULL, NULL),
(285, 1, 'Aktívny', '1749392599.900303s', '2025-06-08 14:23:19', 'disarmed', NULL, NULL),
(286, 1, 'Aktívny', '1749392600.902539s', '2025-06-08 14:23:20', 'disarmed', NULL, NULL),
(287, 1, 'Aktívny', '1749392601.902113s', '2025-06-08 14:23:21', 'disarmed', NULL, NULL),
(288, 1, 'Aktívny', '1749392602.905412s', '2025-06-08 14:23:22', 'disarmed', NULL, NULL),
(289, 1, 'Aktívny', '1749392603.905995s', '2025-06-08 14:23:23', 'disarmed', NULL, NULL),
(290, 1, 'Aktívny', '1749392604.904185s', '2025-06-08 14:23:24', 'disarmed', NULL, NULL),
(291, 1, 'Aktívny', '1749392605.907638s', '2025-06-08 14:23:25', 'disarmed', NULL, NULL),
(292, 1, 'Aktívny', '1749392606.907178s', '2025-06-08 14:23:26', 'disarmed', NULL, NULL),
(293, 1, 'Aktívny', '1749392607.910736s', '2025-06-08 14:23:27', 'disarmed', NULL, NULL),
(294, 1, 'Aktívny', '1749392608.910231s', '2025-06-08 14:23:28', 'disarmed', NULL, NULL),
(295, 1, 'Aktívny', '1749392609.91429s', '2025-06-08 14:23:29', 'disarmed', NULL, NULL),
(296, 1, 'Aktívny', '1749392610.913862s', '2025-06-08 14:23:30', 'disarmed', NULL, NULL),
(297, 1, 'Aktívny', '1749392611.912436s', '2025-06-08 14:23:31', 'disarmed', NULL, NULL),
(298, 1, 'Aktívny', '1749392612.916182s', '2025-06-08 14:23:32', 'disarmed', NULL, NULL),
(299, 1, 'Aktívny', '1749392613.915s', '2025-06-08 14:23:33', 'disarmed', NULL, NULL),
(300, 1, 'Aktívny', '1749392614.918999s', '2025-06-08 14:23:34', 'disarmed', NULL, NULL),
(301, 1, 'Aktívny', '1749392615.917923s', '2025-06-08 14:23:35', 'disarmed', NULL, NULL),
(302, 1, 'Aktívny', '1749392616.917499s', '2025-06-08 14:23:36', 'disarmed', NULL, NULL),
(303, 1, 'Aktívny', '1749392617.920824s', '2025-06-08 14:23:37', 'disarmed', NULL, NULL),
(304, 1, 'Aktívny', '1749392618.920184s', '2025-06-08 14:23:38', 'disarmed', NULL, NULL),
(305, 1, 'Aktívny', '1749392619.923791s', '2025-06-08 14:23:39', 'disarmed', NULL, NULL),
(306, 1, 'Aktívny', '1749392620.922958s', '2025-06-08 14:23:40', 'disarmed', NULL, NULL),
(307, 1, 'Aktívny', '1749392621.92251s', '2025-06-08 14:23:41', 'disarmed', NULL, NULL),
(308, 1, 'Aktívny', '1749392622.925993s', '2025-06-08 14:23:42', 'disarmed', NULL, NULL),
(309, 1, 'Aktívny', '1749392623.926529s', '2025-06-08 14:23:43', 'disarmed', NULL, NULL),
(310, 1, 'Aktívny', '1749392624.928734s', '2025-06-08 14:23:44', 'disarmed', NULL, NULL),
(311, 1, 'Aktívny', '1749392625.928268s', '2025-06-08 14:23:45', 'disarmed', NULL, NULL),
(312, 1, 'Aktívny', '1749392626.932645s', '2025-06-08 14:23:46', 'disarmed', NULL, NULL),
(313, 1, 'Aktívny', '1749392627.93215s', '2025-06-08 14:23:47', 'disarmed', NULL, NULL),
(314, 1, 'Aktívny', '1749392628.930364s', '2025-06-08 14:23:48', 'disarmed', NULL, NULL),
(315, 1, 'Aktívny', '1749392629.934554s', '2025-06-08 14:23:49', 'disarmed', NULL, NULL),
(316, 1, 'Aktívny', '1749392630.933535s', '2025-06-08 14:23:50', 'disarmed', NULL, NULL),
(317, 1, 'Aktívny', '1749392631.936903s', '2025-06-08 14:23:51', 'disarmed', NULL, NULL),
(318, 1, 'Aktívny', '1749392632.936218s', '2025-06-08 14:23:52', 'disarmed', NULL, NULL),
(319, 1, 'Aktívny', '1749392633.935766s', '2025-06-08 14:23:53', 'disarmed', NULL, NULL),
(320, 1, 'Aktívny', '1749392634.940055s', '2025-06-08 14:23:54', 'disarmed', NULL, NULL),
(321, 1, 'Aktívny', '1749392635.938557s', '2025-06-08 14:23:55', 'disarmed', NULL, NULL),
(322, 1, 'Aktívny', '1749392636.942755s', '2025-06-08 14:23:56', 'disarmed', NULL, NULL),
(323, 1, 'Aktívny', '1749392637.942327s', '2025-06-08 14:23:57', 'disarmed', NULL, NULL),
(324, 1, 'Aktívny', '1749392638.944609s', '2025-06-08 14:23:58', 'disarmed', NULL, NULL),
(325, 1, 'Aktívny', '1749392639.94525s', '2025-06-08 14:23:59', 'disarmed', NULL, NULL),
(326, 1, 'Aktívny', '1749392640.943675s', '2025-06-08 14:24:00', 'disarmed', NULL, NULL),
(327, 1, 'Aktívny', '1749392641.946899s', '2025-06-08 14:24:01', 'disarmed', NULL, NULL),
(328, 1, 'Aktívny', '1749392642.946958s', '2025-06-08 14:24:02', 'disarmed', NULL, NULL),
(329, 1, 'Aktívny', '1749392643.950817s', '2025-06-08 14:24:03', 'disarmed', NULL, NULL),
(330, 1, 'Aktívny', '1749392644.950344s', '2025-06-08 14:24:04', 'disarmed', NULL, NULL),
(331, 1, 'Aktívny', '1749392645.949444s', '2025-06-08 14:24:05', 'disarmed', NULL, NULL),
(332, 1, 'Aktívny', '1749392646.953243s', '2025-06-08 14:24:06', 'disarmed', NULL, NULL),
(333, 1, 'Aktívny', '1749392647.952659s', '2025-06-08 14:24:07', 'disarmed', NULL, NULL),
(334, 1, 'Aktívny', '1749392648.955378s', '2025-06-08 14:24:08', 'disarmed', NULL, NULL),
(335, 1, 'Aktívny', '1749392649.955632s', '2025-06-08 14:24:09', 'disarmed', NULL, NULL),
(336, 1, 'Aktívny', '1749392650.958741s', '2025-06-08 14:24:10', 'disarmed', NULL, NULL),
(337, 1, 'Aktívny', '1749392651.958248s', '2025-06-08 14:24:11', 'disarmed', NULL, NULL),
(338, 1, 'Aktívny', '1749392652.956972s', '2025-06-08 14:24:12', 'disarmed', NULL, NULL),
(339, 1, 'Aktívny', '1749392653.960219s', '2025-06-08 14:24:13', 'disarmed', NULL, NULL),
(340, 1, 'Aktívny', '1749392654.959548s', '2025-06-08 14:24:14', 'disarmed', NULL, NULL),
(341, 1, 'Aktívny', '1749392655.962877s', '2025-06-08 14:24:15', 'disarmed', NULL, NULL),
(342, 1, 'Aktívny', '1749392656.963104s', '2025-06-08 14:24:16', 'disarmed', NULL, NULL),
(343, 1, 'Aktívny', '1749392732.154277s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(344, 1, 'Aktívny', '1749392732.157945s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(345, 1, 'Aktívny', '1749392732.159495s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(346, 1, 'Aktívny', '1749392732.161024s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(347, 1, 'Aktívny', '1749392732.162484s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(348, 1, 'Aktívny', '1749392732.163867s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(349, 1, 'Aktívny', '1749392732.165302s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(350, 1, 'Aktívny', '1749392732.166754s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(351, 1, 'Aktívny', '1749392732.168275s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(352, 1, 'Aktívny', '1749392732.169808s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(353, 1, 'Aktívny', '1749392732.171414s', '2025-06-08 14:25:32', 'disarmed', NULL, NULL),
(354, 1, 'Aktívny', '1749392733.809452s', '2025-06-08 14:25:33', 'disarmed', NULL, NULL),
(355, 1, 'Aktívny', '1749392734.812734s', '2025-06-08 14:25:34', 'disarmed', NULL, NULL),
(356, 1, 'Aktívny', '1749392735.81229s', '2025-06-08 14:25:35', 'disarmed', NULL, NULL),
(357, 1, 'Aktívny', '1749392736.81188s', '2025-06-08 14:25:36', 'disarmed', NULL, NULL),
(358, 1, 'Aktívny', '1749392737.814747s', '2025-06-08 14:25:37', 'disarmed', NULL, NULL),
(359, 1, 'Aktívny', '1749392738.814263s', '2025-06-08 14:25:38', 'disarmed', NULL, NULL),
(360, 1, 'Aktívny', '1749392739.817709s', '2025-06-08 14:25:39', 'disarmed', NULL, NULL),
(361, 1, 'Aktívny', '1749392740.816392s', '2025-06-08 14:25:40', 'disarmed', NULL, NULL),
(362, 1, 'Aktívny', '1749392741.817562s', '2025-06-08 14:25:41', 'disarmed', NULL, NULL),
(363, 1, 'Aktívny', '1749392742.819894s', '2025-06-08 14:25:42', 'disarmed', NULL, NULL),
(364, 1, 'Aktívny', '1749392743.819168s', '2025-06-08 14:25:43', 'disarmed', NULL, NULL),
(365, 1, 'Aktívny', '1749392744.822159s', '2025-06-08 14:25:44', 'disarmed', NULL, NULL),
(366, 1, 'Aktívny', '1749392745.822797s', '2025-06-08 14:25:45', 'disarmed', NULL, NULL),
(367, 1, 'Aktívny', '1749392746.824872s', '2025-06-08 14:25:46', 'disarmed', NULL, NULL),
(368, 1, 'Aktívny', '1749392747.824587s', '2025-06-08 14:25:47', 'disarmed', NULL, NULL),
(369, 1, 'Aktívny', '1749392748.824705s', '2025-06-08 14:25:48', 'disarmed', NULL, NULL),
(370, 1, 'Aktívny', '1749392749.828249s', '2025-06-08 14:25:49', 'disarmed', NULL, NULL),
(371, 1, 'Aktívny', '1749392750.827726s', '2025-06-08 14:25:50', 'disarmed', NULL, NULL),
(372, 1, 'Aktívny', '1749392751.830165s', '2025-06-08 14:25:51', 'disarmed', NULL, NULL),
(373, 1, 'Aktívny', '1749392752.830611s', '2025-06-08 14:25:52', 'disarmed', NULL, NULL),
(374, 1, 'Aktívny', '1749392753.830038s', '2025-06-08 14:25:53', 'disarmed', NULL, NULL),
(375, 1, 'Aktívny', '1749392754.833379s', '2025-06-08 14:25:54', 'disarmed', NULL, NULL),
(376, 1, 'Aktívny', '1749392755.831788s', '2025-06-08 14:25:55', 'disarmed', NULL, NULL),
(377, 1, 'Aktívny', '1749392756.836097s', '2025-06-08 14:25:56', 'disarmed', NULL, NULL),
(378, 1, 'Aktívny', '1749392757.834725s', '2025-06-08 14:25:57', 'disarmed', NULL, NULL),
(379, 1, 'Aktívny', '1749392758.83805s', '2025-06-08 14:25:58', 'disarmed', NULL, NULL),
(380, 1, 'Aktívny', '1749392759.837466s', '2025-06-08 14:25:59', 'disarmed', NULL, NULL),
(381, 1, 'Aktívny', '1749392760.836853s', '2025-06-08 14:26:00', 'disarmed', NULL, NULL),
(382, 1, 'Aktívny', '1749392761.84186s', '2025-06-08 14:26:01', 'disarmed', NULL, NULL),
(383, 1, 'Aktívny', '1749392762.839608s', '2025-06-08 14:26:02', 'disarmed', NULL, NULL),
(384, 1, 'Aktívny', '1749392763.844103s', '2025-06-08 14:26:03', 'disarmed', NULL, NULL),
(385, 1, 'Aktívny', '1749392764.84273s', '2025-06-08 14:26:04', 'disarmed', NULL, NULL),
(386, 1, 'Aktívny', '1749392765.843029s', '2025-06-08 14:26:05', 'disarmed', NULL, NULL),
(387, 1, 'Aktívny', '1749392766.846365s', '2025-06-08 14:26:06', 'disarmed', NULL, NULL),
(388, 1, 'Aktívny', '1749392767.845917s', '2025-06-08 14:26:07', 'disarmed', NULL, NULL),
(389, 1, 'Aktívny', '1749392768.848382s', '2025-06-08 14:26:08', 'disarmed', NULL, NULL),
(390, 1, 'Aktívny', '1749392769.84877s', '2025-06-08 14:26:09', 'disarmed', NULL, NULL),
(391, 1, 'Aktívny', '1749392770.848253s', '2025-06-08 14:26:10', 'disarmed', NULL, NULL),
(392, 1, 'Aktívny', '1749392771.85051s', '2025-06-08 14:26:11', 'disarmed', NULL, NULL),
(393, 1, 'Aktívny', '1749392772.850735s', '2025-06-08 14:26:12', 'disarmed', NULL, NULL),
(394, 1, 'Aktívny', '1749392773.853389s', '2025-06-08 14:26:13', 'disarmed', NULL, NULL),
(395, 1, 'Aktívny', '1749392774.852765s', '2025-06-08 14:26:14', 'disarmed', NULL, NULL),
(396, 1, 'Aktívny', '1749392775.857006s', '2025-06-08 14:26:15', 'disarmed', NULL, NULL),
(397, 0, 'Aktívny', '1749392776.856086s', '2025-06-08 14:26:16', 'disarmed', NULL, NULL),
(398, 1, 'Aktívny', '1749392777.856219s', '2025-06-08 14:26:17', 'disarmed', NULL, NULL),
(399, 1, 'Aktívny', '1749392778.858488s', '2025-06-08 14:26:18', 'disarmed', NULL, NULL),
(400, 1, 'Aktívny', '1749392779.857832s', '2025-06-08 14:26:19', 'disarmed', NULL, NULL),
(401, 1, 'Aktívny', '1749392780.861321s', '2025-06-08 14:26:20', 'disarmed', NULL, NULL),
(402, 1, 'Aktívny', '1749392781.860775s', '2025-06-08 14:26:21', 'disarmed', NULL, NULL),
(403, 1, 'Aktívny', '1749392782.86139s', '2025-06-08 14:26:22', 'disarmed', NULL, NULL),
(404, 1, 'Aktívny', '1749392783.864666s', '2025-06-08 14:26:23', 'disarmed', NULL, NULL),
(405, 1, 'Aktívny', '1749392784.853275s', '2025-06-08 14:26:24', 'disarmed', NULL, NULL),
(406, 1, 'Aktívny', '1749392785.369085s', '2025-06-08 14:26:25', 'disarmed', NULL, NULL),
(407, 1, 'Aktívny', '1749392786.366163s', '2025-06-08 14:26:26', 'disarmed', NULL, NULL),
(408, 1, 'Aktívny', '1749392787.365559s', '2025-06-08 14:26:27', 'disarmed', NULL, NULL),
(409, 0, 'Aktívny', '1749392788.369251s', '2025-06-08 14:26:28', 'disarmed', NULL, NULL),
(410, 1, 'Aktívny', '1749392789.369577s', '2025-06-08 14:26:29', 'disarmed', NULL, NULL),
(411, 1, 'Aktívny', '1749392790.371809s', '2025-06-08 14:26:30', 'disarmed', NULL, NULL),
(412, 1, 'Aktívny', '1749392791.371278s', '2025-06-08 14:26:31', 'disarmed', NULL, NULL),
(413, 1, 'Aktívny', '1749392792.370745s', '2025-06-08 14:26:32', 'disarmed', NULL, NULL),
(414, 1, 'Aktívny', '1749392793.374235s', '2025-06-08 14:26:33', 'disarmed', NULL, NULL),
(415, 1, 'Aktívny', '1749392794.374429s', '2025-06-08 14:26:34', 'disarmed', NULL, NULL),
(416, 1, 'Aktívny', '1749392795.377432s', '2025-06-08 14:26:35', 'disarmed', NULL, NULL),
(417, 1, 'Aktívny', '1749392796.376992s', '2025-06-08 14:26:36', 'disarmed', NULL, NULL),
(418, 1, 'Aktívny', '1749392797.377007s', '2025-06-08 14:26:37', 'disarmed', NULL, NULL),
(419, 1, 'Aktívny', '1749392798.379422s', '2025-06-08 14:26:38', 'disarmed', NULL, NULL),
(420, 1, 'Aktívny', '1749392799.379866s', '2025-06-08 14:26:39', 'disarmed', NULL, NULL),
(421, 1, 'Aktívny', '1749392800.383046s', '2025-06-08 14:26:40', 'disarmed', NULL, NULL),
(422, 1, 'Aktívny', '1749392801.381705s', '2025-06-08 14:26:41', 'disarmed', NULL, NULL),
(423, 1, 'Aktívny', '1749392802.385883s', '2025-06-08 14:26:42', 'disarmed', NULL, NULL),
(424, 1, 'Aktívny', '1749392803.384817s', '2025-06-08 14:26:43', 'disarmed', NULL, NULL),
(425, 1, 'Aktívny', '1749392804.384544s', '2025-06-08 14:26:44', 'disarmed', NULL, NULL),
(426, 1, 'Aktívny', '1749392805.388281s', '2025-06-08 14:26:45', 'disarmed', NULL, NULL),
(427, 1, 'Aktívny', '1749392806.386794s', '2025-06-08 14:26:46', 'disarmed', NULL, NULL),
(428, 1, 'Aktívny', '1749392807.391077s', '2025-06-08 14:26:47', 'disarmed', NULL, NULL),
(429, 1, 'Aktívny', '1749392808.39033s', '2025-06-08 14:26:48', 'disarmed', NULL, NULL),
(430, 1, 'Aktívny', '1749392809.388998s', '2025-06-08 14:26:49', 'disarmed', NULL, NULL),
(431, 1, 'Aktívny', '1749392810.392572s', '2025-06-08 14:26:50', 'disarmed', NULL, NULL),
(432, 1, 'Aktívny', '1749392811.393033s', '2025-06-08 14:26:51', 'disarmed', NULL, NULL),
(433, 1, 'Aktívny', '1749392812.396142s', '2025-06-08 14:26:52', 'disarmed', NULL, NULL),
(434, 1, 'Aktívny', '1749392813.395715s', '2025-06-08 14:26:53', 'disarmed', NULL, NULL),
(435, 1, 'Aktívny', '1749392814.399003s', '2025-06-08 14:26:54', 'disarmed', NULL, NULL),
(436, 1, 'Aktívny', '1749392815.398503s', '2025-06-08 14:26:55', 'disarmed', NULL, NULL),
(437, 1, 'Aktívny', '1749392816.397055s', '2025-06-08 14:26:56', 'disarmed', NULL, NULL),
(438, 1, 'Aktívny', '1749392817.400413s', '2025-06-08 14:26:57', 'disarmed', NULL, NULL),
(439, 1, 'Aktívny', '1749392818.399808s', '2025-06-08 14:26:58', 'disarmed', NULL, NULL),
(440, 1, 'Aktívny', '1749392819.404016s', '2025-06-08 14:26:59', 'disarmed', NULL, NULL),
(441, 1, 'Aktívny', '1749392820.403738s', '2025-06-08 14:27:00', 'disarmed', NULL, NULL),
(442, 1, 'Aktívny', '1749392821.403374s', '2025-06-08 14:27:01', 'disarmed', NULL, NULL),
(443, 1, 'Aktívny', '1749392822.405593s', '2025-06-08 14:27:02', 'disarmed', NULL, NULL),
(444, 1, 'Aktívny', '1749392823.405316s', '2025-06-08 14:27:03', 'disarmed', NULL, NULL),
(445, 1, 'Aktívny', '1749392824.408367s', '2025-06-08 14:27:04', 'disarmed', NULL, NULL),
(446, 1, 'Aktívny', '1749392825.408858s', '2025-06-08 14:27:05', 'disarmed', NULL, NULL),
(447, 1, 'Aktívny', '1749392826.411408s', '2025-06-08 14:27:06', 'disarmed', NULL, NULL),
(448, 1, 'Aktívny', '1749392827.410597s', '2025-06-08 14:27:07', 'disarmed', NULL, NULL),
(449, 1, 'Aktívny', '1749392828.410259s', '2025-06-08 14:27:08', 'disarmed', NULL, NULL),
(450, 1, 'Aktívny', '1749392829.414617s', '2025-06-08 14:27:09', 'disarmed', NULL, NULL),
(451, 1, 'Aktívny', '1749392830.414202s', '2025-06-08 14:27:10', 'disarmed', NULL, NULL),
(452, 1, 'Aktívny', '1749392831.416362s', '2025-06-08 14:27:11', 'disarmed', NULL, NULL),
(453, 1, 'Aktívny', '1749392832.416706s', '2025-06-08 14:27:12', 'disarmed', NULL, NULL),
(454, 1, 'Aktívny', '1749392833.415659s', '2025-06-08 14:27:13', 'disarmed', NULL, NULL),
(455, 1, 'Aktívny', '1749392834.419542s', '2025-06-08 14:27:14', 'disarmed', NULL, NULL),
(456, 1, 'Aktívny', '1749392835.418064s', '2025-06-08 14:27:15', 'disarmed', NULL, NULL),
(457, 1, 'Aktívny', '1749392836.42168s', '2025-06-08 14:27:16', 'disarmed', NULL, NULL),
(458, 1, 'Aktívny', '1749392837.420977s', '2025-06-08 14:27:17', 'disarmed', NULL, NULL),
(459, 1, 'Aktívny', '1749392838.421359s', '2025-06-08 14:27:18', 'disarmed', NULL, NULL),
(460, 1, 'Aktívny', '1749392839.423933s', '2025-06-08 14:27:19', 'disarmed', NULL, NULL),
(461, 1, 'Aktívny', '1749392840.423161s', '2025-06-08 14:27:20', 'disarmed', NULL, NULL),
(462, 1, 'Aktívny', '1749392841.426609s', '2025-06-08 14:27:21', 'disarmed', NULL, NULL),
(463, 1, 'Aktívny', '1749392842.426052s', '2025-06-08 14:27:22', 'disarmed', NULL, NULL),
(464, 1, 'Aktívny', '1749392843.429477s', '2025-06-08 14:27:23', 'disarmed', NULL, NULL),
(465, 1, 'Aktívny', '1749392844.429385s', '2025-06-08 14:27:24', 'disarmed', NULL, NULL),
(466, 1, 'Aktívny', '1749392845.428307s', '2025-06-08 14:27:25', 'disarmed', NULL, NULL),
(467, 1, 'Aktívny', '1749392846.43211s', '2025-06-08 14:27:26', 'disarmed', NULL, NULL),
(468, 1, 'Aktívny', '1749392847.431174s', '2025-06-08 14:27:27', 'disarmed', NULL, NULL),
(469, 1, 'Aktívny', '1749392848.43457s', '2025-06-08 14:27:28', 'disarmed', NULL, NULL),
(470, 1, 'Aktívny', '1749392849.434597s', '2025-06-08 14:27:29', 'disarmed', NULL, NULL),
(471, 1, 'Aktívny', '1749392850.434445s', '2025-06-08 14:27:30', 'disarmed', NULL, NULL),
(472, 1, 'Aktívny', '1749392851.437614s', '2025-06-08 14:27:31', 'disarmed', NULL, NULL),
(473, 1, 'Aktívny', '1749392852.437018s', '2025-06-08 14:27:32', 'disarmed', NULL, NULL),
(474, 1, 'Aktívny', '1749392853.440524s', '2025-06-08 14:27:33', 'disarmed', NULL, NULL),
(475, 1, 'Aktívny', '1749392854.440066s', '2025-06-08 14:27:34', 'disarmed', NULL, NULL),
(476, 1, 'Aktívny', '1749392855.442534s', '2025-06-08 14:27:35', 'disarmed', NULL, NULL),
(477, 1, 'Aktívny', '1749392856.441913s', '2025-06-08 14:27:36', 'disarmed', NULL, NULL),
(478, 1, 'Aktívny', '1749392857.441414s', '2025-06-08 14:27:37', 'disarmed', NULL, NULL),
(479, 1, 'Aktívny', '1749392858.444808s', '2025-06-08 14:27:38', 'disarmed', NULL, NULL),
(480, 1, 'Aktívny', '1749392859.44424s', '2025-06-08 14:27:39', 'disarmed', NULL, NULL),
(481, 1, 'Aktívny', '1749392860.447818s', '2025-06-08 14:27:40', 'disarmed', NULL, NULL),
(482, 1, 'Aktívny', '1749392861.447171s', '2025-06-08 14:27:41', 'disarmed', NULL, NULL),
(483, 1, 'Aktívny', '1749392862.446606s', '2025-06-08 14:27:42', 'disarmed', NULL, NULL),
(484, 1, 'Aktívny', '1749392863.450928s', '2025-06-08 14:27:43', 'disarmed', NULL, NULL),
(485, 1, 'Aktívny', '1749392864.449401s', '2025-06-08 14:27:44', 'disarmed', NULL, NULL),
(486, 1, 'Aktívny', '1749392865.452802s', '2025-06-08 14:27:45', 'disarmed', NULL, NULL),
(487, 1, 'Aktívny', '1749392866.452368s', '2025-06-08 14:27:46', 'disarmed', NULL, NULL),
(488, 1, 'Aktívny', '1749392867.455783s', '2025-06-08 14:27:47', 'disarmed', NULL, NULL),
(489, 1, 'Aktívny', '1749392868.455303s', '2025-06-08 14:27:48', 'disarmed', NULL, NULL),
(490, 1, 'Aktívny', '1749392869.454426s', '2025-06-08 14:27:49', 'disarmed', NULL, NULL),
(491, 1, 'Aktívny', '1749392870.458295s', '2025-06-08 14:27:50', 'disarmed', NULL, NULL),
(492, 1, 'Aktívny', '1749392871.457393s', '2025-06-08 14:27:51', 'disarmed', NULL, NULL),
(493, 1, 'Aktívny', '1749392872.460704s', '2025-06-08 14:27:52', 'disarmed', NULL, NULL),
(494, 1, 'Aktívny', '1749392873.460165s', '2025-06-08 14:27:53', 'disarmed', NULL, NULL),
(495, 1, 'Aktívny', '1749392874.460816s', '2025-06-08 14:27:54', 'disarmed', NULL, NULL),
(496, 1, 'Aktívny', '1749392875.46287s', '2025-06-08 14:27:55', 'disarmed', NULL, NULL),
(497, 1, 'Aktívny', '1749392876.462481s', '2025-06-08 14:27:56', 'disarmed', NULL, NULL),
(498, 1, 'Aktívny', '1749392877.465831s', '2025-06-08 14:27:57', 'disarmed', NULL, NULL),
(499, 1, 'Aktívny', '1749392878.465337s', '2025-06-08 14:27:58', 'disarmed', NULL, NULL),
(500, 1, 'Aktívny', '1749392879.469073s', '2025-06-08 14:27:59', 'disarmed', NULL, NULL),
(501, 1, 'Aktívny', '1749392880.468735s', '2025-06-08 14:28:00', 'disarmed', NULL, NULL),
(502, 1, 'Aktívny', '1749392881.467544s', '2025-06-08 14:28:01', 'disarmed', NULL, NULL),
(503, 1, 'Aktívny', '1749392882.471323s', '2025-06-08 14:28:02', 'disarmed', NULL, NULL),
(504, 1, 'Aktívny', '1749392883.470755s', '2025-06-08 14:28:03', 'disarmed', NULL, NULL),
(505, 1, 'Aktívny', '1749392884.474636s', '2025-06-08 14:28:04', 'disarmed', NULL, NULL),
(506, 1, 'Aktívny', '1749392885.473265s', '2025-06-08 14:28:05', 'disarmed', NULL, NULL),
(507, 1, 'Aktívny', '1749392886.472714s', '2025-06-08 14:28:06', 'disarmed', NULL, NULL),
(508, 1, 'Aktívny', '1749392887.476944s', '2025-06-08 14:28:07', 'disarmed', NULL, NULL),
(509, 1, 'Aktívny', '1749392888.47626s', '2025-06-08 14:28:08', 'disarmed', NULL, NULL),
(510, 1, 'Aktívny', '1749392889.47904s', '2025-06-08 14:28:09', 'disarmed', NULL, NULL),
(511, 1, 'Aktívny', '1749392890.479128s', '2025-06-08 14:28:10', 'disarmed', NULL, NULL),
(512, 1, 'Aktívny', '1749392891.478706s', '2025-06-08 14:28:11', 'disarmed', NULL, NULL),
(513, 1, 'Aktívny', '1749392892.481167s', '2025-06-08 14:28:12', 'disarmed', NULL, NULL),
(514, 1, 'Aktívny', '1749392893.480756s', '2025-06-08 14:28:13', 'disarmed', NULL, NULL),
(515, 1, 'Aktívny', '1749392894.484507s', '2025-06-08 14:28:14', 'disarmed', NULL, NULL),
(516, 1, 'Aktívny', '1749392895.483893s', '2025-06-08 14:28:15', 'disarmed', NULL, NULL),
(517, 1, 'Aktívny', '1749392896.487004s', '2025-06-08 14:28:16', 'disarmed', NULL, NULL),
(518, 1, 'Aktívny', '1749392897.486414s', '2025-06-08 14:28:17', 'disarmed', NULL, NULL),
(519, 1, 'Aktívny', '1749392898.48591s', '2025-06-08 14:28:18', 'disarmed', NULL, NULL),
(520, 1, 'Aktívny', '1749392899.490204s', '2025-06-08 14:28:19', 'disarmed', NULL, NULL),
(521, 1, 'Aktívny', '1749392900.489603s', '2025-06-08 14:28:20', 'disarmed', NULL, NULL),
(522, 1, 'Aktívny', '1749392901.49288s', '2025-06-08 14:28:21', 'disarmed', NULL, NULL),
(523, 1, 'Aktívny', '1749392902.492325s', '2025-06-08 14:28:22', 'disarmed', NULL, NULL),
(524, 1, 'Aktívny', '1749392903.490894s', '2025-06-08 14:28:23', 'disarmed', NULL, NULL),
(525, 1, 'Aktívny', '1749392904.495298s', '2025-06-08 14:28:24', 'disarmed', NULL, NULL),
(526, 1, 'Aktívny', '1749392905.493856s', '2025-06-08 14:28:25', 'disarmed', NULL, NULL),
(527, 1, 'Aktívny', '1749392906.497799s', '2025-06-08 14:28:26', 'disarmed', NULL, NULL),
(528, 1, 'Aktívny', '1749392907.497586s', '2025-06-08 14:28:27', 'disarmed', NULL, NULL),
(529, 1, 'Aktívny', '1749392908.501084s', '2025-06-08 14:28:28', 'disarmed', NULL, NULL),
(530, 1, 'Aktívny', '1749392909.499561s', '2025-06-08 14:28:29', 'disarmed', NULL, NULL),
(531, 1, 'Aktívny', '1749392910.499941s', '2025-06-08 14:28:30', 'disarmed', NULL, NULL),
(532, 1, 'Aktívny', '1749392911.502339s', '2025-06-08 14:28:31', 'disarmed', NULL, NULL),
(533, 1, 'Aktívny', '1749392912.502719s', '2025-06-08 14:28:32', 'disarmed', NULL, NULL),
(534, 1, 'Aktívny', '1749392913.50561s', '2025-06-08 14:28:33', 'disarmed', NULL, NULL),
(535, 1, 'Aktívny', '1749392914.504582s', '2025-06-08 14:28:34', 'disarmed', NULL, NULL),
(536, 1, 'Aktívny', '1749392915.504325s', '2025-06-08 14:28:35', 'disarmed', NULL, NULL),
(537, 1, 'Aktívny', '1749392916.507773s', '2025-06-08 14:28:36', 'disarmed', NULL, NULL),
(538, 1, 'Aktívny', '1749392917.506876s', '2025-06-08 14:28:37', 'disarmed', NULL, NULL),
(539, 1, 'Aktívny', '1749392918.510207s', '2025-06-08 14:28:38', 'disarmed', NULL, NULL),
(540, 1, 'Aktívny', '1749392919.510794s', '2025-06-08 14:28:39', 'disarmed', NULL, NULL),
(541, 1, 'Aktívny', '1749392920.513067s', '2025-06-08 14:28:40', 'disarmed', NULL, NULL),
(542, 1, 'Aktívny', '1749392921.512508s', '2025-06-08 14:28:41', 'disarmed', NULL, NULL),
(543, 1, 'Aktívny', '1749392922.512074s', '2025-06-08 14:28:42', 'disarmed', NULL, NULL),
(544, 1, 'Aktívny', '1749392923.515486s', '2025-06-08 14:28:43', 'disarmed', NULL, NULL),
(545, 1, 'Aktívny', '1749392924.514813s', '2025-06-08 14:28:44', 'disarmed', NULL, NULL),
(546, 1, 'Aktívny', '1749392925.518995s', '2025-06-08 14:28:45', 'disarmed', NULL, NULL),
(547, 1, 'Aktívny', '1749392926.517971s', '2025-06-08 14:28:46', 'disarmed', NULL, NULL),
(548, 1, 'Aktívny', '1749392927.517068s', '2025-06-08 14:28:47', 'disarmed', NULL, NULL),
(549, 1, 'Aktívny', '1749392928.520387s', '2025-06-08 14:28:48', 'disarmed', NULL, NULL),
(550, 1, 'Aktívny', '1749392929.52012s', '2025-06-08 14:28:49', 'disarmed', NULL, NULL),
(551, 1, 'Aktívny', '1749392930.523339s', '2025-06-08 14:28:50', 'disarmed', NULL, NULL),
(552, 1, 'Aktívny', '1749392931.522808s', '2025-06-08 14:28:51', 'disarmed', NULL, NULL),
(553, 1, 'Aktívny', '1749392932.526194s', '2025-06-08 14:28:52', 'disarmed', NULL, NULL),
(554, 1, 'Aktívny', '1749392933.525679s', '2025-06-08 14:28:53', 'disarmed', NULL, NULL),
(555, 1, 'Aktívny', '1749392934.52523s', '2025-06-08 14:28:54', 'disarmed', NULL, NULL),
(556, 1, 'Aktívny', '1749392935.528664s', '2025-06-08 14:28:55', 'disarmed', NULL, NULL),
(557, 1, 'Aktívny', '1749392936.532929s', '2025-06-08 14:28:56', 'disarmed', NULL, NULL),
(558, 1, 'Aktívny', '1749392937.531336s', '2025-06-08 14:28:57', 'disarmed', NULL, NULL),
(559, 1, 'Aktívny', '1749392938.530746s', '2025-06-08 14:28:58', 'disarmed', NULL, NULL),
(560, 1, 'Aktívny', '1749392939.530448s', '2025-06-08 14:28:59', 'disarmed', NULL, NULL),
(561, 1, 'Aktívny', '1749392940.534162s', '2025-06-08 14:29:00', 'disarmed', NULL, NULL),
(562, 1, 'Aktívny', '1749392941.533676s', '2025-06-08 14:29:01', 'disarmed', NULL, NULL),
(563, 1, 'Aktívny', '1749392942.536198s', '2025-06-08 14:29:02', 'disarmed', NULL, NULL),
(564, 1, 'Aktívny', '1749392943.536062s', '2025-06-08 14:29:03', 'disarmed', NULL, NULL),
(565, 1, 'Aktívny', '1749392944.535073s', '2025-06-08 14:29:04', 'disarmed', NULL, NULL),
(566, 1, 'Aktívny', '1749392945.538603s', '2025-06-08 14:29:05', 'disarmed', NULL, NULL),
(567, 1, 'Aktívny', '1749392946.5381s', '2025-06-08 14:29:06', 'disarmed', NULL, NULL),
(568, 1, 'Aktívny', '1749392947.541476s', '2025-06-08 14:29:07', 'disarmed', NULL, NULL),
(569, 1, 'Aktívny', '1749392948.542172s', '2025-06-08 14:29:08', 'disarmed', NULL, NULL),
(570, 1, 'Aktívny', '1749392949.544508s', '2025-06-08 14:29:09', 'disarmed', NULL, NULL),
(571, 1, 'Aktívny', '1749392950.543694s', '2025-06-08 14:29:10', 'disarmed', NULL, NULL),
(572, 1, 'Aktívny', '1749392951.5432s', '2025-06-08 14:29:11', 'disarmed', NULL, NULL),
(573, 1, 'Aktívny', '1749392952.546682s', '2025-06-08 14:29:12', 'disarmed', NULL, NULL),
(574, 1, 'Aktívny', '1749392953.545931s', '2025-06-08 14:29:13', 'disarmed', NULL, NULL),
(575, 1, 'Aktívny', '1749392954.549499s', '2025-06-08 14:29:14', 'disarmed', NULL, NULL),
(576, 1, 'Aktívny', '1749392955.549895s', '2025-06-08 14:29:15', 'disarmed', NULL, NULL),
(577, 1, 'Aktívny', '1749392956.549369s', '2025-06-08 14:29:16', 'disarmed', NULL, NULL),
(578, 1, 'Aktívny', '1749392957.552694s', '2025-06-08 14:29:17', 'disarmed', NULL, NULL),
(579, 1, 'Aktívny', '1749392958.55217s', '2025-06-08 14:29:18', 'disarmed', NULL, NULL),
(580, 1, 'Aktívny', '1749392959.555537s', '2025-06-08 14:29:19', 'disarmed', NULL, NULL),
(581, 1, 'Aktívny', '1749392960.554109s', '2025-06-08 14:29:20', 'disarmed', NULL, NULL),
(582, 1, 'Aktívny', '1749392961.558328s', '2025-06-08 14:29:21', 'disarmed', NULL, NULL),
(583, 1, 'Aktívny', '1749392962.558317s', '2025-06-08 14:29:22', 'disarmed', NULL, NULL),
(584, 1, 'Aktívny', '1749392963.556408s', '2025-06-08 14:29:23', 'disarmed', NULL, NULL),
(585, 1, 'Aktívny', '1749392964.55964s', '2025-06-08 14:29:24', 'disarmed', NULL, NULL),
(586, 1, 'Aktívny', '1749392965.559198s', '2025-06-08 14:29:25', 'disarmed', NULL, NULL),
(587, 1, 'Aktívny', '1749392966.563371s', '2025-06-08 14:29:26', 'disarmed', NULL, NULL),
(588, 1, 'Aktívny', '1749392967.564235s', '2025-06-08 14:29:27', 'disarmed', NULL, NULL),
(589, 1, 'Aktívny', '1749392968.561345s', '2025-06-08 14:29:28', 'disarmed', NULL, NULL),
(590, 1, 'Aktívny', '1749392969.564737s', '2025-06-08 14:29:29', 'disarmed', NULL, NULL),
(591, 1, 'Aktívny', '1749392970.564151s', '2025-06-08 14:29:30', 'disarmed', NULL, NULL),
(592, 1, 'Aktívny', '1749392971.568185s', '2025-06-08 14:29:31', 'disarmed', NULL, NULL),
(593, 1, 'Aktívny', '1749392972.567058s', '2025-06-08 14:29:32', 'disarmed', NULL, NULL),
(594, 1, 'Aktívny', '1749392973.570605s', '2025-06-08 14:29:33', 'disarmed', NULL, NULL),
(595, 1, 'Aktívny', '1749392974.569997s', '2025-06-08 14:29:34', 'disarmed', NULL, NULL),
(596, 1, 'Aktívny', '1749392975.570487s', '2025-06-08 14:29:35', 'disarmed', NULL, NULL),
(597, 1, 'Aktívny', '1749392976.572692s', '2025-06-08 14:29:36', 'disarmed', NULL, NULL),
(598, 1, 'Aktívny', '1749392977.573255s', '2025-06-08 14:29:37', 'disarmed', NULL, NULL),
(599, 1, 'Aktívny', '1749392978.5757s', '2025-06-08 14:29:38', 'disarmed', NULL, NULL),
(600, 1, 'Aktívny', '1749392979.576196s', '2025-06-08 14:29:39', 'disarmed', NULL, NULL),
(601, 1, 'Aktívny', '1749392980.574573s', '2025-06-08 14:29:40', 'disarmed', NULL, NULL),
(602, 1, 'Aktívny', '1749392981.578866s', '2025-06-08 14:29:41', 'disarmed', NULL, NULL),
(603, 1, 'Aktívny', '1749392982.578504s', '2025-06-08 14:29:42', 'disarmed', NULL, NULL),
(604, 1, 'Aktívny', '1749392983.581703s', '2025-06-08 14:29:43', 'disarmed', NULL, NULL),
(605, 1, 'Aktívny', '1749392984.580232s', '2025-06-08 14:29:44', 'disarmed', NULL, NULL),
(606, 1, 'Aktívny', '1749392985.583656s', '2025-06-08 14:29:45', 'disarmed', NULL, NULL),
(607, 1, 'Aktívny', '1749392986.583066s', '2025-06-08 14:29:46', 'disarmed', NULL, NULL),
(608, 1, 'Aktívny', '1749392987.582457s', '2025-06-08 14:29:47', 'disarmed', NULL, NULL),
(609, 1, 'Aktívny', '1749392988.585948s', '2025-06-08 14:29:48', 'disarmed', NULL, NULL),
(610, 1, 'Aktívny', '1749392989.585774s', '2025-06-08 14:29:49', 'disarmed', NULL, NULL),
(611, 1, 'Aktívny', '1749392990.589636s', '2025-06-08 14:29:50', 'disarmed', NULL, NULL),
(612, 1, 'Aktívny', '1749392991.589042s', '2025-06-08 14:29:51', 'disarmed', NULL, NULL),
(613, 1, 'Aktívny', '1749392992.58871s', '2025-06-08 14:29:52', 'disarmed', NULL, NULL),
(614, 1, 'Aktívny', '1749392993.59152s', '2025-06-08 14:29:53', 'disarmed', NULL, NULL),
(615, 1, 'Aktívny', '1749392994.591441s', '2025-06-08 14:29:54', 'disarmed', NULL, NULL),
(616, 1, 'Aktívny', '1749392995.594186s', '2025-06-08 14:29:55', 'disarmed', NULL, NULL),
(617, 1, 'Aktívny', '1749392996.594559s', '2025-06-08 14:29:56', 'disarmed', NULL, NULL),
(618, 1, 'Aktívny', '1749392997.593791s', '2025-06-08 14:29:57', 'disarmed', NULL, NULL),
(619, 1, 'Aktívny', '1749392998.595972s', '2025-06-08 14:29:58', 'disarmed', NULL, NULL),
(620, 1, 'Aktívny', '1749392999.596627s', '2025-06-08 14:29:59', 'disarmed', NULL, NULL),
(621, 1, 'Aktívny', '1749393000.599931s', '2025-06-08 14:30:00', 'disarmed', NULL, NULL),
(622, 1, 'Aktívny', '1749393001.59837s', '2025-06-08 14:30:01', 'disarmed', NULL, NULL),
(623, 1, 'Aktívny', '1749393002.601695s', '2025-06-08 14:30:02', 'disarmed', NULL, NULL),
(624, 1, 'Aktívny', '1749393003.601116s', '2025-06-08 14:30:03', 'disarmed', NULL, NULL),
(625, 1, 'Aktívny', '1749393004.601747s', '2025-06-08 14:30:04', 'disarmed', NULL, NULL),
(626, 1, 'Aktívny', '1749393005.605135s', '2025-06-08 14:30:05', 'disarmed', NULL, NULL),
(627, 1, 'Aktívny', '1749393006.603477s', '2025-06-08 14:30:06', 'disarmed', NULL, NULL),
(628, 1, 'Aktívny', '1749393007.607851s', '2025-06-08 14:30:07', 'disarmed', NULL, NULL),
(629, 1, 'Aktívny', '1749393008.607446s', '2025-06-08 14:30:08', 'disarmed', NULL, NULL),
(630, 1, 'Aktívny', '1749393009.605956s', '2025-06-08 14:30:09', 'disarmed', NULL, NULL),
(631, 1, 'Aktívny', '1749393010.60908s', '2025-06-08 14:30:10', 'disarmed', NULL, NULL),
(632, 1, 'Aktívny', '1749393011.608678s', '2025-06-08 14:30:11', 'disarmed', NULL, NULL),
(633, 1, 'Aktívny', '1749393012.612945s', '2025-06-08 14:30:12', 'disarmed', NULL, NULL),
(634, 1, 'Aktívny', '1749393013.611596s', '2025-06-08 14:30:13', 'disarmed', NULL, NULL),
(635, 1, 'Aktívny', '1749393014.614949s', '2025-06-08 14:30:14', 'disarmed', NULL, NULL),
(636, 1, 'Aktívny', '1749393015.614264s', '2025-06-08 14:30:15', 'disarmed', NULL, NULL),
(637, 1, 'Aktívny', '1749393016.613731s', '2025-06-08 14:30:16', 'disarmed', NULL, NULL),
(638, 1, 'Aktívny', '1749393017.617309s', '2025-06-08 14:30:17', 'disarmed', NULL, NULL),
(639, 1, 'Aktívny', '1749393018.616783s', '2025-06-08 14:30:18', 'disarmed', NULL, NULL),
(640, 1, 'Aktívny', '1749393019.620471s', '2025-06-08 14:30:19', 'disarmed', NULL, NULL),
(641, 1, 'Aktívny', '1749393020.619739s', '2025-06-08 14:30:20', 'disarmed', NULL, NULL),
(642, 1, 'Aktívny', '1749393021.618718s', '2025-06-08 14:30:21', 'disarmed', NULL, NULL),
(643, 1, 'Aktívny', '1749393022.622389s', '2025-06-08 14:30:22', 'disarmed', NULL, NULL),
(644, 1, 'Aktívny', '1749393023.621722s', '2025-06-08 14:30:23', 'disarmed', NULL, NULL),
(645, 1, 'Aktívny', '1749393024.62503s', '2025-06-08 14:30:24', 'disarmed', NULL, NULL),
(646, 1, 'Aktívny', '1749393025.624443s', '2025-06-08 14:30:25', 'disarmed', NULL, NULL),
(647, 1, 'Aktívny', '1749393026.627969s', '2025-06-08 14:30:26', 'disarmed', NULL, NULL),
(648, 1, 'Aktívny', '1749393027.628389s', '2025-06-08 14:30:27', 'disarmed', NULL, NULL),
(649, 1, 'Aktívny', '1749393028.626866s', '2025-06-08 14:30:28', 'disarmed', NULL, NULL),
(650, 1, 'Aktívny', '1749393029.63021s', '2025-06-08 14:30:29', 'disarmed', NULL, NULL),
(651, 1, 'Aktívny', '1749393030.630769s', '2025-06-08 14:30:30', 'disarmed', NULL, NULL),
(652, 1, 'Aktívny', '1749393031.633065s', '2025-06-08 14:30:31', 'disarmed', NULL, NULL),
(653, 1, 'Aktívny', '1749393032.632622s', '2025-06-08 14:30:32', 'disarmed', NULL, NULL),
(654, 1, 'Aktívny', '1749393033.631929s', '2025-06-08 14:30:33', 'disarmed', NULL, NULL),
(655, 1, 'Aktívny', '1749393034.635331s', '2025-06-08 14:30:34', 'disarmed', NULL, NULL),
(656, 1, 'Aktívny', '1749393035.634843s', '2025-06-08 14:30:35', 'disarmed', NULL, NULL),
(657, 1, 'Aktívny', '1749393036.639147s', '2025-06-08 14:30:36', 'disarmed', NULL, NULL);

-- --------------------------------------------------------

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
-- AUTO_INCREMENT pre tabuľku `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pre tabuľku `sensors`
--
ALTER TABLE `sensors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pre tabuľku `system_status`
--
ALTER TABLE `system_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=658;

--
-- AUTO_INCREMENT pre tabuľku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
