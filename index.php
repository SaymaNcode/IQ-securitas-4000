<?php
session_start();

if (!isset($_SESSION['loggedin']) || !$_SESSION['loggedin']) {
    header('Location: login.php');
    exit;
}

if (isset($_POST['logout'])) {
    unset($_SESSION['loggedin']);
    header('Location: login.php');
    exit;
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "bezpecnost";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_POST['toggle_alarm'])) {
    $alarm_status = $_POST['alarm_status'];
    $sql = "UPDATE system SET alarm='$alarm_status' WHERE id=1";
    $conn->query($sql);
}

$sql = "SELECT alarm FROM system WHERE id=1";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
$alarm_status = $row['alarm'];

$sql = "SELECT * FROM logs ORDER BY timestamp DESC LIMIT 10";
$result = $conn->query($sql);

$logs_dvere = [];
$logs_okna = [];
$logs_pohyb = [];
while ($row = $result->fetch_assoc()) {
    if (strpos($row['message'], 'dvere') !== false) {
        $logs_dvere[] = $row;
    } elseif (strpos($row['message'], 'okno') !== false) {
        $logs_okna[] = $row;
    } elseif (strpos($row['message'], 'pohyb') !== false) {
        $logs_pohyb[] = $row;
    }
}

$conn->close();
?>


<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Baskervville:ital@0;1&display=swap" rel="stylesheet">
    <title>Bezpečnostný systém</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header id="main-header">
        <div class="header-content">
            <div class="Logo">
                <img src="securitas_images/iq_securitas_logo.svg" alt="Logo" width="100px" height="80px">
            </div>
            <div>
                <h1>IQ Securitas 4000</h1>
            </div>
            <div id="top_logout">
                <form method="post" class="action-form">
                    <input type="hidden" name="alarm_status" value="<?php echo $alarm_status ? '0' : '1'; ?>" />
                    <button type="submit" name="logout" class="button-logout">
                        <b class="icon">🔒</b>
                        Odhlásiť sa
                    </button>
                </form>
            </div>
        </div>
    </header>
    <nav id="main-nav">
        <div class="nav_container">
            <ul>
                <li><a href="index.php">trnava</a></li>
                <li><a href="door.php">Dvere</a></li>
                <li><a href="windows.php">Okna</a></li>
                <li><a href="senzor.php">Senzor</a></li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <form method="post" class="action-form">
            <input type="hidden" name="alarm_status" value="<?php echo $alarm_status ? '0' : '1'; ?>" />
            <button type="submit" name="toggle_alarm" class="<?php echo $alarm_status ? 'button-red' : 'button-green'; ?>">
                <b class="icon"><?php echo $alarm_status ? '🚫' : '✅'; ?></>
                <?php echo $alarm_status ? 'Vypnúť alarm' : 'Zapnúť alarm'; ?>
            </button>
        </form>
        <div id="logs">
            <h2>Logy z otvorenia dverí</h2>
            <div class="log-container">
                <?php foreach ($logs_dvere as $log) : ?>
                    <div class="log">
                        <strong><?php echo $log['timestamp']; ?></strong> - <?php echo $log['message']; ?>
                    </div>
                <?php endforeach; ?>
            </div>

            <h2>Logy z otvorenia okien</h2>
            <div class="log-container">
                <?php foreach ($logs_okna as $log) : ?>
                    <div class="log">
                        <strong><?php echo $log['timestamp']; ?></strong> - <?php echo $log['message']; ?>
                    </div>
                <?php endforeach; ?>
            </div>

            <h2>Logy z pohybového senzora</h2>
            <div class="log-container">
                <?php foreach ($logs_pohyb as $log) : ?>
                    <div class="log">
                        <strong><?php echo $log['timestamp']; ?></strong> - <?php echo $log['message']; ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

</body>
</html>

