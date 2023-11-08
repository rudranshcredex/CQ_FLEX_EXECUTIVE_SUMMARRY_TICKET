/********************************** Revision History **************************
 * @description
* 1.[FLEX-51] Documents - Area configuration
* 2.[FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_SQXSite {
    /**
     * @description
     * GIVEN 	 : CQ Area
     * WHEN  	 : Created.  
     * THEN      : Site(text field) Update with Site (Division) belonging to the Department (Business Unit).
     * Flow      : CQ FLEX Site After Create RT Flow
     * @Story	 : [FLEX-51] Documents - Area configuration
     */
    @isTest
    Public static void givenCQAreaRecord_WhenCreated_ThenSiteUpdateWithSiteInRelatedDepartment() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User'); 
        
        compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id]; 
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Act: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area;
            
            compliancequest__SQX_Site__c cq_Area_Updated=[SELECT id,CQ_FLEX_Site_Sharing__c 
                                                          FROM compliancequest__SQX_Site__c 
                                                          WHERE id=:cq_Area.id];
            
            //Assert: Check Site Field Updated with Site (Division) belonging to the Department (Business Unit) 
            System.assertEquals('ALT - Althofen',cq_Area_Updated.CQ_FLEX_Site_Sharing__c, 'Wrong site value or null');    
            
        }
    }
    /**
     * @description
     * GIVEN 	 : CQ Area
     * WHEN  	 : Created/Update.  
     * THEN      : Update Site_Department_Area Name by concatenat to Area_Unique field
     * Apex Class: CQ_FLEX_Site
     * @Story	 : [FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
     */
    @isTest
    Public static void givenCQAreaRecord_WhenCreatedUpdate_ThenAreaUniqueUpdateWithSiteDepartmentAreaName() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User'); 
        
        compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id]; 
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Area
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area;
            
            //Act: Create Area with same name
            compliancequest__SQX_Site__c cq_Area2 = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            Database.SaveResult result = Database.insert(cq_Area2, false);
            
            //Assert: cq_Area2 should not create as the Site_Department_Area_Name is same as cq_Area.
            System.assertEquals(false,result.isSuccess(), 'cq_Area2 created as the Site_Department_Area_Name is different cq_Area.');                
        }
    }
}