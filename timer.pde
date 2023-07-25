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
  displayName2(name2);
  displayName3(name3);
  displayName4(name4);
}

void keyPressed(){
  switch (key){
    case '1':
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
    break;
    case '2':
    name2="Hola \n José Domingo Aguilar";
      if(!printing2.isPlaying()){
        printing2.play();
      }
    break;
    case '3':
      name3="Hola \n Claritza Arredondo";
      if(!printing3.isPlaying()){
        printing3.play();
      }
    break;
    case '4':
      name4="Hola \n Luis Heredia";
      if(!printing4.isPlaying()){
        printing4.play();
      }
    break;
  }
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

void displayName1(String names){
  String name=names;
  stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1,height/2-printing1.height/2, printing1.width, printing1.height);
  println(name);
  fill(0,50);
  //rect(width*.1,height/2-printing1.height/2, printing1.width, printing1.height);
  fill(255);
  if(dN10>=0){dN10-=10;}
  if(dN10<=0 && dN11<=384){dN11+=9;}
  if(dN11>=384 && dN12>=0){dN12-=9;}
  if(dN12<=0 && dN13<=680){dN13+=7;}
  if(dN13>=680 && dN14>=0){dN14-=3;}
  if(dN14<=0 && dN15<=384){dN15+=3;}
  if(dN15>=384 && dN16>=0){dN16-=4;}
  stroke(255,0);
  rect(width*.1,height/2-printing1.height/2, dN10, printing1.height/8);
  rect(width*.1+dN11,height/2-printing1.height/2+printing1.height/8, printing1.width-dN11, printing1.height/5);
  rect(width*.1,height/2-printing1.height/2+printing1.height*3/8, dN12, printing1.height/7);
  rect(width*.1+dN13,height/2-printing1.height/2+printing1.height*4/8, printing1.width-dN13, printing1.height/5);
  rect(width*.1,height/2-printing1.height/2+printing1.height*6/8, dN14, printing1.height/5);
  //rect(width*.1+dN15,height/2-printing1.height/2+printing1.height*6/8, printing1.width-dN15, printing1.height/8);
  image(printing1, width*.1,height/2-printing1.height/2);
  
}

void displayName2(String names){
  String name=names;
  stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2, printing2.width, printing2.height);
  println(name);
  image(printing2, width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2);
  fill(0,50);
  //rect(width*.1+width*.025*1+printing2.width*1,height/2-printing2.height/2, printing2.width, printing2.height);
  if(dN10>=0){dN10-=10;}
  if(dN10<=0 && dN11<=384){dN11+=9;}
  if(dN11>=384 && dN12>=0){dN12-=9;}
  if(dN12<=0 && dN13<=680){dN13+=7;}
  if(dN13>=680 && dN14>=0){dN14-=3;}
  if(dN14<=0 && dN15<=384){dN15+=3;}
  if(dN15>=384 && dN16>=0){dN16-=4;}
  stroke(255,0);
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
  stroke(0);
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
  stroke(0);
  fill(0,12,54);
  textAlign(CENTER,CENTER);
  textSize(36);
  text(name,width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2, printing4.width, printing4.height);
  println(name);
  image(printing4, width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2);
  fill(0,50);
  //rect(width*.1+width*.025*3+printing4.width*3,height/2-printing4.height/2, printing4.width, printing4.height);

}
