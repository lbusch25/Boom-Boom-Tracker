
/*
  TableReader Class 11/7/2017
    **reads data table input and stores in column array and item array (for row information)
*/

//This class takes in the arrayList of selected items and creates the columns and rows

class TableReader{
  
  public Item[] items;
  static final ArrayList<String> COLUMN_NAMES = new ArrayList<String>(
    asList("VEI", "latitude", "longitude", "SO2 emmission", "S02 altitude", "start year", "duration"));
  
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
    columnNames = new ArrayList<String>();
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
    for (int i = 0;i<numRows;i++){
      e = selected.get(i); 
      Item item = new Item(e.getName());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(0).attName, e.getVEI());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(1).attName, e.getLatitude());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(2).attName, e.getLongitude());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(3).attName, e.getSO2());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(4).attName, e.getS02_alt());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(5).attName, e.getYear());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      item.addAttribute(columns.get(6).attName, e.getDuration());
      //if(row.getFloat(j) > columns.get(j-1).attMax) {
      //    columns.get(j-1).setMax(row.getFloat(j)); //cast int
      //  } if(row.getFloat(j) < columns.get(j-1).attMin) {
      //    columns.get(j-1).setMin(row.getFloat(j)); //cast int
      //  }
      
     
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