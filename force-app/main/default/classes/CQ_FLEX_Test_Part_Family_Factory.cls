/**
 * @description This class includes data set related to Commodity with different data code
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 */ 
public with sharing class CQ_FLEX_Test_Part_Family_Factory implements CQ_CCC_Test_SObject_Factory{
    
    // All public static variables related to Commodity      
    public static final String  COMMODITY_DESCRIPTION = 'Test Description',
                                NAME='Test',                                
                                DIRECTOR_GROUP='DSN',
                                GROUP_VP_LEVEL='IPS',
                                COMMODITY_GROUP='Indirect',
                                COMMODITY_TYPE='Indirect';
    public static final Integer CODE_LEVEL=1;
    
    compliancequest__SQX_Part_Family__c COMRECORD;
    
    /**
     * @description Method to construct required data for Commodity
     * with various policies
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'Commodity' {createCommodity();}
            when 'Supplier_Commodity-with-Account-Commodity' {createSupplierCommoditywithAccountCommodity();}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new Map<String,SObject>();
    }
    
    /**
     * @description  Method to build Commodity
     * @param commoditydescription
     * @param name
     * @param directorgroup
     * @param groupvplevel
     * @param commoditygroup
     * @param commoditytype
     * @param codelevel     
     * @return Commodity record   
     */
    private compliancequest__SQX_Part_Family__c buildCommodity(String commoditydescription, String name, String directorgroup, String groupvplevel,String commoditygroup,String commoditytype,Integer codelevel){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        String accountNum = string.valueOf(system.currentTimeMillis());
        
        compliancequest__SQX_Part_Family__c comRec = new compliancequest__SQX_Part_Family__c(
            Name=name+randomNumber,
            CQ_FLEX_Level_1_Desc__c=commoditydescription,
            CQ_FLEX_Director_Group__c = directorgroup,
            CQ_FLEX_Group_VP_Level__c=groupvplevel,
            CQ_FLEX_Commodity_Group__c = commoditygroup,
            CQ_FLEX_Commodity_Type__c = commoditytype,
            CQ_FLEX_Comm_Code_Level__c=codelevel
        );        
        return comRec;
    }
    
    /**
     * @description  Method to build Supplier Commodity
     * @param accid
     * @param comid   
     * @return Supplier Commodity record   
     */
    private CQ_FLEX_SQX_Supplier_Commodity__c buildSupplierCommodity(id accid, id comid){        
        
        CQ_FLEX_SQX_Supplier_Commodity__c supcomRecord = new CQ_FLEX_SQX_Supplier_Commodity__c(
            CQ_FLEX_SQX_Account__c=accid,
            CQ_FLEX_SQX_Commodity_Code__c=comid
        );        
        return supcomRecord;
    }
    
    /**
      * @description Method to create Commodity record.
      */
    private void createCommodity(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        
        System.runAs(adminUser){         
            COMRECORD = buildCommodity(
                COMMODITY_DESCRIPTION,
                NAME,                                
                DIRECTOR_GROUP,
                GROUP_VP_LEVEL,
                COMMODITY_GROUP,
                COMMODITY_TYPE,
                CODE_LEVEL           
            );
            insert COMRECORD;                                                
        }          
    }
    
    
        /**
      * @description Method to create Commodity record.
      */
    private void createSupplierCommoditywithAccountCommodity(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        Account accRecord = [SELECT Id,ownerid, COMPLIANCEQUEST__ACTIVE__C
                                 FROM Account 
                                 LIMIT 1];
        createCommodity();
        System.runAs(adminUser){         
            CQ_FLEX_SQX_Supplier_Commodity__c supcomRecord = buildSupplierCommodity(
                accRecord.id,
                COMRECORD.id
            );
            insert supcomRecord;                                                  
        }       
    }
}