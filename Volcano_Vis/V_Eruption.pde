class V_Eruption {
  
  float x, y, S02;
  int eruptionNum, VEI;
  
  String name;
  String year;
  
  boolean over;
  boolean highlighted;
  
  Item item;
  
  V_Eruption(int num, int vei, float latitude, float longitude, String n, float s2, int yr) {
    eruptionNum = num;
    VEI = vei;
    x = map(longitude, -180, 180, 0, width);
    y = map(latitude, 90, -90, 0, height/2);
    name = n;
    S02 = s2;
    year = "" + yr;
    highlighted = false;
  }
  
  void setItem(Item i) {
    this.item = i;
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
  
  float calcRadius(float s02) {
    float rad = map(s02, minS02, maxS02, 15, 30);
    return rad;
  }
  
  boolean isHighlighted() {
    return highlighted;
  }
  
  void setHighlighted() {
    highlighted = !highlighted;
    item.highlighted = this.highlighted;
  }
  
  int calcGreen() {
    float greenVal = map(VEI, 0, 7, 255, 0);
    return (int) greenVal;
  }
  
  void display() {
    stroke(0);
    if(over) {
      fill(135, 206, 235);
      textSize(14);
      text(name, x, y-10);
    }
    triangle(x - 7, y + 7, x, y, x + 7, y + 7);
    
    if(this.item.getAttribute("Total SO2 Mass") > 0.0) {
      if(!highlight) {
        fill(0, 255, 0, 25);
      } else {
        fill(0, 255, 0, 10);
      }
      float radius = calcRadius(item.getAttribute("Total SO2 Mass"));
      ellipse(x, y+3.5, radius, radius);
    }
  }
}