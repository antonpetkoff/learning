<?php

require('framework/base_controller.php');
require('framework/app/models/users.php');

class UsersController extends BaseController {

    function register() {
        $errors = array();

        if ($_POST) {
            $email = $_POST['email'];
            $password = $_POST['password'];
            $password_confirm = $_POST['confirm'];

            if (!$email) {
                $errors[] = 'Email required'; // append to the array
            }

            if (!$password) {
                $errors[] = 'Password required'; // append to the array
            }

            if ($password && $password_confirm && $password !== $password_confirm) {
                $errors[] = 'Password mismatch'; // append to the array
            }

            // TODO: persist user only if empty($errors)

            $model = new Users;
            $result = $model->register($email, $password);
            if ($result) {
                $_SESSION['user_email'] = $email;
                header('Location: index.php?q=site/home');
            } else {
                $errors[]= "Error while registering.";
                var_dump($result);
            }
        }

        $params = array('errors' => $errors);
        $this->render('users/register', $params);
    }

    function login() {
        $errors = array();

        if ($_POST) {
            $email = $_POST['email'];
            $password = $_POST['password'];

            if (!$email) {
                $errors[] = 'Email required'; // append to the array
            }

            if (!$password) {
                $errors[] = 'Password required'; // append to the array
            }

            // TODO: persist user only if empty($errors)

            $model = new Users;
            $result = $model->login($email, $password);
            if ($result) {
                $_SESSION['user_email'] = $email;
                header('Location: index.php?q=site/home');
            } else {
                $errors[]= "Error while loging in.";
                var_dump($result);
            }
        }

        $params = array('errors' => $errors);
        $this->render('users/login', $params);
    }

    function logout() {
        session_destroy();
        header('Location: index.php?q=site/home');
    }

}
