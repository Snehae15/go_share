<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$first_name=$_POST['first_name'];
$last_name=$_POST['last_name'];
$mobile_no=$_POST['mobile_no'];
$starting_point=$_POST['starting_point'];
$destination=$_POST['destination'];
$vehicle_no=$_POST['vehicle_no'];
$vehicle_type=$_POST['vehicle_type'];
$group_name=$_POST['group_name'];
$date=$_POST['date'];
$sql=mysqli_query($con,
"INSERT INTO group_trip(log_id,first_name,last_name,mobile_no,starting_point,destination,vehicle_no,date,vehicle_type,group_name)
 VALUES ('$log_id','$first_name','$last_name','$mobile_no','$starting_point','$destination','$vehicle_no','$date','$vehicle_type','$group_name')");
if ($sql){
    $myarray['result']='success';
}
else{
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>