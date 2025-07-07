<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$id = $_GET['id'];
$sql = "DELETE FROM tbl_favorite WHERE id = $id";
if ($conn->query($sql)) {
    echo json_encode(["status" => true, "message" => "Favorite removed"]);
} else {
    echo json_encode(["status" => false, "message" => "Delete failed"]);
}
