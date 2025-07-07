<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$id = $_GET['id'] ?? 0;

$sql = "DELETE FROM tbl_menu WHERE id = $id";
if ($conn->query($sql)) {
    echo json_encode(["status" => true, "message" => "Menu deleted"]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to delete"]);
}
