<?php
    require_once('models/stand.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo Stand::get($parameter);
        } else {
            echo Stand::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validate required fields
        $required_fields = ['name', 'description', 'owner', 'category'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Create new stand
        $stand = new Stand($_POST);
        echo $stand->add();
    }
?>