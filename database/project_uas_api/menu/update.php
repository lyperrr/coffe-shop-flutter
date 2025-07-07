<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'];
$nama = $data['nama_menu'];
$kategori = $data['kategori'];
$harga = $data['harga'];
$stok = $data['stok'];
$deskripsi = $data['deskripsi'];
$gambar = base64_decode($data['gambar']);

$stmt = $conn->prepare("UPDATE tbl_menu SET nama_menu=?, kategori=?, harga=?, stok=?, deskripsi=?, gambar=? WHERE id=?");
$stmt->bind_param("ssdissi", $nama, $kategori, $harga, $stok, $deskripsi, $gambar, $id);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Menu updated"]);
} else {
    echo json_encode(["status" => false, "message" => "Update failed"]);
}
