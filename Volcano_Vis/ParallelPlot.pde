class ParallelPlot{
  TableReader activeTable;
  //TableReader carData;
  //TableReader cameraData;
  //TableReader foodData;
  
  int startX, startY;
  
  
  boolean columnIsHighlighted;
  
  //Item items[];
  
  //void setup() {
  //  size(1200, 600, P2D); //Need P2D in here cause its so much faster, but font messed up
  //  pixelDensity(displayDensity());
  //  loadData();
  //  font = createFont("Arial", 16);
  //  showAll = true;
  //} 
  
  ParallelPlot(TableReader tr) {
    activeTable = tr;
  }
  
  
  void draw() {
    //background(255);
    for(Column c: activeTable.columns) {
      c.draw();
    } 
    for(int i = 0; i < activeTable.items.length - 1; i++){
      for(int j = 0; j < activeTable.columns.size() - 1; j++) {
        Column c1 = activeTable.columns.get(j);
        Column c2 = activeTable.columns.get(j+1);
        float p1 = c1.convertY(activeTable.items[i].getAttribute(c1.attName));
        float p2 = c2.convertY(activeTable.items[i].getAttribute(c2.attName));
        if(activeTable.items[i].highlighted) {
          stroke(0, 0, 175, 255);
          strokeWeight(0.5);
          line(c1.getPosX(), p1, c2.getPosX(), p2);
        } 
        else if (showAll) {
          if(columnIsHighlighted) {
            stroke(0, 0, 0, 25);
          } else {
            stroke(0);
          }
          strokeWeight(0.5);
          line(c1.getPosX(), p1, c2.getPosX(), p2);
        }
      }
    }
  }
  
  void mouseMoved() {
    for(Column c: activeTable.columns) {
      c.rollOver(mouseX, mouseY);
    }
  }
  
  void mousePressed() {
    columnIsHighlighted = false;
    startX = mouseX;
    startY = mouseY;
    for(Column c: activeTable.columns) {
      if(c.highlight) {
        c.setHighlight();
        for(Item item: activeTable.items) {
          if(item.highlighted) {
            item.setHighlighted();
          }
        }
      }
      if (startX >= c.getPosX() - 25 && startX <= c.getPosX() + 25) {
        c.setHighlight();
        //columnIsHighlighted = true;
      }
    }
  }
  
  void mouseReleased() {
    for(int i = 0; i < activeTable.columns.size(); i++) {
      Column c = activeTable.columns.get(i);
      if (c.over && c.deltaX > 50) {
          if(i + 1 < activeTable.columns.size()) {
            Column s = activeTable.columns.get(i+1);
            c.setX(s.getPosX());
            c.deltaX = 0;
            s.setX((i+1) * width/activeTable.numColumns);
            activeTable.columns.set(i, s);
            activeTable.columns.set(i+1, c);
          }
      } 
        if (c.over && c.deltaX < -50) {
          if(i - 1 >= 0) {
            Column s = activeTable.columns.get(i - 1);
            c.setX(s.getPosX());
            c.deltaX = 0;
            s.setX((i+1) * width/activeTable.numColumns);
            activeTable.columns.set(i, s);
            activeTable.columns.set(i-1, c);
          }
       }
       
        if(c.highlight) {
          for(Item item: activeTable.items){
            float val = item.getAttribute(c.attName);
            float yVal = c.convertY(val);
            if((yVal >= startY && yVal <= mouseY) || (yVal <= startY && yVal >= mouseY)) {
              item.setHighlighted();
              columnIsHighlighted = true;
            }
          }
      }
    }
  }
  
  void mouseDragged() {
    for(int i = 0; i < activeTable.columns.size(); i++) {
      Column c = activeTable.columns.get(i);
      if(c.over && c.deltaX >= -50 && c.deltaX <= 50) {
        c.setDX(mouseX);
        }
      } 
  }
  
  void keyPressed() {
    if(key == ' ') {
      showAll = !showAll;
    }
  }
  
  //void loadData() {
    
  //  carData = new TableReader("cars-cleaned.tsv"); //Works
  //  cameraData = new TableReader("cameras-cleaned.tsv"); //Works
  //  foodData = new TableReader("nutrients-cleaned.tsv"); //Not fully working for foodData
    
  //  activeTable = carData;
  //}
}