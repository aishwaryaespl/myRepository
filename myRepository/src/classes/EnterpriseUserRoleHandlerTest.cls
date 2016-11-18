@isTest
private class EnterpriseUserRoleHandlerTest  {

    static testMethod void myUnitTestRole() {
        //call Util class's method  
        Enterprise__c entp =  EnterpriseRoleUtil.CreateEnterpriseData();
        
        //set the testing environment 
        system.test.startTest();
       
      
        Enterprise__c TestEnt = [select name from Enterprise__c where name='TestEnt'];
        system.debug('Test TestEnterprise ---->'+TestEnt);
        //
        //UserRole usr = new UserRole();
        //(name = 'CustomerPortal', PortalAccountId = UR.Id);
        
        system.test.stopTest();
        UserRole usr = [select Id,name from UserRole where name='TestEntManager'];
        //UserRole UR = [Select u.Id,u.name From UserRole u where u.name =: TestEnt.name];
        //User usr = new User();
        //system.assertEquals('TestEnt Manager', TestEnt.name+' Manager');
        system.assertEquals('TestEntManager',usr.name);
        
     
    }
}