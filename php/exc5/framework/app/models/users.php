<?php

require('framework/base_model.php');

class Users extends BaseModel {

    public $table_name = 'USERS';

    function register($email, $password) {
        $sql = "INSERT INTO USERS (email, password) VALUES(?, ?)";
        $stmt = $this->conn->prepare($sql);
        $result = $stmt->execute(array($email, sha1($password)));

        return $result;
    }

    function login($email, $password) {
        $sql = "SELECT * FROM USERS WHERE email = ? AND password = ?";
        $stmt = $this->conn->prepare($sql);
        $result = $stmt->execute(array($email, sha1($password)));

        return $result;
    }

}
