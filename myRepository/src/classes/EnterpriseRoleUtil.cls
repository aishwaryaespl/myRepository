public with sharing class EnterpriseRoleUtil {
    
    //create an enterprise record 

    public static Enterprise__c CreateEnterpriseData(){
        system.debug('In util class');
        Enterprise__c ent = new Enterprise__c();
        ent.Name='TestEnt';
      
        insert ent;
        return ent;
    }
    
     
 }