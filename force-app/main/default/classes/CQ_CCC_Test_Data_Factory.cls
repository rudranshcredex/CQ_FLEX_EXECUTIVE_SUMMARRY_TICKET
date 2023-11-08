/**
 * @description This method is used for data factory for standard OOB application and construct data and modify the records based on dataCode
 * 
 * [FLEX-301]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
 */ 
@SuppressWarnings('PMD')
public class CQ_CCC_Test_Data_Factory {
    private static Integer disableCount = 0;
     
    private static final string CLIENT_CODE = 'FLEX';
    private static final string CLIENT_CODE_TEST_PREFIX = 'CQ_'+ CLIENT_CODE +'_Test';
    private CQ_CCC_Test_SObject_Factory sobjectFactory;
    
    /**
     * @description constructor which ensure Object factory name is present or not depends upon given object type and create instance of sobject factory
     * @param sobjectType
     */
    public CQ_CCC_Test_Data_Factory(SObjectType sobjectType) {
      
        String factoryName = sobjectType.getDescribe().getName().replace('compliancequest__SQX', CLIENT_CODE_TEST_PREFIX).replace('__c', '').replace('compliancequest', '').replace('CQ_FLEX_SQX',CLIENT_CODE_TEST_PREFIX) + '_Factory';
       
        if(!factoryName.startsWith('CQ_')) {
            // append sqx prefix for SF standard object
            factoryName = CLIENT_CODE_TEST_PREFIX+'_' + factoryName;
        }
                  
        if(factoryName.length() > 40){
            //If factory class length is more than 40 characters, we get an error from Salesforce as class names cannot be more than 40 characters long. 
            //So, in such case, replace the factory class full name with abbreviations, using only the first capital character after the underscore
            //For example, SQX_Test_New_Supplier_Introduction_Factory becomes SQX_Test_NSI_Factory
            String newFactoryName = factoryName.replace(CLIENT_CODE_TEST_PREFIX+'_', '').replace('_Factory','');
            String shortForm = '';
            List<String> sList = newFactoryName.split('_');
            for(String str: sList){
                shortForm += str.subString(0,1);
            }
            factoryName = CLIENT_CODE_TEST_PREFIX+'_'+ shortForm + '_Factory';
        }
        Type factoryObj = Type.forName(factoryName);
       
        System.assert(factoryObj != null, 'No factory class named ' +factoryName+ ' is found for the object type ' + sobjectType);
        
        sobjectFactory = (CQ_CCC_Test_SObject_Factory) factoryObj.newInstance();
    }
    
    
    /**
     * @description This method is used to construct data seingt depend upon dataCode which is pass through test setup. Also the modifier parameter defines the class used to modify the data. 
     * @param dataCode
     * @return list of string
     */ 
    public Map<String, SObject> constructData(String dataCode) {
        try {
            //need to disable triggers or assign migration user permission to the user 
            return sobjectFactory.constructData(dataCode);   
        } finally {//NOPMD
            system.assert(true,'Unable to Create Data');        
        }       
    }
}