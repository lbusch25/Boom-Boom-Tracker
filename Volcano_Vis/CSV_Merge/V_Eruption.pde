class V_Eruption {
  int day, month, year, VEI, id;
  float lat, lon;
  
  public HashMap<String, Float> attributes;
  
  
  V_Eruption(int idT) {
    id = idT;
    attributes = new HashMap<String, Float>();
  }
 
  void setID(int idN){
    id = idN;
  }    
}