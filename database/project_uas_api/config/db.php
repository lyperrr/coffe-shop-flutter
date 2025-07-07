<?php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "db_casier";

$conn = new mysqli($host, $user, $pass, $db);

// Tambahkan pengecekan koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}
?>
