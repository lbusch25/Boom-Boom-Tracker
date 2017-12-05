import g4p_controls.*; //GUI lib import

class DropDownMenu{
  
  static final int NUM_ELEMENTS_SHOWN = 5;
  GDropList dropDown;
  String type;
  PApplet canvas;
  int x, y;
  String selected;
  
  DropDownMenu(PApplet canvasT, String typeT, ArrayList<String> items, int tempX, int tempY){
    x = tempX;
    y = tempY;
    canvas = canvasT;
    type = typeT;

    dropDown = new GDropList(canvas, x, y, 100, 100, NUM_ELEMENTS_SHOWN);
    
    setDropDownItems(items);
  }

  void setDropDownItems(ArrayList<String> items){
    dropDown.setItems(items, 0);
  
  }
  
  String getSelectedItem(){
    selected = dropDown.getSelectedText();
    return selected;
  }
  
  void draw(){
    dropDown.draw();
  }
}