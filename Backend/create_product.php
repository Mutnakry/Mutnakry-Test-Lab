<?php
include './functions.php';

$result = array("success" => 0, "error" => 0);

// Debug incoming data
if (isset($_POST['ProductName']) && isset($_POST['CategoryID'])) {
    // Retrieve POST data
    $ProductName = $_POST['ProductName'];
    $CategoryID = $_POST['CategoryID'];
    $Barcode = $_POST['Barcode'];
    $Qty = $_POST['Qty'];
    $UnitPriceIn = $_POST['UnitPriceIn'];
    $Description = $_POST['Description'];
    $UnitPriceOut = $_POST['UnitPriceOut'];

    // Define the table fields and values
    $fields = array('ProductName', 'Description', 'CategoryID', 'Barcode', 'Qty', 'UnitPriceIn', 'UnitPriceOut');
    $values = array($ProductName, $Description, $CategoryID, $Barcode, $Qty, $UnitPriceIn, $UnitPriceOut);

    // Create an instance of the functions class
    $func = new functions();

    // Call insert_data method to insert data into 'tblproduct'
    $insert = $func->insert_data('tblproduct', $fields, $values);

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
