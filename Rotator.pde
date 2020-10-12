class Rotator extends Obstacle{
  float size = 25;
  //coordinates for left-top coner of shape
  float rotateWidth =width;
  float change = rotateWidth/8;
  float speed=3;
  float x =rotateWidth-(speed*frameCount)%rotateWidth;
  float y = height/2-size/2;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
Rotator(){
  size = 25;
  //coordinates for left-top coner of shape
  change = rotateWidth/8;
  x =width-(speed*frameCount)%rotateWidth;
  y = height/2-size/2;
}
Rotator(float y){
  size = 25;
  //coordinates for left-top coner of shape
  change = width/8;
  x =width-(speed*frameCount)%rotateWidth;
this.y =y;
}

  void drawObstacle() {
   if(y+size<-transY+50){return;}//above
   if(y>height-transY-50){return;}//below
   //stroke(255,0,0);
   //line(0, height-transY-50, width, height-transY-50);
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
    for (int i=0; i<8; i++) {
      fill(colors[i/2]);
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
    strokeWeight(3);
    float distBall = dist(user.x, user.y, rotateWidth/2, y);
    if (distBall>user.size) {
      return false;
    }
    for (int i=0; i<8; i++) {
      if (colors[i/2]==user.col) {
      }
      else{
              float distObs = dist(x+size/2.0, y+size/2.0, user.x+user.size/2.0, user.y+user.size/2.0);

        if (distObs<size/2.0 + user.size/2.0) {
        return true;
      }}
      x=x-change;
      if (x<-size) {
        x+=rotateWidth;
      }
    }
    return false;
  }
}
