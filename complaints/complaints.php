<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$time=$_POST['time'];
$date=$_POST['date'];
$complaint=$_POST['complaint'];
$sql=mysqli_query($con,"INSERT INTO complaints (log_id,time,date,complaint) VALUES ('$log_id','$time','$date','$complaint')");
if ($sql) {
    $myarray['result']='success';
}
else
{
    $myarray['result']='failed';

}
echo json_encode($myarray);

?>