
/*
  TableReader Class 11/7/2017
    **reads data table input and stores in column array and item array (for row information)
*/

//This class takes in the arrayList of selected items and creates the columns and rows

class TableReader{
  
  public Item[] items;
  ArrayList<String> COLUMN_NAMES; 
 
  
  ArrayList<V_Eruption> selected;
  
  public int numColumns;
  public int numRows;
  
  int w, h;
  int x, y;
  
  ArrayList<Column> columns;
  
  //Constructor takes in filePath of Table as argument
  TableReader(ArrayList<V_Eruption> selectedT, int widthT, int heightT, int xT, int yT){
    
 
    
    selected = selectedT;
    
    Item[] items = new Item[selected.size()];
    COLUMN_NAMES = new ArrayList<String>();
    COLUMN_NAMES.add("VEI");
    COLUMN_NAMES.add("latitude");
    COLUMN_NAMES.add("longitude");
    COLUMN_NAMES.add("SO2 emmission");
    COLUMN_NAMES.add("S02 altitude");
    COLUMN_NAMES.add("start year");
    COLUMN_NAMES.add("duration");
    
    columns = new ArrayList<Column>();
    
    numRows = selected.size();
    numColumns = 7;
    
    loadColumns(); //updates columnName array with columns from data
    loadItems(); //updates item array with each items row information

  }

  
  /*inputs the column names read from the dataTable*/
  void loadColumns(){
    for(int i = 1; i < numColumns; i++) {
        Column c = new Column(COLUMN_NAMES.get(i));
        c.setX(i*w/numColumns);
        c.setY(y+h);
        c.setMax(0);
        c.setMin(100000);
        columns.add(c);
      }
  }
  
  /*inputs the items from each row*/
  void loadItems(){
    V_Eruption e;
    float currVEI;
    
    
    for (int i = 0;i<numRows;i++){
      e = selected.get(i); 
      Item item = new Item(e.getName());
      currVEI = e.getVEI();
      if(currVEI > columns.get(0).attMax) {
          columns.get(0).setMax(currVEI); //cast int
        } if( currVEI < columns.get(0).attMin) {
          columns.get(0).setMin(currVEI); //cast int
        }
      item.addAttribute(columns.get(0).attName, currVEI);
      
      //currLat = e.getLatitude();
      //if(currLat > columns.get(1).attMax) {
      //    columns.get(1).setMax(currLat); //cast int
      //  } if( currLat < columns.get(1).attMin) {
      //    columns.get(1).setMin(currLat); //cast int
      //  }
      //item.addAttribute(columns.get(1).attName, currLat);
      
      //currLong = e.getLongitude();
      //if(currLong > columns.get(2).attMax) {
      //    columns.get(2).setMax(currLong); //cast int
      //  } if( currLong < columns.get(2).attMin) {
      //    columns.get(2).setMin(currLong); //cast int
      //  }
      //item.addAttribute(columns.get(2).attName, e.getLongitude());
      
      //currSO2 = e.getSO2();
      //if(currSO2 > columns.get(3).attMax) {
      //    columns.get(3).setMax(currSO2); //cast int
      //  } if( currSO2 < columns.get(3).attMin) {
      //    columns.get(3).setMin(currS02); //cast int
      //  }
      //item.addAttribute(columns.get(3).attName, currSO2);
      
      //currSO2_alt = e.getSO2_alt();
      //if(currSO2_alt > columns.get(4).attMax) {
      //    columns.get(4).setMax(currSO2_alt); //cast int
      //  } if( currSO2_alt < columns.get(4).attMin) {
      //    columns.get(4).setMin(currSO2_alt); //cast int
      //  }
      //item.addAttribute(columns.get(4).attName, e.getS02_alt());
      
      //currYear = e.getYear();
      //if(currYear > columns.get(5).attMax) {
      //    columns.get(5).setMax(currYear); //cast int
      //  } if( currYear < columns.get(5).attMin) {
      //    columns.get(5).setMin(currYear); //cast int
      //  }
      //item.addAttribute(columns.get(5).attName, e.getYear());
      
      //currDuration = e.getDuration();
      //if(currDuration > columns.get(6).attMax) {
      //    columns.get(6).setMax(currLat); //cast int
      //  } if( currDuration < columns.get(6).attMin) {
      //    columns.get(6).setMin(currDuration); //cast int
      //  }
      //item.addAttribute(columns.get(6).attName, e.getDuration());
      
      items[i] = item;
  
    }
  }
  /*getter for numRows*/
  int getNumRows(){
    return numRows;
  }
  
  /*getter for numColumns*/
  int getNumColumns(){
    return numColumns;
  }

}