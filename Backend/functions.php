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

    public function update_data($tablename, $fields, $values, $fid, $vid)
    {
        $count = count($fields);
        $this->sql = "UPDATE $tablename SET ";
        for ($i = 0; $i < $count; $i++) {
            $this->sql .= $fields[$i] . "='" . $values[$i] . "'";
            if ($i < $count - 1) {
                $this->sql .= ", ";
            } else {
                $this->sql .= " WHERE $fid='$vid';";
            }
        }

        $this->result = $this->db->connect()->query($this->sql);
        if ($this->result === true) {
            return true;
        } else {
            return false;
        }
    }


    public function get_data($tablename, $fields = '*', $conditions = null)
{
    // Construct the SQL query
    $this->sql = "SELECT $fields FROM $tablename";

    // Append conditions if provided
    if ($conditions != null) {
        $this->sql .= " WHERE $conditions";
    }

    $conn = $this->db->connect(); // Get the database connection
    $this->result = $conn->query($this->sql);

    // Check if query execution was successful
    if ($this->result->num_rows > 0) {
        $data = array();

        // Fetch all rows as associative arrays
        while ($row = $this->result->fetch_assoc()) {
            $data[] = $row;
        }

        return $data; // Return the fetched data
    } else {
        return false; // No rows found or query error
    }
}

}
