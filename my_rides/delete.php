<?php
include '../connect.php';
$ride_id=$_POST['ride_id'];
$sql=mysqli_query($con,"DELETE from my_rides where ride_id='$ride_id'");
if($sql)
{
    $myarray['result']='Success';   
}
else
{
    $myarray['result']='Faild.........';
}
echo json_encode($myarray);
?>