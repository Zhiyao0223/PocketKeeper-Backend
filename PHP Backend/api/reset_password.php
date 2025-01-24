<?php
require_once ('conn.php');
require_once ('common/hash_password.php');

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'change_pass') {
    // Get the data from the form
    if (!isset($_POST['email']) || !isset($_POST['password'])) {
        response(500, 'Missing required fields');
        exit;
    }

    // Check if the username already exists
    $password = $_POST['password'];
    $email = $_POST['email'];

    // Insert into database
    DB::update('users', [
        'password' => hash_password($password),
    ], 'email = %s', $email);

    // Get requestBody
    $requestBody = [
        'message' => 'Password changed successfully',
    ];
    response(200, $requestBody);
} else {
    response(400, 'Invalid request');
}