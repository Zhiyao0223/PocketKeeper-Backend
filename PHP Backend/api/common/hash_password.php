<?php
// Hash password
function hash_password($password)
{
    return password_hash($password, PASSWORD_BCRYPT);
}

// Compare password
function compare_password($password, $hash)
{
    return password_verify($password, $hash);
}

// Test the functions
// $password = 'test@123';
// $hash = hash_password($password);

// echo "Password: $password\n";
// echo "Hash: $hash\n";

// if (compare_password($password, $hash)) {
//     echo "Password verification successful.\n";
// } else {
//     echo "Password verification failed.\n";
// }
