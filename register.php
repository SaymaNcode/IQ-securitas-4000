<?php
// Začíname session na sledovanie prihláseného používateľa
session_start();

// Skontroluj, či je používateľ prihlásený, ak nie, presmeruj ho na prihlasovaciu stránku
if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit();
}

// Pripojenie k databáze
$conn = new mysqli('localhost', 'root', '', 'bezpecnost');

// Overenie pripojenia k databáze
if ($conn->connect_error) {
    die("Pripojenie zlyhalo: " . $conn->connect_error);
}

$successMessage = "";
$errorMessage = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username']);
    $password = $_POST['password'];
    $passwordConfirm = $_POST['password_confirm'];

    // Overenie, či heslá sú rovnaké
    if ($password !== $passwordConfirm) {
        $errorMessage = "Heslá sa nezhodujú!";
    } else {
        // Skontrolovanie, či užívateľ už existuje
        $stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $errorMessage = "Používateľské meno už existuje!";
        } else {
            // Hashovanie hesla
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            // Uloženie do databázy
            $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
            $stmt->bind_param("ss", $username, $hashedPassword);

            if ($stmt->execute()) {
                $successMessage = "Registrácia úspešná! Môžete sa prihlásiť.";
            } else {
                $errorMessage = "Chyba pri registrácii!";
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrácia</title>
    <link rel="stylesheet" href="register-style.css">
</head>
<body>

<div class="register-container">
    <h2>Registrácia</h2>

    <?php if ($successMessage): ?>
        <p class="success"><?php echo $successMessage; ?></p>
    <?php endif; ?>

    <?php if ($errorMessage): ?>
        <p class="error"><?php echo $errorMessage; ?></p>
    <?php endif; ?>

    <form action="register.php" method="POST">
        <input type="text" name="username" placeholder="Používateľské meno" required>
        <input type="password" name="password" placeholder="Heslo" required>
        <input type="password" name="password_confirm" placeholder="Potvrďte heslo" required>
        <button type="submit" class="register-button">Registrovať sa</button>
    </form>
    <p>Už máte účet? <a href="login.php">Prihlásiť sa</a></p>
</div>

</body>
</html>
