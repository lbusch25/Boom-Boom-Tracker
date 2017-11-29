class Volcano {
  float x, y;
  //int day, month, year;
  String name;
  ArrayList<V_Eruption> eruptions;
  
  boolean over = false;
  
  Volcano(float lat, float lng, String n){
    x = map(lng, -180, 180, 0, width);
    y = map(lat, 90, -90, 0, height/2);
    name = n;
    eruptions = new ArrayList<V_Eruption>();
  }
  
  void display(){
    //stroke(0);
    //strokeWeight(2);
    //fill(255, 0, 0);
    triangle(x - 7, y + 7, x, y, x + 7, y + 7);
  }
}