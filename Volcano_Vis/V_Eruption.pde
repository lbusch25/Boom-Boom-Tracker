class V_Eruption {
  int day, month, year, VEI;
  String name;
  boolean over;
  boolean highlighted;
  
  V_Eruption(int tempD, int tempM, int tempY, int tempV, String n) {
    day = tempD;
    month = tempM;
    year = tempY;
    VEI = tempV;
    name = n;
    highlighted = false;
  }
  
  void rollOver(int mX, int mY) {
    float vx = mX - Volcano_Vis.volcanoMap.get(this.name).getX();
    float vy = mY - (Volcano_Vis.volcanoMap.get(this.name).getY() + 3.5);
    if((vx*vx + vy*vy) <= 25) {
      over = true;
    } else {
      over = false;
    }
  }
  
  int calcRed() {
    float redVal = map(VEI, 0, 7, 150, 255);
    return (int) redVal;
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
  
  String getName() {
    return name;
  }
  
  int getYear() {
    return year;
  }
  
  int getVEI() {
    return VEI;
  }
  
  void display() {
    stroke(0);
    if(over) {
      fill(255, 255, 255);
    }
    //  Volcano_Vis.volcanoMap.get(this.name).display();
    //} else if (highlighted) {
    //  fill(255, 255, 255);
    //  Volcano_Vis.volcanoMap.get(this.name).display();
    //} else {
    //  fill(255, this.calcGreen(), 0);
    //  Volcano_Vis.volcanoMap.get(this.name).display();
    //}
    Volcano_Vis.volcanoMap.get(this.name).display();
  }
}