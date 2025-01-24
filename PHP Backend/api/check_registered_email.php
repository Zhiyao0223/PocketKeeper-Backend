<?php

require_once 'conn.php';

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'check_user_exist') {
    // Get the data from the form
    if (!isset($_POST['email'])) {
        response(500, 'Missing required fields');
        exit;
    }

    // Check if the email already exists
    $email = $_POST['email'];

    $row = DB::queryFirstRow("SELECT u.*, i.image_name as image FROM `users` u
                            LEFT JOIN images i ON i.reference_id = u.user_id AND i.type=1
                            WHERE u.email = %s", $email);

    if ($row) {
        $response = array(
            'user_id' => $row['user_id'],
            'username' => $row['username'],
            'email' => $row['email'],
            'status' => $row['status'],
            'image' => $row['image'],
            'created_date' => $row['created_date'],
            'updated_date' => $row['updated_date'],
        );
        response(200, $response);
    } else {
        response(200, '-1');
    }
} else {
    response(400, 'Invalid request');
}
