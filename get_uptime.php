<?php
session_start();

echo json_encode([
    'uptime' => isset($_SESSION['uptime']) ? $_SESSION['uptime'] : 0
]);
