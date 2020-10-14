class Rotator extends Obstacle{
  float size = 16/width;
  //coordinates for left-top coner of shape
  float rotateWidth =width;
  float change = rotateWidth/16;
  float speed=1;
  float x =rotateWidth-(speed*frameCount)%rotateWidth;
  float y = height/2-size/2;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
Rotator(){
  size = 25;
  //coordinates for left-top coner of shape
  change = rotateWidth/16;
  x =width-(speed*frameCount)%rotateWidth;
  y = height/2-size/2;
}
Rotator(float y){
  size = 25;
  //coordinates for left-top coner of shape
  change = width/16;
  x =width-(speed*frameCount)%rotateWidth;
this.y =y;
}

  void drawObstacle() {
   if(y+size<-transY+50){return;}//above
   if(y>height-transY-50){return;}//below
  float angle =TWO_PI;
  float start=0;
  if(y<-transY+50){
  start=-atan((size/2.0-(-transY+50-y))/(size/2.0));
  angle=PI-start;
  }//part above
  if(y+size>height-transY-50){
  angle=atan(((height-transY-50)-(y+(size/2.0)))/(size/2.0));
  start=-angle-PI;
  }//part below
    strokeWeight(0);
    for (int i=0; i<16; i++) {
      fill(colors[(i)%4]);
      //if (x<-size) {
        //ellipse(x, y, size, size);
        //x+=width;
      //}
      arc(x, y, size, size, start, angle, CHORD);
      if (x<0) {
        arc(x+rotateWidth, y, size, size, start, angle, CHORD);
      }
      x=x-change;


    }
    fill(colors[0]);
    arc(-(speed*frameCount)%rotateWidth, y, size, size, start, angle, CHORD);

  }
  boolean check(Ball user) {
  x =rotateWidth-(speed*frameCount)%rotateWidth;
    stroke(0);
    for (int i=0; i<16; i++) {
      if (!(colors[(i)%4]==user.col)) {
      if(checkCircles(x+size/2.0, y+size/2.0, size, user.x+size/2.0, user.y+size/2.0, user.size)){return true;}
    }
      x=x-change;
      if (x<-size) {
        x+=rotateWidth;
      }
    }
    return false;
  }
  
  boolean checkCircles(float x1, float y1, float diam1, float x2, float y2, float diam2){
float dist = dist(x1, y1 , x2, y2);
if(dist>(diam1/2.0)+(diam2/2.0)){return false;}

float angle = atan((x1-x2)/(y1-y2))-HALF_PI;
if(y2<y1){angle-=PI;}

//stroke(255,0,0);
  //line(x1, y1, x1+cos(angle)*diam1/2.0, y1-sin(angle)*diam1/2.0);
//ellipse(x1+cos(angle)*(diam1/2.0+diam2/2.0), y1-sin(angle)*(diam1/2.0+diam2/2.0), diam2, diam2);
user.x =x1+cos(angle)*(diam1/2.0+diam2/2.0);
user.y = y1-sin(angle)*(diam1/2.0+diam2/2.0);
return true;
}
  
}
