Table table;

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
}

void draw() {
  background(255);
}

void loadData() {
  table = loadTable("GVP_Eruption_Results.csv", "header");
}