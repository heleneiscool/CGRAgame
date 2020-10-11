class Ball{
int jumping=20;
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
  transY+=abs(change/3.0);
}
  else{
  change =speed;
  }
   y = y + change;
}

void checkWalls(){
  if (this.y<0) {//top boundary
    y=0;
    speed = abs(speed);
  } else if (y>height-size) {//bottom boundary
    y=height-size;
    speed= -abs(speed);
  }
  if(xSpeed==0){return;}
  if (x<0) {//left boundary
    x=0;
    xSpeed = abs(xSpeed);
  } else if (x>width-size) {//right boundary
    x=width-size;
    xSpeed = -abs(xSpeed);
  }
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
