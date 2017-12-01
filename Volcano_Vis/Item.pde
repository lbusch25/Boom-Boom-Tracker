class Item {
  
  String identifier;
  HashMap<String, Float> attributes;
  
  boolean highlighted;
  
  Item(String ident) {
    identifier = ident;
    attributes = new HashMap<String, Float>();
  }
  
  void addAttribute(String s, Float f) {
    attributes.put(s, f);
  }
  
  void setHighlighted() {
    highlighted = !highlighted;
  }
  
  float getAttribute(String s) {
    return attributes.get(s);
  }
}