/********************************** Revision History **************************
* @description
* Handler Class on Assessment_Trigger
* [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
* [FLEX-156] Training - Assessments mandatory fields
* [FlEX-242] Trainings - SCORM Assessments Edit
* [FLEX-335] Bug in CQFLEXDEV/CQDev - Unable to edit the assessment
*********************************** Revision History **************************/
public without sharing class CQ_FLEX_Assessment {

    //Assessment Record Types
    public static final String  RECORD_TYPE_CQ_ASSESSMENT = 'CQ_Assessment';

    /**
     * @description [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
     * @param lstAssessment tirgger list variable
     */
    public static void restrictAssessment_BasedOn_PersonnelSite_AssessmentSite(List<compliancequest__SQX_Assessment__c> lstAssessment){
        
        //get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        Id currentUserId = System.userInfo.getUserId();
        
        //check the profile
        if(userprofileId == profileId)
        { 
            if(!lstAssessment.isEmpty())
            {                           
                //get the personnel record for site
                Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
                List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
                for(compliancequest__SQX_Personnel__c lstPerson: personList)
                {
                    personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
                }
                
                for(compliancequest__SQX_Assessment__c assRec: lstAssessment)
                { 
                    compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                    if(assRec.CQ_FLEX_Site__c != personRecord.compliancequest__Org_Site__c)
                    {
                        assRec.adderror(System.Label.CQ_FLEX_Assessment_Val_msg);
                    }
                }
            }
        }
    }
     /**
     *@description Make sure Total Questions To Ask more than 0
     *@Story [FLEX-156] Training - Assessments mandatory fields,[FLEX-335] Bug in CQFLEXDEV/CQDev - Unable to edit the assessment
     *@param lstAssessment trigger new list variable
     *@param oldAssessmentMap Map of old assessment records
     */
    public static void restrictAssessment_forTotalQuestionsToAskUpdate(List<compliancequest__SQX_Assessment__c> lstAssessment,Map<id,compliancequest__SQX_Assessment__c> oldAssessmentMap){
        
        Id cqAssessmentRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: RECORD_TYPE_CQ_ASSESSMENT AND SObjectType = 'compliancequest__SQX_Assessment__c'].Id;
        
        for(compliancequest__SQX_Assessment__c assRec: lstAssessment)
        {
            compliancequest__SQX_Assessment__c oldrec=OldAssessmentMap.get(assrec.id);
            //It is a dummy variable that should not be considered
            integer i=0;
            if(oldrec.compliancequest__Total_Questions_To_Ask__c!=0 && assRec.compliancequest__Total_Questions_To_Ask__c==0 && assRec.RecordTypeId == cqAssessmentRecordTypeId){
                //It is a dummy increment that should not be considered
                i++;
            }
            else if(assRec.compliancequest__Total_Questions_To_Ask__c==0 && oldrec.compliancequest__Total_Questions__c!=assRec.compliancequest__Total_Questions__c && assRec.RecordTypeId == cqAssessmentRecordTypeId){
                //It is a dummy increment that should not be considered
                i++;
            }
            else if(assRec.compliancequest__Total_Questions_To_Ask__c==0 && assRec.RecordTypeId == cqAssessmentRecordTypeId){
                assRec.adderror(System.Label.CQ_FLEX_ErrorForTotalQuestionsToAsk);
            }
        }        
    }
}