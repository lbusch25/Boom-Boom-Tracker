class V_Eruption {
  int day, month, year, VEI;
  String name;
  
  V_Eruption(int tempD, int tempM, int tempY, int tempV, String n) {
    day = tempD;
    month = tempM;
    year = tempY;
    VEI = tempV;
    name = n;
  }
  
  int calcRed() {
    float redVal = map(VEI, 0, 7, 150, 255);
    return (int) redVal;
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
    fill(255, this.calcGreen(), 0);
    Volcano_Vis.volcanoMap.get(this.name).display();
  }
}