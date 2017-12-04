Table emissionsT;
Table eruptionsT;

Table newTable;

ArrayList<String> eruptionColumns;

HashMap<Integer, Volcano> volcanos;

void setup(){
  eruptionColumns = new ArrayList<String>();
  volcanos = new HashMap<Integer, Volcano>();
  loadData();
  compareCSV();
  createNewTable();
  saveTable(newTable, "data/Eruption_Emission_Merged.csv");
}

void loadData(){
  emissionsT = loadTable("GVP_Emission_Results.csv", "header");
  eruptionsT = loadTable("GVP_Eruption_Results.csv", "header");
  
  newTable = new Table();
  
  createEruptionColumns();
  updateEruptions();
}



void compareCSV(){
 for (int i =0;i<emissionsT.getRowCount();i++){
   TableRow row = emissionsT.getRow(i);
   int volcano_id = row.getInt("Volcano Number");
   int date = convertDateFormat(row.getString("Start Date"));
   if(volcanos.get(volcano_id) != null){
     for (int j = 0; j< volcanos.get(volcano_id).e.size(); j++){
       V_Eruption currE = volcanos.get(volcano_id).e.get(j);
       if(currE.attributes.get("Start Year") == date){
         volcanos.get(volcano_id).e.get(j).attributes.put("Total SO2 Mass", row.getFloat("Total SO2 Mass"));
         volcanos.get(volcano_id).e.get(j).attributes.put("SO2 Altitude Range Start", row.getFloat("SO2 Altitude Range Start"));        
       }
     }
     V_Eruption newE = volcanos.get(volcano_id).e.get(0);
     newE.setID(row.getInt("Emission ID"));
     newE.attributes.put("Eruption ID", float(newE.id));
     newE.attributes.put("VEI", -1.0);
     newE.attributes.put("Total SO2 Mass", row.getFloat("Total SO2 Mass"));
     newE.attributes.put("SO2 Altitude Range Start", row.getFloat("SO2 Altitude Range Start")); 
   }
   
 }
}

void updateEruptions(){
  TableRow row;
  for (int i = 0; i < eruptionsT.getRowCount();i++){
    row = eruptionsT.getRow(i);
    V_Eruption eruption = new V_Eruption(row.getInt("Eruption Number"));
    for (String col: eruptionColumns){
      eruption.attributes.put(col, row.getFloat(col));
    }
    
    if(volcanos.get(int(eruption.attributes.get("Volcano Number"))) != null){
      volcanos.get(int(eruption.attributes.get("Volcano Number"))).e.add(eruption);
    }else{
      Volcano newV = new Volcano(int(eruption.attributes.get("Volcano Number")), eruption.attributes.get("Latitude"), eruption.attributes.get("Longitude"), row.getString("Volcano Name"));
      newV.e.add(eruption);
      volcanos.put(int(eruption.attributes.get("Volcano Number")), newV);
    }
  }
}

void createNewTable(){
  addColumnsToTable();
  
  for(int i: volcanos.keySet()){
    for(V_Eruption ve: volcanos.get(i).e){
      TableRow row = newTable.addRow();
      for (String s : newTable.getColumnTitles()){
        if(s == "Volcano Name"){
          row.setString(s, volcanos.get(i).name);
        }else if(s == "Total SO2 Mass" || s == "SO2 Altitude Range Start"){
          if(ve.attributes.containsKey(s)){
            row.setFloat(s, ve.attributes.get(s));
          }else{
            row.setString(s, null);
          }
        }else{
          row.setFloat(s,ve.attributes.get(s));
        }
      }
      newTable.addRow(row);
    }
  }
}

void createEruptionColumns(){
  eruptionColumns.add("Volcano Number");
  eruptionColumns.add("Eruption Number");
  eruptionColumns.add("VEI" );
  eruptionColumns.add("Start Year");
  eruptionColumns.add("End Year");
  eruptionColumns.add("Latitude");
  eruptionColumns.add("Longitude");
}

void addColumnsToTable(){
  for (String s: eruptionColumns){
    newTable.addColumn(s);
  }
  newTable.addColumn("Volcano Name");
  newTable.addColumn("Total SO2 Mass");
  newTable.addColumn("SO2 Altitude Range Start");
}

int convertDateFormat(String date){
  String[] concatDate = date.split(" ");
  return Integer.parseInt(concatDate[0]);
}