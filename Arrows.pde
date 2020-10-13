class Arrows extends Obstacle{
  float size = 25;
  float position=0.5;
  //coordinates for left-top coner of shape
  float change = width/8;
  float x =width-frameCount%width;
  float y = height/2-size/2;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};
  Arrows(float pos){
  this.position=pos;
  }
  Arrows(float x, float y,float pos){
  this.position=pos;
  this.x=x;
  this.y=y;
  }
  void drawObstacle(){
    int posInt =(int)position;
  if(posInt>=6){posInt-=6;}
  if(posInt<0){posInt+=6;}
  int b=(int)this.position+1;
      int c=(int)this.position+2;
      int d=(int)this.position+3;
      if (b>=6) {b-=6;}
      if (c>=6) {c-=6;}
      if (d>=6) {d-=6;}
      this.x = curvePoint(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, this.position-(int)this.position);
      this.y = curvePoint(curvePoints[(int)this.position].y, curvePoints[b].y, curvePoints[c].y, curvePoints[d].y, this.position-(int)this.position);
       
       float tx = curveTangent(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, this.position-(int)this.position);
      float ty = curveTangent(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, this.position-(int)this.position);
      float angle = atan2(ty, tx); //angle to rotate tri by

  
  fill(colorScheme[0]);

      translate(x, y); //translate 'world'
boolean stage = (frameCount%600)>300;
if(frameCount%300==0){return;}
for(int i=0; i<2; i++){
      // position of triangle
      PVector vect1 = new PVector(0+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),0).rotate(i*PI+angle);
      PVector vect2 = new PVector(-10+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),-10).rotate(i*PI+angle);
      PVector vect3 = new PVector(30+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),0).rotate(i*PI+angle);
      PVector vect4 = new PVector(-10+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),10).rotate(i*PI+angle);
beginShape();
 vertex(vect1.x, vect1.y);
 vertex(vect2.x, vect2.y);
 vertex(vect3.x, vect3.y);
 vertex(vect4.x, vect4.y);
endShape(CLOSE);
}
      translate(-x, -y);

  }
  
  
    boolean check(Ball user){
           int b=(int)this.position+1;
      int c=(int)this.position+2;
      int d=(int)this.position+3;
      if (b>=6) {b-=6;}
      if (c>=6) {c-=6;}
      if (d>=6) {d-=6;}
       float tx = curveTangent(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, this.position-(int)this.position);
      float ty = curveTangent(curvePoints[(int)this.position].x, curvePoints[b].x, curvePoints[c].x, curvePoints[d].x, this.position-(int)this.position);
      float angle = atan2(ty, tx); //angle to rotate tri by

     translate(x, y); //translate 'world'
boolean stage = (frameCount%600)>300;
if(frameCount%300==0){return false;}
for(int i=0; i<2; i++){
      // position of triangle
      PVector[] vectors = new PVector[5];
      vectors[0]= new PVector(0+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),0).rotate(i*PI+angle);
      vectors[1] = new PVector(-10+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),-10).rotate(i*PI+angle);
      vectors[2] = new PVector(30+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),0).rotate(i*PI+angle);
      vectors[3] = new PVector(-10+30*(i-1)-i*30+(stage?-(frameCount%300)/5:-60+(frameCount%300)/5),10).rotate(i*PI+angle);
      vectors[4]=vectors[0];
      
      int count=0;
      stroke(255,0,0);
for(int index=0; index<4; index++){
line(vectors[index].x, vectors[index].y, vectors[index+1].x, vectors[index+1].y);
}

noFill();
PVector userTranslated = new PVector(user.x-size/2.0, user.y-size/2.0);
userTranslated = new PVector(userTranslated.x-x, userTranslated.y-y);
ellipse(userTranslated.x, userTranslated.y, user.size, user.size);
if(polyCircle(vectors, userTranslated.x+size/2.0, userTranslated.y+size/2.0, size/2.0)){return true;}
  
}
      translate(-x, -y);
    return false;
}


//All following code is adapted from: http://www.jeffreythompson.org/collision-detection/poly-circle.php
// POLYGON/CIRCLE
boolean polyCircle(PVector[] vertices, float cx, float cy, float r) {

  // go through each of the vertices, plus
  // the next vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // check for collision between the circle and
    // a line formed between the two vertices
    boolean collision = lineCircle(vc.x,vc.y, vn.x,vn.y, cx,cy,r);
    if (collision) return true;
  }

  // the above algorithm only checks if the circle
  // is touching the edges of the polygon – in most
  // cases this is enough, but you can un-comment the
  // following code to also test if the center of the
  // circle is inside the polygon

  // boolean centerInside = polygonPoint(vertices, cx,cy);
  // if (centerInside) return true;

  // otherwise, after all that, return false
  return false;
}


// LINE/CIRCLE
boolean lineCircle(float x1, float y1, float x2, float y2, float cx, float cy, float r) {

  // is either end INSIDE the circle?
  // if so, return true immediately
  boolean inside1 = pointCircle(x1,y1, cx,cy,r);
  boolean inside2 = pointCircle(x2,y2, cx,cy,r);
  if (inside1 || inside2) return true;

  // get length of the line
  float distX = x1 - x2;
  float distY = y1 - y2;
  float len = sqrt( (distX*distX) + (distY*distY) );

  // get dot product of the line and circle
  float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2);

  // find the closest point on the line
  float closestX = x1 + (dot * (x2-x1));
  float closestY = y1 + (dot * (y2-y1));

  // is this point actually on the line segment?
  // if so keep going, but if not, return false
  boolean onSegment = linePoint(x1,y1,x2,y2, closestX,closestY);
  if (!onSegment) return false;

  // optionally, draw a circle at the closest point
  // on the line
  fill(255,0,0);
  noStroke();
  ellipse(closestX, closestY, 20, 20);

  // get distance to closest point
  distX = closestX - cx;
  distY = closestY - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // is the circle on the line?
  if (distance <= r) {
    return true;
  }
  return false;
}


// LINE/POINT
boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {

  // get distance from the point to the two ends of the line
  float d1 = dist(px,py, x1,y1);
  float d2 = dist(px,py, x2,y2);

  // get the length of the line
  float lineLen = dist(x1,y1, x2,y2);

  // since floats are so minutely accurate, add
  // a little buffer zone that will give collision
  float buffer = 0.1;    // higher # = less accurate

  // if the two distances are equal to the line's
  // length, the point is on the line!
  // note we use the buffer here to give a range, rather
  // than one #
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}


// POINT/CIRCLE
boolean pointCircle(float px, float py, float cx, float cy, float r) {
  
  // get distance between the point and circle's center
  // using the Pythagorean Theorem
  float distX = px - cx;
  float distY = py - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the circle's 
  // radius the point is inside!
  if (distance <= r) {
    return true;
  }
  return false;
}


// POLYGON/POINT
// only needed if you're going to check if the circle
// is INSIDE the polygon
boolean polygonPoint(PVector[] vertices, float px, float py) {
  boolean collision = false;

  // go through each of the vertices, plus the next
  // vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // compare position, flip 'collision' variable
    // back and forth
    if (((vc.y > py && vn.y < py) || (vc.y < py && vn.y > py)) &&
         (px < (vn.x-vc.x)*(py-vc.y) / (vn.y-vc.y)+vc.x)) {
            collision = !collision;
    }
  }
  return collision;
}


}
