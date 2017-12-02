
/*
  TableReader Class 11/7/2017
    **reads data table input and stores in column array and item array (for row information)
*/


class TableReader{
  Table dataTable;
  public Item[] items;
  public String[] columnNames;
  public int numColumns;
  public int numRows;
  
  ArrayList<Column> columns;
  
  //Constructor takes in filePath of Table as argument
  TableReader(String filePath){
    
    dataTable = loadTable(filePath, "header");
    items = new Item[dataTable.getRowCount()];
    columnNames = new String[dataTable.getColumnCount()];
    columns = new ArrayList<Column>();
    
    numRows = dataTable.getRowCount();
    numColumns = dataTable.getColumnCount();
    
    loadColumns(); //updates columnName array with columns from data
    loadItems(); //updates item array with each items row information
    
    
    
  
  }
  
  /*inputs the column names read from the dataTable*/
  void loadColumns(){
    columnNames = dataTable.getRow(0).getColumnTitles();
    for(int i = 1; i < numColumns; i++) {
        Column c = new Column(columnNames[i]);
        c.setX(i*width/numColumns);
        c.setY(500);
        c.setMax(0);
        c.setMin(100000);
        columns.add(c);
      }
  }
  
  /*inputs the items from each row*/
  void loadItems(){
    TableRow row; 
    for (int i = 0;i<numRows;i++){
      row = dataTable.getRow(i); 
      Item item = new Item(row.getString(columnNames[0]));
      for(int j = 1; j < numColumns; j++) {
        if(row.getFloat(j) > columns.get(j-1).attMax) {
          columns.get(j-1).setMax(row.getFloat(j)); //cast int
        } if(row.getFloat(j) < columns.get(j-1).attMin) {
          columns.get(j-1).setMin(row.getFloat(j)); //cast int
        }
        item.addAttribute(columns.get(j-1).attName, row.getFloat(j));
      }
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