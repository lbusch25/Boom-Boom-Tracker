class ParallelPlot{
  TableReader activeTable;
  
  int startX, startY;
  
  
  boolean columnIsHighlighted;
  
  ParallelPlot(TableReader tr) {
    activeTable = tr;
  }
  
  
  void draw() {
    columnIsHighlighted = highlight;
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
    //columnIsHighlighted = false;
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
      if (c.over && c.deltaX > 25) {
          if(i + 1 < activeTable.columns.size()) {
            Column s = activeTable.columns.get(i+1);
            c.setX(s.getPosX());
            c.deltaX = 0;
            s.setX((i)* (width)/activeTable.numColumns + 50);
            activeTable.columns.set(i, s);
            activeTable.columns.set(i+1, c);
          }
      } 
        if (c.over && c.deltaX < -25) {
          if(i - 1 >= 0) {
            Column s = activeTable.columns.get(i - 1);
            c.setX(s.getPosX());
            c.deltaX = 0;
            s.setX((i) * (width)/activeTable.numColumns + 50);
            activeTable.columns.set(i, s);
            activeTable.columns.set(i-1, c);
          }
       }
       
        if(c.highlight) {
          clearData(); //clears array of highlighted data
          for(Item item: activeTable.items){
            float val = item.getAttribute(c.attName);
            float yVal = c.convertY(val);
            if((yVal >= startY && yVal <= mouseY) || (yVal <= startY && yVal >= mouseY)) {
              item.setHighlighted();
              hlEruptions.add(item.eruption);  //Volcano_Vis
              columnIsHighlighted = true;
              highlight = true; //Volcano_Vis
            } else {
              item.highlighted = false; //Prevents double highlighting on same column
            }
          }
      }
    }
  }
  
  void mouseDragged() {
    for(int i = 0; i < activeTable.columns.size(); i++) {
      Column c = activeTable.columns.get(i);
      if(c.over && c.deltaX >= -25 && c.deltaX <= 25) {
        c.setDX(mouseX);
        }
      } 
  }
  
  void keyPressed() {
    if(key == ' ') {
      showAll = !showAll;
    }
  }
}