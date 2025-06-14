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

// Odhlásenie
if (isset($_POST['logout'])) {
    session_destroy();
    header('Location: login.php');
    exit();
}

// Načítanie posledných logov pre jednotlivé senzory
$logs = [
    'senzor' => null,
    'okna'   => null,
    'dvere'  => null
];

foreach ($logs as $type => &$log) {
    $resultLog = $conn->query("SELECT * FROM logs WHERE typ='$type' ORDER BY timestamp DESC LIMIT 1");
    $log = $resultLog->fetch_assoc();
}

// Získanie hodnoty "fullname" pre prihláseného používateľa
$username = $conn->real_escape_string($_SESSION['user']);
$resultUser = $conn->query("SELECT fullname FROM users WHERE username = '$username' LIMIT 1");

if ($resultUser && $resultUser->num_rows > 0) {
    $rowUser = $resultUser->fetch_assoc();
    $userFullName = $rowUser['fullname'];
} else {
    // Fallback – ak fullname nie je nájdený, použijeme pôvodné používateľské meno
    $userFullName = $username;
}

$senzorLog = null;
$oknaLog = null;
$dvereLog = null;

foreach ($logs as $l) {
    if (isset($l['typ']) && $l['typ'] === 'senzor' && $senzorLog === null) {
        $senzorLog = $l;
    }
    if (isset($l['typ']) && $l['typ'] === 'okna' && $oknaLog === null) {
        $oknaLog = $l;
    }
    if (isset($l['typ']) && $l['typ'] === 'dvere' && $dvereLog === null) {
        $dvereLog = $l;
    }
}

?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Domáci bezpečnostný systém</title>
    <link rel="stylesheet" href="viacinfo-style.css" />
    <link rel="stylesheet" href="styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" />
    <script type="text/javascript" src="script.js"></script>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="logo">
                <img src="securitas_images\iq_securitas_logo.svg" alt="Logo">
            </div>
            <h1 id="infoheader"></h1>
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
            <div class="panel">
    
                    <div class="status-wrapper">
                        <div class="status">
                            <h3><i class="fa fa-info-circle"></i> Všeobecné informácie</h3>
                            <p><i class="fa fa-bell"></i> <strong>Alarm:</strong> Aktívny</p>
                            <p><i class="fa fa-info-circle"></i> <strong>Status:</strong> V poriadku</p>
                            <p><i class="fa fa-clock"></i> <strong>Uptime:</strong> <span id="uptime-display"><?= floor($initialUptime / 60) ?> minút</span></p>
                        </div>

                         <div class="status">
                            <h3><i class="fa fa-info-circle"></i> Systémové informácie</h3>
                            <p> <strong>Typ zariadenia:</strong> Arduino UNO</p>
                            <p> <strong>Počet senzorov:</strong> 3</p>
                            <p> <strong>Verzia systému:</strong> v2.4</p>
                        </div>
                        <div class="status">
                            <h3><i class="fa fa-info-circle"></i> Kontaktné údaje</h3>
                            <p>Administrátor systému:</p>
                            <p>Adam Humaj - humajadam@protonmail.com</p>
                            <p>Simon Lauko - simonlauko02@gmail.com</p>
                        </div>
                    </div>

                <button class="info-button" onclick="spatdom()" style="width: 250px;">
                    <i class="fa fa-info-circle"></i> Spať na hlavnú stránku
                </button>
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
