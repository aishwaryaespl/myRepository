@isTest
private class DealRoleTest {

    static testMethod void myUnitTestPrimary() {
        //call Util class's method  
        Opportunity opp =  DealUtilClass.CreateOpportunityData();
        
        //set the testing environment 
        system.test.startTest();
        system.Test.setCurrentPage(Page.PrimaryDealInlinePage);
        ApexPages.StandardController stdController=new ApexPages.StandardController(opp); 
        PrimaryInfluencerForDeal opportunity= new PrimaryInfluencerForDeal(stdController);
        system.debug('Test opp---->'+opportunity.opp);
        opportunity.rollupOppContacts();
        Opportunity TestOpp = [select PrimaryInfluencer__c, PrimaryInfluencerContact__c from opportunity where name='TestOpp'];
        system.debug('Test TestOpp ---->'+TestOpp);
        system.test.stopTest();
        
        //check for the primary contact's name and email having role as influencer 
        system.assertEquals('TestPrimaryName Test Last', TestOpp.PrimaryInfluencer__c);
        system.assertEquals('test@gmail.com', TestOpp.PrimaryInfluencerContact__c );
        system.debug('----**End of testing primary contact method**----');
     
    }
    static testMethod void myUnitTestNonPrimaryData() {
        //Call util class's method to create records 
        Opportunity opp = DealUtilClass.CreateOpportunityNonPrimaryData();
        
        //set the testing environment
        system.test.startTest();
        system.Test.setCurrentPage(Page.PrimaryDealInlinePage);
        ApexPages.StandardController stdController=new ApexPages.StandardController(opp); 
        PrimaryInfluencerForDeal  opportunity= new PrimaryInfluencerForDeal (stdController);
        //system.debug('Test opp---->'+opportunity.opp);
        opportunity.rollupOppContacts();
        Opportunity TestOpp = [select PrimaryInfluencer__c, PrimaryInfluencerContact__c from opportunity where name='TestOpp'];
        system.debug('Test TestOpp ---->'+TestOpp);
        system.test.stopTest();
        
        //check for the non primary contact's name and email address playing role of influencer or decision maker 
        system.assertEquals('TestNonPrimaryName Test Last', TestOpp.PrimaryInfluencer__c);
        system.assertEquals('test1@gmail.com', TestOpp.PrimaryInfluencerContact__c );
        system.debug('----**End of testing non primary contact method**----');
    }    
     /*static testMethod void myUnitTestException() {
        //Call util class's method to create records 
        Opportunity opp =  UtilClass.CreateOpportunityNonPrimaryDataE();
        
        //set the testing environment
        system.test.startTest();
        system.Test.setCurrentPage(Page.RolePage);
        ApexPages.StandardController stdController=new ApexPages.StandardController(opp); 
        PrimaryDealPageHandler opportunity= new PrimaryDealPageHandler(stdController);
        //system.debug('Test opp---->'+opportunity.opp);
        opportunity.rollupOppContacts();
        Opportunity TestOpp = [select PrimaryInfluencer__c, PrimaryInfluencerContact__c from opportunity where name='TestOpp'];
        system.debug('Test TestOpp ---->'+TestOpp);
         try {
            update opp;
        } catch(DMLException e) {
            system.assertEquals(e.getMessage(), e.getMessage());
        }
        system.test.stopTest();
       
        //check for the non primary contact's name and email address playing role of influencer or decision maker 
        //system.assertEquals(e.getMessage(), e.getMessage());
        system.assertNotEquals('TestNonPrimaryName Test Last', TestOpp.PrimaryInfluencer__c);
        system.assertEquals('test@gmail.com', TestOpp.PrimaryInfluencerContact__c );
        system.debug('----**End of testing non primary contact method**----');
    }   */
}