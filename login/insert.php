<?php
include 'connect.php';
$first_name=$_POST['first_name'];
$last_name=$_POST['last_name'];
$email=$_POST['email'];
$mobile_no=$_POST['mobile_no'];
$password=$_POST['password'];
$sql1=mysqli_query($con,"INSERT into login(email,password) values ('$email','$password')");
$user_id=mysqli_insert_id($con);
$sql2=mysqli_query($con,"INSERT into register(log_id,first_name,last_name,email,mobile_no) values('$user_id','$first_name','$last_name','$email','$mobile_no')"); 

if($sql1 && $sql2)
{
    $myarray['result']='success';
}
else
{
    $myarray['result']='faild';
}
echo json_encode($myarray);
?>