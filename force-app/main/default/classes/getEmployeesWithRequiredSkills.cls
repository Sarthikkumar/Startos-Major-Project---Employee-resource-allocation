public with sharing class getEmployeesWithRequiredSkills {
    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getEmployees(String Skill){

        List<String> res = Skill.split(';');
        System.Debug(res);

        List<Employee__c> empList = [select Id, Employee_Name__c, Skills__c, Role__c, IsAllocated__c  from Employee__c where IsAllocated__c = False AND Skills__c IN :res];

       return emplist;
    }
}