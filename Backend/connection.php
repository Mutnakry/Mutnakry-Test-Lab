<?php

class DBconnection
{
    private $server = "localhost";
    private $username = "root";
    private $password = "";
    private $database = "mutnakry";

    public function connect()
    {
        // Create a connection
        $conn = new mysqli($this->server, $this->username, $this->password, $this->database);

        // Check if the connection was successful
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        return $conn;
    }
}

?>