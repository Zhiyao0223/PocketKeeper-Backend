<?php
require_once 'hash_password.php';

$plainPassword = '123';
$hashedPassword = hash_password($plainPassword);
echo "Hashed Password: $hashedPassword\n";