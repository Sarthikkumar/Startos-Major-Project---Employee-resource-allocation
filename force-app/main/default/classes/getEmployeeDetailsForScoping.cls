public with sharing class getEmployeeDetailsForScoping {
    @AuraEnabled(cacheable=true)
    public static Map<String,Integer> getDetails(String Skill){

        List<String> res = Skill.split(';');
        System.Debug(res);

        List<aggregateresult> agr = [select count(ID), Role__c  from Employee__c where IsAllocated__c = False AND Skills__c IN :res group by Role__c];

         //List<aggregateresult> agr = [select count(ID), Role__c  from Employee__c where IsAllocated__c = False AND Skills__c= :Skill group by Role__c];
         system.debug(agr);

        Map<String,Integer> emplist = new Map<String,Integer>();

        integer Developer=0,Tester=0,Manager=0,Architect=0,Designer=0;

        for(aggregateresult aggr : agr)
        {
            if(aggr.get('Role__c') == 'Developer')
            {
                Developer = (integer)(aggr.get('expr0'));
            }

           else if(aggr.get('Role__c') == 'Tester')
            {
                Tester = (integer)(aggr.get('expr0'));
            }

            else if(aggr.get('Role__c') == 'Manager')
            {
                Manager = (integer)(aggr.get('expr0'));
            }

            else if(aggr.get('Role__c') == 'Designer')
            {
                Designer = (integer)(aggr.get('expr0'));
            }

            else if(aggr.get('Role__c') == 'Architect')
            {
                Architect = (integer)(aggr.get('expr0'));
            }    
        }
        
        // integer Developer =  (integer)(agr[0].get('expr0'));
		// integer Tester = (integer)(agr[1].get('expr0'));
        // integer Designer = (integer)(agr[2].get('expr0'));

        emplist.put('Developer',Developer);
        emplist.put('Tester',Tester);
        emplist.put('Designer',Designer);
        emplist.put('Manager',Manager);
        emplist.put('Architect',Architect);
        
          
        system.debug('Developer '+Developer);
    	system.debug('Designer '+Designer);
        system.debug('Tester '+Tester);
        System.debug(emplist);
       
       return emplist;
    }
    
}