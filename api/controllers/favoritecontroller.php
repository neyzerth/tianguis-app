<?php
    require_once('models/favorite.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if (isset($_GET['item']) && isset($_GET['user'])) {
            echo Favorite::get($_GET['item'], $_GET['user']);
        } else {
            echo Favorite::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validate required fields
        $required_fields = ['item', 'user'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Add favorite
        $favorite = new Favorite($_POST);
        echo $favorite->add();
    }

    if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
        parse_str(file_get_contents('php://input'), $_DELETE);
        
        // Validate required fields
        if (!isset($_DELETE['item']) || !isset($_DELETE['user'])) {
            echo Message::get_message(999, 'Missing item or user ID');
            exit;
        }

        // Remove favorite
        $favorite = new Favorite($_DELETE);
        echo $favorite->delete();
    }
?>