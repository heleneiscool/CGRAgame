class Wheel extends Obstacle {
  float size = 250;
  //coordinates for left-top coner of shape
  float x =width/2-size/2.0;
  float y = 600/2-size/2;
  float speed = 2.5;
  color[] sectors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};

  Wheel() {
    size = 250;
    //coordinates for left-top coner of shape
    y = 600/2-size/2;
  } 
  Wheel(float y) {
    //coordinates for left-top coner of shape
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

  if(y<-transY+50 | y+size>height-transY-50){    
  drawArc(this.x+this.size/2.0, this.y+this.size/2.0, this.size/2.0, angle, endAngle);
  }
  else{
   noFill();
   strokeWeight(20);
  arc(this.x+10, this.y+10, this.size-20.0,this.size-20.0, angle, endAngle);
  }
    }
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

//  boolean check(Ball user) {
//    //first: check if ball is close to wheel
//    // float distTop = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y); 
//    // float distBottom = dist(x+(size/2.0), (y+size/2.0), user.x+user.size, user.y+user.size); 

//    //  if(!((distTop<(size/2.0)+10 & distTop>(size/2.0)-10) |
//    //distBottom<(size/2.0)+10 & distBottom>(size/2.0)-10)){return false;} //if neither are true: ball is too far from wheel
//       float dist = dist(user.x+user.size/2.0, user.y+user.size/2.0, x+(size/2.0), y+(size/2.0));

//     if(dist>user.size/2.0+size/2.0){return false;}
//       if(size/2.0-dist>user.size/2.0+20){return false;}
//            stroke(0);

//      float angle = asin((user.y+user.size/2.0 - (y+size/2.0))/dist);
//      if(angle<0){angle+=TWO_PI;}

//      for (int i=0; i<4; i++) { 
//      float sectAngle = HALF_PI*i+(frameCount*speed)/40.0;
//      sectAngle=sectAngle%TWO_PI;
//      float endAngle = sectAngle+HALF_PI;
//      stroke(sectors[i]);
//if(sectAngle<angle & endAngle>angle & sectors[i]!=user.col){
//       if(dist>user.size/2.0+size/2.0-20){
//       user.y = y-user.size/2.0+20+(user.y+user.size/2.0>y+size/2.0?size:0);
//       }
//       if(size/2.0-dist>user.size/2.0){
//       user.y = y-user.size/2.0+(user.y+user.size/2.0>y+size/2.0?size:0);}
//  return true;
//    }
//    }
    
//      return false;
//  }
boolean check(Ball user) {
    float dist1 = dist(user.x+user.size/2.0, user.y+user.size/2.0, x+size/2.0, y+size/2.0);
if(dist1<user.size/2.0+size/2.0){
  float dist2 = dist(user.x+user.size/2.0, user.y+user.size/2.0, x+20+(size-40)/2.0, y+20+(size-40)/2.0);
if(dist2>size/2.0-40){
float angle = atan(((x+size/2.0)-(user.x+user.size/2.0))/((y+size/2.0)-(user.y+user.size/2.0)))-HALF_PI;
if(user.y+user.size/2.0<y+size/2.0){angle-=PI;}
while(angle<0){angle+=TWO_PI;}
while(angle>=TWO_PI){angle-=TWO_PI;}
float delta = asin((user.size/2.0)/dist1);
float lower = ((TWO_PI-angle%TWO_PI-HALF_PI)-delta)%TWO_PI;
float upper = ((TWO_PI-angle%TWO_PI-HALF_PI)+delta)%TWO_PI;
int index =0;
while(index<sectors.length){
  if(sectors[index]==user.col){break;}
  index++;
}
float startAngle = HALF_PI*index+(frameCount*speed)/40.0-HALF_PI;
      startAngle=startAngle%TWO_PI;
      float endAngle = startAngle+HALF_PI;
      if((startAngle%TWO_PI<lower & endAngle%TWO_PI>upper)
      |((startAngle+PI)%TWO_PI<(lower+PI)%TWO_PI & (endAngle+PI)%TWO_PI>(upper+PI)%TWO_PI)
      ){return false;}

if(dist1>user.size/2.0+size/2.0-20){
user.x =x+size/2.0-user.size/2.0+cos(angle)*(size/2.0 +user.size/2.0+1);
user.y = y+size/2.0-user.size/2.0-sin(angle)*(size/2.0 +user.size/2.0+1);
}
else{
user.x =x+size/2.0-user.size/2.0+cos(angle)*(size/2.0 -40);
user.y = y+size/2.0-user.size/2.0-sin(angle)*(size/2.0 -40);
}
return true;
}
}
return false;
  }
 
}
