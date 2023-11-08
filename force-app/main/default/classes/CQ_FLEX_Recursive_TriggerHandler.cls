/********************************** Revision History **************************
 *  @description : Recursive handler class to avoid recursion.
 * 
 * 1.[FLEX-156] Training - Assessments mandatory fields
 * 
 * 2.[FLEX-174]: Training - JF requirements display of Related documents
 *  
 ********************************** Revision History ***************************/
public without sharing class CQ_FLEX_Recursive_TriggerHandler {
    
    //Boolean flag for not firing validation at first execution
    public static Boolean isSecondTime = false;

    //Boolean flag for not firing validation at first execution
    public static Boolean isFirstTime = true;
     
}