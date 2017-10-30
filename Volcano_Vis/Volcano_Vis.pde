Table table;
PImage earth;
//ArrayList<Volcano> volcanos = new ArrayList<Volcano>(); //Might want to maket this a HashMap
HashMap<String, Volcano> volcanoMap = new HashMap<String, Volcano>();
HashMap<String, ArrayList<V_Eruption>> eruptionYears = new HashMap<String, ArrayList<V_Eruption>>();
HashMap<String, ArrayList<V_Eruption>> eruptionVEI = new HashMap<String, ArrayList<V_Eruption>>();

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  earth = loadImage("Earth.png");
  loadData();
}

void draw() {
  //background(255);
  image(earth, 0, 0, width, height/2);
  //for(Volcano v: volcanos) {
  //  v.display(); //Just drawing every volcano right now, not eruptions.
  //}
  for(String n: volcanoMap.keySet()){
    volcanoMap.get(n).display(); //Just drawing every volcano right now, need to fix 
  } //The lat/lng conversion before we start working on drawing eruptions
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