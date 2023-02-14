trigger EmpAssignmentTrigger on Project__c (after insert , after update) {
   
   if(trigger.isAfter)
   {
       
       if(trigger.isInsert)
       {
           // Assign available employees with matching skills to the project
           System.Debug('In Insert Operation');
           AssignmentClass ac = new AssignmentClass();
           Project__c currentProject = Trigger.New[0];
           ac.assignEmployeesWithRelevantSkills( (string)currentProject.Project_Skills__c, (Integer)currentProject.No_of_Developers__c,  (Integer)currentProject.No_of_Testers__c ,(Integer)currentProject.No_of_Designers__c,(Integer)currentProject.No_of_Architects__c, (Integer)currentProject.No_of_Managers__c,  currentProject.Id );
           
           // Split Required Skills
           List<Skills__c> skillList = [Select Skill__c,Id from Skills__c] ;
           
           String reqSkills = (string)currentProject.Project_Skills__c ;
           List<String> res = reqSkills.split(';');
          
           Integer i=0;
           
           List<Project_Skills__c> pskillList = new List<Project_Skills__c>();
           
           if(res.size()>0)
           {
                
               for(String c : res){
                   for(Skills__c Skill : skillList){
                       if(c == Skill.Skill__c)
                       {
                           Project_Skills__c pskill = new Project_Skills__c(Project_Name__c = currentProject.Id, Skills__c = skill.Id);
                           pskillList.add(pskill);
                           break;
                       }
                   }
                   
               }
               
               // Insert Project Skills
               Database.Insert(pskillList);
           }

             
       }
       
       // Whenever project record is updated execute this.
       if(trigger.isUpdate)
       {
            System.Debug('In Update Operation');
            Project__c currentProject = Trigger.New[0];
           
           // Project in Draft and no of assignments < required resources count, Go for re assignment
                     
           if(currentProject.Stage__c == 'Draft' && currentProject.No_of_Assigned_Employees_count__c < currentProject.No_of_Architects__c + currentProject.No_of_Designers__c + currentProject.No_of_Developers__c + currentProject.No_of_Managers__c + currentProject.No_of_Testers__c){
               
               AfterAssignmentClass ac = new AfterAssignmentClass();
               
               String Query = 'Select Id, Employee_Name__r.Employee_Name__c from Project_Assignment__c where Project_Name__c = ' + '\'' + currentProject.Id + '\'' + ' AND Status__c=\'Draft\'  AND Employee_Name__r.Role__c = \'Developer\' AND Employee_Name__r.IsAllocated__c = false';
               
               List<String> resources = new List<String>{'Developer','Designer','Tester','Architect','Manager'};
                   
                // Get list of all assignments currently in project which are in draft
                List<Project_Assignment__c> QueryResult1 = [Select Id, Employee_Name__r.Employee_Name__c,Employee_Name__r.Skills__c, Employee_Name__r.Role__c from Project_Assignment__c where Project_Name__c = :currentProject.Id AND Status__c='Draft' AND Employee_Name__r.IsAllocated__c = false AND Employee_Name__r.Role__c IN :resources];
               
               
                // Get list of all assignments currently in project which are Cancelled / employees are allocated to another project
                List<Project_Assignment__c> QueryResult = [Select Id, Employee_Name__r.Employee_Name__c,Employee_Name__r.Skills__c, Employee_Name__r.Role__c from Project_Assignment__c where Project_Name__c = :currentProject.Id AND Status__c='Cancelled' AND Employee_Name__r.IsAllocated__c = true AND Employee_Name__r.Role__c IN :resources];
               
               Integer NoOfMissingDevelopers=0,NoOfMissingDesigners =0,NoOfMissingTesters =0, NoOfMissingArchitects =0,NoOfMissingManagers =0;
               Integer devs=0, des=0, man=0,arc=0,tes=0;
               
               // Calculating the count of available employees based on role
               for(Project_Assignment__c pa : QueryResult)
               {
                   if(pa.Employee_Name__r.Role__c == 'Developer'){
                       devs++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Designer'){
                       des++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Tester'){
                       tes++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Manager'){
                       man++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Architect'){
                       arc++;
                   }
               }
               
               Integer devs1=0, des1=0, man1=0,arc1=0,tes1=0;
               
               // Calculating the count of unavailable employees based on role
               
               for(Project_Assignment__c pa : QueryResult1)
               {
                   if(pa.Employee_Name__r.Role__c == 'Developer'){
                       devs1++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Designer'){
                       des1++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Tester'){
                       tes1++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Manager'){
                       man1++;
                   }
                   if(pa.Employee_Name__r.Role__c == 'Architect'){
                       arc1++;
                   }
               }
               
               // Calculating no of missing resources so that we can make re-assignments
               if(devs > 0 ){
                  NoOfMissingDevelopers = (Integer)currentProject.No_of_Developers__c - devs;
               }
               if(devs == 0){
                  NoOfMissingDevelopers = (Integer)currentProject.No_of_Developers__c - devs1;
               }
               
               
               if(des > 0 ){
                  NoOfMissingDesigners = (Integer)currentProject.No_of_Designers__c - des;
               }
               if(des == 0){
                  NoOfMissingDesigners = (Integer)currentProject.No_of_Developers__c - des1;
               }
               
               if(tes > 0 ){
                  NoOfMissingTesters = (Integer)currentProject.No_of_Testers__c - tes;
               }
               if(tes == 0){
                  NoOfMissingTesters = (Integer)currentProject.No_of_Testers__c - tes1;
               }
               
               if(arc > 0 ){
                  NoOfMissingArchitects = (Integer)currentProject.No_of_Architects__c - arc;
               }
               if(arc == 0){
                  NoOfMissingArchitects = (Integer)currentProject.No_of_Architects__c - arc1;
               }
               
               if(man > 0 ){
                  NoOfMissingManagers = (Integer)currentProject.No_of_Managers__c - man;
               }
               if(man == 0){
                  NoOfMissingManagers = (Integer)currentProject.No_of_Managers__c - man1;
               }
               
               //System.debug(NoOfMissingDevelopers);
               ac.afterAssignEmployeesWithRelevantSkills( (string)currentProject.Project_Skills__c, NoOfMissingDevelopers , NoOfMissingTesters, NoOfMissingDesigners,NoOfMissingArchitects,NoOfMissingManagers, currentProject.Id , QueryResult, QueryResult1 );
           } 
           
           
           // When project is Initiated execute this program
           if(currentProject.Stage__c == 'Initiated')
           {
              
               
               List<Project_Assignment__c> EmployeeList = new List<Project_Assignment__c>();
               List<Project_Assignment__c> EmployeeList1 = new List<Project_Assignment__c>();
               
                List<Employee__c> empAllocListFinal = new List<Employee__c>();
               
                String Query = 'Select Employee_Name__r.Id, Employee_Name__r.Employee_Name__c, Employee_Name__r.IsAllocated__c From Project_Assignment__c where Status__c = \'Draft\' AND Project_Name__c =' + '\'' + currentProject.Id + '\'';
               
                // Get list of project assignments in Draft.
                EmployeeList = Database.query(Query);
               
               
               // Mark the Draft assignments as active and allocate the employees to this project
               for(Project_Assignment__c pa : EmployeeList)
               {
                   Id empId = pa.Employee_Name__r.Id;
                   String empName = pa.Employee_Name__r.Employee_Name__c;
                   Boolean empIsAllocated = pa.Employee_Name__r.IsAllocated__c;
                   pa.Status__c = 'Active';
                   
                   Employee__c currentEmployee = new Employee__c(Id = empId , Employee_Name__c = empName , IsAllocated__c = true , Project_Name__c = currentProject.Id, Allocation_Start_Date__c =currentProject.Start_Date__c, Allocation_End_Date__c=currentProject.End_Date__c);
                   empAllocListFinal.add(currentEmployee);
                   EmployeeList1.add(pa);
                   
               }
               
               Database.update(EmployeeList1,false);
               Database.update(empAllocListFinal,false);
               
               
               List<String> empNameList = new List<String>();
               
               for(Employee__c emp : empAllocListFinal)
               {
                   empNameList.add(emp.Employee_Name__c);
               }
               
             
                // Make all the other assignments as cancelled where the same employee is assigned.
                List<Project_Assignment__c> paDelete = [Select Name, Project_Name__r.Project_Name__c, Employee_Name__r.Employee_Name__c,Employee_Name__r.Role__c,Employee_Name__r.Skills__c, Employee_Name__r.IsAllocated__c From Project_Assignment__c where Project_Name__c != :currentProject.Id AND Employee_Name__r.Employee_Name__c IN :empNameList];
               
                List<Project_Assignment__c> paUpdateList = new List<Project_Assignment__c>();
               
               for(Project_Assignment__c paUpdate : paDelete)
               {
                   paUpdate.Status__c = 'Cancelled';
                   paUpdateList.add(paUpdate);
               }
               
               Database.update(paUpdateList, false);
               
           // Emp Reassignment Code , Logic is for each and every cancelled assignment we make a new assignment going for like to like replacement.
           List<String> roles = new List<String>{'Developer','Designer','Tester','Manager','Architect'};
                   
           
           List<Employee__c> AvailableEmployees = [Select Employee_Name__c, Id , Skills__c, Role__c, IsAllocated__c from Employee__c where IsAllocated__c = false AND Role__c IN :roles AND Employee_Name__c NOT IN :empNameList];
           
           List<Project_Assignment__c> paReAssign = new List<Project_Assignment__c>();
                   
           
           System.debug(AvailableEmployees);
               
           
               for(Project_Assignment__c paCan : paUpdateList)
           {
                   for(Employee__c emp : AvailableEmployees)
                   { 
                       if( emp.Role__c == paCan.Employee_Name__r.Role__c && emp.Skills__c ==  paCan.Employee_Name__r.Skills__c ) // && Duplicatecheck == 0
                       {
                           Project_Assignment__c paAssign = new Project_Assignment__c( Project_Name__c = paCan.Project_Name__c, Employee_Name__c = emp.Id, Status__c = 'Draft' );
                           paReAssign.add(paAssign);
                           AvailableEmployees.remove(AvailableEmployees.indexOf(emp));
                           break;
                       }
                   }
               
           }
               
                 Database.Insert(paReAssign, false);  
               
           }
           
           // When project is delivered , de allocate all the employees and mark assignments as rolled off.
           if(currentProject.Stage__c == 'Delivered')
           {
               List<Project_Assignment__c> EmployeeList = new List<Project_Assignment__c>();
               List<Project_Assignment__c> EmployeeList1 = new List<Project_Assignment__c>();
               
                List<Employee__c> empAllocListFinal = new List<Employee__c>();
               
                String Query = 'Select Employee_Name__r.Id, Employee_Name__r.Employee_Name__c, Employee_Name__r.IsAllocated__c From Project_Assignment__c where Status__c = \'Active\' AND Project_Name__c =' + '\'' + currentProject.Id + '\'';
               
                EmployeeList = Database.query(Query);
               
               for(Project_Assignment__c pa : EmployeeList)
               {
                   Id empId = pa.Employee_Name__r.Id;
                   String empName = pa.Employee_Name__r.Employee_Name__c;
                   Boolean empIsAllocated = pa.Employee_Name__r.IsAllocated__c;
                   pa.Status__c = 'Rolled Off';
                   
                   Employee__c currentEmployee = new Employee__c(Id = empId , Employee_Name__c = empName , IsAllocated__c = false , Project_Name__c = null);
                   empAllocListFinal.add(currentEmployee);
                   EmployeeList1.add(pa);
                   
               }
               
               Database.update(EmployeeList1,false);
               Database.update(empAllocListFinal,false);
           }
           
       }
   }
    
}