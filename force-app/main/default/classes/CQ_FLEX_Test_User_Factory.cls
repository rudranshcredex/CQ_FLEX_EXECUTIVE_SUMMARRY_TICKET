/**
 * @description This class creates an User with different profiles
 */
@isTest
public class CQ_FLEX_Test_User_Factory implements CQ_CCC_Test_SObject_Factory {
    
    /**
     * @description Method to invoke another method to create user based on the data code
     * @param dataCode 
     * @return Map
     */
    public Map<String,SObject> constructData(String dataCode) {        
        switch on dataCode {
            when 'users-adminandstandard' {  return createUserWithProfileStandardAndAdmin(); }
            when 'users-standardandroleQuality' {   return createUserWithProfileStandardAndRole('Quality'); }
            when 'users-standardandroleGCM' {   return createUserWithProfileStandardAndRole('GCM'); }
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
       return new Map<String,SObject>();
    }
    
    /**
     * @description Data Tree
     * @return list of users
     * Data Tree:
     * --------
     * User 1 (Admin)
     *    Contact (null)
     *    Permission set name (PROFILE_TYPE_CUSTOMER_ADMIN -> CQ_System_Administrator)
     *
     * User 2 (Standard)
     *      Contact (null)
     *      Permission set name (PROFILE_TYPE_CUSTOMER -> CQ_Standard_User) 
     *
     * User 3 (Standard)
     *      Contact (null)
     *      Permission set name (PROFILE_TYPE_CUSTOMER -> CQ_Standard_User)
     *
     * User 4 (Standard)
     *      Contact (null)
     *      Permission set name (PROFILE_TYPE_CUSTOMER -> CQ_Standard_User) 
     */
    public Map<String,SObject> createUserWithProfileStandardAndAdmin(){
        
        Integer adminIdentifier = (Integer)( Math.random() * 1000000 );

        Map<String, Id> profileIdsByName = new Map<String, Id>();

        UserRole role  = new UserRole(Name = 'CEO' +'USR-000001');
        insert role;         
        
        for(Profile prof : [SELECT ID, Name FROM Profile WHERE Name = : 'System Administrator' OR Name  = 'Standard User' OR Name  = 'CQ Standard Platform User']) {
            profileIdsByName.put(prof.Name, prof.Id);
        }
        
        User adminUser = new User();
        adminUser.Username =  'a' + adminIdentifier + '@test' + adminIdentifier + '.com';
        adminUser.Email = 'a' + adminIdentifier + '@test' + adminIdentifier + '.com';
        adminUser.FirstName = 'Admin User 1';
        adminUser.LastName = 'a' + adminIdentifier;
        adminUser.CommunityNickname = 's' + adminIdentifier;
        adminUser.ProfileId = profileIdsByName.get('System Administrator');
        adminUser.CQ_FLEX_Sites__c='ALT - Althofen';
        adminUser.Alias =  '' + adminIdentifier;
        adminUser.EmailEncodingKey = 'UTF-8';
        adminUser.LanguageLocaleKey = 'en_US';
        adminUser.LocaleSidKey = 'en_US';
        adminUser.TimeZoneSidKey = 'America/Los_Angeles';
        adminUser.AboutMe = 'CQ_System_Administrator:'+'Admin user 1';
        adminUser.UserRoleId = role.Id;

        List<User> userList = new List<User>();
        userList.add(adminUser);
         
        for(integer i=0; i<3; i++) {
            User standardUser = new User();
            Integer standardIdentifier = (Integer)( Math.random() * 1000000 );
            standardUser.Username =  'a' + standardIdentifier + '@test' + standardIdentifier + '.com';
            standardUser.Email = 'a'+ standardIdentifier + '@test' + standardIdentifier + '.com';
            standardUser.FirstName = 'Standard User '+ (i+1);
            standardUser.LastName = 'a' + standardIdentifier;
            standardUser.CommunityNickname = 's' + standardIdentifier;
            standardUser.ProfileId = profileIdsByName.get('Standard User');
            standardUser.Alias =  '' + standardIdentifier;
            standardUser.EmailEncodingKey = 'UTF-8';
            standardUser.LanguageLocaleKey = 'en_US';
            standardUser.LocaleSidKey = 'en_US';
            standardUser.TimeZoneSidKey = 'America/Los_Angeles';
            standardUser.AboutMe = 'CQ_Standard_User:'+'Admin user 1';
            standardUser.UserRoleId = role.Id;
            standardUser.CQ_FLEX_Sites__c='ALT - Althofen';
            userList.add(standardUser);
        }
        for(integer i=0; i<2; i++) {
           User standardPlatformUser = new User();
           Integer standardIdentifier = (Integer)( Math.random() * 1000000 );
           standardPlatformUser.Username =  'a' + standardIdentifier + '@test' + standardIdentifier + '.com';
           standardPlatformUser.Email = 'a'+ standardIdentifier + '@test' + standardIdentifier + '.com';
           standardPlatformUser.FirstName = 'CQ Standard Platform User '+ (i+1);
           standardPlatformUser.LastName = 'a' + standardIdentifier;
           standardPlatformUser.CommunityNickname = 's' + standardIdentifier;
           standardPlatformUser.ProfileId = profileIdsByName.get('CQ Standard Platform User');
           standardPlatformUser.Alias =  '' + standardIdentifier;
           standardPlatformUser.EmailEncodingKey = 'UTF-8';
           standardPlatformUser.LanguageLocaleKey = 'en_US';
           standardPlatformUser.LocaleSidKey = 'en_US';
           standardPlatformUser.TimeZoneSidKey = 'America/Los_Angeles';
           standardPlatformUser.AboutMe = 'CQ_Standard_User:'+'Standard Platform User';
           standardPlatformUser.UserRoleId = role.Id;
           standardPlatformUser.CQ_FLEX_Sites__c='ALT - Althofen';
           userList.add(standardPlatformUser);
       }
        for(integer i=0; i<1; i++) {
           User standardPlatformUser = new User();
           Integer standardIdentifier = (Integer)( Math.random() * 1000000 );
           standardPlatformUser.Username =  'a' + standardIdentifier + '@test' + standardIdentifier + '.com';
           standardPlatformUser.Email = 'a'+ standardIdentifier + '@test' + standardIdentifier + '.com';
           standardPlatformUser.FirstName = 'CQ Standard Platform User '+ 3;
           standardPlatformUser.LastName = 'a' + standardIdentifier;
           standardPlatformUser.CommunityNickname = 's' + standardIdentifier;
           standardPlatformUser.ProfileId = profileIdsByName.get('CQ Standard Platform User');
           standardPlatformUser.Alias =  '' + standardIdentifier;
           standardPlatformUser.EmailEncodingKey = 'UTF-8';
           standardPlatformUser.LanguageLocaleKey = 'en_US';
           standardPlatformUser.LocaleSidKey = 'en_US';
           standardPlatformUser.TimeZoneSidKey = 'America/Los_Angeles';
           standardPlatformUser.AboutMe = 'CQ_Standard_User:'+'Standard Platform User';
           standardPlatformUser.UserRoleId = role.Id;
           standardPlatformUser.CQ_FLEX_Sites__c='AUR - Austin';
           userList.add(standardPlatformUser);
       }
       
       insert userList;
        
       List<String> stdPermissionList = new List<String>{'CQ_Standard_Extended_Permissions','CQ_Standard_User','CQ_FLEX_Document_Admin_PS','CQ_Migration_User'};
       List<PermissionSet> permissionSetList = [SELECT Id,name FROM PermissionSet WHERE Name IN : stdPermissionList];
       List<PermissionSetAssignment> lstPSA = new list<PermissionSetAssignment>();
       for (permissionSet ps:  permissionSetList){
           if(ps.name!='CQ_Migration_User'){
               for(User usrList: userList){  
                   PermissionSetAssignment  psa = new PermissionSetAssignment(AssigneeId=usrList.Id, PermissionSetId=ps.Id);
                   lstPSA.add(psa);               
               }
           }  
           else{
               PermissionSetAssignment  psa = new PermissionSetAssignment(AssigneeId=userList[5].Id, PermissionSetId=ps.Id);
               lstPSA.add(psa); 
           }
       }
        
       insert lstPSA;
              
        
       return new Map<String, SObject> {
           'Admin User 1' => userList[0],
           'Standard User 1' => userList[1],
           'Standard User 2' => userList[2],
           'Standard User 3' => userList[3],
           'CQ Standard Platform User 1' => userList[4],
           'CQ Standard Platform User 2' => userList[5],
           'CQ Standard Platform User 3' => userList[6]
       };
   } 
    
    /**
     * @description Data Tree for Standard user with defined role
     * @param roleName
     * @return list of users
     * Data Tree:
     * --------
     * User 3 (Standard)
     *      Contact (null)
     *      Permission set name (PROFILE_TYPE_CUSTOMER -> CQ_Standard_User)
     *
     */
    public Map<String,SObject> createUserWithProfileStandardAndRole(String roleName){        
        

        Map<String, Id> profileIdsByName = new Map<String, Id>();

        UserRole role  = new UserRole(Name = roleName);
        insert role;         
        
        for(Profile prof : [SELECT ID, Name FROM Profile WHERE Name  = 'CQ Standard Platform User']) {
            profileIdsByName.put(prof.Name, prof.Id);
        }
        

        List<User> userList = new List<User>();
         
        for(integer i=0; i<1; i++) {
            User standardUser = new User();
            Integer standardIdentifier = (Integer)( Math.random() * 1000000 );
            standardUser.Username =  'a' + standardIdentifier + '@test' + standardIdentifier + '.com';
            standardUser.Email = 'a'+ standardIdentifier + '@test' + standardIdentifier + '.com';
            standardUser.FirstName = 'CQ Standard Platform User '+ roleName + (i+1);
            standardUser.LastName = 'a' + standardIdentifier;
            standardUser.CommunityNickname = 's' + standardIdentifier;
            standardUser.ProfileId = profileIdsByName.get('CQ Standard Platform User');
            standardUser.Alias =  '' + standardIdentifier;
            standardUser.EmailEncodingKey = 'UTF-8';
            standardUser.LanguageLocaleKey = 'en_US';
            standardUser.LocaleSidKey = 'en_US';
            standardUser.TimeZoneSidKey = 'America/Los_Angeles';
            standardUser.AboutMe = 'CQ_Standard_User:'+'Admin user 1';
            standardUser.UserRoleId = role.Id;
            userList.add(standardUser);
        }
        
        insert userList;
        
        List<String> stdPermissionList = new List<String>{'CQ_Standard_Extended_Permissions','CQ_Standard_User'};
        if(roleName=='GCM'){
            stdPermissionList.add('CQ_FLEX_GCM_Global_Permission');
        }
        if(roleName=='Quality'){
            stdPermissionList.add('CQ_FLEX_Quality_Permission');
        }
        List<PermissionSet> permissionSetList = [SELECT Id FROM PermissionSet WHERE Name IN : stdPermissionList];
        List<PermissionSetAssignment> lstPSA = new list<PermissionSetAssignment>();
        for (permissionSet ps:  permissionSetList){
            for(User usrList: userList){
                PermissionSetAssignment  psa = new PermissionSetAssignment(AssigneeId=usrList.Id, PermissionSetId=ps.Id);
                lstPSA.add(psa);
            }
        }
        insert lstPSA;
               
         
        return new Map<String, SObject> {             
            'CQ Standard Platform User'+roleName+'1' => userList[0]
        };
    } 
}