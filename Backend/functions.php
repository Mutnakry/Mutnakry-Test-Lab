<?php
class functions
{
    private $db;
    private $sql;
    private $result;

    function __construct()
    {
        require_once 'connection.php';
        $this->db = new DBconnection();
    }

    function __destruct()
    {
        // Close the connection when the object is destroyed
        $this->db->connect()->close();
    }

    public function insert_data($tablename, $fields, $values)
    {
        // Count the fields
        $count = count($fields);

        // Start the INSERT SQL query
        $this->sql = "INSERT INTO $tablename (";

        // Add field names to the query
        for ($i = 0; $i < $count; $i++) {
            $this->sql .= $fields[$i];
            if ($i < $count - 1) {
                $this->sql .= ", ";
            } else {
                $this->sql .= ") VALUES (";
            }
        }

        // Add corresponding values to the query
        for ($i = 0; $i < $count; $i++) {
            $this->sql .= "'" . $values[$i] . "'";
            if ($i < $count - 1) {
                $this->sql .= ", ";
            } else {
                $this->sql .= ")";
            }
        }

        // Execute the query
        $conn = $this->db->connect(); // Get the database connection
        $this->result = $conn->query($this->sql);

        // Check if the query was successful
        if ($this->result === true) {
            return true; // Insert successful
        } else {
            return false; // Insert failed
        }
    }
}
