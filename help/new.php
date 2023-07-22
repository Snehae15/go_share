<?php
include '../connect.php';
// $log_id=$_POST['log_id'];
$sql=mysqli_query($con,"SELECT * FROM help INNER JOIN register ON register.log_id=help.log_id INNER JOIN login ON help.log_id=login.log_id");
$list=array();
if($sql->num_rows>0)
{
    while($row=mysqli_fetch_assoc($sql))
    {
        $myarray['result']='success';
        $myarray['log_id']=$row['log_id'];
        $myarray['lat']=$row['lat'];
        $myarray['long']=$row['long'];
        $myarray['date']=$row['date'];
        $myarray['message']=$row['message'];
        $myarray['first_name']=$row['first_name'];
        $myarray['last_name']=$row['last_name'];
        $myarray['mobile_no']=$row['mobile_no'];
        $myarray['locality']=$row['locality'];
        $myarray['sublocality']=$row['sublocality'];
        $myarray['street']=$row['street'];

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