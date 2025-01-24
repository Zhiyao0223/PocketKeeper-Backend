<?php
require_once 'conn.php';

// Read the raw POST data
$json = file_get_contents('php://input');

// Decode the JSON data
$data = json_decode($json, true);

// Now $data contains your posted values
$response_body = [
    'process' => $data['process'] ?? null,
    'code' => $data['code'] ?? null,
    'discord_id' => $data['discord_id'] ?? null
];

if (isset($response_body['process']) && $response_body['process'] == 'link_account') {
    // Get the data from the form
    if (!isset($response_body['code']) || !isset($response_body['discord_id'])) {
        response(500, 'Missing required fields');
        exit;
    }

    $code = $response_body['code'];
    $discord_id = $response_body['discord_id'];

    // Check if code exist in database
    $checkCode = DB::queryFirstRow("SELECT ud.ud_id, u.email FROM user_discord ud
                                    INNER JOIN users u ON u.user_id = ud.user_id
                                    WHERE ud.authorization_code = %s AND ud.status=1 AND ud.discord_id IS NULL;", $code);
    if (!$checkCode) {
        response(501, 'Invalid code');
        exit;
    }

    // Update user status
    DB::update('user_discord', [
        'discord_id' => $discord_id,
        'status' => 0
    ], 'ud_id=%s', $checkCode['ud_id']);

    $responseBody = [
        'email' => $checkCode['email']
    ];

    response(200, $responseBody);
} else {
    response(500, "Invalid request");
}