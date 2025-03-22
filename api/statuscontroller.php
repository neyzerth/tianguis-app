<?php
    require_once('models/status.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo Status::get($parameter);
        } else {
            echo Status::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validar campos requeridos
        $required_fields = ['code', 'name'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Crear nuevo status
        $status = new Status($_POST);
        echo $status->add();
    }
?>