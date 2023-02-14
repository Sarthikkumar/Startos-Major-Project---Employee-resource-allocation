@isTest
public class AssignmentClassTest {
 
    
    public static testMethod void validateAssignmentClass() {
           AssignmentClass ac = new AssignmentClass();
           
           String reqSkills ='Salesforce Developer;Salesforce Administrator;CPQ Developer;LWC Developer;Salesforce QA Tester;Solution Architect';
           
           
        List<String> res = reqSkills.split(';');
        
         List<Employee__c> empList = new List<Employee__c>();
          
        Employee__c Developer = new Employee__c(Employee_Name__c='emp 1', Skills__c ='Salesforce Developer', Role__c='Developer', isAllocated__c = false);
        Employee__c Designer = new Employee__c(Employee_Name__c='emp 2', Skills__c ='LWC Developer', Role__c='Designer',isAllocated__c = false);
        Employee__c Architect = new Employee__c(Employee_Name__c='emp 3', Skills__c ='Solution Architect', Role__c='Architect',isAllocated__c = false);
        Employee__c Tester = new Employee__c(Employee_Name__c='emp 4', Skills__c ='Salesforce QA Tester', Role__c='Tester',isAllocated__c = false);
        Employee__c Manager = new Employee__c(Employee_Name__c='emp 5', Skills__c ='Salesforce Administrator', Role__c='Manager',isAllocated__c = false);
          
        empList.add(Developer);
        empList.add(Designer);
        empList.add(Architect);
        empList.add(Tester);
        empList.add(Manager);
          
          insert empList;
        
       
          
          List<Project_Assignment__c> projectAssignmentList = new List<Project_Assignment__c>();
          
          for(Employee__c devEmployee : empList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = 'a010w000005DOyQAAW' ,Employee_Name__c = devEmployee.Id , Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
        
         ac.assignEmployeesWithRelevantSkills( reqSkills ,1 , 1 , 1 , 1 , 1 , 'a010w000005DOyQAAW');
    }
}