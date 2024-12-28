<?php
// get_contacts.php
require_once 'functions.php';
$func = new functions();

$fields = $_GET['fields'] ?? '*'; // Fields to retrieve
$conditions = $_GET['conditions'] ?? '1=1'; // Conditions to filter

$data = $func->get_data('tblcontact', $fields, $conditions);

if ($data) {
    echo json_encode(['success' => 1, 'data' => $data]);
} else {
    echo json_encode(['success' => 0, 'message' => 'No records found']);
}

?>