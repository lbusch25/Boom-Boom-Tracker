import g4p_controls.*; //GUI lib import

//GDropList yearDlist; //For GUI
DropDownMenu veiDropDown;
DropDownMenu yearDropDown;

Table table;
PImage earth;
//ArrayList<Volcano> volcanos = new ArrayList<Volcano>(); //Might want to maket this a HashMap
HashMap<String, Volcano> volcanoMap = new HashMap<String, Volcano>();
HashMap<String, ArrayList<V_Eruption>> eruptionYears = new HashMap<String, ArrayList<V_Eruption>>();
HashMap<String, ArrayList<V_Eruption>> eruptionVEI = new HashMap<String, ArrayList<V_Eruption>>();

//Volcano phoenix = new Volcano(33.44, -112.07, "Phoenix");

void setup() {
  size(800, 800);
  pixelDensity(displayDensity());
  earth = loadImage("Earth.png");
  loadData();
  
  //veiDropDown = new DropDownMenu(this, "vei", new ArrayList<String>(eruptionVEI.keySet()));
  yearDropDown = new DropDownMenu(this, "year", new ArrayList<String>(eruptionYears.keySet()));
  for (String i: eruptionYears.keySet()){
    println(i);
  }
}

void draw() {
  //Volcano phoenix = new Volcano(33.44, -112.07, "Phoenix");
  //background(255);
  image(earth, 0, 0, width, height/2);
  //for(Volcano v: volcanos) {
  //  v.display(); //Just drawing every volcano right now, not eruptions.
  //} 
  //for(String n: volcanoMap.keySet()){
  //  volcanoMap.get(n).display(); //Just drawing every volcano right now, need to fix 
  //}
  
  for(String i: eruptionVEI.keySet()) {
   ArrayList<V_Eruption> vol = eruptionVEI.get(i);
   for(V_Eruption e: vol){
     Volcano v = volcanoMap.get(e.getName());
     v.display();
    }
  }
  //The lat/lng conversion before we start working on drawing eruptions
  fill(0, 255, 0);
  //triangle(phoenix.x - 15, phoenix.y - 15, phoenix.x, phoenix.y, phoenix.x + 15, phoenix.y + 15);
  //phoenix.display();
  
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
  yearDropDown.draw();
  
  
}

void loadData() {
  table = loadTable("GVP_Eruption_Results.csv", "header");
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow row = table.getRow(i);
      int year = row.getInt("Start Year");
      int month = row.getInt("Start Month");
      int day = row.getInt("Start Day");
      int vei = row.getInt("VEI");
      String name = row.getString("Volcano Name");
      V_Eruption e = new V_Eruption(day, month, year, vei, name);
      float lat = row.getFloat("Latitude");
      float lng = row.getFloat("Longitude");
      Volcano v = new Volcano(lat, lng, name);
      if(eruptionYears.containsKey(str(year))){ //Add eruption to the year arrayList
        eruptionYears.get(str(year)).add(e);
      }
      else {
        ArrayList<V_Eruption> eruptions = new ArrayList<V_Eruption>();
        eruptions.add(e);
        eruptionYears.put(str(year), eruptions);
      } 
      
      //if(vei >= 0) {
        if(eruptionVEI.containsKey(str(vei))) {
          eruptionVEI.get(str(vei)).add(e);
        } else {
          ArrayList<V_Eruption> erupt = new ArrayList<V_Eruption>();
          erupt.add(e);
          eruptionVEI.put(str(vei), erupt);
        }
     // }
    //Not working yet, probably due to null values in our data
    //if (eruptionVEI.containsKey(str(vei))) { //Add eruption to array of VEI
    //  eruptionVEI.get(vei).add(e);
    //} else {
    //  ArrayList<V_Eruption> eruptionV = new ArrayList<V_Eruption>();
    //  eruptionV.add(e);
    //  eruptionVEI.put(str(vei), eruptionV);
    //} 
    if (!volcanoMap.containsKey(name)) { //If volcano not tracked, add it to the volcanoMap
      volcanoMap.put(name, v);
    }
  }
}

// created for dropDown might want to make a new class for the dropdowns we want to use
void handleDropListEvents(GDropList list, GEvent event){

}