/**
 * @description Handler Class for trigger CQ_FLEX_Training_Fulfilled_Requirements
 * [FLEX-41]-Training - Training Session continued
 */
public without sharing class CQ_FLEX_Training_Fulfilled_Requirement {
    
    /**
	* @description when a new document is added to Training Fulfilled Requirements
	* @param tFRRecord - contains Trigger.New instance
	*/
    public static void newDocumentAddedPopulateActiveJobFunctionsInJFRelatedListOfTS(List<compliancequest__SQX_Training_Fulfilled_Requirement__c> tFRRecord){
        
        set<id> tSIds=new set<id>();
        set<id> condocIds=new set<id>();
        map<id,list<id>>condocJfidMap=new map<id,list<id>>();
        map<id,set<id>>tsJfidMap=new map<id,set<id>>();
        map<id,compliancequest__SQX_Training_Session__c> tscondmap=new map<id,compliancequest__SQX_Training_Session__c>();
        set<id> tFRCondocIds=new set<id>();
        list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> newjflist=new list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c>();
        
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:tFRRecord)
        {
            tSIds.add(tfr.compliancequest__SQX_Training_Session__c);
        }
        
        list<compliancequest__SQX_Training_Session__c> tSlist=[SELECT id,compliancequest__SQX_Controlled_Document__c,
                                                               (SELECT id,CQ_FLEX_SQX_Job_Function__c,CQ_FLEX_SQX_Training_Session__c 
                                                                FROM Job_Functions__r)
                                                               FROM compliancequest__SQX_Training_Session__c
                                                               WHERE id in: tSIds];
        
        for(compliancequest__SQX_Training_Session__c ts:tSlist)
        {
            set<id> exsjfid=new set<id>();
            tscondmap.put(ts.id,ts);
            for(CQ_FLEX_SQX_Job_Function_Junction_Ob__c tfr:ts.Job_Functions__r)
            {                
                exsjfid.add(tfr.CQ_FLEX_SQX_Job_Function__c);
            }            
            tsJfidMap.put(ts.id,exsjfid);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:tFRRecord)
        {
            if(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c!=tfr.compliancequest__SQX_Controlled_Document__c){
                tFRCondocIds.add(tfr.compliancequest__SQX_Controlled_Document__c);
            }                
        }
        
        list<compliancequest__SQX_Controlled_Document__c> condoclist=[SELECT id,
                                                                      (SELECT id,compliancequest__SQX_Job_Function__c 
                                                                       FROM compliancequest__SQX_Requirements__r 
                                                                       WHERE compliancequest__Active__c=true) 
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE id in: tFRCondocIds];
        for(compliancequest__SQX_Controlled_Document__c condoc:condoclist )
        {
            list<id> reqjfid=new list<id>();
            
            for(compliancequest__SQX_Requirement__c req:condoc.compliancequest__SQX_Requirements__r)
            {
                reqjfid.add(req.compliancequest__SQX_Job_Function__c);
            }
            condocJfidMap.put(condoc.id,reqjfid);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c ts:tFRRecord)
        {
            list<id> jfid=condocJfidMap.get(ts.compliancequest__SQX_Controlled_Document__c);
            set<id> exjfids=tsJfidMap.get(ts.compliancequest__SQX_Training_Session__c);
            if(jfid!=null){
                for(id jf:jfid)
                {
                    if(!exjfids.contains(jf))
                    {
                        CQ_FLEX_SQX_Job_Function_Junction_Ob__c newjf=new CQ_FLEX_SQX_Job_Function_Junction_Ob__c();
                        newjf.CQ_FLEX_SQX_Job_Function__c=jf;
                        newjf.CQ_FLEX_SQX_Training_Session__c=ts.compliancequest__SQX_Training_Session__c;
                        newjflist.add(newjf);
                    }
                }  
            }
            
        }        
        insert newjflist;        
    }
    

    /**
	* @description If a Training Fulfilled Requirement is edited, a document is replaced with new document
	* @param tFRRecord - contains Trigger.New instance
	* @param oldTFRRecord - contains Trigger.old instance
	* @param oldMapTFRRecord - contains Trigger.old map instance
	*/
    public static void newDocumentUpdatedPopulateActiveJobFunctionsInJFRelatedListOfTS(List<compliancequest__SQX_Training_Fulfilled_Requirement__c> tFRRecord,List<compliancequest__SQX_Training_Fulfilled_Requirement__c> oldTFRRecord,map<id,compliancequest__SQX_Training_Fulfilled_Requirement__c> oldMapTFRRecord)
    {
        set<id> tSIds=new set<id>();
        set<id> oldCondocIds=new set<id>();       
        set<id> tFRCondocIds=new set<id>();
        set<id> oldjfdel=new set<id>();
        map<id,list<id>>condocJfidMap=new map<id,list<id>>();
        map<id,set<id>>tscondocidMap=new map<id,set<id>>();
        map<id,compliancequest__SQX_Training_Session__c> tscondmap=new map<id,compliancequest__SQX_Training_Session__c>();
        map<id,set<id>>tsJfidMap=new map<id,set<id>>();
        list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> newjflist=new list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c>();
        list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> oldjflist=new list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c>();
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:tFRRecord)
        {
            tSIds.add(tfr.compliancequest__SQX_Training_Session__c);
        }
        
        list<compliancequest__SQX_Training_Session__c> tSlist=[SELECT id,compliancequest__SQX_Controlled_Document__c,
                                                               (SELECT id,CQ_FLEX_SQX_Job_Function__c,CQ_FLEX_SQX_Training_Session__c 
                                                                FROM Job_Functions__r),
                                                               (SELECT id,compliancequest__SQX_Controlled_Document__c
                                                                FROM compliancequest__SQX_Training_Fulfilled_Requirements__r)
                                                               FROM compliancequest__SQX_Training_Session__c
                                                               WHERE id in: tSIds];
        
        for(compliancequest__SQX_Training_Session__c ts:tSlist)
        {
            set<id> exsjfid=new set<id>();
            set<id> exsconidtfr=new set<id>();
            tscondmap.put(ts.id,ts);
            for(CQ_FLEX_SQX_Job_Function_Junction_Ob__c tfr:ts.Job_Functions__r)
            {                
                exsjfid.add(tfr.CQ_FLEX_SQX_Job_Function__c);
            }            
            tsJfidMap.put(ts.id,exsjfid);
            for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:ts.compliancequest__SQX_Training_Fulfilled_Requirements__r)
            {     
                if(oldMapTFRRecord.get(tfr.id)==null){
                    exsconidtfr.add(tfr.compliancequest__SQX_Controlled_Document__c);
                }                    
            }  
            tscondocidMap.put(ts.id,exsconidtfr);
            tFRCondocIds.addAll(exsconidtfr);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:tFRRecord)
        {    
            
            if(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c!=tfr.compliancequest__SQX_Controlled_Document__c){
                tFRCondocIds.add(tfr.compliancequest__SQX_Controlled_Document__c);
            } 
            if(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c!=oldMapTFRRecord.get(tfr.id).compliancequest__SQX_Controlled_Document__c){
                tFRCondocIds.add(oldMapTFRRecord.get(tfr.id).compliancequest__SQX_Controlled_Document__c);
            }
            tFRCondocIds.add(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c);
        }
        
        list<compliancequest__SQX_Controlled_Document__c> condoclist=[SELECT id,name,
                                                                      (SELECT id,compliancequest__SQX_Job_Function__c 
                                                                       FROM compliancequest__SQX_Requirements__r 
                                                                       WHERE compliancequest__Active__c=true) 
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE id in: tFRCondocIds];
        
        for(compliancequest__SQX_Controlled_Document__c condoc:condoclist )
        {
            list<id> reqjfid=new list<id>();
            for(compliancequest__SQX_Requirement__c req:condoc.compliancequest__SQX_Requirements__r)
            {
                reqjfid.add(req.compliancequest__SQX_Job_Function__c);
            }
            
            condocJfidMap.put(condoc.id,reqjfid);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c ts:tFRRecord)
        {            
            set<id> exjsoftfr=new set<id>();
            list<id> jfid=condocJfidMap.get(ts.compliancequest__SQX_Controlled_Document__c); 
            set<id> exTsTfrConids=tscondocidMap.get(ts.compliancequest__SQX_Training_Session__c);            
            set<id> exTSjfids=tsJfidMap.get(ts.compliancequest__SQX_Training_Session__c);
            list<id> oldjfidlist=condocJfidMap.get(oldMapTFRRecord.get(ts.id).compliancequest__SQX_Controlled_Document__c); 
            list<id> parentjfidlist=condocJfidMap.get(tscondmap.get(ts.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c);
            if(jfid!=null)
            {
                for(id jf:jfid)
                {
                    
                    if(!exTSjfids.contains(jf))
                    {                    
                        CQ_FLEX_SQX_Job_Function_Junction_Ob__c newjf=new CQ_FLEX_SQX_Job_Function_Junction_Ob__c();
                        newjf.CQ_FLEX_SQX_Job_Function__c=jf;
                        newjf.CQ_FLEX_SQX_Training_Session__c=ts.compliancequest__SQX_Training_Session__c;
                        newjflist.add(newjf);               
                        
                    }
                }
            }
            for(id exts:exTsTfrConids)
            {
                exjsoftfr.addall(condocJfidMap.get(exts));
            }
            set<id> exdeletejfis =new set<id>();
            exdeletejfis.addAll(exjsoftfr);
            exdeletejfis.addAll(jfid);
            exdeletejfis.addAll(parentjfidlist);
            if(oldjfidlist!=null){
                for(id oldjf:oldjfidlist)
                {
                    if(!exdeletejfis.contains(oldjf))
                    {
                        oldjfdel.add(oldjf);  
                    }                    
                    
                }
            }
        }
        list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jftodelete=[SELECT id 
                                                                  FROM CQ_FLEX_SQX_Job_Function_Junction_Ob__c
                                                                  WHERE CQ_FLEX_SQX_Job_Function__c in: oldjfdel 
                                                                  AND CQ_FLEX_SQX_Training_Session__c in: tSIds];
        
        delete jftodelete;
        insert newjflist;
    }
    

    /**
	* @description If a Document is Deleted from the Training Fulfilled Requirements
	* @param oldTFRRecord - contains Trigger.old instance
	* @param oldMapTFRRecord - contains Trigger.old map instance
	*/
    public static void newDocumentDeletedActiveJobFunctionsInJFRelatedListOfTSToBeDeleted(List<compliancequest__SQX_Training_Fulfilled_Requirement__c> oldTFRRecord,map<id,compliancequest__SQX_Training_Fulfilled_Requirement__c> oldMapTFRRecord)
    {
        set<id> tSIds=new set<id>();
        set<id> tFRCondocIds=new set<id>();
        set<id> oldjfdel=new set<id>();
        map<id,list<id>>condocJfidMap=new map<id,list<id>>();
        map<id,compliancequest__SQX_Training_Session__c> tscondmap=new map<id,compliancequest__SQX_Training_Session__c>();
        map<id,set<id>>tscondocidMap=new map<id,set<id>>();
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:oldTFRRecord)
        {
            tSIds.add(tfr.compliancequest__SQX_Training_Session__c);
        }
        
        list<compliancequest__SQX_Training_Session__c> tSlist=[SELECT id,compliancequest__SQX_Controlled_Document__c
                                                               ,(SELECT id,compliancequest__SQX_Controlled_Document__c
                                                                 FROM compliancequest__SQX_Training_Fulfilled_Requirements__r)
                                                               FROM compliancequest__SQX_Training_Session__c
                                                               WHERE id in: tSIds];
        
        for(compliancequest__SQX_Training_Session__c ts:tSlist)
        {            
            set<id> exsconidtfr=new set<id>();
            tscondmap.put(ts.id,ts);
            for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:ts.compliancequest__SQX_Training_Fulfilled_Requirements__r)
            {     
                if(oldMapTFRRecord.get(tfr.id)==null){
                    exsconidtfr.add(tfr.compliancequest__SQX_Controlled_Document__c);
                }                    
            }  
            tscondocidMap.put(ts.id,exsconidtfr);
            tFRCondocIds.addAll(exsconidtfr);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:oldTFRRecord)
        {    
            
            if(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c!=tfr.compliancequest__SQX_Controlled_Document__c)
            {
                tFRCondocIds.add(tfr.compliancequest__SQX_Controlled_Document__c);
            }

            tFRCondocIds.add(tscondmap.get(tfr.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c);
        }
        
        list<compliancequest__SQX_Controlled_Document__c> condoclist=[SELECT id,name,
                                                                      (SELECT id,compliancequest__SQX_Job_Function__c 
                                                                       FROM compliancequest__SQX_Requirements__r 
                                                                       WHERE compliancequest__Active__c=true) 
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE id in: tFRCondocIds];
        
        for(compliancequest__SQX_Controlled_Document__c condoc:condoclist )
        {
            list<id> reqjfid=new list<id>();
            for(compliancequest__SQX_Requirement__c req:condoc.compliancequest__SQX_Requirements__r)
            {
                reqjfid.add(req.compliancequest__SQX_Job_Function__c);
            }
            
            condocJfidMap.put(condoc.id,reqjfid);
        }
        
        for(compliancequest__SQX_Training_Fulfilled_Requirement__c ts:oldTFRRecord)
        {   
            set<id> exjsoftfr=new set<id>();
            list<id> jfid=condocJfidMap.get(ts.compliancequest__SQX_Controlled_Document__c);
            set<id> exTsTfrConids=tscondocidMap.get(ts.compliancequest__SQX_Training_Session__c);
            for(id exts:exTsTfrConids)
            {
                exjsoftfr.addall(condocJfidMap.get(exts));
            }
            list<id> parentjfidlist=condocJfidMap.get(tscondmap.get(ts.compliancequest__SQX_Training_Session__c).compliancequest__SQX_Controlled_Document__c);
            set<id> exdeletejfis =new set<id>();
            exdeletejfis.addAll(exjsoftfr);
            exdeletejfis.addAll(parentjfidlist);
            if(jfid!=null){
                for(id oldjf:jfid)
                {
                    if(!exdeletejfis.contains(oldjf))
                    {
                        oldjfdel.add(oldjf);  
                    } 
                }   
            }            
        }
        list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jftodelete=[SELECT id 
                                                                  FROM CQ_FLEX_SQX_Job_Function_Junction_Ob__c
                                                                  WHERE CQ_FLEX_SQX_Job_Function__c in: oldjfdel 
                                                                  AND CQ_FLEX_SQX_Training_Session__c in: tSIds];
        
        delete jftodelete;        
        
    }    
}