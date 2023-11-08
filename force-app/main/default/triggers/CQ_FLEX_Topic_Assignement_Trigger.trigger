/**
 * Trigger to perform required operations in Related Part
 * ************************************************* Revision History ********************************************
 * [FLEX-52]-Documents - Area configuration continued
 * ************************************************* Revision History ********************************************
 */
trigger CQ_FLEX_Topic_Assignement_Trigger on TopicAssignment ( After Insert,After Delete) {//NOPMD
    
    if(Trigger.isAfter && Trigger.isDelete){
        new CQ_FLEX_Topic_Assignement(Trigger.Old, Trigger.oldMap)
            .restrictContrrolledDoc_DeleteTopic();
    }
    if(Trigger.isAfter && (Trigger.isInsert)){
        new CQ_FLEX_Topic_Assignement(Trigger.New, Trigger.oldMap)
            .restrictContrrolledDoc_AddNewTopic();
    }    
}