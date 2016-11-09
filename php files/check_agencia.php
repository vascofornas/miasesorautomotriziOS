<?php
header("Content-type: application/json");


function connecter()
{
    $connect=@mysql_connect("localhost", "miasesor_marcabl", "Papa020432");
    if(!$connect)
    {
    echo "Erreur de connexion a la base de donnees";
    exit;
    }
    $select=@mysql_select_db('miasesor_marcablanca');   
    if(!$select)
    {
    echo "Erreur de connexion a la base de donnees";
    exit;
    }
}
connecter();

$codigo=$_POST['codigo'];

$query="SELECT id_agencia,nombre_agencia,codigo_agencia FROM `tb_agencias` WHERE `codigo_agencia` LIKE '$codigo'";
mysql_query("SET CHARACTER SET utf8");
 $result=mysql_query($query);
 $num=mysql_num_rows($result);
 $row=mysql_fetch_row($result);
 $id_agencia=$row[0];
 $nombre_agencia=$row[1];
 
 $codigo_agencia=$row[2];

if($num !=1){
    $erreur=0;
}else{
    $erreur=1;
}

echo '{  "error":'.$erreur.', "nombre_agencia":"'.$nombre_agencia.'", "id_agencia":"'.$id_agencia.'", "codigo_agencia":"'.$codigo_agencia.'"  }';