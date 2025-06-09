<?php
session_start();

// Spracovanie prihlásenia
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    // Pripojenie k DB
    $conn = new mysqli('localhost', 'root', '', 'bezpecnost');
    if ($conn->connect_error) {
        die("Chyba pripojenia: " . $conn->connect_error);
    }

    // Overenie údajov
    $stmt = $conn->prepare("SELECT password FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows === 1) {
        $stmt->bind_result($hashedPassword);
        $stmt->fetch();
        if (password_verify($password, $hashedPassword)) {
            $_SESSION['user'] = $username;
            $_SESSION['uptime'] = 0; // inicializuj uptime
            header("Location: index.php");
            exit();
        }
    }

    // Neúspešné prihlásenie
    header("Location: login.php?error=1");
    exit();
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Prihlásenie</title>
    <link rel="stylesheet" href="log-style.css">
    <script src="script.js"></script>
</head>
<body>
    <div class="login-container">
        <h2 id="typing-title">Prihláste sa</h2>
        <form action="login.php" method="post">
            <input type="text" name="username" placeholder="Používateľské meno" required>
            <input type="password" name="password" placeholder="Heslo" required>
            <button class="learn-more" type="submit">
                <span class="circle" aria-hidden="true">
                    <span class="icon arrow"></span>
                </span>
                <span class="button-text">Prihlásiť sa</span>
            </button>
        </form>

        <?php if (isset($_GET['error']) && $_GET['error'] == 1): ?>
            <p class="error-message">Nesprávne prihlasovacie údaje!</p>
        <?php endif; ?>
    </div>
</body>
</html>
