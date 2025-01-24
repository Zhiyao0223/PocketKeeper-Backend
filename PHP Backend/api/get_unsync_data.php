<?php
require_once 'conn.php';

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'get_unsync') {
    if (!isset($_POST['email'])) {
        response(501, 'Missing required fields');
        exit;
    }

    $email = $_POST['email'];
    $user_id = DB::queryFirstField("SELECT user_id FROM users WHERE email=%s", $email);

    if (!$user_id) {
        response(500, 'User is not registered');
        exit;
    }

    // Get all blog data from db
    $expenses = DB::query("SELECT * FROM expenses WHERE sync_status = 1 AND user_id = %i", $user_id);

    // Update sync_status to 1
    DB::query("UPDATE expenses SET sync_status = 0 WHERE sync_status = 1 AND user_id = %i", $user_id);

    // Get requestBody
    $requestBody = [
        'expenses' => $expenses,
    ];
    response(200, $requestBody);
} else {
    response(400, 'Invalid request');
}
