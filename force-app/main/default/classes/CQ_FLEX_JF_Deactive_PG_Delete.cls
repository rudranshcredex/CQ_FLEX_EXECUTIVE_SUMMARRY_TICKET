/********************************** Revision History **************************
*@description : Invocable apex class through Flow CQ FLEX Application Event PET Flow for Job function and Public Group
*
*1. [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Groups
*
********************************** Revision History **************************/
public without sharing class CQ_FLEX_JF_Deactive_PG_Delete {

    /**
     * @description method to process Group or Member Deletion
     * @param jfGroupId Public Group ids.
     */
    @InvocableMethod(Label='CQ FLEX Delete PG When JF Deactive' Description = 'Delete Public Group When Job function Deactive')
    public static void processPublicGroupDelete(List<Id> jfGroupId){
        List<Group> lstPGroup = [SELECT Id, Name 
                                 FROM Group
                                 WHERE id IN: jfGroupId];
        if(LstPGroup.size()>0){
            Database.delete(new List<Group>(lstPGroup));           
        }
    }
}