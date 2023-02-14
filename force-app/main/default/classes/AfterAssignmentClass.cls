public class AfterAssignmentClass {
    public void afterAssignEmployeesWithRelevantSkills(String reqSkills, Integer Developers,Integer Testers, Integer Designers, Integer Architects, Integer Managers, Id projectId, List<Project_Assignment__c> OldAssignment,List<Project_Assignment__c> OldAssignmentDraft ){ //Integer Designers , Integer Testers , Integer Architects , Integer Managers,
        
        
        List<String> alreadyAssignedEmployees = new List<String>();
        List<String> alreadyAssignedEmployees1 = new List<String>();
        
        // Split the Required Skills
        List<String> res = reqSkills.split(';');
        System.Debug(res);
        
        List<String> Roles = new List<String>{'Developer','Tester','Designer','Architect','Manager'};
        
        for(Project_Assignment__c pa : OldAssignment){
            alreadyAssignedEmployees.add(pa.Employee_Name__r.Employee_Name__c);
        }
        for(Project_Assignment__c pa : OldAssignmentDraft){
            alreadyAssignedEmployees1.add(pa.Employee_Name__r.Employee_Name__c);
        }
        
        
        // List containers for storing employees on role basis         
        List<Employee__c> empDevList = [SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c IN :res AND Role__c='Developer' AND Employee_Name__c NOT IN :alreadyAssignedEmployees1];
        List<Employee__c> empDesList = [SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c IN :res AND Role__c='Designer' AND Employee_Name__c NOT IN :alreadyAssignedEmployees1];
        List<Employee__c> empTestersList = [SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c IN :res AND Role__c='Tester' AND Employee_Name__c NOT IN :alreadyAssignedEmployees1];
        List<Employee__c> empManagersList = [SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c IN :res AND Role__c='Manager' AND Employee_Name__c NOT IN :alreadyAssignedEmployees1];
        List<Employee__c> empArchitectsList = [SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c IN :res AND Role__c='Architect' AND Employee_Name__c NOT IN :alreadyAssignedEmployees1];
        
       
        
        // List container 
        List<Employee__c> assignedEmpDevList = new List<Employee__c>();
        List<Employee__c> assignedEmpDesList = new List<Employee__c>();
        List<Employee__c> assignedEmpTestersList= new List<Employee__c>();
        List<Employee__c> assignedEmpArchitectsList= new List<Employee__c>();
        List<Employee__c> assignedEmpManagersList= new List<Employee__c>();
        
        Integer i = 0, j = 0 , k = 0 , l = 0 , m = 0;
        
        // Developers
        for(Employee__c devEmp : empDevList)
        {
            if(i == Developers)
            {
                break;
            }
            //devEmp.Project_Name__c = projectId ;
            assignedEmpDevList.add(devEmp);
            i++;
            
        }
        
        //Designers
        for(Employee__c desEmp : empDesList)
        {
            if(j == Designers)
            {
                break;
            }
            assignedEmpDesList.add(desEmp);
            j++;
            
        }
        
        //Testers
        for(Employee__c testersEmp : empTestersList)
        {
            if(k == Testers)
            {
                break;
            }
            assignedEmpTestersList.add(testersEmp);
            k++;
            
        }
        
        //Architects
        for(Employee__c architectsEmp : empArchitectsList)
        {
            if(l == Architects)
            {
                break;
            }
            assignedEmpArchitectsList.add(architectsEmp);
            l++;
            
        }
        
        // Managers
        for(Employee__c managerEmp : empManagersList)
        {
            if(m == Managers)
            {
                break;
            }
            assignedEmpManagersList.add(managerEmp);
            m++;
            
        } 
        
        
        List<Project_Assignment__c> projectAssignmentList = new List<Project_Assignment__c>();
        
        for(Employee__c devEmployee : assignedEmpDevList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id, Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
        
        for(Employee__c devEmployee : assignedEmpDesList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id, Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
        
        for(Employee__c devEmployee : assignedEmpTestersList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id, Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
        
        for(Employee__c devEmployee : assignedEmpArchitectsList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id, Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }
        
        for(Employee__c devEmployee : assignedEmpManagersList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id, Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }

        System.debug(empDevList);
       
    }
}