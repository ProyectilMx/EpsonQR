class timer{
  int startTime;
  int ellapsedTime;
  int duration;
  
  void Start(int time){
    startTime=millis();
    duration=time*1000;
  }
  
  int Ellapsed(){
    return millis()-startTime;
  }
  
  boolean Ended(){
    if(Ellapsed()>duration){
      return true;
    }
    else
      return false;
  }
}
