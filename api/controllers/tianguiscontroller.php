<?php
    require_once('models/tianguis.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') {
            echo Tianguis::get($parameter);
        } else {
            echo Tianguis::get();
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validar campos requeridos
        $required_fields = ['name', 'description', 'address', 'latitude', 'longitude'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Crear nuevo tianguis
        $tianguis = new Tianguis($_POST);
        echo $tianguis->add();
    }
?>