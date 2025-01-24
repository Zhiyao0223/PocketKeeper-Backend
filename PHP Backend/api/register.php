<?php
require_once ('conn.php');
require_once ('common/upload_image.php');
require_once 'common/hash_password.php';

// Prevent unauthorized login
if (isset($_POST['process'])) {
    if ($_POST['process'] == 'register') {
        // Get the data from the form
        if (!isset($_POST['username']) || !isset($_POST['password']) || !isset($_POST['email'])) {
            response(500, 'Missing required fields');
            exit;
        }

        // Check if the email already exists
        $username = $_POST['username'];
        $password = $_POST['password'];
        $email = $_POST['email'];

        $user = DB::queryFirstRow("SELECT * FROM users WHERE email = %s", $email);
        if ($user != null) {
            response(500, 'Email already exists');
            exit;
        }

        // Insert into database
        DB::insert('users', [
            'username' => $username,
            'password' => hash_password($password),
            'email' => $email
        ]);

        // Check if insertId is not empty
        $id = DB::insertId();
        if ($id == null) {
            response(500, 'User registration failed');
            exit;
        }
    }
    // Google Sign In
    else if ($_POST['process'] == 'social_register') {
        // Get the data from the form
        if (!isset($_POST['email']) || !isset($_POST['password']) || !isset($_POST['image_url']) || !isset($_POST['username'])) {
            response(500, 'Missing required fields');
            exit;
        }

        // Initialize variables
        $email = $_POST['email'];
        $password = $_POST['password'];
        $image_url = $_POST['image_url'];
        $username = $_POST['username'];

        // Register user
        DB::insert('users', [
            'username' => $username,
            'password' => hash_password($password),
            'email' => $email
        ]);
        $userId = DB::insertId();

        // Upload image to server if not empty
        if ($image_url != null) {
            $image_name = uploadImage($image_url);
        }

        // Insert Image
        DB::insert('images', [
            'reference_id' => $userId,
            'image_name' => $image_name ?? "",
            'type' => '1'
        ]);
        $imageId = DB::insertId();

        if ($userId == null || $imageId == null) {
            response(500, 'User registration failed');
            exit;
        }

        $id = $userId;
    } else {
        response(500, 'Invalid process');
        exit;
    }

    // Get the user data
    $user = DB::queryFirstRow("SELECT * FROM users WHERE user_id = %i", $id);

    // Get requestBody
    $requestBody = [
        'username' => $user['username'],
        'email' => $user['email'],
        'status' => $user['status'],
        'created_date' => $user['created_date'],
        'updated_date' => $user['updated_date'],
        'user_id' => $id,
    ];
    response(200, $requestBody);
} else {
    response(400, 'Invalid request');
}