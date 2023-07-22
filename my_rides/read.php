<?php
include '../connect.php';
$log_id = $_POST['id']; // Update the key to 'id'

if (isset($log_id)) {
    $sql = mysqli_query($con, "SELECT *
        FROM login
        JOIN offer_pool
        ON login.log_id = offer_pool.log_id
        WHERE login.log_id = '$log_id';
    ");

    $list = array();
    if ($sql->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($sql)) {
            $myarray['result'] = 'success';
            $myarray['log_id'] = $row['log_id'];

            $myarray['starting_point'] = $row['starting_point'];
            $myarray['destination'] = $row['destination'];
            $myarray['vehicle_no'] = $row['vehicle_no'];
            $myarray['time'] = $row['time'];
            $myarray['date'] = $row['date'];
            $myarray['status'] = $row['status']; // Add the 'status' field
            array_push($list, $myarray);
        }
    } else {
        $myarray['result'] = 'failed';
        array_push($list, $myarray);
    }
    echo json_encode($list);
} else {
    echo json_encode(array('result' => 'failed', 'message' => 'log_id is not provided'));
}
?>
