public with sharing class DealUtilClass {
    
    //create an opp record and return the same 

    public static Opportunity CreateOpportunityData(){
        system.debug('In util class');
        Opportunity opp = new Opportunity ();
        opp.Name='TestOpp';
        opp.StageName = 'Prospecting';
        opp.CloseDate =date.newinstance(2016,11,15);
        insert opp;
        system.debug('Opportunity Created');
        
        //create contact record 
        Contact con ;
        con = new contact(FirstName = 'TestPrimaryName',LastName='Test Last', Email='test@gmail.com');
        insert con;
        Contact con1;
        con1 = new contact(FirstName='TestNonPrimaryName',LastName='Test Last', Email='test1@gmail.com');
        insert con1;
        system.debug('contact created');
        
        Opportunity Oppo = [select id, name from Opportunity where Name='TestOpp'];
        
        //OCR record having role as decision maker and marked as primary 
        OpportunityContactRole OppConRoleObj = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con.id,
                                                                           Role = 'Decision Maker',
                                                                           isPrimary = True);
        insert OppConRoleObj;
        
        //OCR record having role as Influencer and marked as non primary 
        OpportunityContactRole OppConRoleObj1 = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con1.id,
                                                                           Role = 'Influencer',
                                                                           isPrimary = false);
        
        insert OppConRoleObj1;
        system.debug('Opportunity Contact Role Created');
        return opp;
    }
    public static Opportunity CreateOpportunityNonPrimaryData(){
        system.debug('In util class');
        Opportunity opp = new Opportunity ();
        opp.Name='TestOpp';
        opp.StageName = 'Prospecting';
        opp.CloseDate =date.newinstance(2016,11,15);
        insert opp;
        
        system.debug('Opprtunity Created');
        Contact con ;
        con = new contact(FirstName = 'TestNonPrimaryName',LastName='Test Last', Email='test1@gmail.com');
        insert con;
        Contact con1;
        con1 = new contact(FirstName='TestNonPrimaryName',LastName='Test Last', Email='test@gmail.com');
        insert con1;
        system.debug('contact created');
        
        Opportunity Oppo = [select id, name from Opportunity where Name='TestOpp'];
        
        OpportunityContactRole OppConRoleObj = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con.id,
                                                                           Role = 'Decision Maker',
                                                                           isPrimary = False);
        insert OppConRoleObj;
        
        OpportunityContactRole OppConRoleObj1 = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con1.id,
                                                                           Role = 'Influencer',
                                                                           isPrimary = false);
        insert OppConRoleObj1;
        system.debug('Opportunity Contact Role Created');
        return opp;
    }
     /* public static Opportunity CreateOpportunityNonPrimaryDataE(){
        system.debug('In util class');
        Opportunity opp = new Opportunity ();
        opp.Name='TestOpp';
        //opp.StageName = 'Prospecting';
        opp.CloseDate =date.newinstance(2016,11,15);
        insert opp;
        
        system.debug('Opprtunity Created');
        
        Contact con1;
        con1 = new contact(LastName='Test Last', Email='test@gmail.com');
        insert con1;
      
        
        Opportunity Oppo = [select id, name from Opportunity where Name='TestOpp'];
        
        OpportunityContactRole OppConRoleObj = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con1.id,
                                                                           Role = 'Decision Maker',
                                                                           isPrimary = False);
        insert OppConRoleObj;
        
        /*OpportunityContactRole OppConRoleObj1 = new OpportunityContactRole (opportunityid = Oppo.id,
                                                                           contactid = con1.id,
                                                                           Role = 'Influencer',
                                                                           isPrimary = false);
        insert OppConRoleObj1;
        
        system.debug('Opportunity Contact Role Created');
        return opp;
    }*/
 }