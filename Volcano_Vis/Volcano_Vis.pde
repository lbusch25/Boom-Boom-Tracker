import g4p_controls.*; //GUI lib import

//GDropList yearDlist; //For GUI
DropDownMenu veiDropDown;
DropDownMenu yearDropDown;
DropDownMenu dataTypeDropDown;

TableReader eruptionData;

String selectedVEI;
String selectedYear;
String selectedDataType;

ParallelPlot eruptionPlot;

boolean highlight;
boolean drawRect;
boolean selection;

boolean showAll;
PFont font;

int startX;
int startY;

float maxS02;
float minS02;

V_Eruption[] eruptions;

Table table;
PImage earth;
HashMap<String, ArrayList<V_Eruption>> eruptionYears = new HashMap<String, ArrayList<V_Eruption>>();
HashMap<String, ArrayList<V_Eruption>> eruptionVEI = new HashMap<String, ArrayList<V_Eruption>>();

ArrayList<V_Eruption> hlEruptions = new ArrayList<V_Eruption>();
ArrayList<V_Eruption> selEruptions = new ArrayList<V_Eruption>();

ArrayList<String> dataTypeDDList = new ArrayList<String>();

ArrayList<V_Eruption> emissionList = new ArrayList<V_Eruption>();
ArrayList<V_Eruption> eruptionList = new ArrayList<V_Eruption>();

void setup() {
  size(1200, 800, P2D);
  pixelDensity(displayDensity());
  earth = loadImage("Earth.png");
  loadData();
  highlight = false;
  drawRect = false;
  veiDropDown = new DropDownMenu(this, "VEI", new ArrayList<String>(eruptionVEI.keySet()),width-105,height/2+75);
  yearDropDown = new DropDownMenu(this, "Year", new ArrayList<String>(eruptionYears.keySet()),width-105, height/2+185);
  
  dataTypeDDList.add("Emissions");
  dataTypeDDList.add("Eruptions");
  dataTypeDropDown = new DropDownMenu(this, "Data Type", dataTypeDDList, width-105, height/2+295);
  
  eruptionPlot = new ParallelPlot(eruptionData);
  font = createFont("Arial", 12);
  showAll = true;
  selection = false;
  
  for(Column c: eruptionPlot.activeTable.columns){
    if (c.attName.equals("Total SO2 Mass")) {
      maxS02 = c.attMax;
      minS02 = c.attMin;
    }
  }
  
 
  
}

void draw() {
  background(255, 255, 255);
  image(earth, 0, 0, width, height/2);
  createSelectedArray();
  if(!selection) {
    for(String i: eruptionVEI.keySet()) {
     ArrayList<V_Eruption> vol = eruptionVEI.get(i);
     for(V_Eruption e: vol){
       if(highlight) {
         if(e.isHighlighted()) {
           if(e.VEI >= 0) {
             fill(255, e.calcGreen(), 0);
           } else {
             fill(0, 255, 0);
           }
           e.display();
         } else if (showAll) {
           fill(0, 0, 0, 25);
           e.display();
         }
       } else {
         if(e.VEI >= 0) {
             fill(255, e.calcGreen(), 0);
           } else {
             fill(0, 255, 0);
           }
         e.display();
       }
      }
    }
  } else {
    for(V_Eruption e: selEruptions){
      if(highlight) {
         if(e.isHighlighted()) {
           if(e.VEI >= 0) {
             fill(255, e.calcGreen(), 0);
           } else {
             fill(0, 255, 0);
           }
           e.display();
         } else if (showAll) {
           fill(0, 0, 0, 25);
           e.display();
         }
       } else {
         if(e.VEI >= 0) {
             fill(255, e.calcGreen(), 0);
           } else {
             fill(0, 255, 0);
           }
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

  fill(200, 200, 200);
  rect(width-110, height/2, 110, height/2);
  fill(0);
  textSize(18);
  textAlign(CENTER, TOP);
  text("Filters", width-60, height/2);
  
  

  veiDropDown.draw();
  yearDropDown.draw();
  dataTypeDropDown.draw();
  
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
   } else if (mouseY > height/2 && mouseX < width-110) {
     eruptionPlot.mousePressed();
   }
}

void mouseDragged() {
  if (mouseY > height/2 && mouseX < width-110) {
    eruptionPlot.mouseDragged();
  }
}

void mouseReleased() {
  if(mouseY <= height/2) {
    highlightMapArea();
  } else if (mouseY > height/2 && mouseX < width-110) {
    eruptionPlot.mouseReleased();
  }
  drawRect = false;
}

void keyPressed() { //Add in parallel plot keypressed
  if(key == 'c') {
    clearData();
  } if(key == ' ') {
    showAll = !showAll;
  } if(key == 'r') {
    yearDropDown.dropDown.setSelected(0);
    veiDropDown.dropDown.setSelected(0);
    dataTypeDropDown.dropDown.setSelected(0);
    clearData();
  }
}

void clearData() {
    for(V_Eruption e: hlEruptions) {
      e.setHighlighted();
    }
    hlEruptions.clear();
    highlight = false;
    showAll = true;
    eruptionPlot.columnIsHighlighted = false;
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
      String name = row.getString("Volcano Name");
      float lat = row.getFloat("Latitude");
      float lng = row.getFloat("Longitude");
      float S02 = row.getFloat("Total SO2 Mass");
      int number = row.getInt("Volcano Number");
      V_Eruption e = new V_Eruption(number, vei, lat, lng, name, S02, year);
      
      eruptions[i] = e;
      if(S02 > 0) {
        emissionList.add(e);
      } else {
        eruptionList.add(e);
      }
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
  selection = true;
  if(selectedVEI != veiDropDown.getSelectedItem() || selectedYear != yearDropDown.getSelectedItem() || selectedDataType != dataTypeDropDown.getSelectedItem()){
    selEruptions.clear();
    clearData();
    selectedVEI = veiDropDown.getSelectedItem();
    selectedYear = yearDropDown.getSelectedItem();
    selectedDataType = dataTypeDropDown.getSelectedItem();
       
    if(selectedVEI == "All" && selectedYear == "All" && selectedDataType == "All"){
      for (String e: eruptionYears.keySet()){
        selEruptions.addAll(eruptionYears.get(e));
      }
    } else if (selectedDataType != "All") {
      if(selectedDataType.equals("Emissions")) {
        if(selectedVEI.equals("All") && selectedYear.equals("All")) {
          selEruptions.addAll(emissionList);
        }
        if(!selectedVEI.equals("All")) {
          if(!selectedYear.equals("All")) {
            for(V_Eruption ve: emissionList) {
              if(("" + ve.VEI).equals(selectedVEI) && ve.year.equals(selectedYear)){
                selEruptions.add(ve);
              }
            }
          } else {
            for(V_Eruption ve: emissionList) {
              if(("" + ve.VEI).equals(selectedVEI)){
                selEruptions.add(ve);
              }
            }
          }
        } else if (!selectedYear.equals("All")) {
          for(V_Eruption ve: emissionList) {
              if((ve.year).equals(selectedYear)){
                selEruptions.add(ve);
              }
            }
        }
        
      } else if (selectedDataType.equals("Eruptions")) {
        if(selectedVEI.equals("All") && selectedYear.equals("All")) {
          selEruptions.addAll(eruptionList);
        }
        if(!selectedVEI.equals("All")) {
          if(!selectedYear.equals("All")) {
            for(V_Eruption ve: eruptionList) {
              if(("" + ve.VEI).equals(selectedVEI) && ve.year.equals(selectedYear)){
                selEruptions.add(ve);
              }
            }
          } else {
            for(V_Eruption ve: eruptionList) {
              if(("" + ve.VEI).equals(selectedVEI)){
                selEruptions.add(ve);
              }
            }
          }
        } else if (!selectedYear.equals("All")) {
          for(V_Eruption ve: eruptionList) {
              if((ve.year).equals(selectedYear)){
                selEruptions.add(ve);
              }
            }
        }
        
      }
   
    }else if (selectedVEI == "All" && selectedYear != "All"){
      selEruptions.addAll(eruptionYears.get(selectedYear));
    }else if (selectedYear == "All" && selectedVEI != "All"){
      selEruptions.addAll(eruptionVEI.get(selectedVEI));
    }else{
      
      ArrayList<V_Eruption> tempA = eruptionYears.get(selectedYear);
      for (V_Eruption ve: tempA){
        print(ve);
        if((""+ve.VEI).equals(selectedVEI)) {
          
          selEruptions.add(ve);
        }
      }
    }
    
    //add correct information to selectedarraylist
    //r key input reset selection
  }
}

 //created for dropDown might want to make a new class for the dropdowns we want to use
void handleDropListEvents(GDropList list, GEvent event){
  
}