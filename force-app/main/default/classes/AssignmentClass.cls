public class AssignmentClass {
    public void assignEmployeesWithRelevantSkills(String reqSkills, Integer Developers,Integer Testers, Integer Designers, Integer Architects, Integer Managers, Id projectId){ //Integer Designers , Integer Testers , Integer Architects , Integer Managers,
        
        
        List<String> res = reqSkills.split(';');
        System.Debug(res);
        
        List<Employee__c> empList2 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Developer' AND IsAllocated__c = false AND Skills__c IN :res];
        List<Employee__c> empList3 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Designer' AND IsAllocated__c = false AND Skills__c IN :res];
        List<Employee__c> empList4 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Tester' AND IsAllocated__c = false AND Skills__c IN :res];
        List<Employee__c> empList5 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Architect' AND IsAllocated__c = false AND Skills__c IN :res];
        List<Employee__c> empList6 = [Select Employee_Name__c, Skills__c, Role__c from Employee__c where Role__c= 'Manager' AND IsAllocated__c = false AND Skills__c IN :res];
        
        
        System.debug(empList2);
        
        List<Employee__c> FinalEmpList = new List<Employee__c>();
        
        /* Integer cDev=0,JavaDev=0,PythonDev=0,SalesForceDev=0;
        Integer cDes=0,JavaDes=0,PythonDes=0,SalesForceDes=0;
        Integer cTester=0,JavaTester=0,PythonTester=0,SalesForceTester=0;
        Integer cManager=0,JavaManager=0,PythonManager=0,SalesForceManager=0;
        Integer cArchitect=0,JavaArchitect=0,PythonArchitect=0,SalesForceArchitect=0;

        // For Developers
       for(integer m=0; m< Developers ; m++){
          Double randomNumber = Math.random(); 
          Integer arrayLength = res.size(); 
          System.Debug('arrayLength ' + arrayLength);
          Integer randomIndex = (randomNumber *(arrayLength)).intValue(); 
          System.Debug('randomIndex ' + randomIndex);
           
          if(res[randomIndex] == 'C#')
           {
              cDev++;
            }
          if(res[randomIndex] == 'Java')
           {
              JavaDev++;
           }
          if(res[randomIndex] == 'Python')
           {
              PythonDev++;
           }
           if(res[randomIndex] == 'Salesforce')
           {
              SalesForceDev++;
           }
         //Output the element at the list index generated above
    
           System.debug('Random element: '+ res[randomIndex]);
           }
        
        integer i1=0,j1=0,k1=0,l1=0;
        for(Employee__c emp : empList2)
        {
            if(emp.Skills__c == 'C#' && i1< cDev)
           {
               FinalEmpList.add(emp);
              i1++;
            }
          if(emp.Skills__c == 'Java' && j1< JavaDev)
           {
              FinalEmpList.add(emp);
              j1++;
           }
          if(emp.Skills__c == 'Python' && k1< PythonDev)
           {
              FinalEmpList.add(emp);
              k1++;
           }
           if(emp.Skills__c == 'Salesforce' && l1< SalesForceDev)
           {
              FinalEmpList.add(emp);
              l1++;
           }
        }
        
        
        
        System.debug(FinalEmpList);
        
        // For Designers
        
        for(integer m=0; m< Designers ; m++){
          Double randomNumber = Math.random(); 
          Integer arrayLength = res.size(); 
          System.Debug('arrayLength ' + arrayLength);
          Integer randomIndex = (randomNumber *(arrayLength)).intValue(); 
          System.Debug('randomIndex ' + randomIndex);
           
          if(res[randomIndex] == 'C#')
           {
              cDes++;
            }
          if(res[randomIndex] == 'Java')
           {
              JavaDes++;
           }
          if(res[randomIndex] == 'Python')
           {
              PythonDes++;
           }
           if(res[randomIndex] == 'Salesforce')
           {
              SalesForceDes++;
           }
         //Output the element at the list index generated above
    
           System.debug('Random element: '+ res[randomIndex]);
           }
        
        integer i2=0,j2=0,k2=0,l2=0;
        for(Employee__c emp : empList3)
        {
            if(emp.Skills__c == 'C#' && i2< cDes)
           {
               FinalEmpList.add(emp);
              i2++;
            }
          if(emp.Skills__c == 'Java' && j2< JavaDes)
           {
              FinalEmpList.add(emp);
              j2++;
           }
          if(emp.Skills__c == 'Python' && k2< PythonDes)
           {
              FinalEmpList.add(emp);
              k2++;
           }
           if(emp.Skills__c == 'Salesforce' && l2< SalesForceDes)
           {
              FinalEmpList.add(emp);
              l2++;
           }
        }
        
        
        // Testers
        
        
        for(integer m=0; m< Testers ; m++){
          Double randomNumber = Math.random(); 
          Integer arrayLength = res.size(); 
          System.Debug('arrayLength ' + arrayLength);
          Integer randomIndex = (randomNumber *(arrayLength)).intValue(); 
          System.Debug('randomIndex ' + randomIndex);
           
          if(res[randomIndex] == 'C#')
           {
              cTester++;
            }
          if(res[randomIndex] == 'Java')
           {
              JavaTester++;
           }
          if(res[randomIndex] == 'Python')
           {
              PythonTester++;
           }
           if(res[randomIndex] == 'Salesforce')
           {
              SalesForceTester++;
           }
         //Output the element at the list index generated above
    
           System.debug('Random element: '+ res[randomIndex]);
           }
        
        integer i3=0,j3=0,k3=0,l3=0;
        for(Employee__c emp : empList4)
        {
            if(emp.Skills__c == 'C#' && i3< cTester)
           {
               FinalEmpList.add(emp);
              i3++;
            }
          if(emp.Skills__c == 'Java' && j3< JavaTester)
           {
              FinalEmpList.add(emp);
              j3++;
           }
          if(emp.Skills__c == 'Python' && k3< PythonTester)
           {
              FinalEmpList.add(emp);
              k3++;
           }
           if(emp.Skills__c == 'Salesforce' && l3< SalesForceTester)
           {
              FinalEmpList.add(emp);
              l3++;
           }
        }
        
        // For Architects
        
        for(integer m=0; m< Architects ; m++){
          Double randomNumber = Math.random(); 
          Integer arrayLength = res.size(); 
          System.Debug('arrayLength ' + arrayLength);
          Integer randomIndex = (randomNumber *(arrayLength)).intValue(); 
          System.Debug('randomIndex ' + randomIndex);
           
          if(res[randomIndex] == 'C#')
           {
              cArchitect++;
            }
          if(res[randomIndex] == 'Java')
           {
              JavaArchitect++;
           }
          if(res[randomIndex] == 'Python')
           {
              PythonArchitect++;
           }
           if(res[randomIndex] == 'Salesforce')
           {
              SalesForceArchitect++;
           }
         //Output the element at the list index generated above
    
           System.debug('Random element: '+ res[randomIndex]);
           }
        
        integer i4=0,j4=0,k4=0,l4=0;
        for(Employee__c emp : empList5)
        {
            if(emp.Skills__c == 'C#' && i4< cArchitect)
           {
               FinalEmpList.add(emp);
              i4++;
            }
          if(emp.Skills__c == 'Java' && j4< JavaArchitect)
           {
              FinalEmpList.add(emp);
              j4++;
           }
          if(emp.Skills__c == 'Python' && k4< PythonArchitect)
           {
              FinalEmpList.add(emp);
              k4++;
           }
           if(emp.Skills__c == 'Salesforce' && l4< SalesForceArchitect)
           {
              FinalEmpList.add(emp);
              l4++;
           }
        }
        
        // For Managers
        
        for(integer m=0; m< Managers ; m++){
          Double randomNumber = Math.random(); 
          Integer arrayLength = res.size(); 
          System.Debug('arrayLength ' + arrayLength);
          Integer randomIndex = (randomNumber *(arrayLength)).intValue(); 
          System.Debug('randomIndex ' + randomIndex);
           
          if(res[randomIndex] == 'C#')
           {
              cManager++;
            }
          if(res[randomIndex] == 'Java')
           {
              JavaManager++;
           }
          if(res[randomIndex] == 'Python')
           {
              PythonManager++;
           }
           if(res[randomIndex] == 'Salesforce')
           {
              SalesForceManager++;
           }
         //Output the element at the list index generated above
    
           System.debug('Random element: '+ res[randomIndex]);
           }
        
        integer i5=0,j5=0,k5=0,l5=0;
        for(Employee__c emp : empList6)
        {
            if(emp.Skills__c == 'C#' && i5< cManager)
           {
               FinalEmpList.add(emp);
              i5++;
            }
          if(emp.Skills__c == 'Java' && j5< JavaManager)
           {
              FinalEmpList.add(emp);
              j5++;
           }
          if(emp.Skills__c == 'Python' && k5< PythonManager)
           {
              FinalEmpList.add(emp);
              k5++;
           }
           if(emp.Skills__c == 'Salesforce' && l5< SalesForceManager)
           {
              FinalEmpList.add(emp);
              l5++;
           }
        }
        
        System.debug(FinalEmpList);
        System.Debug(FinalEmpList.size()); */
        
        
        // Query for employees with different roles and with relevant project skills
        // 
       // String QueryforDev = 'SELECT Role__c,Id, Employee_Name__c from Employee__c  where IsAllocated__c = false And Skills__c=' + '\'' + reqSkills + '\'' + ' AND Role__c=' + '\'' + 'Developer' + '\'';
        
        
        //String QueryforDes = 'SELECT Role__c,Id, Employee_Name__c from Employee__c where Skills__c=' +  '\'' + reqSkills + '\'' + ' AND Role__c=' + '\'' + 'Designer' + '\'';
        //String QueryforTesters = 'SELECT Role__c,Id, Employee_Name__c from Employee__c where Skills__c=' + '\'' + reqSkills + '\'' +  ' AND Role__c=' + '\'' + 'Tester' + '\'';
        //String QueryforArchitects = 'SELECT Role__c,Id, Employee_Name__c from Employee__c where Skills__c=' + '\'' + reqSkills + '\'' +  ' AND Role__c=' + '\'' + 'Architect' + '\'';
        //String QueryforManagers = 'SELECT Role__c,Id, Employee_Name__c from Employee__c where Skills__c=' + '\'' + reqSkills + '\'' +  ' AND Role__c=' + '\'' + 'Manager' + '\'';
        
        // List containers for storing employees on role basis 
        // 
        //List<Employee__c> empDevList = Database.query(QueryforDev);
        //
        //List<Employee__c> empDesList = Database.query(QueryforDes);
        //List<Employee__c> empTestersList = Database.query(QueryforTesters);
        //List<Employee__c> empArchitectsList = Database.query(QueryforArchitects);
        //List<Employee__c> empManagersList = Database.query(QueryforManagers);
        
      
        System.debug(empList2);
        
        // List container 
        List<Employee__c> assignedEmpDevList = new List<Employee__c>();
        //List<Employee__c> assignedEmpDesList;
        //List<Employee__c> assignedEmpTestersList;
        //List<Employee__c> assignedEmpArchitectsList;
        //List<Employee__c> assignedEmpManagersList;
        
        Integer i = 0, j = 0 , k = 0 , l = 0 , m = 0;
        
        // Developers
        for(Employee__c devEmp : empList2)
        {
            if(i == Developers)
            {
                break;
            }
            //devEmp.Project_Name__c = projectId ;
            FinalEmpList.add(devEmp);
            i++;
            
        }
        
        //Designers
       for(Employee__c desEmp : empList3)
        {
            if(j == Designers)
            {
                break;
            }
            FinalEmpList.add(desEmp);
            j++;
            
        }
        
        //Testers
        for(Employee__c testersEmp : empList4)
        {
            if(k == Testers)
            {
                break;
            }
            FinalEmpList.add(testersEmp);
            k++;
            
        }
        
        //Architects
        for(Employee__c architectsEmp : empList5)
        {
            if(l == Architects)
            {
                break;
            }
            FinalEmpList.add(architectsEmp);
            l++;
            
        }
        
        // Managers
        for(Employee__c managerEmp : empList6)
        {
            if(m == Managers)
            {
                break;
            }
            FinalEmpList.add(managerEmp);
            m++;
            
        } 
        
        System.debug(FinalEmpList.size());
        
        List<Project_Assignment__c> projectAssignmentList = new List<Project_Assignment__c>();
        
        for(Employee__c devEmployee : FinalEmpList){
          
            Project_Assignment__c oneAssignment = new Project_Assignment__c( Project_Name__c = projectId ,Employee_Name__c = devEmployee.Id , Status__c = 'Draft' );
            projectAssignmentList.add(oneAssignment);
        }

         Database.insert(projectAssignmentList, false); // ----- recent
        
        
        
        //Database.update(assignedEmpDevList,false);
        
       // System.debug(empDevList);
       
       // System.debug(empDesList);
       // System.debug(empTestersList);
    }
}


 /*Select Name, Project_Name__r.Project_Name__c, Employee_Name__r.Employee_Name__c, Employee_Name__r.IsAllocated__c From Project_Assignment__c Where Employee_Name__r.IsAllocated__c = false AND Employee_Name__r.Employee_Name__c = 'R.K. Jain' AND
Project_Name__c != 'a010w000005DN1KAAW'
 */