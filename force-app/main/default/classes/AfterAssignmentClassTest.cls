@isTest
public class AfterAssignmentClassTest {
    
    public static testMethod void afterAssignTestMethod(){
        
         String reqSkills ='Salesforce Developer;Salesforce Administrator;CPQ Developer;LWC Developer;Salesforce QA Tester;Solution Architect';
        
         List<Project_Assignment__c> oldpaList = new List<Project_Assignment__c>();
         List<Project_Assignment__c> oldDraftpaList = new List<Project_Assignment__c>();
        
         Project__c project = new Project__c(Project_Name__c= 'project 1', Account_Name__c = '0010w00000xZ1HKAA0', Project_Skills__c= reqSkills, No_of_Architects__c=1, No_of_Designers__c=1, No_of_Developers__c=1, No_of_Managers__c=1, No_of_Testers__c=1);
        
         insert project;
        
         List<Employee__c> empList = new List<Employee__c>();
        
         Employee__c e1 = new Employee__c( Employee_Name__c = 'emp 1', IsAllocated__c = false , Role__c = 'Architect', Skills__c = 'Solution Architect' );
         Employee__c e2 = new Employee__c( Employee_Name__c = 'emp 2', IsAllocated__c = false , Role__c = 'Manager', Skills__c = 'Salesforce Administrator' );
         Employee__c e3 = new Employee__c( Employee_Name__c = 'emp 3', IsAllocated__c = false , Role__c = 'Designer', Skills__c = 'LWC Developer' );
         Employee__c e4 = new Employee__c( Employee_Name__c = 'emp 4', IsAllocated__c = false , Role__c = 'Tester', Skills__c = 'Salesforce QA Tester' );
         Employee__c e5 = new Employee__c( Employee_Name__c = 'emp 5', IsAllocated__c = false , Role__c = 'Developer', Skills__c = 'Salesforce Developer' );
         
         Employee__c e6 = new Employee__c( Employee_Name__c = 'emp 6', IsAllocated__c = true , Role__c = 'Architect', Skills__c = 'Solution Architect' );
         Employee__c e7 = new Employee__c( Employee_Name__c = 'emp 7', IsAllocated__c = true , Role__c = 'Manager', Skills__c = 'Salesforce Administrator' );
         Employee__c e8 = new Employee__c( Employee_Name__c = 'emp 8', IsAllocated__c = true , Role__c = 'Designer', Skills__c = 'LWC Developer' );
         Employee__c e9 = new Employee__c( Employee_Name__c = 'emp 9', IsAllocated__c = true , Role__c = 'Tester', Skills__c = 'Salesforce QA Tester' );
         Employee__c e10 = new Employee__c( Employee_Name__c = 'emp 10', IsAllocated__c = true , Role__c = 'Developer', Skills__c = 'Salesforce Developer' );
         
        
         empList.add(e1);
         empList.add(e2);
         empList.add(e3);
         empList.add(e4);
         empList.add(e5);
        
         empList.add(e6);
         empList.add(e7);
         empList.add(e8);
         empList.add(e9);
         empList.add(e10);
        
         insert empList;
        
        Project_Assignment__c oneAssignment1 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e1.Id, Status__c = 'Draft' );
        Project_Assignment__c oneAssignment2 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e2.Id, Status__c = 'Draft' );
        Project_Assignment__c oneAssignment3 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e3.Id, Status__c = 'Draft' );
        Project_Assignment__c oneAssignment4 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e4.Id, Status__c = 'Draft' );
        Project_Assignment__c oneAssignment5 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e5.Id, Status__c = 'Draft' );
        
        oldDraftpaList.add(oneAssignment1);
        oldDraftpaList.add(oneAssignment2);
        oldDraftpaList.add(oneAssignment3);
        oldDraftpaList.add(oneAssignment4);
        oldDraftpaList.add(oneAssignment5);
        
        insert oldDraftpaList;
        
        Project_Assignment__c oneAssignment6 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e6.Id, Status__c = 'Cancelled' );
        Project_Assignment__c oneAssignment7 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e7.Id, Status__c = 'Cancelled' );
        Project_Assignment__c oneAssignment8 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e8.Id, Status__c = 'Cancelled' );
        Project_Assignment__c oneAssignment9 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e9.Id, Status__c = 'Cancelled' );
        Project_Assignment__c oneAssignment10 = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = e10.Id, Status__c = 'Cancelled' );
        
        oldpaList.add(oneAssignment6);
        oldpaList.add(oneAssignment7);
        oldpaList.add(oneAssignment8);
        oldpaList.add(oneAssignment9);
        oldpaList.add(oneAssignment10);
        
        insert oldpaList;
        
        AfterAssignmentClass aac = new AfterAssignmentClass();
        
        aac.afterAssignEmployeesWithRelevantSkills((string)project.Project_Skills__c, 1,1,1,1,1, project.Id, oldpaList , oldDraftpaList);
    }
}