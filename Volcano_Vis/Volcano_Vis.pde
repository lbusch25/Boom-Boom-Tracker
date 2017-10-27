Table table;
ArrayList<Volcano> volcanos = new ArrayList<Volcano>();

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  loadData();
}

void draw() {
  background(255);
  for(Volcano v: volcanos) {
    v.display();
  }
}

void loadData() {
  table = loadTable("GVP_Eruption_Results.csv", "header");
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow row = table.getRow(i);
    float lat = row.getFloat("Latitude");
    float lng = row.getFloat("Longitude");
    int year = row.getInt("Start Year");
    int month = row.getInt("Start Month");
    int day = row.getInt("Start Day");
    String name = row.getString("Volcano Name");
    
    Volcano v = new Volcano(lat, lng, day, month, year, name);
    volcanos.add(v);
  }
}