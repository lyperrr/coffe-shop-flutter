<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$data = json_decode(file_get_contents("php://input"), true);
$menu_id = $data['menu_id'];

$sql = "INSERT INTO tbl_favorite (menu_id) VALUES ($menu_id)";
if ($conn->query($sql)) {
    echo json_encode(["status" => true, "message" => "Favorite added"]);
} else {
    echo json_encode(["status" => false, "message" => "Insert failed"]);
}
