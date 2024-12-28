<?php
include './functions.php';

$result = array("success" => 0, "error" => 0);

if (isset($_POST['contactId']) && isset($_POST['contactName']) && isset($_POST['contactNumber']) && isset($_POST['contactEmail'])) {
    // Retrieve POST data
    $contactId = $_POST['contactId'];
    $contactName = $_POST['contactName'];
    $contactNumber = $_POST['contactNumber'];
    $contactEmail = $_POST['contactEmail'];

    // Define the table fields and values
    $fields = array('contactName', 'contactNumber', 'contactEmail');
    $values = array($contactName, $contactNumber, $contactEmail);

    $func = new functions();

    // Call update_data method to update data in 'tblcontact'
    $update = $func->update_data('tblcontact', $fields, $values, 'contactID', $contactId);

    // Check if the update was successful
    if ($update == true) {
        $result["success"] = 1;
        $result["msg_success"] = "Contact updated successfully";
    } else {
        $result["error"] = 2;
        $result["msg_error"] = "Failed to update contact";
    }
} else {
    $result["error"] = 1;
    $result["msg_error"] = "Access Denied: Missing parameters";
}

echo json_encode($result);
?>
