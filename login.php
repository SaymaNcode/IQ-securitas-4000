<?php
session_start();
$conn = new mysqli('localhost', 'root', '', 'bezpecnost');
$zleheslo = "Nesprávne prihlasovacie údaje!";

if ($conn->connect_error) {
    die("Pripojenie zlyhalo: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $conn->real_escape_string($_POST['username']);
    $password = $_POST['password']; // Už nehashujeme, heslo je zadané v plaintext (pre porovnanie)

    // Použitie prepared statement na bezpečnejšie dotazy
    $stmt = $conn->prepare("SELECT fullname, password FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();

        // Porovnanie zadaného hesla s hashovaným heslom v databáze
        if (password_verify($password, $user['password'])) {
            $_SESSION['user'] = $user['fullname'];
            header("Location: index.php");
            exit();
        } else {
            echo "<h2 class='errorheslo'>" . $zleheslo . "</h2>";
        }
    } else {
        echo "<h2 class='errorheslo'>" . $zleheslo . "</h2>";
    }
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prihlásenie</title>
    <link rel="stylesheet" href="log-style.css">
    <script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="login-container">
        <h2 id="typing-title"></h2>
        <form action="login.php" method="POST">
            <input type="text" name="username" placeholder="Používateľské meno" required>
            <input type="password" name="password" placeholder="Heslo" required>
            <div id="container">
                <button class="learn-more">
                    <span class="circle" aria-hidden="true">
                        <span class="icon arrow"></span>
                    </span>
                    <span class="button-text">Prihlásiť sa </span>
                </button>
            </div>
        </form>
    </div>
</body>
</html>
