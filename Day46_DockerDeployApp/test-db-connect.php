<?php
$host = getenv('DB_HOST') ?: 'mysql_host';
$dbname = getenv('DB_NAME') ?: 'database_host';
$username = getenv('DB_USER') ?: 'app_user';
$password = getenv('DB_PASSWORD') ?: 'StrongP@ssw0rd123!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    echo "Database connection successful!";
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>