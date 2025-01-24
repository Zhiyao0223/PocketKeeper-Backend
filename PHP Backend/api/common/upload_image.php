<?php

function uploadImage($image_url)
{
    // Get the image
    $image = file_get_contents($image_url);
    if ($image === false) {
        return "";
    }

    // Generate image name
    $image_name = generateImageName();

    // Save the image
    $image_path = $_SERVER['DOCUMENT_ROOT'] . "/pocketkeeper/assets/images/profile/" . $image_name;

    // Display error if save fail
    if (file_put_contents($image_path, $image) === false) {
        $error = error_get_last();
        error_log("Failed to save image to $image_path. Error: " . $error['message']);
        return "";
    }

    return $image_name;
}

// Randomly generate image name with current timestamp
function generateImageName()
{
    return time() . rand(1000, 9999) . '.jpg';
}
