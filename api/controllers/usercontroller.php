<?php
    require_once('models/user.php');
    require_once('models/message.php');

    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '')
            echo User::get($parameter);
        else
            echo User::get();
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Validar que existan los campos requeridos
        $required_fields = ['first_name', 'last_name', 'email', 'password', 'phone'];
        $missing_fields = array_filter($required_fields, function($field) {
            return !isset($_POST[$field]) || empty($_POST[$field]);
        });

        if (!empty($missing_fields)) {
            echo Message::get_message(999, 'Missing required fields: ' . implode(', ', $missing_fields));
            exit;
        }

        // Crear nuevo usuario con los datos del POST
        $user = new User($_POST);
        echo $user->add();
    }
?>