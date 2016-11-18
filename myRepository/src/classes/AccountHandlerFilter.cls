/**
*  ================================================================================================
*    Version       Date            Author                            Comment
*  ================================================================================================
*    Initial    Nov-14-2016     Aishwarya Shetty      Manage account filters .
*                                                   
**/
public with sharing class AccountHandlerFilter {
        public ApexPages.StandardSetController ssc {get;set;}  //For Pagination
        public List<SelectOption> sizeOptions {get;set;} 
        public List<SelectOption> expiryOptions {get;set;}      //List view
        public String chosenSize {get; set;}                   //Default selection in list view
        public String SelectedDaysCount {get; set;}
        public Account ca {get;set;}                          //Campaign object
        public Integer getPageNumber{get;set;}
        public Integer size{get;set;}
        public Integer noOfRecords{get; set;} 
        public List<SelectOption> PageOptions {get;set;}       //List view for pagination
        public String chosenPage {get; set;}
        public list<Account>ListAcc {get;set;}     
        public String UID = system.userinfo.getuserid();
        
        public AccountHandlerFilter(ApexPages.StandardSetController controller) {        
            ssc= new ApexPages.StandardSetController (
                [
                 Select a.Name
                      , a.Owner.name
                      , a.CountofE__c
                      , a.Earliestdate__c
                      , a.LatestDate__c
                      , Entitlement_Filtered_Count__c 
                   From Account a 
               Order by a.LastModifiedDate Desc
                ]
            );
                //Custom listView
                sizeOptions = new List<SelectOption>
                {
                        new SelectOption('All Accounts', 'All Acccounts'),
                        new SelectOption('Team Accounts', 'Team Accounts'),
                        new SelectOption('My Accounts', 'My Accounts')
                        
                };
                chosenSize = 'Team Accounts';    
                expiryOptions = new List<SelectOption>
                {
                        new SelectOption('30', '30'),
                        new SelectOption('60', '60'),
                        new SelectOption('90', '90'),
                        new SelectOption('365', '365')
                };
                SelectedDaysCount = '30'; 
                //Custom Pagination size 
                PageOptions = new List<SelectOption>
                {
                    new SelectOption('10', '10'),
                    new SelectOption('15', '15'),
                    new SelectOption('20', '20'),
                    new SelectOption('50', '50')
                };  
                chosenPage = '20';  
        }
        //onclick on name redirect to custom detail page
        public PageReference getRef() {    
                pageReference newPage = new PageReference('/apex/AccountNew');
                return newPage;
        }  
        public Integer pageNumber {
            get {
                return ssc.getPageNumber();
            }
            set;
        }
        
        //Store the queried result in list and pass this to table  
        Public List<Account> getAccount() {
                List<Account> accList = new List<Account>();
                for(Account c : (List<Account>)ssc.getRecords())
                    accList.add(c);
                return accList;
        }
        
        //Dynamic query based on selection on list view        
        public PageReference ApplyFilter() {
                date SampleDate = system.today() + integer.valueof(SelectedDaysCount) ;
                String query = 'Select a.Name, a.Owner.name,a.CountofE__c,a.Earliestdate__c,a.LatestDate__c,Entitlement_Filtered_Count__c'; 
                if(chosenSize == 'Team Accounts' &&  (SelectedDaysCount =='30' ||  SelectedDaysCount =='60' || SelectedDaysCount =='90' || SelectedDaysCount =='365'))
                {
                    query += ',(Select Name, EndDate From Entitlements where EndDate <=: SampleDate)  From Account a where Id IN (SELECT accountId FROM accountteammember WHERE UserId = :UID) ';
                }
                else if(chosenSize == 'My Accounts' && (SelectedDaysCount =='30' ||  SelectedDaysCount =='60' || SelectedDaysCount =='90' || SelectedDaysCount =='365') )
                {
                    query += ',(Select Name, EndDate From Entitlements where EndDate <=: SampleDate) From Account a where ownerid =: UID';
                }
                else if(chosenSize == 'All Accounts' && (SelectedDaysCount =='30' ||  SelectedDaysCount =='60' || SelectedDaysCount =='90' || SelectedDaysCount =='365'))
                {
                    query += ',(Select Name, EndDate From Entitlements where EndDate <=: SampleDate) From Account a where a.Name != null Order by a.LastModifiedDate Desc';
                }
                set<id>SetOFeNT = new set<id>();
                //store the query results in ssc object and 
                List<Account> AccountList = Database.Query(query);
                system.debug('Content of AccountList ---->'+AccountList);
                for (Account acc : AccountList ){
                    for (Entitlement ent : acc.Entitlements ){
                        SetOFeNT.add(ent.id);
                        acc.Entitlement_Filtered_Count__c = SetOFeNT.size();
                       
                    }
                }
                system.debug('Content of SetOFeNT ---->'+SetOFeNT );
                ssc = new ApexPages.StandardSetController(AccountList);
                
                //For select list to set the number of records on one page 
                if(chosenPage == '10')
                    ssc.setPageSize(10);
                else if(chosenPage == '15')    
                    ssc.setPageSize(15);
                else if(chosenPage == '20')    
                    ssc.setPageSize(20);
                else if(chosenPage == '50')    
                    ssc.setPageSize(50);
                return null;
        }
}