/**
 * @description : Custom Handler class on Account Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-436] Scouting Account - Quick Action to Promote Supplier
 * ***************************************REVISION HISTORY****************************************** 
 */
public class CQ_FLEX_Account {    
    /**
     * @description  [FLEX-436] Scouting Account - Quick Action to Promote Supplier
     * @param acclist tirgger list variable
     * @param mapAcc tirgger map variable
     */
    public static void publishPEToPromoteSupplier(List<Account> acclist,Map<id, Account> mapAcc){
        List<CQ_FLEX_Application_Event__e> apEvents = new List<CQ_FLEX_Application_Event__e>();
        for(Account accrec : acclist)
        {
            Account oldacc=mapAcc.get(accrec.id);
            if(accrec.CQ_FLEX_Global_Supplier_Code_Promotion__c != oldacc.CQ_FLEX_Global_Supplier_Code_Promotion__c) 
            {
                Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Global').getRecordTypeId();
                apEvents.add(new CQ_FLEX_Application_Event__e(CQ_FLEX_Action__c='PromoteSupplier', CQ_FLEX_Record_Id__c=accrec.id, 
                                                              CQ_FLEX_Related_Record_Id__c=accrec.CQ_FLEX_Global_Supplier_Code_Promotion__c,
                                                             CQ_FLEX_Related_Record_Id2__c=devRecordTypeId));  
            }            
        }
        if(apEvents.size() > 0){
            List<Database.SaveResult> results = EventBus.publish(apEvents);        
        }   
    }
}