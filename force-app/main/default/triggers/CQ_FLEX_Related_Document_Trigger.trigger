/* 
 * [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 * [FLEX-174]: Training - JF requirements display of Related documents
 * [FLEX-200]: Training - JF requirements display of Related documents
 */
trigger CQ_FLEX_Related_Document_Trigger on compliancequest__SQX_Related_Document__c (Before Insert, After Insert, Before Update,After Update,After Delete,Before Delete) {
    /*if(Trigger.isAfter && Trigger.isInsert || Trigger.isBefore && Trigger.isUpdate){
       CQ_FLEX_Related_Document.restrictSaveorEditRelatedDocforContDoc(trigger.New);
    }*/
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
        //[FLEX-200]: Training - JF requirements display of Related documents
        CQ_FLEX_Related_Document.moveReferencedDocumentParentdocumentTrainingDocumentValToNewDoc(trigger.new);
    }

    if(Trigger.isAfter && Trigger.isInsert )
    {
        CQ_FLEX_Related_Document.UpdateSecondaryContentStatusToOutofSyncwhenInserted(trigger.new); 

        //[FLEX-174]: Training - JF requirements display of Related documents
        CQ_FLEX_Related_Document.CreateTrainingRequirementsforRelatedDocs(trigger.new);
    }

    //[FLEX-174]: Training - JF requirements display of Related documents
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        CQ_FLEX_Related_Document.CreateDeleteTrainingRequirementsforRelatedDocs(trigger.new,trigger.oldMap);
    }

    //[FLEX-174]: Training - JF requirements display of Related documents
    if(Trigger.isBefore && Trigger.isdelete){        
        CQ_FLEX_Related_Document.DeleteTrainingRequirementsforRelatedDocs(trigger.old);
    }

    if(Trigger.isAfter && Trigger.isdelete){
        
        CQ_FLEX_Related_Document.UpdateSecondaryContentStatusToOutofSyncWhenDeleted(trigger.old);
    }
}