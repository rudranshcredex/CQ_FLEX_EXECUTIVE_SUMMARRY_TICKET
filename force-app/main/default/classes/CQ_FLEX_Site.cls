/**
 * @description Custom Handler class on Site Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-82] Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
 * ***************************************REVISION HISTORY****************************************** 
 */ 
public class CQ_FLEX_Site {

    private Map<Id, compliancequest__SQX_Site__c> oldValues { get; set; }
    private List<compliancequest__SQX_Site__c> newValues { get; set; }
    
    /**
     * @description Constructor to initialize newValues and oldValues
     * @param newValues - contains Trigger.New instance
     * @param oldValues - contains Trigger.Old instance
     */
    public CQ_FLEX_Site(List<compliancequest__SQX_Site__c> newValues, Map<Id, compliancequest__SQX_Site__c> oldValues){
        this.oldValues = oldValues == null ? new Map<Id, compliancequest__SQX_Site__c>() : oldValues;
        this.newValues = newValues;
    }
    
    /**
     * @description Method to validate the combination of Site_Department_Area Name is unique
     * @return this
     * @Story: [FLEX-82] Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
     */
    public CQ_FLEX_Site ensureCombinationIsUnique(){
        Schema.SObjectField [] fields = new Schema.SObjectField[]{ Schema.compliancequest__SQX_Site__c.Name, Schema.compliancequest__SQX_Site__c.CQ_FLEX_Department_Name__c,Schema.compliancequest__SQX_Site__c.CQ_FLEX_Site__c};
            for(compliancequest__SQX_Site__c objectToCheck: newValues){
                String uniqueMap = '';
                //for each field that is to be unique add the combination to get a string which must be unique
                for(Schema.SObjectField field : fields){
                    uniqueMap = uniqueMap + objectToCheck.get(field);
                }
                objectToCheck.put(Schema.compliancequest__SQX_Site__c.CQ_FLEX_Area_Unique__c, uniqueMap); //updates the value in the unique field
            }
        return this;
    }
}