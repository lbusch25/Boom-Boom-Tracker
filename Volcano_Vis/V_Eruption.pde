class V_Eruption {
  
  float x, y;
  int eruptionNum, VEI;
  
  boolean over;
  boolean highlighted;
  
  Item item;
  
  //HashMap<String, Float> attributes;
  
  V_Eruption(int num, int vei, float latitude, float longitude) {
    eruptionNum = num;
    VEI = vei;
    x = map(longitude, -180, 180, 0, width);
    y = map(latitude, 90, -90, 0, height/2);
    
    highlighted = false;
    //attributes = new HashMap<String, Float>();
    //attributes.put("lat", latitude);
    //attributes.put("long", longitude);
    //attributes.put("VEI", (float) VEI);
  }
  
  //void addAttribute(String s, Float f) {
  //  attributes.put(s, f);
  //}
  
  //float getAttribute(String s) {
  //  return attributes.get(s);
  //}
  
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
  
  boolean isHighlighted() {
    return highlighted;
  }
  
  void setHighlighted() {
    highlighted = !highlighted;
    item.highlighted = !item.highlighted;
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