<?php
include '../connect.php';
$gt_id=$_POST['gt_id'];
$starting_point=$_POST['starting_point'];
$destination=$_POST['destination'];
$vehicle_no=$_POST['vehicle_no'];
$date=$_POST['date'];
$vehicle_type=$_POST['vehicle_type'];
// $mobile_no=$_POST['mobile_no'];
$sql=mysqli_query($con,"UPDATE group_trip set starting_point='$starting_point',destination='$destination',vehicle_no='$vehicle_no',date='$date',vehicle_type='$vehicle_type' where gt_id='$gt_id'");
if($sql)
{
    $myArray['result']='success';
}
else
{
    $myArray['result']='faild';
}
echo json_encode($myArray);
?>