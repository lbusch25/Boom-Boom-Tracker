class Item {
  
  String identifier;
  HashMap<String, Float> attributes;
  
  V_Eruption eruption;
  
  boolean highlighted;
  
  Item(String ident) {
    identifier = ident;
    attributes = new HashMap<String, Float>();
    highlighted = false;
  }
  
  void addAttribute(String s, Float f) {
    attributes.put(s, f);
  }
  
  void setHighlighted() {
    highlighted = !highlighted;
    eruption.highlighted = this.highlighted;
  }
  
  void setEruption(V_Eruption e) {
    this.eruption = e;
  }
  
  float getAttribute(String s) {
    return attributes.get(s);
  }
}