import g4p_controls.*; //GUI lib import
import java.util.Collections;

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

    dropDown = new GDropList(canvas, x, y+25, 100, 100, NUM_ELEMENTS_SHOWN);
    
    
    Collections.sort(items);
    items.add(0, "All");
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
    fill(0, 0, 0);
    textAlign(CENTER, TOP);
    textSize(16);
    text(type, x+50, y);
    dropDown.draw();
  }
}