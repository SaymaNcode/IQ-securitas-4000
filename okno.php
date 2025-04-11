<?php
session_start();

$conn = new mysqli('localhost', 'root', '', 'bezpecnost');
if ($conn->connect_error) {
    die("Pripojenie zlyhalo: " . $conn->connect_error);
}

if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit();
}

if (isset($_POST['logout'])) {
    session_destroy();
    header('Location: login.php');
    exit();
}

$username = $conn->real_escape_string($_SESSION['user']);
$resultUser = $conn->query("SELECT fullname FROM users WHERE username = '$username' LIMIT 1");
$userFullName = $resultUser && $resultUser->num_rows > 0 ? $resultUser->fetch_assoc()['fullname'] : $username;

// Spracovanie filtra
$filterFrom = $_GET['from'] ?? '';
$filterTo = $_GET['to'] ?? '';
$whereClause = "WHERE typ='okna'";
$room = $_GET['room'] ?? '';
if ($room) {
    $roomEscaped = $conn->real_escape_string($room);
    $whereClause .= " AND message LIKE '%$roomEscaped%'";
}

if ($filterFrom && $filterTo) {
    $from = $conn->real_escape_string($filterFrom . " 00:00:00");
    $to = $conn->real_escape_string($filterTo . " 23:59:59");
    $whereClause .= " AND timestamp BETWEEN '$from' AND '$to'";
}

$roomConditions = [];
if (!empty($_GET['rooms']) && is_array($_GET['rooms'])) {
    foreach ($_GET['rooms'] as $room) {
        $roomEscaped = $conn->real_escape_string($room);
        $roomConditions[] = "message LIKE '%$roomEscaped%'";
    }
    if ($roomConditions) {
        $whereClause .= " AND (" . implode(' OR ', $roomConditions) . ")";
    }
}

// Načítanie logov
$logs = [];
$resultLogs = $conn->query("SELECT * FROM logs $whereClause ORDER BY timestamp DESC LIMIT 100");
while ($row = $resultLogs->fetch_assoc()) {
    $logs[] = $row;
}

$scrollStyle = count($logs) > 10 ? 'max-height: 400px; overflow-y: auto;' : '';

?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Detail logov z okien</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="style-detail-okna.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" />
    <script type="text/javascript" src="script.js"></script>
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo">
            <img src="securitas_images/iq_securitas_logo.svg" alt="Logo">
        </div>
        <h1 id="oknoheader"></h1>
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
            <p><i class="fa fa-bell"></i>  Sledujete detailné záznamy okien.</p>
            <form method="get" class="filter-form">
                <label>Od: <input type="date" name="from" value="<?= htmlspecialchars($filterFrom); ?>"></label>
                <label>Do: <input type="date" name="to" value="<?= htmlspecialchars($filterTo); ?>"></label>
                <label>Miestnosť:</label>
                <div class="room-checkboxes">
    <?php
    $availableRooms = ['kuchyňa', 'garáž', 'obývačka', 'spálňa', 'detská izba', 'chodba'];
    foreach ($availableRooms as $roomOption):
        $checked = in_array($roomOption, $_GET['rooms'] ?? []) ? 'checked' : '';
    ?>
        <label class="container-room-checkboxes">
            <input type="checkbox" name="rooms[]" value="<?= htmlspecialchars($roomOption) ?>" <?= $checked ?>>
            <span class="checkmark"></span>
            <?= ucfirst($roomOption) ?>
        </label>
    <?php endforeach; ?>
</div>

                <button type="submit">Filtrovať</button>
            </form>
        </div>
        <div class="right-panel">
    <?php if (count($logs) > 0): ?>
        <div class="log-box" style="<?= count($logs) > 10 ? 'max-height: 400px; overflow-y: auto;' : '' ?>">
            <h3><i class="fa fa-bell"></i> senzor</h3>
            <?php foreach ($logs as $log): ?>
                <div class="log-entry">
                    <p><strong><?= htmlspecialchars($log['timestamp']); ?>:</strong> <?= htmlspecialchars($log['message']); ?></p>
                </div>
            <?php endforeach; ?>
        </div>
    <?php else: ?>
        <div class="log-box">
            <h3><i class="fa fa-bell"></i> Nenájdené žiadne údaje!</h3>
        </div>
    <?php endif; ?>
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