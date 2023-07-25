String auxString="";
MySQL dbconnection;
String user="proye214_Epson";
String password="PMX-Dev3ps0n";
String database = "proye214_DSPEpson";
String table = "cliente";
String host = "proyectil.tech";

void keyPressed(){
  if (keyCode == UP){
    dN10=384;
    dN11=0;
    dN12=384;
    dN13=0;
    dN14=384;
    dN15=0;
    dN16=384;
    name1="Hola \n Zenyaze Quetzalina Lazcano Arteaga";
      if(!printing1.isPlaying()){
        printing1.play();
      }
  }
  else if (keyCode == DOWN){
  }
  else if (keyCode == RIGHT){
  }
  else{
    char pressed = key;
    println(pressed);
    auxString+=pressed;
    ////Enter validates QR
    if(keyCode==ENTER){
      name1=SearchData(auxString);
      auxString="";
    }
  }  
}

Boolean found=false;
String name="";

String SearchData(String qrcode){
   //Database connection
  println("Searching for database");
  dbconnection = new MySQL( this, host, database, user, password);
  if (dbconnection.connect()) {
    println("Before query");
    // now read it back out
    //String Query="SELECT * FROM "+table+" WHERE ID = '"+QRmsg+"';";
    String sCompare="'"+qrcode.substring(0,qrcode.length()-1)+"'";
    println(sCompare);
    ////Primero valida si existe o no el código QR en la base de datos
    //dbconnection.query( "SELECT COUNT(*) FROM %s WHERE codigoQR = %s", table, sCompare);
    dbconnection.query( "SELECT COUNT(*) FROM %s WHERE codigoQR = %s", table, sCompare);
    dbconnection.next();
    println(dbconnection.getInt(1));
    if(dbconnection.getInt(1)>=1){
      found=true;
    }
    else{
      found=false;
    }
    //////Si el valor es mayor o igual a 1 entonces prosigue, si no, termina el proceso y muestra el error.
    if(found){
      dbconnection.query( "SELECT * FROM %s WHERE codigoQR = %s", table, sCompare);
      dbconnection.next();
      name=dbconnection.getString("nombre");
      println(name);
      
      dbconnection.query( "UPDATE %s SET asistencia = 1 WHERE codigoQR = %s", table, sCompare);
      dbconnection.next();
      return name;
    }
    println("After query");
    //println("Bienvenido "+ nameToShow[0]);
  }
  else{
     println("Not connected to database");
  }
  return name;
}
