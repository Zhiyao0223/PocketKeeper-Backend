<?php
require_once 'conn.php';

// Read the raw POST data
$json = file_get_contents('php://input');

// Decode the JSON data
$data = json_decode($json, true);

// Now $data contains your posted values
$response_body = [
    'process' => $data['process'] ?? null,
    'remark' => $data['remark'] ?? null,
    'amount' => $data['amount'] ?? null,
    'discord_id' => $data['discord_id'] ?? null,
];

if (isset($response_body['process']) && ($response_body['process'] == 'add_expenses' || $response_body['process'] == 'add_incomes')) {
    // Get the data from the form
    if (!isset($response_body['remark']) || !isset($response_body['amount']) || !isset($response_body['discord_id'])) {
        response(500, 'Missing required fields');
        exit;
    }

    $remark = $response_body['remark'];
    $amount = intval($response_body['amount']);
    $discordId = $response_body['discord_id'];

    // Default give other category, diff by expenses and incomes
    $categoryId = $response_body['process'] == 'add_expenses' ? 16 : 21;

    // Check if code exist in database
    $userId = DB::queryFirstField("SELECT ud.user_id
                                    FROM user_discord ud
                                    WHERE ud.discord_id = %s;", $discordId);
    if (!$userId) {
        response(501, 'Please link your discord with application before using this function.');
        exit;
    }

    // Add expenses

    DB::insert('expenses', [
        'user_id' => $userId,
        'description' => $remark,
        'amount' => $amount,
        'category_id' => $categoryId,
        'sync_status' => 1,
        'status' => 0,
    ]);

    // Check if insertId is not empty
    $id = DB::insertId();
    if ($id == null) {
        response(500, 'Add expenses failed');
        exit;
    }

    response(200, "Success");
} else {
    response(500, "Invalid request");
}
