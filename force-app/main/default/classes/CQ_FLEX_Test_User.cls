/********************************** Revision History **************************
 * 1.[FLEX-165] User Record configuration
 *   Validation Rule : CQ_FLEX_Restrict_Username_Change
 *-----------------------------------------------------------------------------
 * 2.[FLEX-165] User Record configuration
 *   Validation Rule : CQ_FLEX_Restrict_Name_Email_Change
 *-----------------------------------------------------------------------------
 * 3.[FLEX-196] User Record configuration + JFs to PGs User creation/removal
 *   Validation Rule : CQ_FLEX_Restrict_Department_NonEditable
 *-----------------------------------------------------------------------------
 **/
@isTest
/**
* @description  Test class for Nonconformance record
*/
public class CQ_FLEX_Test_User{

    /*
     * Given            : A User Record update
     * When             : System Admin changes Username for Active user
     * Then             : Throw Validation Error
     * Validation Rule  : CQ_FLEX_Restrict_Username_Change
	 * Story            : [FLEX-165] User Record configuration
     * @description Test method for Validation Rule CQ_FLEX_Restrict_Username_Change 
	 */
    @isTest
    public static void givenUserRecord_WhenSysAdminUpdateUserName_ThenThrowValidationError(){
        //Arrange : Create System Administrator
        User sysAdminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        
        System.runAs(sysAdminUser){
            
            //Act: Update UserName
            sysAdminUser.Username = 'Test@cq.com';
            Database.SaveResult resultUpdate =Database.update(sysAdminUser, false);
            
            //Assert : Check the Validation Error
            system.assertEquals(false, resultUpdate.isSuccess(),'Username was Changed');    
        }
    }

    /*
     * Given            : A User Record update
     * When             : Standard Plaform User changes Username for Active user
     * Then             : Throw Validation Error
     * Validation Rule  : CQ_FLEX_Restrict_Name_Email_Change
	 * Story            : [FLEX-165] User Record configuration
     * @description Test method for Validation Rule CQ_FLEX_Restrict_Name_Email_Change
	 */
    @isTest
    public static void givenUserRecord_WhenPlatformUserUpdateUserDetails_ThenThrowValidationError(){
        //Arrange : Create Standard Platform User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs(stdUser){
            
            //Act: Update UserName
            stdUser.Email = 'Test@cq.com';
            stdUser.FirstName = 'Test Name';
            stdUser.LastName = 'Last Name';
            Database.SaveResult resultUpdate =Database.update(stdUser, false);
            
            //Assert : Check the Validation Error
            system.assertEquals(false, resultUpdate.isSuccess(),'User Details were Changed');    
        }
    }
    /*
     * Given            : A User Record
     * When             : Given value to Department
     * Then             : Throw Validation Error
     * Validation Rule  : CQ_FLEX_Restrict_Department_NonEditable
	 * Story            : [FLEX-196] User Record configuration + JFs to PGs User creation/removal
     * @description Test method for Validation Rule CQ_FLEX_Restrict_Department_NonEditable 
	 */
    @isTest
    public static void givenUserRecord_WhenValueGivenToDepartment_ThenThrowValidationError(){
        //Arrange : Create System Administrator
        User sysAdminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        
        System.runAs(sysAdminUser){
            
            //Act: Update Department
            sysAdminUser.Department = 'Department';
            Database.SaveResult resultUpdate =Database.update(sysAdminUser, false);
            
            //Assert : Check the Validation Error
            system.assertEquals(false, resultUpdate.isSuccess(),'Department was Changed');
        }
    }
}