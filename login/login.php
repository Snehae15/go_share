<?php
include 'connect.php';
// $log_id=$_POST['log_id'];
$email=$_POST['email'];
$password=$_POST['password'];
$sql="";
$sql=mysqli_query($con,"SELECT * FROM login WHERE email='$email' AND password='$password'");
// $result=$con->query($sql);
if($sql->num_rows>0) {
    while($row=mysqli_fetch_assoc($sql)){
        $myarray['result']='Login success';
        $myarray['log_id']=$row['log_id'];
    }
}
else
{
    $myarray['result']='Login failed';
    
}
echo json_encode($myarray);

?>