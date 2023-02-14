public class opportunityEstimationClass {
    List<opportunityClass> oclist = new List<opportunityClass>();
    
    public void EstimationStageMethod(){
        opportunityClass oc1 = new opportunityClass('Initiation/Planning' , 32 , 3, 1000);
        opportunityClass oc2 = new opportunityClass('Requirement analysis' , 20 , 2, 1000);
        opportunityClass oc3 = new opportunityClass('Design' , 50 , 7, 1000);
        opportunityClass oc4 = new opportunityClass('Development' , 120 , 12, 1000);
        opportunityClass oc5 = new opportunityClass('QA' , 50 , 10, 1000);
        opportunityClass oc6 = new opportunityClass('Implementation' , 40 , 10, 1000);
        opportunityClass oc7 = new opportunityClass('Operation & Maintenance' , 18 , 2, 1000);
        oclist.add(oc1);
        oclist.add(oc2);
        oclist.add(oc3);
        oclist.add(oc4);
        oclist.add(oc5);
        oclist.add(oc6);
        oclist.add(oc7);
        System.Debug(oclist);
    }

}