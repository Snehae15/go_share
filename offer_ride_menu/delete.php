<?php
include '../connect.php';
$pool_id=$_POST['pool_id'];
$sql=mysqli_query($con,"DELETE from offer_pool where pool_id='$pool_id'");
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