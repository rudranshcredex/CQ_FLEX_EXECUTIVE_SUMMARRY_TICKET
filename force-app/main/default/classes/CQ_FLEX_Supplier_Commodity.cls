/**
 * @description : Custom Handler class on Supplier Commodity Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 * ***************************************REVISION HISTORY****************************************** 
 */
public class CQ_FLEX_Supplier_Commodity {
    /**
     * @description  [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
     * @param newValues tirgger list variable
     */
    public static void updatSupplierCodeCommodityNameToSupplierCommodityExternalID(List<CQ_FLEX_SQX_Supplier_Commodity__c> newValues){        
        for(CQ_FLEX_SQX_Supplier_Commodity__c supComRec: newValues){            
            supComRec.put(Schema.CQ_FLEX_SQX_Supplier_Commodity__c.CQ_FLEX_Supplier_Commodity_ExternalID__c,supComRec.CQ_FLEX_Supplier_Code_Commodity_Name__c); //updates the value in the unique field
        }   
    }
}