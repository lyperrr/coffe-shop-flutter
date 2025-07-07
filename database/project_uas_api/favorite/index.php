<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$query = "SELECT m.id, m.nama_menu, m.kategori, m.harga, m.stok, m.gambar 
          FROM tbl_favorite f
          JOIN tbl_menu m ON f.menu_id = m.id";

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $row['gambar'] = base64_encode($row['gambar']);
    $data[] = $row;
}

echo json_encode($data);
