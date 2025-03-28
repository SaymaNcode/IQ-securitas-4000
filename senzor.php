<?php
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<div class="logs">
    <h2>Logy z pohybového senzora</h2>
    <div class="log-container">
        <?php foreach ($logs_pohyb as $log) : ?>
            <div class="log">
                <strong><?php echo $log['timestamp']; ?></strong> - <?php echo $log['message']; ?>                    
            </div>
        <?php endforeach; ?>
    </div>
</div>
</body>
</html>