<?php
use LDAP\Result;
include 'connect.php';
$locality=$_POST['locality'];
$street=$_POST['street'];
$sublocality=$_POST['sublocality'];
$subadminstrative=$_POST['subadminstrative'];
$latitude=$_POST['latitude'];
$longitude=$_POST['longitude'];
$sql=mysqli_query($con,"INSERT INTO location (locality,street,sublocality,subadminstrative,latitude,longitude) VALUES ('$locality','$street','$sublocality','$subadminstrative','$latitude','$longitude')");
if ($sql) {
    $myarray['result']='success';
}
else
{
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>