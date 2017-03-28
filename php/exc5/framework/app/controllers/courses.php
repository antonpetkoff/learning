<?php

require('framework/base_controller.php');
require('framework/app/models/courses.php');

class CoursesController extends BaseController {
    function all() {
        $model = new Courses();
        $courses = $model->get_all();
        var_dump($courses);
        // $params = array('courses' => $courses);
        // $this->render('courses/all', $params);
    }

    function add() {
        $this->render('courses/add', null);
    }
}

// don't close the <?php tag