class Ball{
int jumping=0;
float size; 
int speed;
int xSpeed;
color col = colorScheme[1];
float x;
float y;

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
ellipse(x, y, size, size);
}

}
