/*
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects 
 */
trigger CQ_FLEX_Supplier_Commodity_Trigger on CQ_FLEX_SQX_Supplier_Commodity__c (before insert,Before Update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            //[FLEX-310] Duplicate Rules - Data Import for Global Account and child objects.
            CQ_FLEX_Supplier_Commodity.UpdatSupplierCodeCommodityNameToSupplierCommodityExternalID(Trigger.new);
        } 
    }
}