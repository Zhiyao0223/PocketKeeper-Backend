<?php

require_once 'db_class.php';

date_default_timezone_set("Asia/Kuala_Lumpur");

DB::$dbName = 'xiaowupr_pocketkeeper';
DB::$user = '';
DB::$password = '';
DB::$host = 'localhost';
DB::$error_handler = false;
DB::$throw_exception_on_error = true;

define("BASE_URL", "https://xiaowuproject.com/");
