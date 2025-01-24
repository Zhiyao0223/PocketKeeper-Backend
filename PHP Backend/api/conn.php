<?php
// In case later on change database folder, we can just change this file to apply for all API
require_once '../db/config.php';

// For JSON response
require_once ('common/response.php');

// Prevent relative path from causing error
$root_directory = $_SERVER['DOCUMENT_ROOT'];