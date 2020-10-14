class Ball{
int jumping=0;
float size=30; 
int ySpeed=1;
int xSpeed=0;
int change=0;
color col = colorScheme[1];
float x=width/2-15;
float y=height-size;
float position=0.0;
Ball(){}
//Ball(float x, float y, float size){
//this.size = size;
//this.x =x;
//this.y = y;
//this.col = colorScheme[(int)random(colorScheme.length-1)];
//ySpeed=(int)random(-5, 5);
//xSpeed=(int)random(-5, 5);
//}

void move(){  
  x=x+xSpeed;
  change=0;
  if(jumping!=20){
     change = (-(20-jumping)*(ySpeed) +jumping*(ySpeed));

  jumping++; 
  if(endless){transY+=abs(change/3.0);}
  //else{t-=change*0.0008;if(t>=1){t-=1; a++;}}
}
  else{
  change =ySpeed;
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
