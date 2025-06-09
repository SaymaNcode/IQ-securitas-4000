<?php
session_start();

// Kontrola prihlásenia
if (!isset($_SESSION['user'])) {
    http_response_code(401);
    die("Nepovolený prístup");
}

// Získanie uptime z POST dát
$uptime = isset($_POST['uptime']) ? (int)$_POST['uptime'] : 0;

// Uloženie do session
$_SESSION['uptime'] = $uptime;

// ⏬ Nepovinné: Uloženie do DB (napr. ak chcete posledný známy uptime pre používateľa)
$conn = new mysqli('localhost', 'root', '', 'bezpecnost');
if ($conn->connect_error) {
    http_response_code(500);
    die("Chyba DB pripojenia: " . $conn->connect_error);
}

$username = $_SESSION['user']; // Predpokladáme, že je uložené meno/ID

// Skontroluj, či už záznam existuje
$stmt = $conn->prepare("SELECT id FROM system_status WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // Aktualizácia existujúceho záznamu
    $stmt->close();
    $stmt = $conn->prepare("UPDATE system_status SET uptime = ? WHERE username = ?");
    $stmt->bind_param("is", $uptime, $username);
} else {
    // Vytvorenie nového záznamu
    $stmt->close();
    $stmt = $conn->prepare("INSERT INTO system_status (username, uptime) VALUES (?, ?)");
    $stmt->bind_param("si", $username, $uptime);
}

if ($stmt->execute()) {
    echo "OK";
} else {
    http_response_code(500);
    echo "Chyba pri ukladaní: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
