/********************************** Revision History **********************************************
*@description : Batch apex class When Personnel Job function Created then Public Group Member added
*
*1. [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Groups
*
********************************** Revision History ******************************************************/
@SuppressWarnings('PMD.EmptyCatchBlock')
global class CQ_FLEX_JobFunction_AddGroupMember_Batch implements Database.Batchable<sObject> {//NOPMD
        
  //Instance specific configurable variable for batch job name
  public String JOB_NAME = 'CQ FLEX-Job Function Group Member Processor';
  
  //Instance specific configurable variable for next schedule in minutes
  public Integer SCHEDULE_AFTER_MIN = 30;
  
  //this flag can be used in tests to disable rescheduling
  //for normal usage this value is always true, for tests it is set to false but can be changed
  public boolean RESCHEDULE = !Test.isRunningTest();
  /**
   * @description : when PJF is Created Group member added.
   * @param bc trigger list variable
   * @return query of records
   */
  global Database.QueryLocator start(Database.BatchableContext bc) 
  {
    DateTime lastHalfHour = DateTime.now().addMinutes(-30);
    DateTime now = DateTime.now();
    // collect the batches of Job Function records to be passed to execute 
    String query ='SELECT Id,compliancequest__Activation_Date__c,compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c,compliancequest__SQX_Job_Function__r.CQ_FLEX_IsGroup_Created__c,compliancequest__SQX_Job_Function__r.CQ_FLEX_Group_Id__c,compliancequest__Active__c FROM compliancequest__SQX_Personnel_Job_Function__c WHERE compliancequest__SQX_Job_Function__r.CQ_FLEX_IsGroup_Created__c = TRUE AND LastModifiedDate < : now AND LastModifiedDate >: lastHalfHour ORDER BY compliancequest__Activation_Date__c ASC';
    return Database.getQueryLocator(query);
  }
  /**
   * @description execute method to of batch apex
   * @param bc BatchableContext variable
   * @param scope Stores the records of start method returns
   */
  global void execute(Database.BatchableContext bc, List<sObject> scope) 
  {
    List<compliancequest__SQX_Personnel_Job_Function__c> lstJobFunction =  (List<compliancequest__SQX_Personnel_Job_Function__c>)scope;
    List<GroupMember> lstGroupMember = new List<GroupMember>();
    List<GroupMember> lstGrpMemberDelete = new List<GroupMember>();
    Set<Id> userId = new Set<Id>();
    Set<Id> groupId = new Set<Id>();
    Set<String> uniqueSet = new Set<String>();
    Map<String, Id> pjfNameUserId = new  Map<String, Id>();
      
      
    for(compliancequest__SQX_Personnel_Job_Function__c pjf:lstJobFunction){
      String uniqueUserIDGroupID = pjf.compliancequest__SQX_Job_Function__r.CQ_FLEX_Group_Id__c + pjf.compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c;
      if(pjf.compliancequest__Active__c==TRUE){
        GroupMember grpMember = new GroupMember();
        grpMember.GroupId= (Id)pjf.compliancequest__SQX_Job_Function__r.CQ_FLEX_Group_Id__c;
        grpMember.UserOrGroupId= pjf.compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c;
        lstGroupMember.add(grpMember);
        UniqueSet.add(uniqueUserIDGroupID);
      }else if(!UniqueSet.contains(uniqueUserIDGroupID)){
        userId.add(pjf.compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c);
        groupId.add(pjf.compliancequest__SQX_Job_Function__r.CQ_FLEX_Group_Id__c);
      }
  }
      lstGrpMemberDelete =[SELECT Id,GroupId, UserOrGroupId FROM GroupMember WHERE UserOrGroupId IN: userId AND GroupId IN: groupId];
     
      try {
        if(!lstGrpMemberDelete.isEmpty()){
            Delete lstGrpMemberDelete;
        }
        if(!lstGroupMember.isEmpty()){
            insert lstGroupMember; 
        }   
      }catch(Exception e) {
              //System.debug(e);//NOPMD
          }  
  }
  /**
   * @description finish method to of batch apex
   * @param bc BatchableContext variable
   */
  global void finish(Database.BatchableContext bc) 
  {
    if(RESCHEDULE)
    {
      System.scheduleBatch(this, this.JOB_NAME, SCHEDULE_AFTER_MIN);
    }
  }
}