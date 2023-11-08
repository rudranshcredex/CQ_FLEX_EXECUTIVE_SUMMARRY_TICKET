/**
 * @description This class includes data set related to Task
 * 
 * [FLEX-435] Scouting Account - Send a notification when a task to promote supplier is created  
 */
public with sharing class CQ_FLEX_Test_Task_Factory implements CQ_CCC_Test_SObject_Factory{
    // All public static variables related to Task  
    public static final String SUBJECT='Scouting to Global Supp Promotion';
    
    /**
     * @description Method to construct required data for task
     * with various policies
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'TaskRecord' {createTaskRecord();}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new Map<String,SObject>();
    }
    
    /**
     * @description  Method to build Task
     * @param subject
     * @return task record   
	 */
    private Task buildTask(String subject)
    {
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        Id scoutingRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Scouting').getRecordTypeId();
        
        Task tasRecord = new Task(
            Subject=subject
        );
        
        return tasRecord;
    }
    /**
      * @description Method to create task record.
      */
    private void createTaskRecord(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
       
        System.runAs(adminUser){         
            Task tasRecord = buildTask(
                SUBJECT
            );
            insert tasRecord;                                                
        }          
    }    
}