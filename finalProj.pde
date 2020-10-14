float transX=0; //how much the veiwing field has been translated by for y axis
float transY=0;//above for y axis

PVector[] curvePoints = new PVector[6] ;//stores points for curved path
int a=0;//which curve segment is centered
float t=0.0;//position on curve segment
//int width=300;
//int height =600;
void setup() {
  //size(300, 600);
    fullScreen();
  //frameRate(30);
}
//orange, pink, green, blue
color[] colorScheme = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
PVector[] buttons = {new PVector(10, 300), new PVector(10, 380)};

int dyingCount=0;

Ball user;

boolean endless = false;
boolean playing =false;

float checkPoint =0;

ArrayList<Obstacle> setGame = new ArrayList<Obstacle>();

Integer[] clipping = {0, 15};
color bottom = color(255,0,0);
void draw() {
  background(255);
   if (!playing) {
    drawRectangles();
  } else {
    playGame();
    if (dyingCount>0) {
    dyingCount--;
    if(dyingCount==0){reset();}
  }
  }
}
void playGame() {
  translate(transX, transY);
  stroke(0);
  
  drawScore();
  //user.checkBoundaries();
  
  if(!endless){
  if((a+t)-user.position>0.05){translateByCurve(-0.002);}
    translateByCurve();
   
  //    for (int index=0;index<setGame.size(); index++) {
  //      Obstacle obs =setGame.get(index);
  //     //Obstacle obs = setGame.get(frameCount%setGame.size());

      

  //    obs = setGame.get(index);
  //  obs.drawObstacle();
  //  if (obs.check(user)) {
  //    if(obs instanceof ColorChange){user.col = colorScheme[(int)random(colorScheme.length-1)];}
  //    else{  dyingCount=40;}
  //  }
  //}
  
  
  //user.x=-transX+width/2.0-user.size/2.0;
  //user.y=-transY+height/2.0-user.size/2.0;
  
  //line(-transX+width/2.0,0,-transX+width/2.0,height);
  //line(0,-transY+height/2.0,width,-transY+height/2.0);
  }
  else{
  if(endless & user.y<checkPoint+height){
  addToGame(checkPoint, 0);
  }
  if (user.y>height-user.size-transY) {
    user.y = height-user.size-transY;
  }//lose game
  else if (user.y<-transY) {
     dyingCount=40;
  }//win game
transY+=0.8;
}

  for (Obstacle obs : setGame) {
    obs.drawObstacle();
    if (obs.check(user)) {
      if(obs instanceof ColorChange){user.col = colorScheme[(int)random(colorScheme.length-1)];}
      else{
        int saveX = user.xSpeed;
        user.xSpeed = user.ySpeed;
        user.ySpeed = saveX;
      dyingCount=40;
    }
    }
  }
  user.drawBall(); 
  user.move();
}
void drawScore() {
  fill(0);
  textSize(30);
  text(""+(int)(transY/4.0), 30, 40-transY, 500);
}

void reset() {
  transY=0;
  transX=0;
  playing=false;
  user=new Ball();
  endless=false;
}

void mousePressed() {
  if(dyingCount!=0){return;}
  if (playing) {
    user.makeJump();
  } else {
    if (hovered(buttons[0])) {
      playing=true;
      user=new Ball();
        for ( int i=0; i < 6; i++ ) {
    curvePoints[i]=new PVector(random(-width*4, width*4), random(-height*4, height*4)); //starts with random curves
  }
      fillGame();
    }
    if (hovered(buttons[1])) {
      playing=true;
            user=new Ball();
      endless=true;
      fillGame();
    }
  }
}

void keyPressed() {
    if(dyingCount!=0){return;}
  if (playing) {
    user.makeJump();
  }
}


void drawRectangles() {
  strokeWeight(5);
  for (int i=0; i<buttons.length; i++) {
          noFill();
    PVector value = buttons[i];
    if (!hovered(value)) {
      stroke(colorScheme[0]);
    } else {  
      stroke(colorScheme[1]);
    }
    rect(value.x, value.y, width-20, 30);
    textSize(30);
    if (!hovered(value)) {
      fill(colorScheme[0]);
    } else {  
      fill(colorScheme[1]);
    }
    if(i==0){text("TRACK",value.x+5, value.y+27);}
    else{text("ENDLESS",value.x+5, value.y+27);}
  }
}

boolean hovered(PVector value) {
  boolean xAligned = (mouseX<value.x+width-20) & mouseX>value.x;
  boolean yAligned = (mouseY<value.y+30) & mouseY>value.y;
  return xAligned & yAligned;
}

void fillGame() {
  setGame = new ArrayList<Obstacle>();
  checkPoint =300;
  if(endless){
  for(int i=0; i<10; i++){
addToGame(checkPoint, i);
  }
}
else{ 
  checkPoint=0.5;
  for(int i=0;i<11;i++){
  Obstacle obs;
  obs = new Arrows(checkPoint);
    //obs.position= checkPoint;
  setGame.add(obs);
  checkPoint+=0.5;
}}
}

void translateByCurve(){
  translateByCurve(-0.001);
}
void translateByCurve(float amount){
if(a>=6){a-=6;}
if(a<0){a+=6;}
int b=a+1;
      int c=a+2;
      int d=a+3;
      if (b>=6) {b-=6;}
      if (c>=6) {c-=6;}
      if (d>=6) {d-=6;}

      float x = curvePoint(curvePoints[a].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, t);
      float y = curvePoint(curvePoints[a].y, curvePoints[b].y, curvePoints[c].y, curvePoints[d].y, t);
drawCurve();
     strokeWeight(1); 
//line(x, height, x, 0);
//line(0, y, width, y);

transX=-x+width/2.0;
transY=-y+height/2.0;

t+=amount;
if(t<0){t+=1; a--;}
if(t>=1){t-=1; a++;}
}
void addToGame(float y, int i){
  int rnd = (int)random(3);
    y-=500;
  Obstacle obs;
  if(rnd==0){
  obs = new Rotator(y);
  }
  else if(rnd==1){
  obs = new Wheel(y);
  }
  else{
  obs = new ColorChange(y);
  }
    obs.position= 0.5*i;
  setGame.add(obs);
  checkPoint=y;
}
 /** draws the curved shape */
  void drawCurve() {
    noFill();
    stroke(200);

    // draws curve
    strokeWeight(12) ;
    stroke(200); //grey
    for ( int i=0; i<6; i++ ) {
      int a=i;
      int b=i+1;
      int c=i+2;
      int d=i+3;
      if (b>=6) {
        b-=6;
      }
      if (c>=6) {
        c-=6;
      }
      if (d>=6) {
        d-=6;
      }
      curve( curvePoints[a].x, curvePoints[a].y, curvePoints[b].x, curvePoints[b].y, curvePoints[c].x, curvePoints[c].y, curvePoints[d].x, curvePoints[d].y ) ;
    }
  }
