<?php
// login.php

// Start the session
session_start();

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["email"];
    $password = $_POST["password"];

    // Perform data validation and any other required processing here

    // Check if the provided email and password match the admin credentials
    $adminEmail = "admin@gmail.com";
    $adminPassword = "admin";

    if ($email === $adminEmail && $password === $adminPassword) {
        // Set a session variable to indicate that the user is logged in as an admin
        $_SESSION['admin'] = true;

        // Redirect to the admin page
        header("Location:  dashboard.php");
        exit;
    } else {
        // If credentials do not match, display an error message or take appropriate action
        echo '<script>alert("Invalid credentials. Please try again."); window.location.href = "index.html";</script>';
    }
}
?>
