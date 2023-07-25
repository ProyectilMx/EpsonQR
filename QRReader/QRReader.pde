//Libraries
import de.bezier.data.sql.*;  //Biblioteca para consultar bases de datos
import processing.video.*;    //Biblioteca para la ejecución de videos
import processing.serial.*;


////Variables
String QRmsg="";  //Cadena para guardar la información del lector de QR
Boolean flagPass=false;
Boolean flagNOPass=false;
Boolean flagError=false;
int Time=2000; //2 Segundos
int StartTimer=0;
int Timer=0;

//Database variable
MySQL dbconnection;
String user="proye214_munaviqr";
String password="Munavi-PMX";
String database = "proye214_munavi";
String table = "asistente";
String host = "proyectil.tech";

////Imagenes
PImage logo;      
PImage fondo;
PImage PASS, NOPASS;
PImage QRCodeLogo;
PImage DatabaseError;

//Flags
Boolean personDetected=false;
Boolean qrscaned=false;
Boolean used=false;
Boolean found=false;
//Video
Movie video;

//Fonts
PFont munaviFont;
PFont munaviLFont;

///Images and icons
PImage logoMunavi;
PImage geoIcon;
PImage openIcon;
PImage closeIcon;
PImage arrow;
PImage registryQR;


////Serial communication
Serial myPort;
char char2Send;
char inChar;
Boolean flagSensorError=false;
timer detectionTimer = new timer();

////Función de setup
void setup(){
  fullScreen();    
  background(0);   
  logo=loadImage("FS_TitleF.png");
  fondo=loadImage("munavi.png");
  fondo.resize(width,height);
  PASS=loadImage("PASS.png");
  NOPASS=loadImage("NOPASS.png");
  QRCodeLogo=loadImage("qrcodescan.png");
  QRCodeLogo.resize(256,256);
  DatabaseError=loadImage("database.png");
  DatabaseError.resize(256,256);
  
  video = new Movie(this, "Teaserlong.mp4");
  video.loop();
  //video.stop();
  
  logoMunavi=loadImage("MUNAVI_Logo_Red.png");
  logoMunavi.resize(logoMunavi.width/4,0);
  geoIcon=loadImage("ubicacion.png");
  geoIcon.resize(28,28);
  openIcon=loadImage("circuloVerde.png");
  closeIcon=loadImage("circuloRojo.png");
  openIcon.resize(28,28);
  closeIcon.resize(28,28);
  registryQR=loadImage("registryqr.png");
  registryQR.resize(290,290);
  arrow=loadImage("rarrow.png");
  arrow.resize(128,128);
  munaviFont = createFont("Sohne-Halbfett.otf",128);
  munaviLFont = createFont("Sohne-Leicht.otf",128);
  
  String portName="";
  printArray(Serial.list());
  for(int i=0; i<Serial.list().length; i++){
    if(Serial.list()[i].indexOf("ACM") > 0 ||  Serial.list()[i].indexOf("USB") > 0){
      portName=Serial.list()[i];
    }
  }
  if(portName!=""){
    myPort = new Serial(this, portName, 9600);
  }
  else{
    flagSensorError=true;
    println("Hay un error con el sensor de presencia. Contacta a soporte o utiliza un teclado USB.");
    background(0);
    text("Hay un error con el sensor de presencia. Contacta a soporte o utiliza un teclado USB.", width/2,height/2,width/height);
    noLoop();
  }
  
  imageMode(CENTER);  
}


void movieEvent(Movie m){
  m.read();
}

////Función principal (loop)
void draw(){
  background(0,0,0);
  if(flagSensorError){
    background(0);
    textAlign(CENTER,CENTER);
    textSize(32);
    text("Hay un error con el sensor de presencia. Contacta a soporte o utiliza un teclado USB.", width/2,height/2,width/height);
    noLoop();
  }
  else{
    //image(logo, width/2, height/3);
    if(!personDetected && detectionTimer.Ended()){
      standby();
    }
    else{
      scanQR();
      //welcomeQR();
      //pass();
    }
  }
}

void standby(){
  image(video, width/2,height/2, width,height);  
}

void welcomeQR(){
  imageMode(CENTER);
  fill(0);
  textAlign(LEFT);
  background(231,231,231);
  image(geoIcon,width*.065,height*.075);
  image(openIcon,width*.85,height*.075);
  image(logoMunavi,width/2,height*.075);
  textFont(munaviLFont);
  textSize(20);
  text("CDMX, MÉXICO", width*.065+geoIcon.width,height*.075+geoIcon.height/4);
  text("ABIERTO AHORA", width*.85+openIcon.width,height*.075+openIcon.height/4);
  textAlign(LEFT,CENTER);
  textFont(munaviFont);
  textSize(128);
  text("¡Hola, "+wname+"!", width*.05+openIcon.width,height*.5+openIcon.height/4);
  textFont(munaviLFont);
  textSize(24);
  text("Número de reservación: ",width*.55+openIcon.width,height*.5-openIcon.height*5);
  text("Nombre completo: ",width*.55+openIcon.width,height*.5-openIcon.height*3);
  text("Fecha: ",width*.55+openIcon.width,height*.5-openIcon.height);
  text("Hora: ",width*.55+openIcon.width,height*.5+openIcon.height);
  text("Número de visitas: ",width*.55+openIcon.width,height*.5+openIcon.height*3);
  text("Asistencia: ",width*.55+openIcon.width,height*.5+openIcon.height*5);
  textFont(munaviFont);
  textSize(24);
  text(userCode,width*.75+openIcon.width,height*.5-openIcon.height*5);
  text(name,width*.75+openIcon.width,height*.5-openIcon.height*3);
  text(date,width*.75+openIcon.width,height*.5-openIcon.height);
  text(time,width*.75+openIcon.width,height*.5+openIcon.height);
  text(qty,width*.75+openIcon.width,height*.5+openIcon.height*3);
  text(chair,width*.75+openIcon.width,height*.5+openIcon.height*5);
  
}

void scanQR(){
  fill(255);
  image(geoIcon,width*.065,height*.075);
  image(openIcon,width*.85,height*.075);
  image(logoMunavi,width/2,height*.075);
  textFont(munaviLFont);
  textSize(20);
  textAlign(LEFT);
  text("CDMX, MÉXICO", width*.065+geoIcon.width,height*.075+geoIcon.height/4);
  text("ABIERTO AHORA", width*.85+openIcon.width,height*.075+openIcon.height/4);
  
  image(registryQR, width*.75,height*.425);
  textFont(munaviFont);
  textSize(48);
  text("¿No tienes reservación?", width*.75-registryQR.width/2,height*.7);
  textFont(munaviLFont);
  textSize(40);
  text("Escanea este código ", width*.75-registryQR.width/2,height*.8);
  text("para programar tu visita",width*.75-registryQR.width/2,height*.8+48);
  if(!qrscaned){
    bienvenido();
  }
  else{
    if(found && used){
      qrUsed();
    }
    else if(!found){
      qrNotFound();
    }
    else if(found){
      welcomeQR();
    }
  }
  

}

void bienvenido(){
  textFont(munaviFont);
  textSize(144);
  text("Te damos", width*.05,height*.4);
  text("la bienvenida", width*.05,height*.4+144);
  text("al Munavi.", width*.05,height*.4+288);
  
  image(arrow,width*.375,height*.825);
  textFont(munaviLFont);
  textSize(40);
  text("Escanea tu código en la parte", width*.05,height*.8);
  text("inferior de este tótem", width*.05,height*.8+48);
  
}

void qrNotFound(){
  textFont(munaviFont);
  textSize(96);
  text("Lo sentimos,", width*.05,height*.685-128);
  text("no se ha encontrado", width*.05,height*.700);
  text("tu reservación", width*.05,height*.720+128);
}

void qrUsed(){
  textFont(munaviFont);
  textSize(96);
  text("Este código ya", width*.05,height*.4);
  text("fue usado.", width*.05,height*.4+128);
  textFont(munaviLFont);
  textSize(34);
  text("Intenta escanear otro código QR que sea válido", width*.05,height*.8);
}


////Función del teclado
//El lector de QR convierte el código QR en texto como si hubiera sido introducido por el teclado.
//El formato del código QR sería algo como TerrorXXXXID (Terror000054)
String auxString="";
int auxPressed=0;
boolean flagQR=true;
void keyPressed(){
  if (keyCode == UP){
    personDetected=true;
    found=false;
    used=false;
    qrscaned=false;
    video.stop();
  }
  if (keyCode == DOWN){
    personDetected=false;
    found=false;
    used=false;
    qrscaned=false;
    video.loop();
  }
  if (keyCode == LEFT){
    used=true;
    qrscaned=true;
    println("used");
  }
  if (keyCode == RIGHT){
    found=false;
    qrscaned=true;
  }
  
  flagPass=false;
  flagNOPass=false;
  
  if(personDetected){
    char pressed = key;
    println(pressed);
    auxString+=pressed;
    
    ////Enter validates QR
    if(keyCode==ENTER){
      int indexHash=auxString.indexOf("#")+1;
      if(indexHash<0){
        SearchData(auxString);
        auxString="";
      }
      else{
        flagQR=true;
        String QRmsg=auxString.substring(indexHash,auxString.length()-1);
        SearchData(QRmsg);
        auxString="";
        QRmsg="";
      }
    }
  }  
}

void Welcoming(String QRmsg){
  println(QRmsg);
  flagPass=true;
}

void SearchData(String QRmsg){
  println(QRmsg);
  //flagNOPass=true;
    Database(QRmsg);
}

String userCode="";
String name="";
String wname="";
String mail="";
String phone="";
String date="";
String time="";
String qty="";
String chair="";
String confirm="";


void Database(String QRmsg){
  //Database connection
  println("Searching for database");
  flagQR=false;
  dbconnection = new MySQL( this, host, database, user, password);
  if (dbconnection.connect()) {
    flagError=false;
    println("Before query");
    // now read it back out
    //String Query="SELECT * FROM "+table+" WHERE ID = '"+QRmsg+"';";
    String sCompare="'"+QRmsg+"'";
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
      used=false;
    }
    //////Si el valor es mayor o igual a 1 entonces prosigue, si no, termina el proceso y muestra el error.
    if(found){
      dbconnection.query( "SELECT * FROM %s WHERE codigoQR = %s", table, sCompare);
      dbconnection.next();
      userCode=sCompare;
      name=dbconnection.getString("nombre");
      println(name);
      String []nameToShow = split(name, ' ');
      wname = nameToShow[0];
      mail=dbconnection.getString("email");
      phone=dbconnection.getString("telefono");
      String dateTime=dbconnection.getString("fechaHoraReservacion");
      date=dateTime.substring(0,11);
      time=dateTime.substring(12,17);
      qty=dbconnection.getString("numeroRegistros");
      chair=dbconnection.getString("accesibilidad");
      confirm=dbconnection.getString("asistencia");
      println(confirm);
      if(int(confirm)==1){
        used=true;
      }
      else{
        used=false;
      }
      dbconnection.query( "UPDATE %s SET asistencia = 1 WHERE codigoQR = %s", table, sCompare);
      dbconnection.next();
    }
    qrscaned=true;
    println("After query");
    //println("Bienvenido "+ nameToShow[0]);
  }
  else{
     flagError=true;
     println("Not connected to database");
  }
}

////Función que muestra si puede pasar o no.
//Básicamente si el registro esta bien o no hay un registro para ese valor.
void pass(){
  //Si existe el registro despliega overlay verde y simbolo de pasar.
  if (flagPass){
    fill(2,252,94,50); ///Green
    //fill(252,44,3); ///Red
    rect(0,0,width,height);
    //image(PASS, width/2, height*2/3);
    println(QRmsg);
    if(millis()-StartTimer>Time){
      flagPass=false;
      flagNOPass=false;
      flagError=false;
    }
  }
  //Si NO existe el registro despliega overlay rojo y simbolo de NO pasar.
  else if (flagNOPass){
    fill(252,44,3,50); ///Red
    rect(0,0,width,height);
    //image(NOPASS, width/2, height*2/3);
    println(QRmsg);
    if(millis()-StartTimer>Time){
      flagPass=false;
      flagNOPass=false;
      flagError=false;
    }
  }
  else if(flagError){
       image(DatabaseError, width/2, height*2/3);
  }
  //Si ninguna bandera esta activa no hace nada o puede desplegar mensaje de leer código QR.
  else{
    //image(QRCodeLogo, width/2, height*2/3);
  }
}


void serialEvent(Serial myPort){
  inChar = char(myPort.read());
  println(inChar);
  println(inChar=='0');
  if(inChar=='0'){
    personDetected=true;
    detectionTimer.Start(20000);
  }
  else{
    if(personDetected=true){
      detectionTimer.Start(20000);
    }
    personDetected=false;
  }
}
