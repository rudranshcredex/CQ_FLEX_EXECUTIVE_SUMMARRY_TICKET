/********************************** Revision History ************************************************************
*  @description : Invocable class for process personnelBU retainAll on conDocBU.
* 
* [FLEX-209] : Training - Bug- FLEX-69 & FLEX-33
*********************************** Revision History **************************************************************/
public without sharing class CQ_FLEX_DTN_BU {
    
    /**
     * @description method to restrictSaveorEditDistributionTrack
     * @param listDTNRec Document training list
     * @return retainAll result
     */
    @InvocableMethod(Label='CQ FLEX personnelBU retainAll on conDocBU' Description = 'Check DTN has Document → Business Unit that does not match with atleast one Personnel → Business Unit')
    public static list<boolean> processpersonnelBU(List<compliancequest__SQX_Personnel_Document_Training__c> listDTNRec){
        list<boolean> resultretain=new list<boolean>();
        for(compliancequest__SQX_Personnel_Document_Training__c dtnrec:listDTNRec){
            Set<String> personnelBU = new Set<String>(); 
            List<String> conDocBU=new List<String>();
            if(dtnrec.CQ_FLEX_Personnel_Business_Unit__c!=null){
                personnelBU.addAll(dtnrec.CQ_FLEX_Personnel_Business_Unit__c.split(';'));
            }
            //Controlled Document Business Unit
            if(dtnrec.CQ_FLEX_Controlled_Document_BU__c!=null){
                conDocBU = dtnrec.CQ_FLEX_Controlled_Document_BU__c.split(';');   
            }            
            //RetainAll method in Set extracts interesection values
            Boolean retailResult = personnelBU.retainAll(conDocBU);
            resultretain.add(personnelBU.size()>0);
        }
        return resultretain;
    }    
}