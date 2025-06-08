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

// Prepínanie alarmu – ak bolo stlačené tlačidlo
if (isset($_POST['toggle_alarm'])) {
    // Načítame aktuálny stav alarmu
    $resultToggle = $conn->query("SELECT * FROM system_status ORDER BY timestamp DESC LIMIT 1");
    $currentStatus = $resultToggle->fetch_assoc();
    $newState = ($currentStatus && $currentStatus['alarm_on']) ? 0 : 1;
    // Predpokladáme, že tabuľka system_status má primárny kľúč id
    if (isset($currentStatus['id'])) {
        $stmt = $conn->prepare("UPDATE system_status SET alarm_on = ? WHERE id = ?");
        $stmt->bind_param("ii", $newState, $currentStatus['id']);
        $stmt->execute();
        $stmt->close();
    }
}

// Načítanie aktuálneho stavu systému
$result = $conn->query("SELECT * FROM system_status ORDER BY timestamp DESC LIMIT 1");
$status = $result->fetch_assoc() ?: ['alarm_on' => 0, 'status' => 'Neznámy', 'uptime' => '0s'];

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
                            <p><strong>Alarm:</strong> <?= $status['alarm_on'] ? 'Zapnutý' : 'Vypnutý'; ?></p>
                            <p><strong>Status:</strong> <?= htmlspecialchars($status['status']); ?></p>
                            <p><strong>Uptime:</strong> <?= htmlspecialchars($status['uptime']); ?></p>
                        </div>

                         <div class="status">
                            <h3><i class="fa fa-info-circle"></i> Systémové informácie</h3>
                            <p> <strong>Typ zariadenia:</strong> Arduino UNO</p>
                            <p> <strong>Počet senzorov:</strong> 3</p>
                            <p> <strong>Verzia systému:</strong> v2.4</p>
                        </div>
                        <div class="status">
                            <h3><i class="fa fa-info-circle"></i> Neviem uprimne</h3>
                            <p>Simon vymysli sem nieco diky ❤️</p>
                            <p><?= htmlspecialchars($status['status']); ?></p>
                            <p><?= htmlspecialchars($status['status']); ?></p>
                        </div>
                    </div>

                <form method="post" class="alarm-form">
                     <button type="submit" name="toggle_alarm" class="toggle-alarm">
                        <?= $status ? 'Vypnúť alarm' : 'Zapnúť alarm'; ?>
                    </button>
                </form>

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
