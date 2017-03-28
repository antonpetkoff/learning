<?php

class WebApp {
    function process_request() {
        $query = $_GET['q'];

        if ($query) {
            $query_arr = explode('/', $query);
            $controller = $query_arr[0];
            $action = $query_arr[1];
        } else {
            $controller = 'courses';
            $action = 'all';
        }

        $controller_file = "framework/app/controllers/$controller.php";

        if (file_exists($controller_file)) {
            require($controller_file);
        } else {
            die('No such controller available!');
        }

        $controller_name = ucfirst($controller) . 'Controller';

        $instance = new $controller_name();
        $instance->$action();
    }
}
