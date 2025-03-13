<?php
session_start();

if (isset($_POST['password']) && $_POST['password'] === 'tvojeheslo') {
    $_SESSION['loggedin'] = true;
    header('Location: index.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prihlásenie</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="glass-cont">
        <div class="login-container">
            <h2>Login</h2>
            <form method="post" class="login-form">
                <div class="textbox">
                    <input type="password" name="password" placeholder="Heslo" required>
                </div>
                <button type="submit" value="Prihlásiť sa">Login</button>
            </form>
        </div>
    </div>
</body>
</html>
