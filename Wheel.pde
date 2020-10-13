class Wheel extends Obstacle {
  float size = 250;
  //coordinates for left-top coner of shape
  float x =300/2-size/2;
  float y = 600/2-size/2;
  float speed = 5;
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
    Wheel(float x, float y, float position) {
    this.position=position;
    //coordinates for left-top coner of shape
    this.x=x;
    this.y =y;
  }
  
  void drawObstacle() {
//    line(-size/2,0,-size/2,height);
    //check if whole wheel is outside before trying to draw/clip
    if (y+size<-transY) {
      return;
    }
    if (y>height-transY) {
      return;
    }
    
    //float edgeAngle = asin((-transY+50-(y+(size/2.0)))/(size/2.0));//andgle between edge line and wheel center
    strokeWeight(1);
    stroke(0);
   // line(0, -transY+50, width, -transY+50);
     //   strokeWeight(20);    noFill();
    strokeCap(SQUARE);

    for (int i=0; i<4; i++) { 
      float angle = HALF_PI*i+(frameCount*speed)/40.0;
      angle=angle%TWO_PI;
      float endAngle = angle+HALF_PI;
      stroke(sectors[i]);
    strokeWeight(1);

      drawArc(this.x+this.size/2.0, this.y+this.size/2.0, this.size/2.0, angle, endAngle);
      //ellipse(x+size/2.0, y+size/2.0, 20,20);
    }
  //  println("("+this.x+", "+this.y+")");
  }


void drawArc(float cx, float cy, float radius, float startAngle, float endAngle){
    float c, s ;
     // strokeWeight(5) ;
float angle=startAngle;
  while(angle>=startAngle & angle<endAngle){
  c = cos(angle) ;
  s = sin(angle) ;
  float y0 = s*(radius-20)+cy;
  float y1 = s*radius+cy;
    float x0=c*(radius-20)+cx;
    float x1 = c*radius+cx;
    //first to if statements are for top edge
  if(y0<-transY+50){
    float m = (c*(radius-20))/(s*(radius-20));
  y0=-transY+50;
  x0 = m*(y0-cy)+cx;
  }
    if(y1<-transY+50){
    float m = (c*(radius))/(s*(radius));
  y1=-transY+50;
  x1 = m*(y1-cy)+cx;
  }
  
  //bottom edge
  if(y0>height-transY-50){
    float m = (c*(radius-20))/(s*(radius-20));
  y0=height-transY-50;
  x0 = m*(y0-cy)+cx;
  }
    if(y1>height-transY-50){
    float m = (c*(radius))/(s*(radius));
  y1=height-transY-50;
  x1 = m*(y1-cy)+cx;
  }
  line( x0, y0, x1,y1 ) ;
   angle = angle + 0.002 ;

  }
}

  boolean check(Ball user) {
    //first: check if ball is close to wheel
    // float distTop = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y); 
    // float distBottom = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y+user.size); 

    //  if(!((distTop<(size/2.0)+10 & distTop>(size/2.0)-10) |
    //distBottom<(size/2.0)+10 & distBottom>(size/2.0)-10)){return false;} //if neither are true: ball is too far from wheel
       float dist = dist(user.x+user.size/2.0, user.y+user.size/2.0, x+(size/2.0), y+(size/2.0));
       if(dist>user.size/2.0+size/2.0){return false;}
            stroke(0);

      boolean checkTop = true;
      if(user.y>y+(size/2.0)){stroke(255);checkTop =false;}
       for(int i=0; i<4; i++){
      if(sectors[i]==user.col){continue;}//if ball and sector are same color skip
          float angle = HALF_PI*i+(frameCount*speed)/40.0;
          if(checkTop){if(angle%TWO_PI>PI & angle%TWO_PI<HALF_PI+PI){return true;}}
          else{if(angle%TWO_PI>0 & angle%TWO_PI<HALF_PI){return true;}}  
        }
      return false;
  }
}
