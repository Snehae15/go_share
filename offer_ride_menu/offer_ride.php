
<?php
include '../connect.php';
$log_id = $_POST['log_id'];
$sql = mysqli_query($con, "SELECT * from offer_pool where log_id='$log_id'");
$list = array();

if ($sql->num_rows > 0) {
    while ($row = mysqli_fetch_assoc($sql)) {
        $myarray['result'] = 'success';
        $myarray['pool_id'] = $row['pool_id'];
         $myarray['log_id']=$row['log_id'];
        $myarray['starting_point']=$row['starting_point'];
        $myarray['destination']=$row['destination'];
        $myarray['vehicle_no']=$row['vehicle_no'];
        $myarray['time']=$row['time'];
        $myarray['date']=$row['date'];
        $myarray['licenceno']=$row['licenceno'];
        

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