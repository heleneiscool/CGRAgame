float transX=0; //how much the veiwing field has been translated by for y axis
float transY=0;//above for y axis

PVector[] curvePoints = new PVector[6] ;//stores points for curved path
int a=0;//which curve segment is centered
float t=0.0;//position on curve segment
int width=300;
int height =600;
void setup() {
  size(300, 600);
  frameRate(30);
}
//orange, pink, green, blue
color[] colorScheme = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
PVector[] buttons = {new PVector(10, 300), new PVector(10, 380)};

ArrayList<Ball> dying = new ArrayList<Ball>();
int dyingCount=0;

Ball user = new Ball();

boolean endless = false;
boolean playing =false;

float checkPoint =0;

ArrayList<Obstacle> setGame = new ArrayList<Obstacle>();

Integer[] clipping = {0, 15};
color bottom = color(255,0,0);
void draw() {
  background(255);
  if (dyingCount>0) {
    for (Ball b : dying) {
      b.drawBall();
      b.move();
      b.checkBoundaries();
      dyingCount--;
    }
  } else if (!playing) {
    drawRectangles();
  } else {
    playGame();
  }
}
void playGame() {
  translate(transX, transY);
  stroke(0);
  
  drawScore();
  //user.checkBoundaries();
  
  if(!endless){
   
  translateByCurve();
      for (int index=0;index<setGame.size(); index++) {
        Obstacle obs =setGame.get(index);
       //Obstacle obs = setGame.get(frameCount%setGame.size());
  int posInt =(int)obs.position;
  if(posInt>=6){posInt-=6;}
  if(posInt<0){posInt+=6;}
      
      int b=posInt+1;
      int c=posInt+2;
      int d=posInt+3;
      if (b>=6) {b-=6;}
      if (c>=6) {c-=6;}
      if (d>=6) {d-=6;}

      float x = curvePoint(curvePoints[posInt].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, obs.position-posInt);
      float y = curvePoint(curvePoints[posInt].y, curvePoints[b].y, curvePoints[c].y, curvePoints[d].y, obs.position-posInt);

      setGame.set(index, new Wheel(x-(250/2.0),y-(250/2.0), setGame.get(index).position));
      
      obs = setGame.get(index);
    obs.drawObstacle();
    //if (obs.check(user)) {
    //  if(obs instanceof ColorChange){user.col = colorScheme[(int)random(colorScheme.length-1)];}
    //  else{reset();}
    //}
  }
  //user.x=-transX+width/2.0-user.size/2.0;
  //user.y=-transY+height/2.0-user.size/2.0;
  
  }
  else{
  if(endless & user.y<checkPoint+height){
  addToGame(checkPoint, 0);
  }
  for (Obstacle obs : setGame) {
    obs.drawObstacle();
    if (obs.check(user)) {
      if(obs instanceof ColorChange){user.col = colorScheme[(int)random(colorScheme.length-1)];}
      else{reset();}
    }
  }
  if (user.y>height-user.size-transY) {
    user.y = height-user.size-transY;
  }//lose game
  else if (user.y<-transY) {
    reset();
  }//win game
transY+=0.8;
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
  dying=new ArrayList<Ball>();
  for (int i=0; i<5; i++) {
    dying.add(new Ball(user.x, user.y, 10));
  }
  transY=0;
  dyingCount=400;
  playing=false;
  user=new Ball();
  endless=false;
}

void mousePressed() {
  if (playing) {
    user.makeJump();
  } else {
    if (hovered(buttons[0])) {
      playing=true;
        for ( int i=0; i < 6; i++ ) {
    curvePoints[i]=new PVector(random(-width/4, width/4), random(-height/4, height/4)); //starts with random curves
  }
      fillGame();
    }
    if (hovered(buttons[1])) {
      playing=true;
      endless=true;
      fillGame();
    }
  }
}

void keyPressed() {
  if (playing) {
    user.makeJump();
  }
}

void drawRectangles() {
  noStroke();
  for (int i=0; i<buttons.length; i++) {
    PVector value = buttons[i];
    if (!hovered(value)) {
      fill(colorScheme[0]);
    } else {  
      fill(colorScheme[1]);
    }
    rect(value.x, value.y, width-20, 30);
    textSize(30);
    if(i==0){text("PLAY",value.x, value.y);}
    else{text("ENDLESS",value.x, value.y);}
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
  checkPoint=0;
  for(int i=0;i<12;i++){
  Obstacle obs;
  obs = new Wheel(i*20,i*20, checkPoint);
    //obs.position= checkPoint;
  setGame.add(obs);
  checkPoint+=0.5;
}}
}

void translateByCurve(){
  
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
//user.x=-x+width/2.0;
//user.y=-y+height/2.0;
t-=0.005;
if(t<0){t+=1; a--;}
}
void addToGame(float y, int i){
  int rnd = (int)random(3);
  Obstacle obs;
  if(rnd==0){
  y-=230;
  obs = new Rotator(y);
  }
  else if(rnd==1){
    y-=530;
  obs = new Wheel(y);
  }
  else{
   y-=150;
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
