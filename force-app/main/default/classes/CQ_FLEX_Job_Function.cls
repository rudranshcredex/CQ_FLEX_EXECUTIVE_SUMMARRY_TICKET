/**
 * @description : Custom Handler class on Job Function Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-82] Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
 * [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
 * [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
 * ***************************************REVISION HISTORY****************************************** 
 */ 
public without sharing class CQ_FLEX_Job_Function {
    /**
     * @description [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
     * @param listJobFunction tirgger list variable
     */
    public static void restrictJobFunction_BasedOn_DocAdminPersonnelSite_AndJobFunctionSite(List<compliancequest__SQX_Job_Function__c> listJobFunction){
        //get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        
        Id currentUserId = System.userInfo.getUserId();
        
        //check the profile
        if(userprofileId == profileId)
        { 
            if(listJobFunction != null)
            {  
                
                //get the personnel record for site
                Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
                List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
                for(compliancequest__SQX_Personnel__c lstPerson: personList){
                    personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
                }
                
                
                for(compliancequest__SQX_Job_Function__c jobf :listJobFunction)
                {
                    compliancequest__SQX_Personnel__c person = personMap.get(currentUserId);
                    if(jobf.CQ_FLEX_Site__c != person.compliancequest__Org_Site__c)
                    {
                        jobf.adderror(System.Label.CQ_FLEX_JobFunction_Val_msg);
                    }
                }
            } 
        }
    }
    
    /**
     * @description [FLEX-82] Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
     * @param newValues tirgger list variable
     */
    public static void ensureCombinationIsUnique(List<compliancequest__SQX_Job_Function__c> newValues){
       
        Schema.SObjectField [] fields = new Schema.SObjectField[]{ Schema.compliancequest__SQX_Job_Function__c.Name,Schema.compliancequest__SQX_Job_Function__c.CQ_FLEX_Area__c,Schema.compliancequest__SQX_Job_Function__c.CQ_FLEX_Site__c,Schema.compliancequest__SQX_Job_Function__c.CQ_FLEX_Department__c};
            for(compliancequest__SQX_Job_Function__c objectToCheck: newValues){
                if(objectToCheck.compliancequest__Active__c  == true){
                    String uniqueMap = '';
                    //for each field that is to be unique add the combination to get a string which must be unique
                    for(Schema.SObjectField field : fields){
                        uniqueMap = uniqueMap + objectToCheck.get(field);
                    }
                    objectToCheck.put(Schema.compliancequest__SQX_Job_Function__c.CQ_Flex_Job_Function_Unique__c, uniqueMap); //updates the value in the unique field
                }
                else if(objectToCheck.compliancequest__Active__c  == false){
                    objectToCheck.CQ_FLEX_Job_Function_Unique__c = '';
                }
            }        
    }

    /**
    * @description Apex Method to increment counter by 1 on JF creation
    * @param newlstJF
    * @Story [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
    */
    public static void incrementDuplicateNameCounter(List<compliancequest__SQX_Job_Function__c> newlstJF){
        
        Set<string> nameSet = new Set <string>();
        for(compliancequest__SQX_Job_Function__c jFrecord : newlstJF){
            nameSet.add(jFrecord.name);
        }
        
        list<compliancequest__SQX_Job_Function__c> lstjF = [SELECT id,Name,CQ_FLEX_Duplicate_Counter__c FROM compliancequest__SQX_Job_Function__c WHERE Name IN :nameSet AND compliancequest__Active__c = true Order By CQ_FLEX_Duplicate_Counter__c asc];
        Map<String,compliancequest__SQX_Job_Function__c> mapCounterValue = new Map<String,compliancequest__SQX_Job_Function__c>();
        for(compliancequest__SQX_Job_Function__c jFrecord : lstjF){
            mapCounterValue.put(jFrecord.Name,jFrecord);
        }
        if(mapCounterValue.size() > 0){
            for(compliancequest__SQX_Job_Function__c jFrecord : newlstJF){
                compliancequest__SQX_Job_Function__c oldJF = mapCounterValue.get(jFrecord.Name);
                if(jFrecord.compliancequest__Active__c == true){
                    if(oldJF.CQ_FLEX_Duplicate_Counter__c == null){
                        jFrecord.CQ_FLEX_Duplicate_Counter__c = 1;
                    }
                    else{
                        jFrecord.CQ_FLEX_Duplicate_Counter__c = oldJF.CQ_FLEX_Duplicate_Counter__c + 1 ;
                    }
                }
            } 
        }
    }
    
    /**
    * @description Apex Method to increment counter by 1 on JF Activation
    * @param newlstJF
    * @param oldJFMap
    * @Story [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
    */
    public static void incrementDuplicateNameCounterOnActivation(List<compliancequest__SQX_Job_Function__c> newlstJF,Map<Id,compliancequest__SQX_Job_Function__c> oldJFMap){
        
        Set<string> nameSet = new Set <string>();
        for(compliancequest__SQX_Job_Function__c jFrecord : newlstJF){
            nameSet.add(jFrecord.name);
        }
        
        list<compliancequest__SQX_Job_Function__c> lstjF = [SELECT id,Name,CQ_FLEX_Duplicate_Counter__c FROM compliancequest__SQX_Job_Function__c WHERE Name IN :nameSet AND compliancequest__Active__c = true Order By CQ_FLEX_Duplicate_Counter__c asc];
        Map<String,compliancequest__SQX_Job_Function__c> mapCounterValue = new Map<String,compliancequest__SQX_Job_Function__c>();
        for(compliancequest__SQX_Job_Function__c jFrecord : lstjF){
            mapCounterValue.put(jFrecord.Name,jFrecord);
        }       
        if(mapCounterValue.size() > 0){
            for(compliancequest__SQX_Job_Function__c jFrecord : newlstJF){
                compliancequest__SQX_Job_Function__c oldJF = oldJFMap.get(jFrecord.id);
                compliancequest__SQX_Job_Function__c olddupJF = mapCounterValue.get(jFrecord.Name);
                if(oldJF.compliancequest__Active__c != jFrecord.compliancequest__Active__c && jFrecord.compliancequest__Active__c == true){
                    if(olddupJF.CQ_FLEX_Duplicate_Counter__c == null){
                        jFrecord.CQ_FLEX_Duplicate_Counter__c = 1;
                    }
                    else{
                        jFrecord.CQ_FLEX_Duplicate_Counter__c = olddupJF.CQ_FLEX_Duplicate_Counter__c + 1 ;
                    }
                }
            } 
        }
    }
}