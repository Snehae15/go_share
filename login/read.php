<?php
include 'connect.php';
$id=$_POST['id'];
$sql=mysqli_query($con,"SELECT * from register where id =$id");
$list=array();
if($sql->num_rows>0)
{
    while($row=mysqli_fetch_assoc($sql))
    {
        $myarray['result']='success';
        $myarray['id']=$row['id'];
        $myarray['first_name']=$row['first_name'];
        $myarray['last_name']=$row['last_name'];
        $myarray['mobile_no']=$row['mobile_no'];
        $myarray['password']=$row['password'];
        $myarray['confirm_password']=$row['confirm_password'];
        array_push($list,$myarray);
        
    }
}
else
{
    $myarray['result']='failed';
    array_push($list,$myarray);
}
echo json_encode($list);
?>