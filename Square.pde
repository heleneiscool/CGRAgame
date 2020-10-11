class Square extends Obstacle{
    float size = 100;
  //coordinates for left-top coner of shape
  float change = width/8;
  float x =width-frameCount%width;
  float y = height/2-size/2;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
  ArrayList<Rotator> sections =new ArrayList<Rotator>();
  
  void drawObstacle(){
  
  }
    boolean check(Ball user){
    
    return false;
  }
}
