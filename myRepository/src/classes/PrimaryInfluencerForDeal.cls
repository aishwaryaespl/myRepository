public with sharing class PrimaryInfluencerForDeal {
    
    public Opportunity opp;
    
    //fetch current opportunity record
    public PrimaryInfluencerForDeal( ApexPages.StandardController stdController ) {
        opp = (Opportunity)stdController.getRecord();       
    }
    
    public PrimaryInfluencerForDeal () { }
    
    public void rollupOppContacts() {
        PrimaryInfluencerForDeal  obj = new PrimaryInfluencerForDeal ();
        obj.PrimaryRoleHandler(opp.Id);  
    }
    
    public void PrimaryRoleHandler(ID OppID) {
        //fetche the primary contact roles having role as Influencer or decision maker
        list<OpportunityContactRole> ListOppConRole = [
                                        Select o.Role
                                             , o.OpportunityId
                                             , o.IsPrimary
                                             , o.ContactId
                                             , o.contact.name
                                             , o.contact.Email 
                                          From OpportunityContactRole o 
                                         where OpportunityId = : OppID 
                                           and (Role ='Influencer' or Role='Decision Maker') 
                                           and isPrimary = true
                                        ];                              
        Opportunity  opp;
        
        //assign the primary contact detail to opp fields
        for(OpportunityContactRole ocr : ListOppConRole ) {
            opp  = new Opportunity(Id = OppID, PrimaryInfluencer__c = ocr.contact.name, PrimaryInfluencerContact__c= ocr.Contact.Email);
        }
        if (!ListOppConRole.isEmpty()) {
            try {
                update opp;
            } catch(DMLException e) {
                system.debug(e);
            }
        }
        
        //fetches non primary contact roles having role as Influencer or decision maker
        else {
            list<OpportunityContactRole> NonPrimaryConRole = [
                                            Select o.Role
                                                 , o.OpportunityId
                                                 , o.IsPrimary
                                                 , o.ContactId
                                                 , o.contact.name
                                                 , o.contact.Email 
                                              From OpportunityContactRole o 
                                             where OpportunityId = : OppID 
                                               and (Role ='Influencer' or Role='Decision Maker') 
                                               and isPrimary = false 
                                          ORDER BY CreatedDate DESC LIMIT 1 
                                          ]; 
                                          
            for(OpportunityContactRole ocr : NonPrimaryConRole ) {
                opp  = new Opportunity(Id = OppID, PrimaryInfluencer__c = ocr.contact.name, PrimaryInfluencerContact__c= ocr.Contact.Email);
            }
            
            try {
                update opp;
            } catch(DMLException e){
                system.debug(e);
            }
        }   
   }
}  
   
   
   
   
   
   
   
   
   
   
   /*public static PageReference DetailPageHandler (ID OppID){
        system.debug('detail page'+OppID);
        PageReference nextPage = new PageReference('/' +OppID);
        
         
        
        return nextPage;
   }*/