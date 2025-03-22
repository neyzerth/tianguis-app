<?php
    require_once('models/stand_location.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo StandLocation::get($parameter);
        } else {
            echo StandLocation::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validate required fields
        $required_fields = ['address', 'location', 'tianguis', 'stand_info'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Create new stand location
        $location = new StandLocation($_POST);
        echo $location->add();
    }
?>