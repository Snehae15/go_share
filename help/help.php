<?php
include '../connect.php';
$log_id = $_POST['log_id'];
$lat = $_POST['lat'];
$long = $_POST['long'];
$date = $_POST['date'];
$message = $_POST['message'];
$locality=$_POST['locality'];
$street=$_POST['street'];
$sublocality=$_POST['sublocality'];

$sql = mysqli_query($con, "INSERT INTO help (locality,street,sublocality,log_id, date, message, lat, `long`) VALUES ('$locality','$street','$sublocality','$log_id', '$date', '$message', '$lat', '$long')");
if ($sql) {
    $myarray['result'] = 'success';
} else {
    $myarray['result'] = 'failed';
}
echo json_encode($myarray);
?>
