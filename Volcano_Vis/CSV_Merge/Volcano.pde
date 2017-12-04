class Volcano{
  int id;
  float lat, lon;
  String name;
  
  ArrayList<V_Eruption> e;
  
  Volcano(int number, float latitude, float longitude, String nameT){
    e = new ArrayList<V_Eruption>();
    id = number;
    lat = latitude;
    lon = longitude;
    name = nameT;
  }
}