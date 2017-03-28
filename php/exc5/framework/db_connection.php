<?php

class DBConnection {
    public $host   = "localhost";
    public $db     = "electives";
    public $user   = "root";
    public $pass   = "";

    private static $instance = null;

    function __construct() {
        $this->conn = new PDO("mysql:host={$this->host};dbname={$this->db}", $this->user, $this->pass);
    }

    static function get_instance() {
        if (!self::$instance) {
            self::$instance = new self();
        }

        return self::$instance;
    }
}
