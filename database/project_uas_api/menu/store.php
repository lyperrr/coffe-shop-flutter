<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$data = json_decode(file_get_contents("php://input"), true);

$nama = $data['nama_menu'];
$kategori = $data['kategori'];
$harga = $data['harga'];
$stok = $data['stok'];
$deskripsi = $data['deskripsi'];
$gambar = base64_decode($data['gambar']);

$stmt = $conn->prepare("INSERT INTO tbl_menu (nama_menu, kategori, harga, stok, deskripsi, gambar) VALUES (?, ?, ?, ?, ?, ?)");
$stmt->bind_param("ssdiss", $nama, $kategori, $harga, $stok, $deskripsi, $gambar);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Menu created"]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to create menu"]);
}
