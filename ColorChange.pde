class ColorChange extends Obstacle {
  float size = 40;
  //coordinates for left-top coner of shape
  float change = width/8;
  float x =width/2-size/2;
  float y = height/2-size/2;
  boolean used=false;
  color[] colors = {color(255, 165, 0), color(255, 20, 147), color(0, 255, 0), color(0, 0, 255)};

  ColorChange(float y) {
    this.y = y;
  }
  void drawObstacle() {
    if (used) {
      return;
    }
    if (y+size<-transY+50) {
      return;
    }//above
    if (y>height-transY-50) {
      return;
    }//below  

    strokeCap(SQUARE);
    noStroke();

    for (int i=0; i<4; i++) {
      strokeWeight(1);
      stroke(colors[i]);
      drawArc(x+i%2*(size/2.0), y+size/2.0, i);
    }
  }

  boolean check(Ball user) {
    //    if((dist(user.x+user.size/2, user.y, this.x+size/2, this.y+size/2)<this.size/2)
    //& (dist(user.x+user.size/2, user.y+user.size, this.x+size/2, this.y+size/2)<this.size/2)){used=true;return true;}

    if (user.y<y+size & !used) {
      used=true;
      return true;
    }
    return false;
  }


  void drawArc(float x0, float y0, int i) {
    strokeWeight(1);
    float y1=y0;
    float y2=y0;
    float y3=y0;

    for (float currentX=x0; currentX<x0+size/2.0; currentX++) { 
      float s=0;
      if (i%2==0) {//RHS
        s = sqrt(pow(size/2.0, 2)-pow((x0+size/2.0)-currentX, 2));
      } else {//LHS
        s = sqrt(pow(size/2.0, 2)-pow(currentX-x0, 2));
      }

      if (i<2) {
        s=-s;

        y3=y0+s;
        if (y0<-transY+50) {continue;}//y0=-transY+50;}
        if (y3<-transY+50) {y3=-transY+50;}

        if (y0>height-transY-100) {
          y1=y0;
          y2=height-transY-100;
          if (y3>y2) {
            continue;
          }
        }
      } else {

        y3=y0+s;
        if (y0<-transY+50) {
          y1=y0;//dont draw first line
          y2=-transY+50; //second line starts at edge goes to circle border
          if (y2>y3) {
            continue;
          }
        }
        if (y3>height-transY-100) {//if bottom is below bottom edge, increase bottom to edge - unless y0 is also below edge
        y3=height-transY-100;
        if(y0>height-transY-100){continue;}  
    }
      }
        line(currentX, y2, currentX, y3);
        line(currentX, y0, currentX, y1);
      }
    }
  }
