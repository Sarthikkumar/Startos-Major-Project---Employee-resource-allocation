public with sharing class employeeAssignment {

    @AuraEnabled
    public static void assignmentMethod(List<Employee__c> empList, String OppId){

        Project__c Project = [Select Id from Project__c where Opportunity_Name__c =: OppId limit 1];

        List<Project_Assignment__c> projectAssignmentList = new List<Project_Assignment__c>();
        
        for(Employee__c devEmployee : empList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = Project.Id ,Employee_Name__c = devEmployee.Id , Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
         system.debug(projectAssignmentList);
         Database.insert(projectAssignmentList, false);
    }
}
