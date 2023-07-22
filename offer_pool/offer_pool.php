<?php
include 'connect.php';

$log_id = $_POST['log_id'];
$starting_point = $_POST['starting_point'];
$destination = $_POST['destination'];
$vehicle_no = $_POST['vehicle_no'];
$time = $_POST['time'];
$date = $_POST['date'];
$licenceno = $_POST['licenceno'];

$sql = mysqli_query($con, "INSERT INTO offer_pool (log_id, starting_point, destination, vehicle_no, time, date, licenceno)
                           VALUES ('$log_id', '$starting_point', '$destination', '$vehicle_no', '$time', '$date', '$licenceno')");
if ($sql) {
    $myarray['result'] = 'success';
} else {
    $myarray['result'] = 'failed';
}
echo json_encode($myarray);
?>
