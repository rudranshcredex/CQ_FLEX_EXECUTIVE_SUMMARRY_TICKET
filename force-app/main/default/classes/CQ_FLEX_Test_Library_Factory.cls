/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Library access
 * [FLEX-470] : Refactor | Refactor the following unit test to optimize the execution time.
 ***************************REVISION HISTORY **********************/
/**
 * @description This class includes data set related to Library access
 */
@SuppressWarnings('PMD.AvoidSoqlInLoops')
public with sharing class CQ_FLEX_Test_Library_Factory {
    
   	/**
     * @description  Method to create Libraries 
     */ 
    public static void createLibrary(){        
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1]; 
        //Add access to libraries
        List<ContentWorkspaceMember> contentWorkspaceMemberadd = new list<ContentWorkspaceMember>();
        
        for(ContentWorkspace cw:[SELECT Id, Name FROM ContentWorkspace])
        {
            for(ContentWorkspacePermission cwp:[SELECT Id, Name FROM ContentWorkspacePermission]){
                contentWorkspaceMemberadd.add(new ContentWorkspaceMember(ContentWorkspaceId = cw.id,
                                                                         ContentWorkspacePermissionId=cwp.id,
                                                                         MemberId=stdUser.Id));   
            }                
        }
        if(!contentWorkspaceMemberadd.isEmpty() && contentWorkspaceMemberadd != null) {
            Database.upsert(contentWorkspaceMemberadd, false);
        } 
    }     
}