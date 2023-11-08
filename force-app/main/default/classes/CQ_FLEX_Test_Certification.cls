/**
 * @description Class to perform all the unit test related to Certification
 * 
 * [FLEX-283]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for GCM & PSL Roles
 * 
 * [FLEX-236]: Account - Document tab - Supplier Document: Account and Record fields are to be read-only
 * 
 * [FLEX-293]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
 * 
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
 * 
 * [FLEX-453]:Global Account - Document : Validation rules is applied to make Description field required, it should be removed.
 */ 
@isTest
public class CQ_FLEX_Test_Certification {
    
    /**
     * @description Method to call user class and Certification factory to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard'); 
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-standardandroleGCM'); 
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-standardandroleQuality'); 
        new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Certification__c.SObjectType).constructData('Certification-with-Account');   
    }
    
    /**
     * @description Test method to valdation for PreventEditingSupplier_DocNumber
     * 
     * GIVEN: Certification record with Account
     * WHEN: Name updated
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_PreventEditingSupplier_DocNumber     
     * @Story: [FLEX-236]:Account - Document tab - Supplier Document: Account and Record fields are to be read-only
     */ 
    @isTest
    public static void givenCertificationRecordWithAccount_WhenNameIsUpdated_ThenThrowValidation(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,compliancequest__Account__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            //Act: Update Name
            certRecord.name = 'test';
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully.');            
        }
    }
    /**
     * @description Test method to Prevent GCM or PSL Role Not to add or modify Document Type other than FLEX DOCUMENTS and SUPPLIER DOCUMENTS
     * 
     * GIVEN: Certification record
     * WHEN: Document Type is not FLEX DOCUMENTS or SUPPLIER DOCUMENTS Updated by GCM or PSL User
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Restrict_GCMPSLRoleFewDoctypeVal     
     * @Story: [FLEX-283]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for GCM & PSL Roles
     */ 
    @isTest
    public static void givenCertificationRecord_WhenDocumentTypeNotFLEXDOCUMENTSORSUPPLIERDOCUMENTSUpdatedbyGCMOrPSLUser_ThenThrowValidation(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User GCM1' LIMIT 1];
        new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Certification__c.SObjectType).constructData('GCMCertification-with-Account');
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     


        System.runAs(standardUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c 
                                                                LIMIT 1];
            //Act: Update Document type and doc classification
            certRecord.CQ_FLEX_Document_Type__c = 'Certifications';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Supplier documents (EXTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully.');  
            
        }
        System.runAs(adminUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c
                                                                WHERE CQ_FLEX_Contract_Hierarchy__c='GCM'
                                                                LIMIT 1];
            //Act: Update Document Type Classification
            certRecord.CQ_FLEX_Document_Type__c = 'Certifications';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Supplier documents (EXTERNAL)';
            certRecord.compliancequest__Document_Name__c='AECQ';
            
            update certRecord;
            
        }
        System.runAs(standardUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c 
                                                                LIMIT 1];
            //Act: Delete Certification record
            Database.DeleteResult delresult=Database.delete(certRecord,false);
            
            //Assert: Ensure record is not deleted.
            System.assertEquals(false,delresult.isSuccess(),'Record deleted successfully.'); 
        }
    }
	/**
     * @description Test method to Prevent Quality Role Not to add or modify Document Types Legal, Supplier Documents, Flex Documents, or Other Documents
     * 
     * GIVEN: Certification record
     * WHEN: Document Type is Legal, Supplier Documents, Flex Documents, or Other Documents Updated by Quality User
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Restrict_QualRoleFewDoctypeVals     
     * @Story: [FLEX-293]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
     */ 
    @isTest
    public static void givenCertificationRecord_WhenDocumentTypeIsUpdatedbyLegalSupplierDocumentsFlexDocumentsOrOtherQualityUser_ThenThrowValidation(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User Quality1' LIMIT 1];
        new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Certification__c.SObjectType).constructData('QualityCertification-with-Account');   
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     

        
        System.runAs(standardUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c 
                                                                LIMIT 1];
            //Act: Update Document type and doc classification
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully.');  
        }
        System.runAs(adminUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c
                                                                WHERE CQ_FLEX_Contract_Hierarchy__c='Quality'
                                                                LIMIT 1];
            //Arrange: Update Document Type Classification
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            certRecord.compliancequest__Document_Name__c='EDI';
            
            update certRecord;
            
        }
        System.runAs(standardUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c,CQ_FLEX_Doc_Classification__c
                                                                FROM compliancequest__SQX_Certification__c 
                                                                LIMIT 1];
            //Act: Delete Certification record
            Database.DeleteResult delresult=Database.delete(certRecord,false);
            
            //Assert: Ensure record is not deleted.
            System.assertEquals(false,delresult.isSuccess(),'Record deleted successfully.'); 
        }
    }

    /**
     * @description Test method to ensure Update Contract Id to Certification_Num
     * 
     * GIVEN: Certification record
     * WHEN: Contract Id has value
     * THEN: Update Contract Id to Certification_Num
     * 
     * Apex Class:CQ_FLEX_Certification (UpdateContractIdToCerificationNum)   
     * @Story: [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenContractIdHasValue_ThenUpdateContractIdToCertificationNum(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
        System.runAs(adminUser){
            
            //Arrange: Get Certification record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,compliancequest__Certification_Num__c,CQ_FLEX_Contract_Id__c
                                                                FROM compliancequest__SQX_Certification__c 
                                                                LIMIT 1];
            //Act: Covert decimal to string.
            string contractId=String.Valueof(certRecord.CQ_FLEX_Contract_Id__c);
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(certRecord.compliancequest__Certification_Num__c,ContractId,'Record updated successfully.');            
        }
    }
    /**
     * @description Test method to Issue Date cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Issue Date Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_IssueDate
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenIssueDateUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,compliancequest__Issue_Date__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Issue Date Updated by Admin with Null            
            certRecord.compliancequest__Issue_Date__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Classification cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Classification Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Classification
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenClassificationUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Doc_Classification__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Classification Updated by Admin with Null            
            certRecord.CQ_FLEX_Doc_Classification__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Description cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Description Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_ContractDescription
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenDescriptionUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,compliancequest__Description__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Description Updated by Admin with Null            
            certRecord.compliancequest__Description__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contract Hierarchy cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Contract Hierarchy Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_ContractHierarchy
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenContractHierarchyUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Contract_Hierarchy__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Contract Hierarchy Updated by Admin with Null            
            certRecord.CQ_FLEX_Contract_Hierarchy__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contract Id cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Contract Id Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_ContractId
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenContractIdUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Contract_Id__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Contract Id Updated by Admin with Null            
            certRecord.CQ_FLEX_Contract_Id__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';

            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contract Status cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Contract Status Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_ContractStatus
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenContractStatusUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Status__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Contract Status Updated by Admin with Null            
            certRecord.CQ_FLEX_Status__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contract URL cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Contract URL Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_ContractURL
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenContractURLUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Contract_URL__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Contract URL Updated by Admin with Null            
            certRecord.CQ_FLEX_Contract_URL__c=Null;
            certRecord.CQ_FLEX_Document_Type__c = 'Legal';
            certRecord.CQ_FLEX_Doc_Classification__c = 'Contract (INTERNAL)';

            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Document Name cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Document Name Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_DocumentName
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenDocumentNameUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,compliancequest__Document_Name__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Document Name Updated by Admin with Null            
            certRecord.compliancequest__Document_Name__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Document Type cannot be blank.
     * 
     * GIVEN: Supplier Document record
     * WHEN: Document Type Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_DocumentType
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCertificationRecord_WhenDocumentTypeUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Document record
            compliancequest__SQX_Certification__c certRecord = [SELECT Id,CQ_FLEX_Document_Type__c
                                 FROM compliancequest__SQX_Certification__c 
                                 LIMIT 1];
            
            //Act:Document Type Updated by Admin with Null            
            certRecord.CQ_FLEX_Document_Type__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(certRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
}