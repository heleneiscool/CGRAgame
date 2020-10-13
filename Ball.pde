class Ball{
int jumping=0;
float size; 
int speed;
int xSpeed;
color col = colorScheme[1];
float x;
float y;
float position=0.0;

Ball(){
 size = 30; 
 speed = 1;
 xSpeed=0;
 this.col = colorScheme[1];
 x=150-size/2.0;
 y= 600;
}
Ball(float x, float y, float size){
this.size = size;
this.x =x;
this.y = y;
this.col = colorScheme[(int)random(colorScheme.length-1)];
speed=(int)random(-5, 5);
xSpeed=(int)random(-5, 5);
}

void move(){  
  x=x+xSpeed;
  float change=0;
  if(jumping!=20){
     change = (-(20-jumping)*(speed) +jumping*(speed));

  jumping++; 
  if(endless){transY+=abs(change/3.0);}
  //else{t-=change*0.0008;if(t>=1){t-=1; a++;}}
}
  else{
  change =speed;
  }
   y = y + change;
   position+=change/2500.0;
   if(position>=6){position-=6;}
   if(position<0){position+=6;}
}

void checkBoundaries(){
if(this.x<transX){this.x=transX;}
if(this.x+user.size/2.0>transX+width){this.x=transX+width-this.size/2.0;}
if(this.y<transY){this.y=transY;}
if(this.y+user.size/2.0>transY+width){this.y=transY+width-this.size/2.0;}
}


void makeJump(){
jumping=0;
}
void changeColor(){
col = colorScheme[(int)random(colorScheme.length)];
}
void drawBall(){
  noStroke();
  ellipseMode(CORNER);
  fill(this.col);
  if(endless | !playing){
ellipse(x, y, size, size);
  }
  else {
    int b=(int)this.position+1;
      int c=(int)this.position+2;
      int d=(int)this.position+3;
      if (b>=6) {b-=6;}
      if (c>=6) {c-=6;}
      if (d>=6) {d-=6;}
      this.x = curvePoint(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, position-(int)this.position);
      this.y = curvePoint(curvePoints[(int)this.position].y, curvePoints[b].y, curvePoints[c].y, curvePoints[d].y, position-(int)this.position);
      ellipse(x-this.size/2.0,y-this.size/2.0,size,size);
  }
}

}
