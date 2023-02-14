@isTest
public class ApexTestClass {
       
      public static testMethod void validateAssignmentClass() {
          
          String reqSkills ='Salesforce Developer;Salesforce Administrator;CPQ Developer;LWC Developer;Salesforce QA Tester;Solution Architect';
          
          Project__c project = new Project__c(Project_Name__c = 'project1' ,Project_Skills__c = reqSkills, No_of_Developers__c = 1,No_of_Designers__c=1, No_of_Testers__c=1, No_of_Architects__c=1, No_of_Managers__c=1,Stage__c = 'Draft', Account_Name__c = '0010w00000xZ1HKAA0');
          insert project;
          
          Project__c project1 = new Project__c(Project_Name__c = 'project2' ,Project_Skills__c = reqSkills, No_of_Developers__c = 1,No_of_Designers__c=1, No_of_Testers__c=1, No_of_Architects__c=1, No_of_Managers__c=1,Stage__c = 'Draft', Account_Name__c = '0010w00000xZ1HKAA0');
          insert project1;
          
          List<Employee__c> empList = new List<Employee__c>();
          Employee__c emp1 = new Employee__c(Employee_Name__c='emp 1', Skills__c ='Salesforce Developer', Role__c='Developer', IsAllocated__c=false);
          empList.add(emp1);
           Employee__c emp2 = new Employee__c(Employee_Name__c='emp 2', Skills__c ='LWC Developer', Role__c='Designer', IsAllocated__c=false);
          empList.add(emp2);
           Employee__c emp3 = new Employee__c(Employee_Name__c='emp 3', Skills__c ='Salesforce QA Tester', Role__c='Tester', IsAllocated__c=false);
          empList.add(emp3);
           Employee__c emp4 = new Employee__c(Employee_Name__c='emp 4', Skills__c ='Salesforce Administrator', Role__c='Manager', IsAllocated__c=false);
          empList.add(emp4);
           Employee__c emp5 = new Employee__c(Employee_Name__c='emp 5', Skills__c ='Solution Architect', Role__c='Architect', IsAllocated__c=false);
          empList.add(emp5);
          Employee__c emp6 = new Employee__c(Employee_Name__c='emp 6', Skills__c ='Salesforce Developer', Role__c='Developer', IsAllocated__c=false);
          empList.add(emp6);
           Employee__c emp7 = new Employee__c(Employee_Name__c='emp 7', Skills__c ='LWC Developer', Role__c='Designer', IsAllocated__c=false);
          empList.add(emp7);
           Employee__c emp8 = new Employee__c(Employee_Name__c='emp 8', Skills__c ='Salesforce QA Tester', Role__c='Tester', IsAllocated__c=false);
          empList.add(emp8);
           Employee__c emp9 = new Employee__c(Employee_Name__c='emp 9', Skills__c ='Salesforce Administrator', Role__c='Manager', IsAllocated__c=false);
          empList.add(emp9);
           Employee__c emp10 = new Employee__c(Employee_Name__c='emp 10', Skills__c ='Solution Architect', Role__c='Architect', IsAllocated__c=false);
          empList.add(emp10);
          
          insert empList;
          
          
        
           AssignmentClass ac = new AssignmentClass();
           
           
           ac.assignEmployeesWithRelevantSkills( reqSkills ,1 , 1 , 1 , 1 , 1 , project.Id);
           
        List<String> res = reqSkills.split(';');
        System.assertEquals(6, res.size());
          
       // System.Debug(res);
        
       // List<Employee__c> empList2 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Developer' AND IsAllocated__c = false AND Skills__c IN :res];
        //List<Employee__c> empList3 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Designer' AND IsAllocated__c = false AND Skills__c IN :res];
        //List<Employee__c> empList4 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Tester' AND IsAllocated__c = false AND Skills__c IN :res];
        //List<Employee__c> empList5 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Architect' AND IsAllocated__c = false AND Skills__c IN :res];
       // List<Employee__c> empList6 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Manager' AND IsAllocated__c = false AND Skills__c IN :res];
      
          
           //System.assertEquals(0, empList2.size());
           //System.assertEquals(1, empList3.size());
          
          
          List<Employee__c> FinalEmpList = new List<Employee__c>();
          
          Integer i = 0, j = 0 , k = 0 , l = 0 , m = 0;
        
        // Developers
        for(Employee__c devEmp : empList)
        {
            if(i == 1)
            {
                break;
            }
            //devEmp.Project_Name__c = projectId ;
            FinalEmpList.add(devEmp);
            i++;
            
        }
          
          System.assertEquals(1, FinalEmpList.size());
          System.assertEquals(1, i);
          
          //System.assertEquals(1, empList.size());
          
          List<Project_Assignment__c> projectAssignmentList = new List<Project_Assignment__c>();
          
          for(Employee__c devEmployee : empList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = project.Id ,Employee_Name__c = devEmployee.Id , Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
          
          insert projectAssignmentList;
          
          List<Project_Assignment__c> projectAssignmentList1 = new List<Project_Assignment__c>();
          for(Employee__c devEmployee1 : empList){
          
            Project_Assignment__c oneAssignment1 = new Project_Assignment__c( Project_Name__c = project1.Id ,Employee_Name__c = devEmployee1.Id , Status__c = 'Draft' );
            projectAssignmentList1.add(oneAssignment1);
        }
          
          insert projectAssignmentList1;
          
          String reqSkills1 ='Salesforce Developer;Salesforce Administrator;CPQ Developer;LWC Developer;Salesforce QA Tester;Solution Architect';
          
         // AfterAssignmentClass aac = new AfterAssignmentClass();
          
         // aac.afterAssignEmployeesWithRelevantSkills((string)reqSkills1, (Integer)1 ,(Integer)1 ,(Integer)1 ,(Integer)1 ,(Integer)1 , projectAssignmentList1 , projectAssignmentList);
          
          project.Stage__c='Initiated';
          update project;
          
          project.Stage__c='Delivered';
          update project;
          
          opportunityEstimationClass oc = new opportunityEstimationClass();
          oc.EstimationStageMethod();
          
          
          Map<String,Integer> emp = getEmployeeDetailsForScoping.getDetails(reqSkills);
          System.assertEquals(1, emp.get('Developer'));
    
          EmployeeQuery eq = new EmployeeQuery('Salesforce Developer', 1 , 'Developer');
          
          
          
          
         // aac.afterAssignEmployeesWithRelevantSkills(reqSkills , 1,1,1,1,1, );
          
         /* project1.Stage__c = 'Draft';
          List<Employee__c> empList1 = new List<Employee__c>();
          
          Employee__c emp11 = new Employee__c(Employee_Name__c='emp 11', Skills__c ='Solution Architect', Role__c='Architect', IsAllocated__c=false);
          empList1.add(emp11);
          Employee__c emp12 = new Employee__c(Employee_Name__c='emp 12', Skills__c ='Salesforce Developer', Role__c='Developer', IsAllocated__c=false);
          empList1.add(emp12);
           Employee__c emp13 = new Employee__c(Employee_Name__c='emp 13', Skills__c ='LWC Developer', Role__c='Designer', IsAllocated__c=false);
          empList1.add(emp13);
           Employee__c emp14 = new Employee__c(Employee_Name__c='emp 14', Skills__c ='Salesforce QA Tester', Role__c='Tester', IsAllocated__c=false);
          empList1.add(emp14);
           Employee__c emp15 = new Employee__c(Employee_Name__c='emp 15', Skills__c ='Salesforce Administrator', Role__c='Manager', IsAllocated__c=true);
          empList1.add(emp15);
           Employee__c emp16 = new Employee__c(Employee_Name__c='emp 16', Skills__c ='Solution Architect', Role__c='Architect', IsAllocated__c=true);
          empList1.add(emp16);
          
          insert empList1;
          
          update project1; */

       }
           
}