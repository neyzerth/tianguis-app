<?php
    require_once('models/image.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo Image::get($parameter);
        } else {
            echo Image::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Handle file upload
        if (!isset($_FILES['image'])) {
            echo Message::get_message(999, 'No image file uploaded');
            exit;
        }

        // Validate required fields
        $required_fields = ['order'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Handle file upload
        $upload_dir = '../uploads/';
        $file_extension = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
        $file_name = uniqid() . '.' . $file_extension;
        $file_path = $upload_dir . $file_name;

        if (!move_uploaded_file($_FILES['image']['tmp_name'], $file_path)) {
            echo Message::get_message(999, 'Failed to upload image');
            exit;
        }

        // Create image record
        $_POST['url'] = $file_name;
        $image = new Image($_POST);
        echo $image->add();
    }
?>