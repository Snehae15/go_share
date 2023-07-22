<?php
// Assuming you have a database connection already established and named $con
// Replace 'your_database_name', 'your_username', 'your_password', and 'your_server' with your actual database credentials
require('connect.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST["name"];
    $mobile_number = $_POST["mobile_number"];
    $price = $_POST["price"];
    $vehicle_number = $_POST["vehicle_number"];
    $vehicle_model = $_POST["vehicle_model"];

    // Handle file upload
    $targetDir = "uploads/";
    $vehicle_image = $_FILES["vehicle_image"]["name"];
    $targetFilePath = $targetDir . basename($vehicle_image);
    $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

    if (!empty($vehicle_image)) {
        if ($_FILES["vehicle_image"]["error"] !== UPLOAD_ERR_OK) {
            echo "Error uploading file: " . $_FILES["vehicle_image"]["error"];
        } elseif (move_uploaded_file($_FILES["vehicle_image"]["tmp_name"], $targetFilePath)) {
            echo '<script>alert("File uploaded successfully");</script>';
        } else {
            echo "Error uploading file.";
        }
    } else {
        echo "Please select a file.";
    }

    // Perform data validation and any other required processing here

    // Insert the data into the database
    $sql = "INSERT INTO rent (name, mobile_no, price, vehicle_no, vehicle_model, vehicle_image) VALUES ('$name', '$mobile_number', '$price', '$vehicle_number', '$vehicle_model', '$vehicle_image')";

    if ($con->query($sql) === TRUE) {
        // Redirect to car_rental.php after successfully executing the query
        header("Location: car rental.php");
        exit;
    } else {
        echo "Error: " . $sql . "<br>" . $con->error;
    }
}
?>
