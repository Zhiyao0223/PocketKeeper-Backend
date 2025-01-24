<?php
require_once 'conn.php';

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'get_blog') {
    // Get all blog data from db
    $blogs = DB::query("SELECT * FROM financial_blog");

    // Get requestBody
    $requestBody = [
        'blogs' => $blogs,
    ];
    response(200, $requestBody);
} else {
    response(400, 'Invalid request');
}
