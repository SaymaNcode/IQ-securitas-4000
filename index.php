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
    <title>Bezpečnostný systém</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header id="main-header">
        <div class="container">
            <h1>Bezpečnostný systém</h1>
        </div>
    </header>
    <div class="container">
        <form method="post" class="action-form">
            <input type="hidden" name="alarm_status" value="<?php echo $alarm_status ? '0' : '1'; ?>" />
            <button type="submit" name="toggle_alarm" class="<?php echo $alarm_status ? 'button-red' : 'button-green'; ?>">
                <b class="icon"><?php echo $alarm_status ? '🚫' : '✅'; ?></>
                <?php echo $alarm_status ? 'Vypnúť alarm' : 'Zapnúť alarm'; ?>
            </button>
            <button type="submit" name="logout" class="button-logout">
                <b class="icon">🔒</b>
                Odhlásiť sa
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
    <script src="scripts.js"></script>
</body>
</html>
