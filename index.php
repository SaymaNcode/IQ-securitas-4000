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
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Domáci bezpečnostný systém</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Font Awesome pre ikony -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
          integrity="sha512-pap6bEGC8tOac4R7k3QB3iT7/hTQbBRhd9qq0edYfXefmIjo3w+gBt/6M4ecbEjpd3UUlN5C6r72X3Q8a6V+5A==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <header>
        <div class="header-container">
            <!-- Logo – upravte cestu k obrázku podľa potreby -->
            <div class="logo">
                <img src="securitas_images\iq_securitas_logo.svg" alt="Logo">
            </div>
            <h1>IQ Securitas 4000</h1>
            <div class="menu">
                <!-- Ikona, ktorá spúšťa zobrazenie dropdown menu -->
                <button id="menu-button" onclick="toggleDropdown()">
                    <i class="fa fa-bars"></i>
                </button>
                <!-- Dropdown menu – počiatočne skryté -->
                <div id="dropdown-menu" class="dropdown">
                    <p><i class="fa fa-user"></i> Prihlásený: <?= htmlspecialchars($userFullName); ?></p>
                    <a href="register.php"><i class="fa fa-user-plus"></i> Registrovať</a>
                    <form method="post" style="margin:0;">
                        <button type="submit" name="logout">
                            <i class="fa fa-sign-out-alt"></i> Odhlásiť sa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </header>
    
    <main>
        <div class="container">
            <div class="left-panel">
                <h2><i class="fa fa-user-circle"></i> Vitaj, <?= htmlspecialchars($userFullName); ?>!</h2>
                <div class="status-info">
                    <p><i class="fa fa-bell"></i> <strong>Alarm:</strong> <?= $status['alarm_on'] ? 'Zapnutý' : 'Vypnutý'; ?></p>
                    <p><i class="fa fa-info-circle"></i> <strong>Status:</strong> <?= htmlspecialchars($status['status']); ?></p>
                    <p><i class="fa fa-clock"></i> <strong>Uptime:</strong> <?= htmlspecialchars($status['uptime']); ?></p>
                </div>
                <form method="post" class="alarm-form">
                    <button type="submit" name="toggle_alarm" class="toggle-alarm">
                        <?= $status['alarm_on'] ? '<i class="fa fa-power-off"></i> Vypnúť alarm' : '<i class="fa fa-power-off"></i> Zapnúť alarm'; ?>
                    </button>
                </form>
                <button class="info-button"><i class="fa fa-info-circle"></i> Viac info</button>
            </div>
            <div class="right-panel">
                <div class="log-box" onclick="showHistory('senzor')">
                    <h3><i class="fa fa-bell"></i> Detekcia zo senzora</h3>
                    <p><?= $logs['senzor']['message'] ?? 'Žiadne záznamy'; ?></p>
                </div>
                <div class="log-box" onclick="showHistory('okna')">
                    <h3><i class="fa fa-window-maximize"></i> Detekcia z okien</h3>
                    <p><?= $logs['okna']['message'] ?? 'Žiadne záznamy'; ?></p>
                </div>
                <div class="log-box" onclick="showHistory('dvere')">
                    <h3><i class="fa fa-door-closed"></i> Detekcia z dverí</h3>
                    <p><?= $logs['dvere']['message'] ?? 'Žiadne záznamy'; ?></p>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Inline JavaScript pre animáciu dropdown menu a ďalšie funkcie -->
    <script>
        function toggleDropdown() {
            console.log("Toggle dropdown");
            const dropdown = document.getElementById("dropdown-menu");
            dropdown.classList.toggle("show");
        }
        // Kliknutie mimo menu zatvorí dropdown
        document.addEventListener("click", function(e) {
            const dropdown = document.getElementById("dropdown-menu");
            const button = document.getElementById("menu-button");
            if (!button.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove("show");
            }
        });
        
        // Dummy funkcia pre zobrazenie histórie logov – uprav podľa potreby
        function showHistory(type) {
            alert("Zobrazenie histórie pre: " + type);
        }
    </script>
</body>
</html>
