/*
 * [FLEX-436] Scouting Account - Quick Action to Promote Supplier
 */
trigger CQ_FLEX_Account_Trigger on Account (After Update) {
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            //[FLEX-436] Scouting Account - Quick Action to Promote Supplier
            CQ_FLEX_Account.publishPEToPromoteSupplier(Trigger.new,trigger.oldmap);
        } 
    }
}