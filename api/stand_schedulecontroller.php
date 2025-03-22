<?php
    require_once('models/stand_schedule.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo StandSchedule::get($parameter);
        } else {
            echo StandSchedule::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validate required fields
        $required_fields = ['day', 'stand', 'open_time', 'close_time'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Create new schedule
        $schedule = new StandSchedule($_POST);
        echo $schedule->add();
    }
?>