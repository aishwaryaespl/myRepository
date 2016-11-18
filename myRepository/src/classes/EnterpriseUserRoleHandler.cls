public with sharing class EnterpriseUserRoleHandler {
 list<UserRole> URObj = new list<UserRole> ();
    UserRole obj;
    public void ProcessData(list<Enterprise__c>ListEnt){
    
        list<string>EntNameList = new list<string>();
        map<Enterprise__c, id>MapoEntRoleID = new map<Enterprise__c, id>();
        for (Enterprise__c EntObj : ListEnt){
            EntNameList.add(EntObj.name); 
            MapoEntRoleID.put(EntObj, null);
        }
        system.debug(EntNameList);
        
        //retrieve top most role in role hierarchy 
        UserRole UR = [Select u.Id From UserRole u where u.ParentRoleId = null];
        
        //create new role under parent role 
        for (String str : EntNameList ){
            String RoleName ;
            obj = new UserRole(name= str+Label.Manager, ParentRoleId = UR.id); //custom label
            URObj.add((obj)); 
            
        }
        
        //call future method to insert user role
        EnterpriseUserRoleHandler.InsertUserRole (JSON.serialize(URObj));
       
    }
    
    //future method to insert user role 
    @future(callout=true)
      public static  void InsertUserRole(String Str){
         list<UserRole> urLIST =(list<UserRole>) JSON.deserialize(Str, list<UserRole>.class);
         system.debug(urLIST);
         insert urLIST;
        
    }
    

    


}
