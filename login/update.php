<?php
include '../connect.php';
$register_id=$_POST['register_id'];
$log_id=$_POST['log_id'];
$first_name=$_POST['first_name'];
$last_name=$_POST['last_name'];
$username=$_POST['username'];
$email=$_POST['email'];

// upload photo
$dp=$_FILES['dp']['name'];
$dpPath='image/'.$dp;
$tmp_name=$_FILES['dp']['tmp_name'];
move_uploaded_file($tmp_name,$dpPath);
// upload photo


$sql=mysqli_query($con,"UPDATE register set first_name='$first_name',last_name='$last_name',username='$username',email='$email',dp='$dp' where register_id='$register_id'");
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