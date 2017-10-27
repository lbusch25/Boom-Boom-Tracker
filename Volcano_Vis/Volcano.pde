class Volcano {
  float x, y;
  int day, month, year;
  String name;
  
  boolean over = false;
  
  Volcano(float lat, float lng, int tempD, int tempM, int tempY, String n){
    //x = cos(lat)*cos(lng);
    x = (lng - width/2)*cos(height); //equirectangular projection
    //y = cos(lat)*sin(lng);
    y = (lat - 0); //equirectangular projection
    day = tempD;
    month = tempM;
    year = tempY;
    name = n;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    fill(255, 0, 0);
    triangle(x-1, y-1, x, y, x+1, y+1);
  }
}