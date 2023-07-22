<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$time=$_POST['time'];
$date=$_POST['date'];
$destination=$_POST['destination'];
$sql=mysqli_query($con,"INSERT INTO my_rides (log_id,time,date,destination) VALUES ('$log_id','$time','$date','$destination')");
if ($sql) {
    $myarray['result']='success';
}
else
{
    $myarray['result']='failed';

}
echo json_encode($myarray);

?>