<?php
function response($status, $message)
{
    $response = ['status' => $status, 'body' => $message];

    header('Content-Type: application/json');
    echo json_encode($response);
}