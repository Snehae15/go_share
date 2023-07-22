<?php
include '../connect.php';

$pool_id = $_POST['pool_id'];
$starting_point = $_POST['starting_point'];
$destination = $_POST['destination'];
$vehicle_no = $_POST['vehicle_no'];
$date = $_POST['date'];
$time = $_POST['time'];

// Use prepared statements to avoid SQL injection
$stmt = $con->prepare("UPDATE offer_pool SET starting_point=?, destination=?, vehicle_no=?, date=?, time=? WHERE pool_id=?");
$stmt->bind_param("sssssi", $starting_point, $destination, $vehicle_no, $date, $time, $pool_id);

$myArray = array();
if ($stmt->execute()) {
    $myArray['result'] = 'success';
} else {
    $myArray['result'] = 'failed';
}

$stmt->close();

echo json_encode($myArray);
?>
