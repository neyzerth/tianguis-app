<?php
    //headers
    header('Access-Control-Allow-Origin: *');
     header('Content-Type: application/json; charset=UTF-8');
    //allow methods
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
    //get request URI
    $requestUri = substr($_SERVER['REQUEST_URI'], strlen(dirname($_SERVER['PHP_SELF']))); 
    //split uri parts
    $uriParts = explode('/', $requestUri); 
    //correct URI
    if (sizeof($uriParts) == 3) {
        //get URI info
        $controller = 'controllers/'.$uriParts[1];
        //parameter
        $parameter = $uriParts[sizeof($uriParts) - 1];
        //send to controllers
        $controller .= 'controller.php';
        if (file_exists($controller))
            require_once($controller); 
        else
            echo json_encode(array('status' => 998,'errorMessage' => 'Invalid Controller '.$controller));
    }
    else
        echo json_encode(array('status' => 999, 'errorMessage' => 'Invalid URI'));
?>