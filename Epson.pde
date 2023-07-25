//Libraries
import de.bezier.data.sql.*;  //Biblioteca para consultar bases de datos
import gifAnimation.*;

PImage back;
PImage logo;
PImage gifEpson;

PImage[] animation;
Gif printing1;
Gif printing2;
Gif printing3;
Gif printing4;
boolean pause = false;

String name1="";
String name2="";
String name3="";
String name4="";

void setup(){
  fullScreen();
  frameRate(24);
  
  /////loadingImages
  back=loadImage("back.png");
  back.resize(width,height);
  logo=loadImage("Logo-1.png");
  logo.resize(width/8,0);
  
  ////loading gif
  printing1 = new Gif(this, "logo3.gif");
  printing2 = new Gif(this, "logo3.gif");
  printing3 = new Gif(this, "logo3.gif");
  printing4 = new Gif(this, "logo3.gif");
  printing1.play();
  printing1.ignoreRepeat();
  printing2.play();
  printing2.ignoreRepeat();
  printing3.play();
  printing3.ignoreRepeat();
  printing4.play();
  printing4.ignoreRepeat();
}

void draw(){
  background(back);
  image(logo,width*.8,height*.25);
  displayName1(name1);
}

int dN10=384;
int dN11=0;
int dN12=384;
int dN13=0;
int dN14=384;
int dN15=0;
int dN16=384;

int dN20=384;
int dN21=0;
int dN22=384;
int dN23=0;
int dN24=384;
int dN25=0;
int dN26=384;
boolean flagStart=false;
int auxStart=0;


void displayName1(String names){
  if(!flagStart){
    flagStart=true;
    auxStart=millis();
  }
  String name=names;
  stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(34);
  text(name,width*.1,height/2-printing1.height/2, printing1.width, printing1.height);
  //println(name);
  fill(0,50);
  //rect(width*.1,height/2-printing1.height/2, printing1.width, printing1.height);
  fill(255);
  if(dN10>=0){dN10-=20;}
  if(dN10<=0 && dN11<=384){dN11+=18;auxStart=millis();}
  if(dN11>=384 && dN12>=0){dN12-=24;auxStart=millis();}
  if(dN12<=0 && dN13<=384){dN13+=12;auxStart=millis();}
  //println(millis()-auxStart);
  //println("DN14="+dN14);
  if(millis()-auxStart>1000){
    //println("deleting red"+dN14);
    if(dN13>=384 && dN14>=0){dN14-=24;}
    if(dN14<=0 && dN15<=384){dN15+=24;}
    if(dN15>=384 && dN16>=0){dN16-=12;flagStart=false;}
  }
  stroke(255);
  //stroke(255,0,0);
  rect(width*.1,height/2-printing1.height/2, dN10, printing1.height/8);
  //stroke(0,255,0);
  rect(width*.1+dN11,height/2-printing1.height/2+printing1.height/8, printing1.width-dN11, printing1.height/5);
  //stroke(0,0,255);
  rect(width*.1,height/2-printing1.height/2+printing1.height*3/8, dN12, printing1.height/7);
  //stroke(255,255,0);
  rect(width*.1+dN13,height/2-printing1.height/2+printing1.height*4/8, printing1.width-dN13, printing1.height/5);
  //stroke(0,255,255);
  rect(width*.1,height/2-printing1.height/2+printing1.height*5/8, dN14, printing1.height/4);
  //rect(width*.1+dN15,height/2-printing1.height/2+printing1.height*6/8, printing1.width-dN15, printing1.height/8);
  image(printing1, width*.1,height/2-printing1.height/2);
}

void displayName2(String names){
  String name=names;
  //stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2, printing2.width, printing2.height);
  println(name);
  image(printing2, width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2);
  fill(0,50);
  //rect(width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2, printing2.width, printing2.height);
  if(dN20>=0){dN20-=20;}
  if(dN20<=0 && dN21<=384){dN21+=16;}
  if(dN21>=384 && dN22>=0){dN22-=11;}
  if(dN22<=0 && dN23<=680){dN23+=14;}
  if(dN23>=680 && dN24>=0){dN24-=5;}
  if(dN24<=0 && dN25<=384){dN25+=4;}
  if(dN25>=384 && dN26>=0){dN26-=8;}
  //stroke(255,0);
  rect(width*.1+width*.025*1+printing2.width*1,height/2-printing1.height/2, dN20, printing1.height/8);
  rect(width*.1+width*.025*1+printing2.width*1+dN21,height/2-printing1.height/2+printing1.height/8, printing1.width-dN21, printing1.height/5);
  rect(width*.1+width*.025*1+printing2.width*1,height/2-printing1.height/2+printing1.height*3/8, dN22, printing1.height/7);
  rect(width*.1+width*.025*1+printing2.width*1+dN23,height/2-printing1.height/2+printing1.height*4/8, printing1.width-dN23, printing1.height/5);
  rect(width*.1+width*.025*1+printing2.width*1,height/2-printing1.height/2+printing1.height*6/8, dN24, printing1.height/5);
  //rect(width*.1+dN15,height/2-printing1.height/2+printing1.height*6/8, printing1.width-dN15, printing1.height/8);
  image(printing1, width*.1,height/2-printing1.height/2);
}

void displayName3(String names){
  String name=names;
  //stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1+width*.025*2+printing3.width*2,height/2-printing3.height/2, printing3.width, printing3.height);
  println(name);
  image(printing3, width*.1+width*.025*2+printing3.width*2,height/2-printing3.height/2);
  fill(0,50);
  //rect(width*.1+width*.025*2+printing3.width*2,height/2-printing3.height/2, printing3.width, printing3.height);
}

void displayName4(String names){
  String name=names;
  //stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2, printing4.width, printing4.height);
  println(name);
  image(printing4, width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2);
  fill(0,50);
  //rect(width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2, printing4.width, printing4.height);

}
