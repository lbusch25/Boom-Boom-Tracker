class Column {
  
  public static final int COLUMN_HEIGHT = 400;
  public static final int ATT_LABEL_HEIGHT = COLUMN_HEIGHT + 50;
  public static final int MAX_LABEL_HEIGHT = COLUMN_HEIGHT + 20;
  public static final int MIN_LABEL_HEIGHT = 15;
  
  int x, y;
  String attName;
  float attMax, attMin;
  
  int deltaX;
  
  boolean over;
  boolean highlight;
  
  Column(String attribute) {
    attName = attribute;
  }
  
  float convertY(float ty) {
    //float attRange = attMax - attMin;
    //float pos = floor((ty - attMin)) * floor((400/attRange)); WHYYYYYYY :(
    //return y - pos;
    return map(ty, attMin, attMax, y, y-COLUMN_HEIGHT);
  }
  
  void rollOver(int mx, int my) {
    if(y - ATT_LABEL_HEIGHT + 50 >= my && my >= y - ATT_LABEL_HEIGHT - 50 
        && x + deltaX - 50 <= mx && mx <= x + deltaX +50) {
          over = true;
        } else {
          over = false;
        }
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  int getPosX() {
    return x + deltaX;
  }
  
  void setX(int tx) {
    x = tx;
  }
  
  void setY(int ty) {
    y = ty;
  }
  
  void setMax(float max) {
    attMax = max;
  }
  
  void setMin(float min) {
    attMin = min;
  }
  
  void setHighlight() {
    highlight = !highlight;
  }
  
  void setDX(int mx) {
    deltaX = mx - x;
  }
  
  void draw() {
    fill(0);
    stroke(0);
    if(over) {
      fill(255, 0, 0);
    }
    line(x + deltaX, y, x + deltaX, y - COLUMN_HEIGHT);
      textFont(font, 16); //Using the font from ParallelPlot.pde
      textAlign(CENTER, CENTER);
      text(attName, x  + deltaX + 5, y - ATT_LABEL_HEIGHT);
      text(str(ceil(attMax)), x + deltaX + 5, y - MAX_LABEL_HEIGHT);
      text(str(floor(attMin)), x + deltaX + 5, y + MIN_LABEL_HEIGHT);
  }
}