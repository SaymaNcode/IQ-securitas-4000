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
    <div class="login-container">
        <form method="post" class="login-form">
            <input type="password" name="password" placeholder="Heslo" required />
            <input type="submit" value="Prihlásiť sa" />
        </form>
    </div>
</body>
</html>
