<?php
include '../connect.php';

$sql = mysqli_query($con, "SELECT *
    FROM offer_pool;
");

$list = array();
if ($sql->num_rows > 0) {
    while ($row = mysqli_fetch_assoc($sql)) {
        $myarray['result'] = 'success';
        $myarray['log_id'] = $row['log_id'];
        $myarray['pool_id'] = $row['pool_id'];
        $myarray['starting_point'] = $row['starting_point'];
        $myarray['destination'] = $row['destination'];
        $myarray['vehicle_no'] = $row['vehicle_no'];
        $myarray['time'] = $row['time'];
        $myarray['date'] = $row['date'];
        $myarray['licenceno'] = $row['licenceno'];
        $myarray['status'] = $row['status'];
        array_push($list, $myarray);
    }
} else {
    $myarray['result'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>
