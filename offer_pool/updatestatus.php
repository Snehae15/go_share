<?php
include 'connect.php';

// Get the pool_id sent from Flutter using the 'pool_id' key
$pool_id = $_POST['pool_id'];

// Update the status column in the offer_pool table for the received pool_id
$sql = mysqli_query($con, "UPDATE offer_pool SET status = 'completed' WHERE pool_id = '" . mysqli_real_escape_string($con, $pool_id) . "';");

if ($sql) {
    $response['result'] = 'success';
} else {
    $response['result'] = 'failed';
}

echo json_encode([$response]);
?>
