<?php
include '../connect.php';
$sql=mysqli_query($con,"SELECT * FROM `rent`;");
$list=array();
if($sql->num_rows>0)
{
    while($row=mysqli_fetch_assoc($sql))
    {
        $myarray['result']='success';
        $myarray['rent_id']=$row['rent_id'];
        $myarray['name']=$row['name'];
        $myarray['mobile_no']=$row['mobile_no'];
        $myarray['price']=$row['price'];
        $myarray['vehicle_no']=$row['vehicle_no'];
        $myarray['vehicle_model']=$row['vehicle_model'];
        // $myarray['vehicle_image']=$row['vehicle_image'];
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