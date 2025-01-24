<?php

require_once 'conn.php';
require_once 'common/upload_image.php';

// Prevent unauthorized login
if (isset($_POST['process']) && $_POST['process'] == 'update_profile_picture') {
    // Get the data from the form
    if (!isset($_POST['email']) || !isset($_FILES['image'])) {
        response(500, 'Missing required fields');
        exit;
    }

    // Initialize variables
    $email = $_POST['email'];
    $image = $_FILES['image'];

    // Upload POST image to server
    $image_name = generateImageName();
    $image_path = $_SERVER['DOCUMENT_ROOT'] . "/pocketkeeper/assets/images/profile/" . $image_name;

    // Move the uploaded file to the target directory
    if (!move_uploaded_file($image['tmp_name'], $image_path)) {
        response(500, 'Failed to save image');
        exit;
    }

    // Get userid
    $user_id = DB::queryFirstField("SELECT user_id FROM users WHERE email=%s", $email);

    // Check if has image record
    $image_record = DB::queryFirstRow('SELECT * FROM images WHERE reference_id=%i AND type=1', $user_id);

    // Check if has record
    if ($image_record) {
        // Update image
        DB::update('images', ['image_name' => $image_name], 'reference_id=%i AND type=1', $user_id);
    } else {
        // Insert the new image
        DB::insert('images', [
            'image_name' => $image_name,
            'reference_id' => $user_id,
            'type' => 1,
            'status' => 0
        ]);
    }

    response(200, 'Profile picture updated successfully');

} else {
    response(500, 'Invalid request');
}