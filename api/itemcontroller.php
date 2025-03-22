<?php
    require_once('models/item.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo Item::get($parameter);
        } else {
            echo Item::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validate required fields
        $required_fields = ['name', 'description', 'price', 'stand', 'owner', 'status', 'category'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Validate price format
        if (!is_numeric($_POST['price']) || $_POST['price'] < 0) {
            echo Message::get_message(999, 'Invalid price format');
            exit;
        }

        // Create new item
        $item = new Item($_POST);
        echo $item->add();
    }
?>