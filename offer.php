<!DOCTYPE html>
<?php
session_start();

// Check if the user is logged in as an admin
if (!isset($_SESSION['admin']) || $_SESSION['admin'] !== true) {
    // The user is not logged in as an admin, redirect to the login page or show an error message
    header("Location: index.html");
    exit;
}
?>
<?php
require('connect.php');

// Database connection and other initialization
if (isset($_GET['log_id'])) {
    $log_id = $_GET['log_id'];
    $sql = "SELECT * FROM offer WHERE log_id = '$log_id'";
    $result = $con->query($sql);

    if (!$result) {
        die("Query failed: " . $con->error);
    }
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST["name"];
    $log_id = $_POST["log_id"];
    // Handle file upload
    $targetDir = "uploads/";
    $voucher = $_FILES["voucher"]["name"];
    $targetFilePath = $targetDir . basename($voucher);
    $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

    if (!empty($voucher)) {
        if ($_FILES["voucher"]["error"] !== UPLOAD_ERR_OK) {
            echo "Error uploading file: " . $_FILES["voucher"]["error"];
        } elseif (move_uploaded_file($_FILES["voucher"]["tmp_name"], $targetFilePath)) {
            echo '<script>alert("File uploaded successfully"); window.location.href = "car rental.php";</script>';
        } else {
            echo "Error uploading file.";
        }
    } else {
        echo "Please select a file.";
    }
    
    // Perform data validation and any other required processing here

    // Insert the data into the database
    $sql = "INSERT INTO offer (log_id, company_name, voucher) VALUES ('$log_id', '$name', '$voucher')";

    // Execute the SQL query here (you have missed this step in your code)

    // Assuming you have a connection object named $con
    if ($con->query($sql) === TRUE) {
        // Redirect to car_rental.php after successfully executing the query
        header("Location: carpooling.php");
        exit;
    } else {
        echo "Error: " . $sql . "<br>" . $con->error;
    }
}
?>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>GoShare</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- site icon -->
      <link rel="icon" href="images/fevicon.png" type="image/png" />
      <!-- bootstrap css -->
      <link rel="stylesheet" href="css/bootstrap.min.css" />
      <!-- site css -->
      <link rel="stylesheet" href="style.css" />
      <!-- responsive css -->
      <link rel="stylesheet" href="css/responsive.css" />
      <!-- color css -->
      <link rel="stylesheet" href="css/colors.css" />
      <!-- select bootstrap -->
      <link rel="stylesheet" href="css/bootstrap-select.css" />
      <!-- scrollbar css -->
      <link rel="stylesheet" href="css/perfect-scrollbar.css" />
      <!-- custom css -->
      <link rel="stylesheet" href="css/custom.css" />
      <!-- calendar file css -->
      <link rel="stylesheet" href="js/semantic.min.css" />
      <!-- fancy box js -->
      <link rel="stylesheet" href="css/jquery.fancybox.css" />
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <body class="dashboard dashboard_1">
      <div class="full_container">
         <div class="inner_container">
            <!-- Sidebar  -->
            <nav id="sidebar">
              <div class="sidebar_blog_1">
                  <div class="sidebar-header">
                     <div class="logo_section">
                        <a href="index.html"></a>
                     </div>
                  </div>
                  <div class="sidebar_user_info">
                     <div class="icon_setting"></div>
                     <div class="user_profle_side">
                        <div class="user_img"><img class="img-responsive" src="images/logo/gocircle2.jpg" width="100" alt="#" /></div>
                        <div class="user_info">
                           <h2 style="color: aliceblue;">ADMIN</h2>
                           <p><span class="online_animation"></span> Online</p>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="sidebar_blog_2">
                  <h4>GO SHARE POOLING SERVICE</h4>
                  <ul class="list-unstyled components">
                     <li>
                        <a href=" dashboard.php" ><i class="fa fa-dashboard yellow_color"></i> <span>Dashboard</span></a>
                        
                     </li>
                     <li><a href="user.php"><i class="fa fa-user orange_color"></i> <span>USER  DETAILS</DETAILS> </span></a></li>
                    
                     
                      <li><a href="complaint1.php"><i class="fa fa-comments-o green_color"></i> <span>COMPLAINTS</span></a></li>






                     
                      
                    
                  </ul>
               </div>
            </nav>
            <!-- end sidebar -->
            <!-- right content -->
            <div id="content">
               <!-- topbar -->
               <div class="topbar">
                  <nav class="navbar navbar-expand-lg navbar-light">
                     <div class="full">
                        <button type="button" id="sidebarCollapse" class="sidebar_toggle"><i class="fa fa-bars"></i></button>
                        <div class="logo_section">
                          
                              <img class="img-responsive" src="images/logo/goshare.png" alt="#" width="130" />
                           
                        </div>
                        
                        <div class="right_topbar">
                           <div class="icon_info">
                             
                              <ul class="user_profile_dd">
                                 <li>
                                    <a class="dropdown-toggle" data-toggle="dropdown"> <span class="name_user"><h5>Settings</h5></span></a>
                                    <div class="dropdown-menu">
                                       
                                      
                                       <a class="dropdown-item" href="about.html">About</a>
                                       <a class="dropdown-item" href="logout.php"><span>Log Out</span> <i class="fa fa-sign-out"></i></a>
                                    </div>
                                 </li>
                              </ul>
                           </div>
                        </div>
                     </div>
                  </nav>
               </div>
               <!-- end topbar -->
               <!-- dashboard inner -->
               <div class="midde_cont">
                  <div class="container-fluid">
                     <div class="row column_title">
                        <div class="col-md-12">
                           <div class="page_title">
                              <h2>Add offer</h2>
                              <br>
                              <div><a class="back-arrow" href="javascript:history.back()"> < back</a></div>
                           </div>
                        </div>
                     </div>

<div class="container p-3 w-50 bg-dark rounded ">
<!-- ... (other form fields) ... -->
<form method="post" action="offer.php" enctype="multipart/form-data">
   <input type="text" name="name" class="form-control mt-1 border" placeholder="Enter comapny name" required>
   <input type="file" name="voucher" class="form-control mt-4 mb-4" placeholder="Voucher" required>
   <?php
   if (isset($_GET['log_id'])) {
   $id = $_GET['log_id'];
   echo '<input type="hidden" name="log_id" value="' . $id . '">';
   }
   ?>
   <input type="submit" class="btn btn-success " value="Submit">
</form>
<!-- ... (other form fields) ... -->

</div>
<br>

                  
                     <!-- row -->
                     <div class="row">
                        <!-- table section -->
                        
                        <!-- table section -->
                        <div class="col-md-12">
                           <div class="white_shd full margin_bottom_50">
                              
                              <div class="table_section padding_infor_info">
                                 <div class="table-responsive-sm">
                                    <table class="table">
                                       <thead class="thead-dark">
                                          <tr>
                                             <th>Company name</th>
                                             <th> Voucher</th>
                                            
                                             
                                          </tr>
                                       </thead>
                                       <tbody>
                                       <?php
                        if (isset($result) && $result->num_rows > 0) {
                            while ($row = $result->fetch_assoc()) {
                        ?>
                                <tr>
                                  
                                    <td><?php echo $row['company_name']; ?></td>
                                    <td><img src="uploads/<?php echo $row['voucher']; ?>" width="200px"></td>

                                
                                    <td>
                                        <!-- Add any additional action buttons here -->
                                    </td>
                                </tr>
                        <?php
                            }
                        } else {
                            echo '<tr><td colspan="8">No data found.</td></tr>';
                        }
                        ?>
                                       </tbody>
                                    </table>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- footer -->
                
               </div>
               <!-- end dashboard inner -->
            </div>
         </div>
         <!-- model popup -->
         <!-- The Modal -->
         <div class="modal fade" id="myModal">
            <div class="modal-dialog">
               <div class="modal-content">
                  <!-- Modal Header -->
                  <div class="modal-header">
                     <h4 class="modal-title">Modal Heading</h4>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <!-- Modal body -->
                  <div class="modal-body">
                     Modal body..
                  </div>
                  <!-- Modal footer -->
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- end model popup -->
      </div>
      <!-- jQuery -->
      <script src="js/jquery.min.js"></script>
      <script src="js/popper.min.js"></script>
      <script src="js/bootstrap.min.js"></script>
      <!-- wow animation -->
      <script src="js/animate.js"></script>
      <!-- select country -->
      <script src="js/bootstrap-select.js"></script>
      <!-- owl carousel -->
      <script src="js/owl.carousel.js"></script> 
      <!-- chart js -->
      <script src="js/Chart.min.js"></script>
      <script src="js/Chart.bundle.min.js"></script>
      <script src="js/utils.js"></script>
      <script src="js/analyser.js"></script>
      <!-- nice scrollbar -->
      <script src="js/perfect-scrollbar.min.js"></script>
      <script>
         var ps = new PerfectScrollbar('#sidebar');
      </script>
      <!-- fancy box js -->
      <script src="js/jquery-3.3.1.min.js"></script>
      <script src="js/jquery.fancybox.min.js"></script>
      <!-- custom js -->
      <script src="js/custom.js"></script>
      <!-- calendar file css -->    
      <script src="js/semantic.min.js"></script>
   </body>
</html>
<style>
   .border{

      border-radius="40px";
   }
   </style>