public class MyAccountExtenstion {

    public Decimal SelectedDaysCount {get;set;}
      list<Account> Accounts = new list<Account>();
    
    public MyAccountExtenstion(ApexPages.StandardSetController controller) {

    }
  
    
    public list<Account> getAccounts(){
        system.debug('selected days :'+SelectedDaysCount );
        date SampleDate;
        if (SelectedDaysCount != null){
            SampleDate = system.today() + integer.valueof(SelectedDaysCount) ;
            system.debug(SampleDate);            
        
        Accounts =[Select id
                       , a.Name
                       , Owner.name
                       , CountofE__c
                       , Earliestdate__c
                       , LatestDate__c 
                       
                       , (
                         Select Name
                              , EndDate
                           From Entitlements 
                          where EndDate <=: SampleDate
                         ) 
                     From Account a 
                    limit 100 ];
        } 
        return Accounts ;
    }
       
    public PageReference PerformFilterAction(){
    
        return null;
    }
    
    

}