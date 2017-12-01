import g4p_controls.*; //GUI lib import

class DropDownMenu{
  
  static final int NUM_ELEMENTS_SHOWN = 5;
  GDropList dropDown;
  String type;
  PApplet canvas;
  
  DropDownMenu(PApplet canvasT, String typeT, ArrayList<String> items){
    canvas = canvasT;
    type = typeT;

    dropDown = new GDropList(canvas, canvas.width-100, canvas.height/2, 100, 100, NUM_ELEMENTS_SHOWN);
    
    setDropDownItems(items);
  }

  void setDropDownItems(ArrayList<String> items){
    dropDown.setItems(items, 0);
  
  }
  
  void draw(){
    dropDown.draw();
  }
}