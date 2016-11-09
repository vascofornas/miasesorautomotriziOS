<?php 


 

 
function connectDB(){
 
        $server = "localhost";
        $user = "miasesor_marcabl";
        $pass = "Papa020432";
        $bd = "miasesor_marcablanca";
 
    $conexion = mysqli_connect($server, $user, $pass,$bd);
 
        if($conexion){
  ;
        }else{
  ;
        }
 
    return $conexion;
}
 
function disconnectDB($conexion){
 
    $close = mysqli_close($conexion);
 
        if($close){
  ;
        }else{
 ;
        }   
 
    return $close;
}
 
function getArraySQL($sql){
    //Creamos la conexión con la función anterior
    $conexion = connectDB();
 
    //generamos la consulta
 
        mysqli_set_charset($conexion, "utf8"); //formato de datos utf8
 
 $agencia = $_GET['agencia'];
 
 $sql = "SELECT * FROM tb_asesores WHERE agencia_asesor = '".$agencia."'";
    if(!$result = mysqli_query($conexion, $sql)) die(); //si la conexión cancelar programa
 
    $rawdata = array(); //creamos un array
 
    //guardamos en un array multidimensional todos los datos de la consulta
    $i=0;
 
    while($row = mysqli_fetch_array($result))
    {
        $rawdata[$i] = $row;
        $i++;
		
    }
 
    disconnectDB($conexion); //desconectamos la base de datos
 
    return $rawdata; //devolvemos el array
}
 
        $myArray = getArraySQL($sql);
        echo json_encode($myArray);
?>