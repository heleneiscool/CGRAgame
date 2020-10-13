abstract class Obstacle{
  float size = 25;
  float position=0.5;
  //coordinates for left-top coner of shape
  float change = width/8;
  float x =width-frameCount%width;
  float y = height/2-size/2;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
  void drawObstacle(){}
    boolean check(Ball user){return false;}
   //void clip(){}
  void setCoords(float x, float y){this.x=x;this.y=y;}
}
