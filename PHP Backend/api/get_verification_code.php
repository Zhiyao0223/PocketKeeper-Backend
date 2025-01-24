<?php
require_once 'conn.php';
require_once 'common/send_email.php';

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'get_code') {
    // Get the data from the form
    if (!isset($_POST['email'])) {
        response(500, 'Missing required fields');
        exit;
    }

    // Check if the email already exists
    $email = $_POST['email'];

    // Get verification code
    $verificationCode = rand(1000, 9999);

    // Check if email exist in database, if exist replace existing code with new
    $checkEmail = DB::queryFirstRow("SELECT * FROM verification_code WHERE email = %s", $email);
    if ($checkEmail) {
        DB::update('verification_code', [
            'code' => $verificationCode
        ], 'email=%s', $email);
    } else {
        // Check if exist in user database
        $checkEmail = DB::queryFirstRow("SELECT * FROM users WHERE email = %s", $email);
        if (!$checkEmail) {
            response(501, 'Email does not registered');
            exit;
        }

        // Insert into database
        DB::insert('verification_code', [
            'email' => $email,
            'code' => $verificationCode
        ]);

        // Check if insertId is not empty
        $id = DB::insertId();
        if ($id == null) {
            response(500, 'Verification code generation failed');
            exit;
        }
    }

    // Send email
    $subject = 'Forget Password OTP';
    $body = '
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Forget Password OTP</title>
            </head>
            <body style="font-family: Arial, sans-serif;">
            
                <h2>Forget Password OTP</h2>
                <p>Your One-Time Password (OTP) for resetting your password is:</p>
                <h3 style="color: #ff0000;">' . $verificationCode . '</h3>

                <p>If you did not request this OTP, please ignore this email.</p>
            
                <p>Thank you!</p>
            </body>
            </html>
            ';

    if (sendEmail($email, $subject, $body) != 200) {
        response(500, 'Email sending failed');
        exit;
    }

    // Get requestBody
    $requestBody = [
        'verification_code' => $verificationCode,
    ];
    response(200, $requestBody);
} else {
    response(400, 'Invalid request');
}