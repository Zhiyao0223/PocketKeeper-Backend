<?php
require_once ('conn.php');
require_once ('common/hash_password.php');

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'update_profile') {
    // Get the data from the form
    if (!isset($_POST['key']) || !isset($_POST['value']) || !isset($_POST['email'])) {
        response(500, 'Missing required fields');
        exit;
    }

    // Variables
    $column_name = $_POST['key'];
    $value = $_POST['value'];
    $email = $_POST['email'];

    // Check if update password
    if ($column_name == 'password') {
        $value = hash_password($value);
    }

    // Update database
    DB::update('users', [
        $column_name => $value,
    ], 'email = %s', $email);

    // Get requestBody
    $requestBody = [
        'message' => 'Changed successfully',
    ];
    response(200, $requestBody);
} else {
    response(500, 'Invalid request');
}