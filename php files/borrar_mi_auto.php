<?php
$servername = "localhost";
$username = "miasesor_marcabl";
$password = "Papa020432";
$dbname = "miasesor_marcablanca";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// sql to delete a record
$mi_auto_id = $_POST['id'];
$sql = "DELETE FROM tb_mis_autos WHERE id_mis_autos='".$mi_auto_id."'";

if ($conn->query($sql) === TRUE) {
   
} else {
    
}

$conn->close();
?> 