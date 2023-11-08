/********************************** Revision History **************************
 * @description
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Class includes common method used in modules
 * 2.[FLEX-101] Documents - Submitted Document Rejected email template - Fields missing + email recipients
 ********************************** Revision History **************************/
@SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
@isTest
public class CQ_CCC_Test_Generic_CS {
    
    private static Map<String, List<String>> profilePermissionSetsMap = new Map<String, List<String>>{
        'CQ Standard Platform User' => new List<String>{'CQ_Standard_Extended_Permissions','CQ_Standard_User','CQ_FLEX_Document_Owner_PS','CQ_FLEX_Document_Admin_PS','CQ_FLEX_Controlled_Document_Permission_Set', 'CQ_FLEX_Training_Admin_PS'},
        'CQ Standard Platform User Not Training Admin' => new List<String>{'CQ_Standard_Extended_Permissions','CQ_Standard_User','CQ_FLEX_Controlled_Document_Permission_Set'},
        'System Administrator' => new List<String>{'CQ_Admin_Extended_Permissions','CQ_System_Administrator','CQ_FLEX_Document_Admin_PS'}
    };
    
    /**
     * @description create user according to the profile name
     * @param profileName profile Name variable
	 * @return createdUser
     */ 
    public static User createUser(String profileName){
        String randomNumber = string.valueOf(system.currentTimeMillis());  
        Boolean notTAdmin=false;
        if(profileName=='CQ Standard Platform User Not Training Admin'){
            profileName='CQ Standard Platform User';
            notTAdmin=true;
        } 
        List<Profile> profiles = new List<Profile>();
        profiles = [SELECT ID FROM Profile WHERE Name =: profileName];
        System.assert(!profiles.isEmpty(), 'Profile should not be empty '+profiles);
        User user = new User();
        user.Username = string.format('cqtest{0}-{1}-{2}@test.cq.com', new list<string>{profileName.deleteWhitespace(),randomnumber});
        user.Email = 'a' + randomNumber + '@test' + randomNumber + '.com';
        user.FirstName =  'abc' + randomNumber;
        user.LastName = ''+randomNumber;
        user.CommunityNickname = ''+ randomNumber;
        user.ProfileId = profiles[0].id;
        user.Alias =  randomNumber.mid(4,6);
        user.EmailEncodingKey = 'UTF-8';
        user.LanguageLocaleKey = 'en_US';
        user.LocaleSidKey = 'en_US';
        user.TimeZoneSidKey = 'America/Los_Angeles';
        user.IsActive=true;
        user.Country = 'Nepal';
        insert user;
        if(profilePermissionSetsMap.containsKey(profileName)){
            if(notTAdmin){
                profileName='CQ Standard Platform User Not Training Admin';
            }
            List<PermissionSet> permissionSets = [SELECT ID FROM PermissionSet WHERE Name IN: profilePermissionSetsMap.get(profileName)];
            List<PermissionSetAssignment> lstPSA = new list<PermissionSetAssignment>();
            for (permissionSet ps:  permissionSets){
                PermissionSetAssignment  psa = new PermissionSetAssignment(AssigneeId=user.Id, PermissionSetId=ps.Id);
                lstPSA.add(psa);
            }
            insert lstPSA;
        }
        return user;
    }
    
    /**
     * @description create users in bulk according to the profile name and number of user
     * @param profileName profile Name variable
     * @param count count variable.
	 * @return list of Users.
     */ 
    public static List<user> createUser(String profileName, Integer count){
        String randomNumber = string.valueOf(system.currentTimeMillis());   
        List<Profile> profiles = new List<Profile>();
        profiles = [SELECT ID FROM Profile WHERE Name =: profileName];
        System.assert(!profiles.isEmpty(), 'Profile should be be empty '+profiles);
        //List<Role> roles = [select id from userrole where name='CQ User' LIMIT 1];
        //System.assert(!roles.isEmpty(), 'UserRole should be be empty '+roles);
        User user;
        List<User> userList = new List<User>();
        for (Integer i = 1;i <= count; i++){
            user = new User();
            user.Username = string.format('cqtest{0}-{1}-{2}@test.cq.com', new list<string>{profileName.deleteWhitespace(),string.valueof(i),randomnumber});
            user.Email = 'a' + randomNumber + '@test' + randomNumber + '.com';
            user.FirstName =  'abc' + randomNumber;
            user.LastName = i+''+randomNumber;
            user.CommunityNickname = i+''+ randomNumber;
            user.ProfileId = profiles[0].id;
            //user.UserRoleId = roles[0].Id;
            
            user.Alias =  randomNumber.mid(4,6)+i;
            user.EmailEncodingKey = 'UTF-8';
            user.LanguageLocaleKey = 'en_US';
            user.LocaleSidKey = 'en_US';
            user.TimeZoneSidKey = 'America/Los_Angeles';
            user.IsActive=true;
            userList.add(user);
        }
        insert userList;

        if(profilePermissionSetsMap.containsKey(profileName)){
            List<PermissionSet> permissionSets = [SELECT ID FROM PermissionSet WHERE Name IN: profilePermissionSetsMap.get(profileName)];
            List<PermissionSetAssignment> lstPSA = new list<PermissionSetAssignment>();
            
            for(User usr: userList){
                for (permissionSet ps:  permissionSets){
                    PermissionSetAssignment  psa =   new PermissionSetAssignment(AssigneeId=usr.Id, PermissionSetId=ps.Id);
                    lstPSA.add(psa);
                }
            }
            insert lstPSA;
        }

        return userList;
    }
    
    /**
     * @description method to get user bulk users based on profile name and user number
     * @param profileName profile Name variable
     * @param userNumber  user Number variable
	 * @return user
     */ 
    public static user getUser(String profileName,integer userNumber){
        string usrName = string.format('cqtest{0}-{1}%', new list<string>{profileName.deleteWhitespace(),string.valueof(userNumber)});
        List<User> usrs = [SELECT id FROM user WHERE username LIKE: usrName LIMIT 1];
        System.assert(!usrs.isEmpty(), 'No User found with given '+profileName+' profile name');
        return usrs[0];
    }
    
    /**
     * @description Create Account.
	 * @return Account
     */ 
    public static Account createAccount(){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        Account acc = new Account(
        Name = randomNumber+'Test Account'
        );
        insert acc;
        return acc;
    }
    
    /**
     * @description Create Contact
     * @param acc variable for acc id
	 * @return Contact
     */ 
    public static Contact createContact(Id acc){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        Contact cont = new Contact(
            AccountId = acc,
            Email = 'ab.test@compliancequest.com',
            LastName = randomNumber+'test',
            FirstName = 'First',
            Title = 'Test Title',
            Phone = '1234567890'
        );
        insert cont;
        return cont; 
    }
    
    /**
     * @description method to create personnel record 
     * @param users
	 * @return personnel record
     */ 
    public static List<compliancequest__SQX_Personnel__c> createPersonnels(List<User> users) {
        List<compliancequest__SQX_Personnel__c> personnels = new List<compliancequest__SQX_Personnel__c>();
        compliancequest__SQX_Personnel__c personnel;
        Integer randomNumber;
        Map<id,String> useridNameMap=new Map<id,String>();
        set<id> uid=new set<id>();
        
        for(User u: users)
        {
            uid.add(u.id);
        }
        
        for(user us:[select id,name from user where id in: uid]){
            useridNameMap.put(us.id,us.name);
        }
        for(User u: users){
            personnel = new compliancequest__SQX_Personnel__c();
            randomNumber = (Integer)( Math.random() * 1000000 );
            
            personnel.compliancequest__Full_Name__c = useridNameMap.get(u.id);
            personnel.compliancequest__Identification_Number__c = randomNumber+'abc';
            personnel.compliancequest__Active__c = true;
            personnel.compliancequest__SQX_User__c = u.Id;
            personnels.add(personnel);
        }
        
        insert personnels;

        return personnels;
    }
   
    
    /**
     * @description method to create job function record and set its active status
     * @param jfName Job Function name.
     * @param isActive boolean variable.
     * @param noCommitToDb boolean variable.
	 * @return Job Function 
     */ 
    public static compliancequest__SQX_Job_Function__c createJobFunction(String jfName, Boolean isActive,Boolean noCommitToDb){
        compliancequest__SQX_Job_Function__c jobFunction = new compliancequest__SQX_Job_Function__c();
        jobFunction.Name = jfName;        
        jobFunction.compliancequest__Active__c = isActive;
        

        if(!noCommitToDb){insert jobFunction;}    

        return jobFunction;
    }
    
    /**
     * @description method to create personnel job function record and set its active status
     * @param jobFunctionId job Function Id
     * @param personnels Personnel record list variable
     * @param isActive boolean variable.
	 * @return 
     */ 
    public static List<compliancequest__SQX_Personnel_Job_Function__c> createPersonnelJobFunctions(Id jobFunctionId, List<compliancequest__SQX_Personnel__c> personnels, Boolean isActive){
        List<compliancequest__SQX_Personnel_Job_Function__c> pjfList = new List<compliancequest__SQX_Personnel_Job_Function__c>();
        compliancequest__SQX_Personnel_Job_Function__c pjf;
        for(compliancequest__SQX_Personnel__c personnel: personnels){
            pjf = new compliancequest__SQX_Personnel_Job_Function__c();
            pjf.compliancequest__SQX_Personnel__c = personnel.Id;
            pjf.compliancequest__SQX_Job_Function__c = jobFunctionId;
            pjf.compliancequest__Active__c = isActive;
            pjfList.add(pjf);
        }
        
        insert pjfList;

        return pjfList;
    }
    
    /**
     * @description method to create part Family
	 * @return PartFamily
     */ 
    public static compliancequest__SQX_Part_Family__c createPartFamily(){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        compliancequest__SQX_Part_Family__c partFamily = new compliancequest__SQX_Part_Family__c (
            Name = randomNumber+'Default Part Family' 
        );
        upsert partFamily name;
        return partFamily;   
    }

    /**
     * @description method to create part
     * @param partFamilyId Part_Family id
	 * @return Part
     */ 
    public static compliancequest__SQX_Part__c createPart(Id partFamilyId){
        if (string.isblank(partFamilyId)){partFamilyId = createPartFamily().id;}
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        compliancequest__SQX_Part__c part = new compliancequest__SQX_Part__c  (
            Name = randomNumber+'Default Part',
            compliancequest__Part_Number__c = randomNumber+'Default Part Number',
            compliancequest__Part_Risk_Level__c = 1,
            compliancequest__Active__c = true,
            compliancequest__Part_Family__c = partFamilyId
        );
        upsert part name;
        return part;
    }
    
    /**
     * @description This method adds department
     * @param departmentName department name
	 * @return Department
     */ 
     public static compliancequest__SQX_Department__c createDepartment(String departmentName){       
        //ARRANGE: Create and insert Department and retrieve department id
        compliancequest__SQX_Department__c department1 = new compliancequest__SQX_Department__c (
            Name = departmentName
        );
        insert department1;       
        return department1;
    } 
       
    /**
     * @description This method adds standard service
	 * @return Standard_Service
     */ 
    public static compliancequest__SQX_Standard_Service__c createService(){
        //Arrange: Create and insert Standard Services
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        compliancequest__SQX_Standard_Service__c service = new compliancequest__SQX_Standard_Service__c (
            Name = randomNumber+'Service 101'
        );
        insert service;
        return service;
    }

    /**
     * @description This method adds Division.
     * @param name
	 * @return Division
     */ 
    public static compliancequest__SQX_Division__c setupTestDivision(String name){
        //Arrange : Created Division.
        compliancequest__SQX_Division__c div = new compliancequest__SQX_Division__c(
            Name = name
        );
        insert div;
        return div;
    }

}