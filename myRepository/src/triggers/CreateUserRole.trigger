trigger CreateUserRole on Enterprise__c (before insert) {
EnterpriseUserRoleHandler HandlerObj = new EnterpriseUserRoleHandler();
    if (trigger.isbefore){
    	if (trigger.isinsert){
    	HandlerObj.ProcessData(trigger.new);
    	}
    }
}