<?php

class BaseController {

    function render($view, $params) {
        ob_start();
        require("framework/app/views/$view.php");
        $content = ob_get_contents();
        ob_end_clean();
        require('framework/app/views/layout.php');
    }

}
