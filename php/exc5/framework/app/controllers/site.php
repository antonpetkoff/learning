<?php

require('framework/base_controller.php');
require('framework/app/models/courses.php');

class SiteController extends BaseController {

    function home() {
        if ($_SESSION['visits']) {
            $_SESSION['visits'] += 1;
        } else {
            $_SESSION['visits'] = 1;
        }

        $view_params = array('visits' => $_SESSION['visits']);
        $this->render('site/home', $view_params);
    }

}
