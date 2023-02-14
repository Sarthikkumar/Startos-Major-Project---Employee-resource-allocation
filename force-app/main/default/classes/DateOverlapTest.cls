@isTest
private class DateOverlapTest {
 public static void dateoverlap(){
        Date endDatep1 = Date.newInstance(2022, 8, 21); //Active //emp 1 // java
        Date startDatep2 = Date.newInstance(2022, 8, 21);// Draft // java
        string emp1 = 'Active';
        string emp2 = 'inactive';
        string p1 = 'Active' ;
        string p2 = 'Draft';
        
        
        if (endDatep1 < startDatep2){
            
            system.debug('p1 ' +emp1);
             system.debug('p2 '+emp2);
        }
        else{
             system.debug('p2 '+emp2);
        }
        
 System.assertEquals('P2','p2 '+emp2);
 }
}