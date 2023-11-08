/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Personnel with different data setup based on data code
 * [FLEX-359] : Refactor | Refactor the following unit test to optimize the execution time
 ***************************REVISION HISTORY **********************/
/**
* @description This class includes data set related to Personnel with different data code
*/
public without sharing class CQ_FLEX_Test_Personnel_Factory implements CQ_CCC_Test_SObject_Factory{
    
    //Personnel Name
    public static final String  PERSONNEL_FIRST_NAME = 'Test Personnel site Althofen';
    
    //Personnel Business Unit
    public static final String  BU_HS_HEALTH_SOLUTION = 'HS - Health Solution';
    
    //Personnel Sites
    public static final String  SITE_ALTHOFEN = 'ALT - Althofen';
    public static final String  SITE_AUSTIN = 'AUR - Austin';
    
    /**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'createActivePersonnel' { createPersonnel();}
            when 'createActivePersonnel3' { createPersonnelUser3();}
        }
        return new  Map<String,SObject>();
    }
    
    /**
	 * @description Method to Create Personnel record
	 */
    private void createPersonnel(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        String randomNumber = string.valueOf(system.currentTimeMillis());
        
        compliancequest__SQX_Personnel__c personnel = new compliancequest__SQX_Personnel__c();
        personnel.compliancequest__Full_Name__c = PERSONNEL_FIRST_NAME;
        personnel.compliancequest__Identification_Number__c = randomNumber;
        personnel.compliancequest__Active__c = true;
        personnel.compliancequest__SQX_User__c = stdUser.Id;
        personnel.compliancequest__Org_Site__c = SITE_ALTHOFEN;
        personnel.CQ_FLEX_Business_Unit__c = BU_HS_HEALTH_SOLUTION;
        insert personnel;
    }
    /**
	 * @description Method to Create Personnel record
	 */
    private void createPersonnelUser3(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 3' LIMIT 1];
        
        String randomNumber = string.valueOf(system.currentTimeMillis());
        
        compliancequest__SQX_Personnel__c personnel = new compliancequest__SQX_Personnel__c();
        personnel.compliancequest__Full_Name__c = PERSONNEL_FIRST_NAME;
        personnel.compliancequest__Identification_Number__c = randomNumber;
        personnel.compliancequest__Active__c = true;
        personnel.compliancequest__SQX_User__c = stdUser.Id;
        personnel.compliancequest__Org_Site__c = SITE_AUSTIN;
        personnel.CQ_FLEX_Business_Unit__c = BU_HS_HEALTH_SOLUTION;
        insert personnel;
    }
}