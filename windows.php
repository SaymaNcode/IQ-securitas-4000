<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<div class="logs">
    <h2>Logy z otvorenia okien</h2>
    <div class="log-container">
        <?php foreach ($logs_okna as $log) : ?>
            <div class="log">
                <strong><?php echo $log['timestamp']; ?></strong> - <?php echo $log['message']; ?>
            </div>
        <?php endforeach; ?>
    </div>
</div>
</body>
</html>