<?php

require_once ('conn.php');

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

response(200, $response_body);