<?php
include '../connect.php';
// $log_id=$_POST['log_id'];
$sql=mysqli_query($con,"SELECT * FROM goods_movement ");
$sql1=mysqli_query($con,"SELECT * FROM group_trip ");
$sql2=mysqli_query($con,"SELECT * FROM offer_pool ");

$list=array();


if($sql->num_rows>0 && $sql1->num_rows>0 && $sql2->num_rows>0 )
{
    while($row=mysqli_fetch_assoc($sql))
        {
          $myarray['result']='success';
          $myarray['gm_id']=$row['gm_id'];
          $myarray['starting_point']=$row['starting_point'];
          $myarray['destination']=$row['destination'];
          $myarray['vehicle_no']=$row['vehicle_no'];
          $myarray['date']=$row['date'];
          $myarray['time']=$row['time'];
          array_push($list,$myarray);

         }
    while($row=mysqli_fetch_assoc($sql1))
         {
            $myarray['gt_id']=$row['gt_id'];
            $myarray['log_id']=$row['log_id'];
            $myarray['first_name']=$row['first_name'];
            $myarray['last_name']=$row['last_name'];  
            $myarray['mobile_no']=$row['mobile_no'];
            $myarray['starting_point']=$row['starting_point'];
            $myarray['destination']=$row['destination'];
            $myarray['vehicle_no']=$row['vehicle_no'];
            $myarray['vehicle_type']=$row['vehicle_type'];
            $myarray['group_name']=$row['group_name'];
            $myarray['date']=$row['date'];       
                array_push($list,$myarray);

          }
    while($row=mysqli_fetch_assoc($sql1))
          {
             $myarray['gt_id']=$row['gt_id'];
             $myarray['pool_id']=$row['pool_id'];
             $myarray['starting_point']=$row['starting_point'];
             $myarray['destination']=$row['destination'];
             $myarray['vehicle_no']=$row['vehicle_no'];
             $myarray['date']=$row['date'];
             $myarray['time']=$row['time'];   
                 array_push($list,$myarray);
 
           }

}
else
{
    $myarray['result']='failed';
    array_push($list,$myarray);


    // array_push($list,$myarray);

}
echo json_encode($list);
// $con->close();
?>