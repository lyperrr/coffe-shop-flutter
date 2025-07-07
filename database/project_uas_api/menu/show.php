<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$id = $_GET['id'] ?? 0;
$sql = "SELECT * FROM tbl_menu WHERE id = $id";
$result = $conn->query($sql);

if ($row = $result->fetch_assoc()) {
    $row['gambar'] = base64_encode($row['gambar']);
    echo json_encode(["status" => true, "data" => $row]);
} else {
    echo json_encode(["status" => false, "message" => "Menu not found"]);
}
