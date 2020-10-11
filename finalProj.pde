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

float transY=0;
float checkPoint =0;

ArrayList<Obstacle> setGame = new ArrayList<Obstacle>();
void draw() {
  background(255);
  if (dyingCount>0) {
    for (Ball b : dying) {
      b.drawBall();
      b.move();
      b.checkWalls();
      dyingCount--;
    }
  } else if (!playing) {
    drawRectangles();
  } else {
    playGame();
  }
}

void playGame() {
  translate(0, transY);
  stroke(0);
  drawScore();
  user.drawBall(); 
  user.move();
  if(endless & user.y<checkPoint+200){
  addToGame(checkPoint);
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

void drawScore() {
  fill(0);
  textSize(30);
  text(""+(int)(transY/4.0), 30, height-40-transY, 500);
}

void reset() {
  dying=new ArrayList<Ball>();
  for (int i=0; i<5; i++) {
    dying.add(new Ball(user.x, user.y+i*12, 10));
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
  for(int i=0; i<10; i++){
addToGame(checkPoint);
  }
}
void addToGame(float y){
  int rnd = (int)random(3);
  Obstacle obs;
  if(rnd==0){
 // y-=230;
 // obs = new Rotator(y);
    y-=530;
  obs = new Wheel(y);
  }
  //else if(rnd==1){
  //  y-=530;
  //obs = new Wheel(y);
  //}
  else{
    //y-=150;
  //obs = new ColorChange(y);
    y-=530;
  obs = new Wheel(y);
  }
  setGame.add(obs);
    checkPoint=y;

}
