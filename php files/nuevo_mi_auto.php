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
$id_movil = $_POST['id_movil'];
$marca_auto = $_POST['marca_auto'];
$ano_auto = $_POST['ano_auto'];



$sql = "INSERT INTO tb_mis_autos (id_movil,modelo,ano) VALUES ('".$id_movil."', '".$marca_auto."', '".$ano_auto."' )";

if ($conn->query($sql) === TRUE) {
   
} else {
    
}

$conn->close();
?> 