class Wheel extends Obstacle {
  float size = 250;
  //coordinates for left-top coner of shape
  float x =300/2-size/2;
  float y = 600/2-size/2;
  float speed = 2.0;
  color[] sectors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};

  Wheel() {
    size = 250;
    //coordinates for left-top coner of shape
    x =300/2-size/2;
    y = 600/2-size/2;
  } 
  Wheel(float y) {
    size = 250;
    //coordinates for left-top coner of shape
    x =300/2-size/2;
    this.y =y;
  }
  void drawObstacle() {
    if (y+size<-transY) {
      return;
    }
    if (y>height-transY) {
      return;
    }
    float edgeAngle = asin((-transY+50-(y+(size/2.0)))/(size/2.0));
    strokeWeight(1);
    stroke(0);
    line(0, -transY+50, width, -transY+50);
        strokeWeight(20);    noFill();
    strokeCap(SQUARE);

    for (int i=0; i<4; i++) { 
      float angle = HALF_PI*i+(frameCount*speed)/40.0;
      float endAngle = angle+HALF_PI;
      stroke(sectors[i]);
      if (y<-transY+50) {
        if ((angle+HALF_PI)%TWO_PI >= edgeAngle & (angle+HALF_PI)%TWO_PI < PI-edgeAngle) { //end angle inside
          if (angle%TWO_PI < edgeAngle) {//start is outside
            angle=edgeAngle;
          }
          //if (angle%TWO_PI > PI-edgeAngle) {
          //  angle=PI-edgeAngle;
          //}
        }
        else{
         if ((angle)%TWO_PI > PI-edgeAngle) {
            continue;
          } //if both are outside, do not draw
          else{
          endAngle=PI-edgeAngle;
          }
        }
        //if ((angle)%TWO_PI >=edgeAngle & (angle)%TWO_PI < PI-edgeAngle) { //start angle inside
        //  if (endAngle%TWO_PI < edgeAngle) {//start is outside
        //    endAngle=edgeAngle;
        //  }
        //  if (endAngle%TWO_PI > PI-edgeAngle) {
        //    endAngle=PI-edgeAngle;
        //  }
        //}
      }
      //if(((y<-transY+50) & (angle%TWO_PI)>edgeAngle & (angle%TWO_PI)+HALF_PI<PI-edgeAngle) |!(y<-transY+50)){
      arc(x, y, size, size, angle, endAngle);
      arc(x+size/2.0, y+size/2.0, size/2.0, size/2.0, edgeAngle, PI-edgeAngle);
      //}
    }
  }


  boolean check(Ball user) {
    return false;
    //first: check if ball is close to wheel
    // float distTop = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y); 
    // float distBottom = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y+user.size); 

    //  if(!((distTop<(size/2.0)+10 & distTop>(size/2.0)-10) |
    //distBottom<(size/2.0)+10 & distBottom>(size/2.0)-10)){return false;} //if neither are true: ball is too far from wheel
    //        stroke(0);

    //  boolean checkTop = true;
    //  if(user.y>y+(size/2.0)){stroke(255);checkTop =false;}
    //   for(int i=0; i<4; i++){
    //  if(sectors[i]==user.col){continue;}//if ball and sector are same color skip
    //      float angle = HALF_PI*i+(frameCount*speed)/40.0;
    //      if(checkTop){if(angle%TWO_PI>PI & angle%TWO_PI<HALF_PI+PI){return true;}}
    //      else{if(angle%TWO_PI>0 & angle%TWO_PI<HALF_PI){return true;}}  
    //    }
    //  return false;
  }
}
