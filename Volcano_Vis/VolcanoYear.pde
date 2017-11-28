

class VolcanoInYear {
  int year;
  Volcano[] volcanoList;
  
  
  VolcanoInYear(int yearT, Volcano[] volcanoListT){
    year = yearT;
    volcanoList = volcanoListT;
   }
   
   
   void draw(){
     for (Volcano v: volcanoList){
       v.display();
     }
   }
   


}