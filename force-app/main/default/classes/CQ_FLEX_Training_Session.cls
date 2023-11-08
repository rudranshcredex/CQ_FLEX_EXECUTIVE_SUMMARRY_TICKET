/**
 * @description Handler Class on Training_Session_Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-41]-Training - Training Session continued
 * [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
 * ***************************************REVISION HISTORY****************************************** 
*/
public without sharing class CQ_FLEX_Training_Session {
    /**
	 * @description FLEX-43 restrictTraining_Session_BasedOn_PersonnelSite_Training_SessionSite
	 * @param lstTrainingSession - contains Trigger.New instance
	 */
    public static void restrictTraining_Session_BasedOn_PersonnelSite_Training_SessionSite(List<compliancequest__SQX_Training_Session__c> lstTrainingSession){
        //get the profile info
		 Id userprofileId = userInfo.getProfileId();
  		 Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        
        Id currentUserId = System.userInfo.getUserId();
                                    			
        //check the profile
        if(userprofileId == profileId)
        { 
            if(!lstTrainingSession.isEmpty())
            {
                
                //get the personnel record for site
            	Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            	List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
            	for(compliancequest__SQX_Personnel__c lstPerson: personList){
                	personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
            	}
                
                for(compliancequest__SQX_Training_Session__c traningSRec: lstTrainingSession){
                    
                   compliancequest__SQX_Personnel__c personRec = personMap.get(currentUserId);
                    
                    if(traningSRec.compliancequest__Org_Site__c != personRec.compliancequest__Org_Site__c)
                    {
                        traningSRec.adderror(System.Label.CQ_FLEX_Training_Session_Val_msg);
                    } 
                   
                }
            }
        }
    }

    /**
	 * @description Training Session Rosters From Users in JOB Function When Training_Session Is Open [FLEX-41]
	 * @param lstTrainingSession - contains Trigger.New instance
	 * @param oldMapTrainingSession - contains Trigger.oldmap instance
	 */
    public static void createTrainingSessionRostersFromJfWhenTSIsOpen(List<compliancequest__SQX_Training_Session__c> lstTrainingSession,map<id,compliancequest__SQX_Training_Session__c> oldMapTrainingSession)
    {
        set<id> tsopenid=new set<id>();
        set<id> tsCompleteid=new set<id>();
        set<id> allJfs=new set<id>();
        map<id,set<id>> tsJfidMap=new map<id,set<id>>();
        map<id,list<id>> jfidPersonnelIdsMap=new map<id,list<id>>();
        list<compliancequest__SQX_Training_Session_Roster__c> tsrlist=new list<compliancequest__SQX_Training_Session_Roster__c>();
        
        for(compliancequest__SQX_Training_Session__c tS:lstTrainingSession)
        {
            if(tS.compliancequest__Status__c=='open' && oldMapTrainingSession.get(tS.id).compliancequest__Status__c=='Draft')
            {
                tsopenid.add(tS.id);
            }
            
        }
        
        list<compliancequest__SQX_Training_Session__c> tSlist=[SELECT id,compliancequest__SQX_Controlled_Document__c,
                                                               (SELECT id,CQ_FLEX_SQX_Job_Function__c,CQ_FLEX_SQX_Training_Session__c 
                                                                FROM Job_Functions__r)
                                                               FROM compliancequest__SQX_Training_Session__c
                                                               WHERE id in: tsopenid];
        list<compliancequest__SQX_Training_Session_Roster__c> tSRlist_complete=[SELECT id,compliancequest__Result__c
                                                               FROM compliancequest__SQX_Training_Session_Roster__c
                                                               WHERE compliancequest__SQX_Training_Session__c in: tsCompleteid];
        for(compliancequest__SQX_Training_Session__c tS:tSlist)
        {
            set<id> exsjfid=new set<id>();
            for(CQ_FLEX_SQX_Job_Function_Junction_Ob__c tfr:tS.Job_Functions__r)
            {                
                exsjfid.add(tfr.CQ_FLEX_SQX_Job_Function__c);
            }  
            allJfs.addAll(exsjfid);
            tsJfidMap.put(tS.id,exsjfid);
        }
        list<compliancequest__SQX_Job_Function__c> jFlist=[SELECT id,
                                                               (SELECT id,compliancequest__SQX_Personnel__c 
                                                                FROM compliancequest__SQX_Personnel_Job_Functions__r 
                                                                WHERE compliancequest__Active__c=true)
                                                               FROM compliancequest__SQX_Job_Function__c
                                                               WHERE id in: allJfs];
        for(compliancequest__SQX_Job_Function__c jf:jFlist)
        {
            list<id> personnelIdOfPjf=new list<id>();
            for(compliancequest__SQX_Personnel_Job_Function__c pjf:jf.compliancequest__SQX_Personnel_Job_Functions__r)
            {
                personnelIdOfPjf.add(pjf.compliancequest__SQX_Personnel__c);
            }
            jfidPersonnelIdsMap.put(jf.id,personnelIdOfPjf);
        }
        for(compliancequest__SQX_Training_Session__c tS:tSlist)
        {
            set<id> uniqPersonnelIds=new set<id>();
            set<id> tsjfids=tsJfidMap.get(tS.id);
            for(id tsjfid:tsjfids)
            {
              uniqPersonnelIds.addall(jfidPersonnelIdsMap.get(tsjfid));
            }
            for(id uniqPersonnelId:uniqPersonnelIds)
            {
                compliancequest__SQX_Training_Session_Roster__c tsr=new compliancequest__SQX_Training_Session_Roster__c();
                tsr.compliancequest__SQX_Personnel__c=uniqPersonnelId;
                tsr.compliancequest__SQX_Training_Session__c=tS.id;
                tsrlist.add(tsr);
            }            
            
        }
        insert tsrlist;      
    }
}