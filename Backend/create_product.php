<?php
include './functions.php';

$result = array("success" => 0, "error" => 0);

// Debug incoming data
if (isset($_POST['contactName']) && isset($_POST['contactNumber']) && isset($_POST['contactEmail'])) {
    // Retrieve POST data
    $contactName = $_POST['contactName'];
    $contactNumber = $_POST['contactNumber'];
    $contactEmail = $_POST['contactEmail'];

    // Define the table fields and values
    $fields = array('contactName', 'contactNumber', 'contactEmail');
    $values = array($contactName, $contactNumber, $contactEmail);
    $func = new functions();

    // Call insert_data method to insert data into 'tblproduct'
    $insert = $func->insert_data('tblcontact', $fields, $values);

    // Check if the insertion was successful
    if ($insert == true) {
        $result["success"] = 1;
        $result["msg_success"] = "Product registered successfully";
    } else {
        $result["error"] = 2;
        $result["msg_error"] = "Failed to register product";
    }
} else {
    $result["error"] = 1;
    $result["msg_error"] = "Access Denied: Missing parameters";
}

echo json_encode($result);
?>
