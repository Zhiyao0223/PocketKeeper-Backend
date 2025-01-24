<?php
require_once 'conn.php';

// Prevent unauthorized login
if (isset($_POST['process']) && isset($_POST['email'])) {
  $email = $_POST['email'];
  $user_id = DB::queryFirstField("SELECT user_id FROM users WHERE email = %s", $email);

  // Link discord
  if ($_POST['process'] == 'link_discord') {
    // Get verification code
    $verificationCode = rand(1000, 9999);

    // Check if email exist in database, if exist replace existing code with new
    $checkEmail = DB::queryFirstRow("SELECT * FROM user_discord WHERE user_id = %i", $user_id);
    if ($checkEmail) {
      DB::update('user_discord', [
        'authorization_code' => $verificationCode
      ], 'user_id=%i', $user_id);
    } else {
      // Insert into database
      DB::insert('user_discord', [
        'user_id' => $user_id,
        'authorization_code' => $verificationCode,
        'status' => 1
      ]);

      // Check if insertId is not empty
      $id = DB::insertId();
      if ($id == null) {
        response(500, 'Verification code generation failed');
        exit;
      }
    }

    // Get requestBody
    $requestBody = [
      'code' => $verificationCode,
    ];
    response(200, $requestBody);
  }
  // Unlink discord
  else if ($_POST['process'] == 'unlink_discord') {
    // Check if record exist in database
    $checkEmail = DB::queryFirstRow("SELECT * FROM user_discord WHERE user_id = %i", $user_id);
    if ($checkEmail) {
      DB::update('user_discord', [
        'status' => 2
      ], 'user_id=%i', $user_id);
    }

    // Get requestBody
    $requestBody = [
      'code' => 0,
    ];

    response(200, $requestBody);
  }
  // Invalid action
  else {
    response(500, 'Invalid request');
  }

  // Get the data from the form
  if (!isset($_POST['email'])) {
    response(500, 'Missing required fields');
    exit;
  }
} 
else {
  response(500, 'Invalid request');
}
