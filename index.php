<?php
session_start();

// Pripojenie k databáze
$conn = new mysqli('localhost', 'root', '', 'bezpecnost');
if ($conn->connect_error) {
    die("Pripojenie zlyhalo: " . $conn->connect_error);
}

// Kontrola prihlásenia
if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit();
}

// Načítanie posledného uptime z databázy
$resultStatus = $conn->query("SELECT uptime FROM system_status ORDER BY timestamp DESC LIMIT 1");
$initialUptime = 0;
if ($resultStatus && $row = $resultStatus->fetch_assoc()) {
    $initialUptime = is_numeric($row['uptime']) ? (int)$row['uptime'] : 0;
}

// Načítanie posledných logov
$logs = ['senzor' => null, 'okna' => null, 'dvere' => null];
foreach ($logs as $type => &$log) {
    $resultLog = $conn->query("SELECT * FROM logs WHERE typ='$type' ORDER BY timestamp DESC LIMIT 1");
    $log = $resultLog->fetch_assoc();
}

// Získanie celého mena používateľa
$username = $conn->real_escape_string($_SESSION['user']);
$resultUser = $conn->query("SELECT fullname FROM users WHERE username = '$username' LIMIT 1");
$userFullName = ($resultUser && $resultUser->num_rows > 0) ? $resultUser->fetch_assoc()['fullname'] : $username;
?>
<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Domáci bezpečnostný systém</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        var initialUptime = <?= $initialUptime ?>;
    </script>
    <script src="script.js"></script>
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo">
            <img src="securitas_images/iq_securitas_logo.svg" alt="Logo">
        </div>
        <h1 id="header"></h1>
    </div>
</header>
<nav>
    <a href="index.php" class="ponuka">Domov</a>
    <div class="dropdown">
        <div class="ponuka">Detailné výpisy</div>
        <div class="dropdown-content">
            <a href="dvere.php">Dvere</a>
            <a href="okno.php">Okná</a>
            <a href="senzor.php">Pohybový senzor</a>
        </div>
    </div>
    <a href="register.php" class="ponuka">Registrovať</a>
    <a href="logout.php" class="ponuka">Odhlásiť sa</a>
</nav>
<main>
    <div class="container">
        <div class="left-panel">
            <h2><i class="fa fa-user-circle"></i> Vitaj, <?= htmlspecialchars($userFullName) ?>!</h2>
            <div class="status-info">
                <p><i class="fa fa-bell"></i> <strong>Alarm:</strong> Aktívny</p>
                <p><i class="fa fa-info-circle"></i> <strong>Status:</strong> V poriadku</p>
                <p><i class="fa fa-clock"></i> <strong>Uptime:</strong> <span id="uptime-display"><?= floor($initialUptime / 60) ?> minút</span></p>
            </div>
            <button class="info-button" onclick="viacinfo()"><i class="fa fa-info-circle"></i> Viac info</button>
        </div>
        <div class="right-panel">
            <div class="log-box" onclick="window.location.href='senzor.php'">
                <h3><i class="fa fa-bell"></i> Posledná detekcia zo senzora</h3>
                <p><?= isset($logs['senzor']['message']) ? htmlspecialchars($logs['senzor']['message'] . ' o ' . $logs['senzor']['timestamp']) : 'Žiadne záznamy' ?></p>
            </div>
            <div class="log-box" onclick="window.location.href='okno.php'">
                <h3><i class="fa fa-window-maximize"></i> Posledná detekcia z okien</h3>
                <p><?= isset($logs['okna']['message']) ? htmlspecialchars($logs['okna']['message'] . ' o ' . $logs['okna']['timestamp']) : 'Žiadne záznamy' ?></p>
            </div>
            <div class="log-box" onclick="window.location.href='dvere.php'">
                <h3><i class="fa fa-door-closed"></i> Posledná detekcia z dverí</h3>
                <p><?= isset($logs['dvere']['message']) ? htmlspecialchars($logs['dvere']['message'] . ' o ' . $logs['dvere']['timestamp']) : 'Žiadne záznamy' ?></p>
            </div>
        </div>
    </div>
</main>
<footer class="custom-footer">
    <div class="footer-content">
        <p>Ročníkový projekt predmetu IoT na Strednej odbornej škole v Handlovej</p>
        <p>Domáci bezpečnostný systém - IQ Securitas 4000</p>
        <p>Vytvoril Adam Humaj a Simon Lauko</p>
    </div>
</footer>
</body>
</html>