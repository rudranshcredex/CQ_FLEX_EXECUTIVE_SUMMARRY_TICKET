/**
* Controller class for the EA Dashboard Wrapper Component
*/ 
public class SQX_EA_Dashboard_Wrapper {
    
    public static String EA_DASHBOARD_NAME = '';

    /**
    * Method to get Dashboard developerName from custom settings
    */ 
    @AuraEnabled
    public static String getDeveloperName(){
        
        if (String.isNotBlank(compliancequest__SQX_Custom_Settings_Public__c.getInstance().compliancequest__EA_Dashboard_Name__c)){
            EA_DASHBOARD_NAME = compliancequest__SQX_Custom_Settings_Public__c.getInstance().compliancequest__EA_Dashboard_Name__c;
        }
        return EA_DASHBOARD_NAME;
    }
    
}