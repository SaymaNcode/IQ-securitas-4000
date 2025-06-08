<?php
$conn = new mysqli('localhost', 'root', '', 'bezpecnost');

$res = $conn->query("SELECT * FROM system_status ORDER BY timestamp DESC LIMIT 1");
$status = $res->fetch_assoc();

$uptimeSecs = (int) floatval(str_replace('s', '', $status['uptime']));
$status['uptime'] = round($uptimeSecs / 60) . " minút";

$logs = [];
foreach (['senzor', 'okna', 'dvere'] as $type) {
    $logRes = $conn->query("SELECT * FROM logs WHERE typ='$type' ORDER BY timestamp DESC LIMIT 1");
    $logs[$type] = $logRes->fetch_assoc();
}

echo json_encode([
    'alarm_on' => $status['alarm_on'],
    'status' => $status['status'],
    'uptime' => $status['uptime'],
    'logs' => $logs
]);
