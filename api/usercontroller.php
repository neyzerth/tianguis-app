<?php
    require_once('models/user.php');
    require_once('models/message.php');
    //GET
    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if ($parameter != '') 
            echo User::get($parameter); //get one
        else 
            echo User::get(); //get all
    }
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        if(isset($_POST['id']) && isset($_POST['name'])) {
            $b = new User($_POST['id'], $_POST['name']);
            echo $b->add();
        }
        else {
            echo Message::get_message(999, 'Missing post data');
        }
    }
?>