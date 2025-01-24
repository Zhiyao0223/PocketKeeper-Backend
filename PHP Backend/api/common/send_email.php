<?php
use PHPMailer\PHPMailer\PHPMailer;

require_once 'response.php';
require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

function sendEmail($to, $subject, $body)
{
    // Due to privacy concerns, the following sensitive information is removed. Please request from the owner.
    $SMTP_HOST = "";
    $SMTP_USERNAME = "";
    $SMTP_PASSWORD = "";
    $SMTP_PORT = "465";
    $SMTP_SECURE = "ssl";

    $mail = new PHPMailer(true);

    // $mail->SMTPDebug = 2;
    $mail->isSMTP();
    $mail->SMTPKeepAlive = true;
    $mail->Host = $SMTP_HOST;
    $mail->SMTPAuth = true;
    $mail->Username = $SMTP_USERNAME;
    $mail->Password = $SMTP_PASSWORD;
    $mail->SMTPSecure = $SMTP_SECURE;
    $mail->Port = $SMTP_PORT;

    $mail->setFrom($SMTP_USERNAME, 'PocketKeeper');
    $mail->addAddress($to);
    $mail->isHTML(true);
    $mail->Subject = $subject;
    $mail->Body = $body;

    if (!$mail->send()) {
        // echo 'Mailer Error: ' . $mail->ErrorInfo;
        return 500;
    }
    return 200;
}

// require 'dotenv/src/Dotenv.php';
// require 'dotenv/src/Loader/LoaderInterface.php';
// require 'dotenv/src/Loader/Loader.php';
// require 'dotenv/src/Repository/Adapter/ServerConstAdapter.php';
// require 'dotenv/src/Repository/RepositoryInterface.php';
// require 'dotenv/src/Repository/RepositoryBuilder.php';

// Load environment variables from .env file
// $dotenv = Dotenv::createImmutable(__DIR__);
// $dotenv->load();

// HTML content for email
// $otp = '1234';
// $title = 'Forget Password OTP';
// $htmlContent = '
// <!DOCTYPE html>
// <html lang="en">
// <head>
//     <meta charset="UTF-8">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>Forget Password OTP</title>
// </head>
// <body style="font-family: Arial, sans-serif;">

//     <h2>Forget Password OTP</h2>
//     <p>Your One-Time Password (OTP) for resetting your password is:</p>
//     <h3 style="color: #ff0000;">' . $otp . '</h3>

//     <p>If you did not request this OTP, please ignore this email.</p>

//     <p>Thank you!</p>
// </body>
// </html>
// ';

// // Send email
// sendEmail('zhiyao0223@gmail.com', $title, $htmlContent);
