<?php
require_once 'db.php';

$result = null;
$keyword = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['keyword'])) {
    $keyword = trim($_POST['keyword']);
    $stmt = mysqli_prepare($conn, "SELECT recommendation FROM items WHERE keyword = ?");
    mysqli_stmt_bind_param($stmt, 's', $keyword);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
    $row = mysqli_fetch_assoc($res);
    $result = $row ? $row['recommendation'] : null;
    mysqli_stmt_close($stmt);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Recommendation System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Recommendation System</h1>
        <p class="subtitle">Type a weather keyword and get the matching season</p>

        <form method="POST" action="">
            <input
                type="text"
                name="keyword"
                placeholder="e.g. hot, cold, rainy..."
                value="<?= htmlspecialchars($keyword) ?>"
                autofocus
                required
            >
            <button type="submit">Recommend</button>
        </form>

        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
            <div class="result <?= $result ? 'success' : 'empty' ?>">
                <?php if ($result): ?>
                    <strong><?= htmlspecialchars($keyword) ?></strong>
                    &rarr;
                    <span class="recommendation"><?= htmlspecialchars($result) ?></span>
                <?php else: ?>
                    No recommendation found for "<?= htmlspecialchars($keyword) ?>"
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <div class="hint">
            <p>Try one of: hot, cold, rainy, mild, snow, warm, windy, sunny</p>
        </div>
    </div>
</body>
</html>
