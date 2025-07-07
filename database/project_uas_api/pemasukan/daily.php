<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$tanggal = date("Y-m-d");

// check jika ada entri di tbl_pemasukan_harian
$cek = $conn->query("SELECT * FROM tbl_pemasukan_harian WHERE tanggal = '$tanggal'");
if ($cek->num_rows == 0) {
    // hitung dari tbl_history
    $res = $conn->query("SELECT COUNT(*) as jumlah_transaksi, SUM(total_harga) as total_pemasukan FROM tbl_history WHERE DATE(waktu_transaksi) = '$tanggal'");
    $row = $res->fetch_assoc();
    $jumlah = $row['jumlah_transaksi'] ?? 0;
    $total = $row['total_pemasukan'] ?? 0;

    $stmt = $conn->prepare("INSERT INTO tbl_pemasukan_harian (tanggal, total_pemasukan, jumlah_transaksi) VALUES (?, ?, ?)");
    $stmt->bind_param("sdi", $tanggal, $total, $jumlah);
    $stmt->execute();
}

// ambil dan tampilkan
$result = $conn->query("SELECT * FROM tbl_pemasukan_harian WHERE tanggal = '$tanggal'");
$data = $result->fetch_assoc();

echo json_encode(["status" => true, "data" => $data]);
