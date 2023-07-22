<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$date=$_POST['date'];
$rating=$_POST['rating'];
$review=$_POST['review'];
$sql=mysqli_query($con,"INSERT INTO review (log_id,date,review,rating) VALUES ('$log_id','$date','$review',$rating)");
if ($sql) {
    $myarray['result']='success';
}
else
{
    $myarray['result']='failed';

}
echo json_encode($myarray);

?>