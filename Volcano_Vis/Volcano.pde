class Volcano {
  float x, y;
  //int day, month, year;
  String name;
  ArrayList<V_Eruption> eruptions;
  
  boolean over = false;
  
  Volcano(float lat, float lng, String n){
    //x = cos(lat)*cos(lng);
    x = (lng - width/2)*cos(height); //equirectangular projection
    //y = cos(lat)*sin(lng);
    y = (lat + height/4); //equirectangular projection
    name = n;
    eruptions = new ArrayList<V_Eruption>();
  }
  
  void display(){
    stroke(0);
    //strokeWeight(2);
    fill(255, 0, 0);
    triangle(x - 5, y + 5, x, y, x + 5, y + 5);
  }
}