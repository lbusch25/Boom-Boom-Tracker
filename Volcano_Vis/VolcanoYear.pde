

class VolcanoYear {
  int year;
  Volcano[] volcanoList;
  
  
  VolcanoYear(int yearT, Volcano[] volcanoListT){
    year = yearT;
    volcanoList = volcanoListT;
   }
   
   
   void draw(){
     for (Volcano v: volcanoList){
       v.display();
     }
   }
   


}