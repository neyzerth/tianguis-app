<?php
    require_once('models/tianguis_schedule.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo TianguisSchedule::get($parameter);
        } else {
            echo TianguisSchedule::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validar campos requeridos
        $required_fields = ['tianguis_id', 'day_of_week', 'start_time', 'end_time'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Crear nuevo horario
        $schedule = new TianguisSchedule($_POST);
        echo $schedule->add();
    }
?>