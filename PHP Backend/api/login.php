<?php
header('Content-Type: application/json');
require_once 'conn.php';
require_once 'common/hash_password.php';

// Prevent unauthorized access
if (isset($_POST['process']) && $_POST['process'] == 'login') {
    // Get the email and password, if empty return an error
    if (empty($_POST['email']) || empty($_POST['password'])) {
        response(400, 'Missing required fields');
        exit;
    }

    $email = $_POST['email'];
    $password = $_POST['password'];

    $query_row = DB::queryFirstRow("SELECT u.*, ud.discord_id FROM users u 
                                    LEFT JOIN user_discord ud ON ud.user_id = u.user_id
                                    WHERE u.email = %s", $email);

    if ($query_row !== null) {
        $user_id = $query_row['user_id'];
        $hash = $query_row['password'];

        // Check if the password is correct
        if (compare_password($password, $hash)) {
            // Get image
            $imageName = DB::queryFirstField('SELECT i.image_name
                                        FROM images i
                                        WHERE i.reference_id=%i AND i.type=1', $user_id);


            $requestBody = [
                'user_id' => $query_row['user_id'],
                'username' => $query_row['username'],
                'email' => $query_row['email'],
                'image' => $imageName ?? '',
                'discord_id' => $query_row['discord_id'],
                'status' => $query_row['status'],
                'created_date' => $query_row['created_date'],
                'updated_date' => $query_row['updated_date']
            ];
            response(200, $requestBody);
            exit;
        }
    }
    response(400, 'Invalid username or password');
} else {
    response(400, 'Unauthorized access');
}