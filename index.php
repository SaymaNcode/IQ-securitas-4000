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
    $resultToggle = $conn->query("SELECT * FROM system_status ORDER BY timestamp DESC LIMIT 1");
    $currentStatus = $resultToggle->fetch_assoc();
    $newState = ($currentStatus && $currentStatus['alarm_on']) ? 0 : 1;

    if (isset($currentStatus['id'])) {
        $stmt = $conn->prepare("UPDATE system_status SET alarm_on = ? WHERE id = ?");
        $stmt->bind_param("ii", $newState, $currentStatus['id']);
        $stmt->execute();
        $stmt->close();
    }

    $command = $newState ? "ALARM_ON" : "ALARM_OFF";
    $pythonScript = "D:\IQ-securitas-4000\arduino\alarm_control.py";
    $output = [];
    $return_var = 0;
    exec('python "' . $pythonScript . '" "' . $command . '" 2>&1', $output, $return_var);
    error_log("Alarm command: $command");
    error_log("Python script: $pythonScript");
    error_log("Return status: $return_var");
    error_log("Output: " . implode("\n", $output));

    header("Location: index.php");
    exit();
}

// Toggle bzučiaka
if (isset($_POST['buzzer_toggle'])) {
    $res = $conn->query("SELECT value FROM settings WHERE key_name = 'buzzer_enabled'");
    $curr = $res->fetch_object()->value;
    $new_val = ($curr == '1') ? '0' : '1';
    $conn->query("UPDATE settings SET value = '$new_val' WHERE key_name = 'buzzer_enabled'");
    header("Location: index.php");
    exit();
}

// Čítanie stavu bzučiaka
$res = $conn->query("SELECT value FROM settings WHERE key_name = 'buzzer_enabled'");
$buzzer_enabled = ($res->fetch_object()->value === '1');

// Posledný status systému
$resultStatus = $conn->query("SELECT * FROM system_status ORDER BY timestamp DESC LIMIT 1");
$status = $resultStatus->fetch_assoc();

// Uptime zaokrúhlený
$uptimeSecs = (int) floatval(str_replace('s', '', $status['uptime']));
$status['uptime'] = round($uptimeSecs / 60) . " minút";

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

$username = $conn->real_escape_string($_SESSION['user']);
$resultUser = $conn->query("SELECT fullname FROM users WHERE username = '$username' LIMIT 1");
$userFullName = ($resultUser && $resultUser->num_rows > 0) ? $resultUser->fetch_assoc()['fullname'] : $username;

$senzorLog = $logs['senzor'];
$oknaLog = $logs['okna'];
$dvereLog = $logs['dvere'];
?>
<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Domáci bezpečnostný systém</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" />
    <script type="text/javascript" src="script.js"></script>
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
            <h2><i class="fa fa-user-circle"></i> Vitaj, <?= htmlspecialchars($userFullName); ?>!</h2>
            <div class="status-info">
                <p><i class="fa fa-bell"></i> <strong>Alarm:</strong> <?= $status['alarm_on'] ? 'Zapnutý' : 'Vypnutý'; ?></p>
                <p><i class="fa fa-info-circle"></i> <strong>Status:</strong> <?= htmlspecialchars($status['status']); ?></p>
                <p><i class="fa fa-clock"></i> <strong>Uptime:</strong>     <?php
                // Ukážka uptime (zaokrúhlenie)
                $res = $conn->query("SELECT uptime FROM system_status ORDER BY timestamp DESC LIMIT 1");
                if ($res && $row = $res->fetch_assoc()) {
                    $uptime = round($row["uptime"] / 60);  // zaokrúhlenie na minúty
                    echo "<p>Uptime systému: {$uptime} min</p>";
                }
                ?></p>
            </div>
            <button class="info-button" onclick="viacinfo()"><i class="fa fa-info-circle"></i> Viac info</button>
        </div>
        <div class="right-panel">
            <div class="log-box" onclick="window.location.href='senzor.php'">
                <h3 style="font-weight: bold;"><i class="fa fa-bell"></i> Posledná detekcia zo senzora</h3>
                <p><?= isset($senzorLog['message'], $senzorLog['timestamp']) ? "{$senzorLog['message']} o {$senzorLog['timestamp']}" : 'Žiadne záznamy'; ?></p>
            </div>
            <div class="log-box" onclick="window.location.href='okno.php'">
                <h3 style="font-weight: bold;"><i class="fa fa-window-maximize"></i> Posledná detekcia z okien</h3>
                <p><?= isset($oknaLog['message'], $oknaLog['timestamp']) ? "{$oknaLog['message']} o {$oknaLog['timestamp']}" : 'Žiadne záznamy'; ?></p>
            </div>
            <div class="log-box" onclick="window.location.href='dvere.php'">
                <h3 style="font-weight: bold;"><i class="fa fa-door-closed"></i> Posledná detekcia z dverí</h3>
                <p><?= isset($dvereLog['message'], $dvereLog['timestamp']) ? "{$dvereLog['message']} o {$dvereLog['timestamp']}" : 'Žiadne záznamy'; ?></p>
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
<script>
function updateStatus() {
    fetch('status_update.php')
        .then(response => response.json())
        .then(data => {
            // Aktualizuj alarm
            document.querySelector('.status-info').innerHTML = `
                <p><i class="fa fa-bell"></i> <strong>Alarm:</strong> ${data.alarm_on == 1 ? 'Zapnutý' : 'Vypnutý'}</p>
                <p><i class="fa fa-info-circle"></i> <strong>Status:</strong> ${data.status}</p>
                <p><i class="fa fa-clock"></i> <strong>Uptime:</strong> ${data.uptime}</p>
            `;

            // Aktualizuj logy
            document.querySelectorAll('.log-box').forEach(box => {
                if (box.innerText.includes('senzora')) {
                    box.querySelector('p').textContent =
                        data.logs.senzor?.message ? `${data.logs.senzor.message} o ${data.logs.senzor.timestamp}` : 'Žiadne záznamy';
                }
                if (box.innerText.includes('okien')) {
                    box.querySelector('p').textContent =
                        data.logs.okna?.message ? `${data.logs.okna.message} o ${data.logs.okna.timestamp}` : 'Žiadne záznamy';
                }
                if (box.innerText.includes('dverí')) {
                    box.querySelector('p').textContent =
                        data.logs.dvere?.message ? `${data.logs.dvere.message} o ${data.logs.dvere.timestamp}` : 'Žiadne záznamy';
                }
            });
        });
}

// Spúšťa každých 5 sekúnd
setInterval(updateStatus, 5000);
</script>
</body>
</html>
