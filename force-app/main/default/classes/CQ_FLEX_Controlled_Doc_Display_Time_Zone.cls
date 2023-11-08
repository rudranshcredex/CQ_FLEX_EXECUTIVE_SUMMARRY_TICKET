/**
 * @description 
 * [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 */
global without sharing class CQ_FLEX_Controlled_Doc_Display_Time_Zone {//NOPMD
    /**
     * @description method to fetch user time zone
     * @return time zone
     */
@AuraEnabled(cacheable=true)
    global static String getUserTimeZone(){
        User currentUser = [Select TimeZoneSidKey from User where id =: USerInfo.getUserId()];
		String strTimeUser = currentUser.TimeZoneSidKey;
		TimeZone tz = TimeZone.getTimeZone(strTimeUser);
		String tzName = tz.getDisplayName();
        return tzName;
    }
}