/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Site with different data setup based on data code
 * [FLEX-359] : Refactor | Refactor the following unit test to optimize the execution time
 ***************************REVISION HISTORY **********************/
/**
* @description This class includes data set related to Site with different data code
*/
public without sharing class CQ_FLEX_Test_Site_Factory implements CQ_CCC_Test_SObject_Factory {
    
    //Site values
    public static final String  SITE_ALTHOFEN = 'ALT - Althofen',
                                SITE_AURAUSTIN = 'AUR - Austin';
    
    /**
    * @description Method to Construct Data
    * @return new
    * @param dataCode
    */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'CreateArea-ALT' { createArea(SITE_ALTHOFEN);}
        }
        return new  Map<String,SObject>();
    }
    
    /**
     * @description method to create site
     * @param site
     * @return site
     */
    public static compliancequest__SQX_Site__c createArea(String site) {
        
        //Arrange: Create Divison
        compliancequest__SQX_Division__c div = new compliancequest__SQX_Division__c();
        div.Name = site;
        insert div;
        
        //Arrange: Create Business_unit
        compliancequest__SQX_Business_Unit__c department = new compliancequest__SQX_Business_Unit__c();
        department.Name = site;
        department.compliancequest__SQX_Division__c=div.id;
        insert department; 
        
        //Arrange: Create Site
        compliancequest__SQX_Site__c area = new compliancequest__SQX_Site__c();
        area.Name = site;
        area.compliancequest__SQX_Business_Unit__c=department.id;
        insert area;
        
        return area; 
    }
}