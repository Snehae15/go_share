<?php
// logout.php

// Start the session
session_start();

// Clear all session data
session_unset();

// Destroy the session
session_destroy();

// Redirect to the login page or any other page after logout
header("Location: index.html");
exit;
?>
