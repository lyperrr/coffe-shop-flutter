<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$data = json_decode(file_get_contents("php://input"), true);

$nama = $data['nama_pelanggan'];
$total = $data['total_harga'];
$metode = $data['metode_pembayaran'];
$items = $data['items']; // array of {menu_id, jumlah, subtotal}

// insert ke tbl_history
$stmt = $conn->prepare("INSERT INTO tbl_history (nama_pelanggan, total_harga, metode_pembayaran) VALUES (?, ?, ?)");
$stmt->bind_param("sds", $nama, $total, $metode);
$stmt->execute();
$history_id = $stmt->insert_id;

// insert detail
foreach ($items as $item) {
    $menu_id = $item['menu_id'];
    $jumlah = $item['jumlah'];
    $subtotal = $item['subtotal'];
    $conn->query("INSERT INTO tbl_history_detail (history_id, menu_id, jumlah, subtotal) VALUES ($history_id, $menu_id, $jumlah, $subtotal)");
}

echo json_encode(["status" => true, "message" => "Transaksi disimpan"]);
