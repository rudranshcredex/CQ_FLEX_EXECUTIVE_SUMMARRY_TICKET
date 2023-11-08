/**
 * Test call for SQX_Test_EA_Dashboard_Wrapper
 * [SQX-17097]
 * @author: Nischal Nayaju
 */
@isTest
public class SQX_Test_EA_Dashboard_Wrapper {

    /*
     * Given : DeveloperName In CQ Settings
     * When : Get DeveloperName method is invoked from SQX_EA_Dashboard_Wrapper class
     * Then : DeveloperName from the CQ Settings is returned
     */
    @isTest static void givenDeveloperNameWhenGetDeveloperNameMethodIsInvokedDeveloperNameIsReturned(){
        
        String expectedDeveloperName = 'CQ_Sample_Dashboard';
        // ARRANGE : Set DeveloperName in the EA_DeveloperName field in CQ Settings
		compliancequest__SQX_Custom_Settings_Public__c settings = compliancequest__SQX_Custom_Settings_Public__c.getOrgDefaults();
		settings.compliancequest__EA_Dashboard_Name__c = expectedDeveloperName;
        settings.compliancequest__Community_URL__c = 'https://www.compliancequest.com';
        settings.compliancequest__Org_Base_URL__c = 'https://www.compliancequest.com/';
        settings.compliancequest__Account_Record_Type__c = 'CQ_Supp';
        settings.compliancequest__NC_Analysis_Report__c = 'a3Ge0000000yrbDEA';
        insert settings;
        
        // ACT : Invoke the getDeveloperName method
		String developerName = SQX_EA_Dashboard_Wrapper.getDeveloperName();
        
        // ASSERT: CQ_Sample_Dashboard is returned
        System.assertEquals(expectedDeveloperName, developerName, 'EA Dashboard DeveloperName is returned from the CQ Settings is returned');
    }
    
    /*
     * Given : No DeveloperName In CQ Settings
     * When : Get DeveloperName method is invoked from SQX_EA_Dashboard_Wrapper class
     * Then : Default DeveloperName is returned
     */
    
    @isTest static void givenNoDeveloperNameWhenGetDeveloperNameMethodIsInvokedDefaultDeveloperNameIsReturned(){
        
        String defaultDeveloperName = '';
        // ARRANGE : Set DeveloperName in the EA_DeveloperName field in CQ Settings
		compliancequest__SQX_Custom_Settings_Public__c settings = compliancequest__SQX_Custom_Settings_Public__c.getOrgDefaults();
        settings.compliancequest__Community_URL__c = 'https://www.compliancequest.com';
        settings.compliancequest__Org_Base_URL__c = 'https://www.compliancequest.com/';
        settings.compliancequest__Account_Record_Type__c = 'CQ_Supp';
        settings.compliancequest__NC_Analysis_Report__c = 'a3Ge0000000yrbDEA';
        insert settings;
        
        // ACT : Invoke the getDeveloperName method
		String developerName = SQX_EA_Dashboard_Wrapper.getDeveloperName();
        
        // ASSERT: defaultDeveloperName is returned
        System.assertEquals(defaultDeveloperName, developerName, 'Default EA Dashboard DeveloperName is returned');
    }
   
}