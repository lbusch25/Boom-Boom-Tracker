import g4p_controls.*; //GUI lib import

//GDropList yearDlist; //For GUI
DropDownMenu veiDropDown;
DropDownMenu yearDropDown;
TableReader eruptionData;

String selectedVEI;
String selectedYear;

ParallelPlot eruptionPlot;

boolean highlight;
boolean drawRect;

boolean showAll;
PFont font;

int startX;
int startY;

V_Eruption[] eruptions;

Table table;
PImage earth;
HashMap<String, ArrayList<V_Eruption>> eruptionYears = new HashMap<String, ArrayList<V_Eruption>>();
HashMap<String, ArrayList<V_Eruption>> eruptionVEI = new HashMap<String, ArrayList<V_Eruption>>();
ArrayList<V_Eruption> hlEruptions = new ArrayList<V_Eruption>();

ArrayList<V_Eruption> selEruptions = new ArrayList<V_Eruption>();


void setup() {
  size(1200, 800, P2D);
  pixelDensity(displayDensity());
  earth = loadImage("Earth.png");
  loadData();
  highlight = false;
  drawRect = false;
  veiDropDown = new DropDownMenu(this, "vei", new ArrayList<String>(eruptionVEI.keySet()),width-100,height/2);
  yearDropDown = new DropDownMenu(this, "year", new ArrayList<String>(eruptionYears.keySet()),width-200, height/2);
  
  eruptionPlot = new ParallelPlot(eruptionData);
  font = createFont("Arial", 12);
  showAll = true;
}

void draw() {
  background(255, 255, 255);
  image(earth, 0, 0, width, height/2);
  for(String i: eruptionVEI.keySet()) {
   ArrayList<V_Eruption> vol = eruptionVEI.get(i);
   for(V_Eruption e: vol){
     if(highlight) {
       if(e.isHighlighted()) {
         fill(255, e.calcGreen(), 0);
         e.display();
       } else if (showAll) {
         fill(0, 0, 0, 25);
         e.display();
       }
     } else {
       fill(255, e.calcGreen(), 0);
       e.display();
     }
    }
  }
  
  if(drawRect) {
    noFill();
    stroke(135, 206, 235);
    strokeWeight(1.5);
    rect(startX, startY, mouseX - startX, mouseY - startY);
    strokeWeight(1.0);
  }
  
  //Dropdown testing MOVE OUT OF DRAW NO MORE MEMORY!!!
  //yearDlist = new GDropList(this, width-100, height/2, 100, 100);
  //String[] list = new String[6];
  //for (int i = 0;i<list.length;i++){
  //  if(i == 0){
  //    list[i] = "All";
  //  }else{
  //  list[i] = str(1990+i);
  //  }
  //}
  
  //yearDlist.setItems(list, -1);
  //yearDlist.draw();
  veiDropDown.draw();
  eruptionPlot.draw();
  
  
}

void mouseMoved() {
  if(mouseY <= height/2) {
   for(String i: eruptionVEI.keySet()) {
     ArrayList<V_Eruption> vol = eruptionVEI.get(i);
     for(V_Eruption e: vol){
       e.rollOver(mouseX, mouseY);
     }
   }
  } else if (mouseY > height/2) {
    eruptionPlot.mouseMoved();
  }
}

void mousePressed() {
   startX = mouseX;
   startY = mouseY;
   if(mouseY <= height/2) {
     for(String i: eruptionVEI.keySet()) {
       ArrayList<V_Eruption> vol = eruptionVEI.get(i);
       for(V_Eruption e: vol){
         if(e.isOver()) {
           highlight = true;
           e.setHighlighted();
           hlEruptions.add(e); //depending on how we decide to do this, might need to
           //toggle adding and removing e
         }
       }
     }
     drawRect = true;
   } else if (mouseY > height/2) {
     eruptionPlot.mousePressed();
   }
}

void mouseDragged() {
  if (mouseY > height/2) {
    eruptionPlot.mouseDragged();
  }
}

void mouseReleased() {
  if(mouseY <= height/2) {
    highlightMapArea();
  } else if (mouseY > height/2) {
    eruptionPlot.mouseReleased();
  }
  drawRect = false;
}

void keyPressed() { //Add in parallel plot keypressed
  if(key == 'c') {
    for(V_Eruption e: hlEruptions) {
      e.setHighlighted();
    }
    hlEruptions.clear();
    highlight = false;
    showAll = true;
  } if(key == ' ') {
    showAll = !showAll;
  }
}

void highlightMapArea() {
  if(mouseX < startX) {
      if(mouseY < startY) {
       for(String i: eruptionVEI.keySet()) {
         ArrayList<V_Eruption> vol = eruptionVEI.get(i);
         for(V_Eruption e: vol){
           if((e.x >= mouseX && e.x <= startX) && (e.y <= startY && e.y >= mouseY)) {
             if(!e.isHighlighted()) {
               highlight = true;
               e.setHighlighted();
               hlEruptions.add(e);
             }
           }
         }
       }
      } else if (mouseY > startY) {
        for(String i: eruptionVEI.keySet()) {
         ArrayList<V_Eruption> vol = eruptionVEI.get(i);
         for(V_Eruption e: vol){
           if((e.x >= mouseX && e.x <= startX) && (e.y >= startY && e.y <= mouseY)) {
             if(!e.isHighlighted()) {
               highlight = true;
               e.setHighlighted();
               hlEruptions.add(e);
             }
           }
         }
       }
      }
    } else if (mouseX > startX) {
      if(mouseY < startY) {
       for(String i: eruptionVEI.keySet()) {
         ArrayList<V_Eruption> vol = eruptionVEI.get(i);
         for(V_Eruption e: vol){
           if((e.x <= mouseX && e.x >= startX) && (e.y <= startY && e.y >= mouseY)) {
             if(!e.isHighlighted()) {
               highlight = true;
               e.setHighlighted();
               hlEruptions.add(e);
             }
           }
         }
       }
      } else if (mouseY > startY) {
        for(String i: eruptionVEI.keySet()) {
         ArrayList<V_Eruption> vol = eruptionVEI.get(i);
         for(V_Eruption e: vol){
           if((e.x <= mouseX && e.x >= startX) && (e.y >= startY && e.y <= mouseY)) {
             if(!e.isHighlighted()) {
               highlight = true;
               e.setHighlighted();
               hlEruptions.add(e);
             }
           }
         }
       }
      }
    }
}

void loadData() {
  table = loadTable("Eruption_Emission_Merged.csv", "header");
  eruptions = new V_Eruption[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow row = table.getRow(i);
      int year = row.getInt("Start Year");
      //int month = row.getInt("Start Month");
      //int day = row.getInt("Start Day");
      int vei = row.getInt("VEI");
      //String name = row.getString("Volcano Name");
      float lat = row.getFloat("Latitude");
      float lng = row.getFloat("Longitude");
      int number = row.getInt("Volcano Number");
      V_Eruption e = new V_Eruption(number, vei, lat, lng);
      eruptions[i] = e;
      if(eruptionYears.containsKey(str(year))){ //Add eruption to the year arrayList
        eruptionYears.get(str(year)).add(e);
      }
      else {
        ArrayList<V_Eruption> eruptions = new ArrayList<V_Eruption>();
        eruptions.add(e);
        eruptionYears.put(str(year), eruptions);
      } 
      
        if(eruptionVEI.containsKey(str(vei))) {
          eruptionVEI.get(str(vei)).add(e);
        } else {
          ArrayList<V_Eruption> erupt = new ArrayList<V_Eruption>();
          erupt.add(e);
          eruptionVEI.put(str(vei), erupt);
        }
  }
  
  eruptionData = new TableReader("Eruption_Emission_Merged.csv");
}

void createSelectedArray(){
  if(selectedVEI != veiDropDown.getSelectedItem() && selectedYear != yearDropDown.getSelectedItem()){
    selectedVEI = veiDropDown.getSelectedItem();
    selectedYear = yearDropDown.getSelectedItem();
    
    //add correct information to selectedarraylist
    //r key input reset selection
  }
}

// created for dropDown might want to make a new class for the dropdowns we want to use
//void handleDropListEvents(GDropList list, GEvent event){

//}