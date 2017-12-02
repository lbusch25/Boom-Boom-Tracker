class V_Eruption {
  //int day, month, year, VEI;
  float x, y;
  int eruptionNum, VEI;
  //String name;
  boolean over;
  boolean highlighted;
  
  //V_Eruption(int tempD, int tempM, int tempY, int tempV, String n, float latitude, float longitude) {
  //  day = tempD;
  //  month = tempM;
  //  year = tempY;
  //  VEI = tempV;
  //  name = n;
  //  x = map(longitude, -180, 180, 0, width);
  //  y = map(latitude, 90, -90, 0, height/2);
  //  highlighted = false;
  //}
  
  V_Eruption(int num, int vei, float latitude, float longitude) {
    eruptionNum = num;
    VEI = vei;
    x = map(longitude, -180, 180, 0, width);
    y = map(latitude, 90, -90, 0, height/2);
    highlighted = false;
  }
  
  void rollOver(int mX, int mY) {
    float vx = mX - x;
    float vy = mY - (y + 3.5);
    if((vx*vx + vy*vy) <= 25) {
      over = true;
    } else {
      over = false;
    }
  }
  
  boolean isOver() {
    return over;
  }
  
  boolean isHighlighted() {
    return highlighted;
  }
  
  void setHighlighted() {
    highlighted = !highlighted;
  }
  
  int calcGreen() {
    float greenVal = map(VEI, 0, 7, 255, 0);
    return (int) greenVal;
  }
  
  void display() {
    stroke(0);
    if(over) {
      fill(135, 206, 235);
    }
    triangle(x - 7, y + 7, x, y, x + 7, y + 7);
  }
}