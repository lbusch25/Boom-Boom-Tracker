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
  
  String getName() {
    return name;
  }
  
  int getYear() {
    return year;
  }
  
  int getVEI() {
    return VEI;
  }
}