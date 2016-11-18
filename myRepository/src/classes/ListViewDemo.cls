public with sharing class ListViewDemo {

  private String baseQuery = 'Select id, Name,Owner.name,CountofE__c,Earliestdate__c,LatestDate__c From Account';
  private String query{get;set;} 
  public String AccFilterId {get; set;}
  private Integer pageSize = 10;

  public ListViewDemo(){}

  public ApexPages.StandardSetController AccSetController {
        get{
            if(AccSetController == null){
                AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery));
                AccSetController.setPageSize(pageSize);

                // We have to set FilterId after Pagesize, else it will not work
                if(AccFilterId != null)
                {
                  AccSetController.setFilterId(AccFilterId);
                }
            }
            return AccSetController;
        }set;
    }

  public ListViewDemo(ApexPages.StandardSetController c) {   }

    //Navigate to first Page
    public void firstPage()
    {
      AccSetController.first();
    }

    //Navigate to last Page
    public void lastPage()
    {
      AccSetController.last();
    }

    //Navigate to Next page
    public void next()
    {
      if(AccSetController.getHasNext())
      {
        AccSetController.next();
      }
    }

    //Navigate to Prev Page
    public void prev()
    {
      if(AccSetController.getHasPrevious())
      {
        AccSetController.previous();
      }
    }

    public List<Account> getAccounts()
    {
      return (List<Account>)AccSetController.getRecords();
    }

    //Get all available list view for Account
    public SelectOption[] getAccountExistingViews(){
        return AccSetController.getListViewOptions();
    }

    /**
    * Reset List View
    */
    public PageReference resetFilter()
    {
      AccSetController = null;
        AccSetController.setPageNumber(1);
        return null;
    }
public Decimal SelectedDaysCount {get;set;}
      list<Account> Accounts = new list<Account>();
    
  
  
   /* 
    public list<Account> getListAccounts(){
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
    }*/
    
   
    
  
  
    
    public list<Account> getAccountss(){
    
        system.debug('selected days :'+SelectedDaysCount );
        date SampleDate;
        if (SelectedDaysCount != null){
            SampleDate = system.today() + integer.valueof(SelectedDaysCount) ;
            system.debug(SampleDate);            
            if(SelectedDaysCount == 30){
                query = 'Select id, Name, Owner.name, CountofE__c, Earliestdate__c, LatestDate__c , ( Select Name, EndDate, Count(Id) From Entitlements where EndDate >=:'+ SampleDate+' And Expire_Count__c<=:'+ SelectedDaysCount +') From Account limit 100 ';
            }
            else if(SelectedDaysCount == 60) {
                query = 'Select id, Name, Owner.name, CountofE__c, Earliestdate__c, LatestDate__c , ( Select Name, EndDate, Count(Id) From Entitlements where EndDate >=:'+ SampleDate+' And Expire_Count__c<=:'+ SelectedDaysCount +') From Account limit 100 ';
            }
            else if(SelectedDaysCount == 90) {
                query = 'Select id, Name, Owner.name, CountofE__c, Earliestdate__c, LatestDate__c , ( Select Name, EndDate, Count(Id) From Entitlements where EndDate >=:'+ SampleDate+' And Expire_Count__c<=:'+ SelectedDaysCount +') From Account limit 100 ';
            }
            else if(SelectedDaysCount == 365){
                query = 'Select id, Name, Owner.name, CountofE__c, Earliestdate__c, LatestDate__c , ( Select Name, EndDate, Count(Id) From Entitlements where EndDate >=:'+ SampleDate+' And Expire_Count__c<=:'+ SelectedDaysCount +') From Account limit 100 ';
            }
            else {
                query = 'Select id, Name, Owner.name, CountofE__c, Earliestdate__c, LatestDate__c , ( Select Name, EndDate, Count(Id) From Entitlements where EndDate >=:'+ SampleDate+') From Account limit 100 ';
            }    
        }
        list<Account> Account = Database.Query(query); 
        return Accounts ;
    }
       
    public PageReference PerformFilterAction(){
        return null;
    }
}