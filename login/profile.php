<?php
include 'connect.php';

$log_id = $_POST['log_id'];

$sql = mysqli_query($con, "SELECT * FROM register WHERE log_id='$log_id'");
$sql2 = mysqli_query($con, "SELECT * FROM login WHERE log_id='$log_id'");

if ($sql->num_rows > 0 && $sql2->num_rows > 0) {
    $response = array();
    
    while ($row = mysqli_fetch_assoc($sql)) {
        $data['result'] = 'success';
        $data['log_id'] = $row['log_id'];
        $data['register_id'] = $row['register_id'];
        $data['first_name'] = $row['first_name'];
        $data['last_name'] = $row['last_name'];
        $data['email'] = $row['email'];
        $data['mobile_no'] = $row['mobile_no'];
        
        array_push($response, $data);
    }

    // Use a separate key for data from $sql2
    while ($row = mysqli_fetch_assoc($sql2)) {
        $loginData['log_id'] = $row['log_id'];
        
        array_push($response, $loginData);
    }

    echo json_encode($response);
} else {
    // Return 'failed' result if no data is found
    $response = array('result' => 'failed');
    echo json_encode($response);
}
?>
