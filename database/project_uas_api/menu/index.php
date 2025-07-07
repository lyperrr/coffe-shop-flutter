<?php
header("Content-Type: application/json");
include_once "../config/db.php";

if (!$conn) {
    echo json_encode(["status" => false, "message" => "Koneksi tidak tersedia"]);
    exit;
}

$sql = "SELECT * FROM tbl_menu";
$result = $conn->query($sql);

if (!$result) {
    echo json_encode([
        "status" => false,
        "message" => "Query gagal: " . $conn->error
    ]);
    exit;
}

$menus = [];
while ($row = $result->fetch_assoc()) {
    // Konversi BLOB ke base64 agar bisa dikirim sebagai string JSON
    if (!empty($row['gambar'])) {
        $row['gambar'] = base64_encode($row['gambar']);
    } else {
        $row['gambar'] = "";
    }

    $menus[] = $row;
}

echo json_encode([
    "status" => true,
    "data" => $menus
]);
?>
