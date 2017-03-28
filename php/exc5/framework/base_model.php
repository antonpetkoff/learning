<?php

require('framework/db_connection.php');

class BaseModel {

    function __construct() {
        $this->conn = DBConnection::get_instance()->conn;
    }

    function get_all() {
        $sql = "SELECT * FROM {$this->table_name}";
        $query = $this->conn->query($sql) or die ('query failed!');

        $result = array();
        while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            $result[] = $row;   // push to array
        }
        return $result;
    }


}
