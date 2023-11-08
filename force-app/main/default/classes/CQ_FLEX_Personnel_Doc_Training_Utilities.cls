/**
 * @description
 * This class will contain the common methods and static strings required for the Personnel Document Training object 
 * without sharing is required to query/insert/update personnel and its child records when requirements of a controlled documents get activated/deactivated
 * Note: personnel object is deployed with private sharing setting
 * 
 * ******************************Revision History******************************
 * [FLEX-33] Training - Training's assignment via JF Requirement
 * ******************************Revision History******************************
 */
public without sharing class CQ_FLEX_Personnel_Doc_Training_Utilities {
    
    /**
      * Used for skipping pending training count triggger
      * Used by batch job to process training for activated or deactivated requirements
      * When this value is set to true, we need to call setPendingDocumentsInControlledDoc() separately
      */ 
    public static Boolean skipPendingDocumentTrainingCountTrigger = false;
    
    
    /**
     * Maximum number of personnel job functions to process by training generation batch processor for document requirement.
     * Must be set below 5000 since double number of records including both PDJFs and PDTs will be inserted due to which SF DML Rows Limit will hit.
     */
    public static Integer MAX_RECORDS_TO_PROCESS_BY_TRAINING_BATCH_JOB = 1000;
    
    /**
     * Maximum number of pending trainings to count for a document
     * Note: Count has been limited to avoid System.QueryException with error "Aggregate query has too many rows for direct assignment, use FOR loop"
     */ 
    public static final Integer MAX_PENDING_TRAINING_COUNT = 100;
    
    //Training Type values
    public static final String  TRAINING_TYPE_INITIAL = 'Initial',
                                TRAINING_TYPE_REVISION = 'Revision',
                                TRAINING_TYPE_REFRESHER = 'Refresher',
                                TRAINING_TYPE_RETRAIN = 'Retrain';
    
    public static final String STATUS_PENDING = 'Pending',
                               STATUS_TRAINER_APPROVAL_PENDING = 'Trainer Approval Pending',
                               STATUS_COMPLETE = 'Complete',
                               STATUS_OBSOLETE = 'Obsolete';

    public static final String[] PENDING_STATUSES = new String[] { STATUS_PENDING, STATUS_TRAINER_APPROVAL_PENDING};
        
    //Training Job Status
    public static String TRAINING_JOB_STATUS_ACTIVATION_PENDING     = 'Activation Pending',
                         TRAINING_JOB_STATUS_ACTIVATION_ERROR       = 'Activation Error',
                         TRAINING_JOB_STATUS_DEACTIVATION_PENDING   = 'Deactivation Pending',
                         TRAINING_JOB_STATUS_DEACTIVATION_ERROR     = 'Deactivation Error';
    
    //Training Status
    public static final String  TRAINING_STATUS_CURRENT = 'Current',
                                TRAINING_STATUS_PENDING = 'Pending',
                                TRAINING_STATUS_OVERDUE = 'Overdue',
                                TRAINING_STATUS_NA = 'NA';    
        
    /**
     * @description batch process for activated requirements pending training generation
     * @param req    activated requirement
     */
     public static void batchProcessActivatedRequirement(compliancequest__SQX_Requirement__c req) {
         
         List<compliancequest__SQX_Personnel_Document_Job_Function__c> newPdjfs = new List<compliancequest__SQX_Personnel_Document_Job_Function__c>();
            Map<Id, compliancequest__SQX_Personnel_Job_Function__c> pjfToBeUpdatedMap = new Map<Id, compliancequest__SQX_Personnel_Job_Function__c>();
            Set<Id> allPsnIds = new Set<Id>();
            Set<Id> allJFIds = new Set<Id>();
            String lastPjfId = req.compliancequest__Training_Job_Last_Processed_Record__c == null ? '' : req.compliancequest__Training_Job_Last_Processed_Record__c;
            Integer pjfCount = 0;
            Integer errMaxLength = compliancequest__SQX_Requirement__c.compliancequest__Training_Job_Error__c.getDescribe().getLength();
            
         for (compliancequest__SQX_Personnel_Job_Function__c pjf : [SELECT Id,compliancequest__SQX_Personnel__c,compliancequest__SQX_Personnel__r.CQ_FLEX_Business_Unit__c,
                                                                    compliancequest__SQX_Job_Function__c,compliancequest__Training_Status__c,compliancequest__Current_Training_Program_Step__c,
                                                                    compliancequest__Retrain_Comment__c,(
                                                                        SELECT Id
                                                                        FROM compliancequest__SQX_Personnel_Document_Job_Functions__r
                                                                        WHERE compliancequest__SQX_Requirement__c = :req.Id LIMIT 1
                                                                    ) FROM compliancequest__SQX_Personnel_Job_Function__c
                                                                    WHERE compliancequest__SQX_Job_Function__c = :req.compliancequest__SQX_Job_Function__c
                                                                    AND compliancequest__SQX_Personnel__r.CQ_FLEX_Business_Unit__c <> null
                                                                    AND compliancequest__Active__c = true AND Id > :lastPjfId
                                                                    ORDER BY Id ASC  LIMIT :MAX_RECORDS_TO_PROCESS_BY_TRAINING_BATCH_JOB ]) {
                                                                        pjfCount++;
                                                                        lastPjfId = pjf.Id;
                                                                        Decimal pjfCurrentTrainingStepValue = pjf.compliancequest__Current_Training_Program_Step__c == null ? 0 : pjf.compliancequest__Current_Training_Program_Step__c;
                                                                        Decimal createPdjfsForTrainingStep = null;
                                                                        
                                                                        // add new pdjfs only when no PDJF exists for the personnel on the document requirement
                                                                        if (pjf.compliancequest__SQX_Personnel_Document_Job_Functions__r.isEmpty()) {
                                                                            if (pjf.compliancequest__Training_Status__c == TRAINING_STATUS_CURRENT) {
                                                                                if(pjfCurrentTrainingStepValue <= req.compliancequest__Training_Program_Step_Internal__c) {
                                                                                    
                                                                                    // update step of pjf and also create pdjf
                                                                                    createPdjfsForTrainingStep = req.compliancequest__Training_Program_Step_Internal__c;
                                                                                    
                                                                                }
                                                                            } else { // training status may be pending/overdue
                                                                                if (pjfCurrentTrainingStepValue >= req.compliancequest__Training_Program_Step_Internal__c) {
                                                                                    
                                                                                    // update step of pjf(case : pjf step is blank and requirement step is also blank in this case we have to update step of pjf so updating) and create pdjf
                                                                                    createPdjfsForTrainingStep = pjfCurrentTrainingStepValue;
                                                                                } else {
                                                                                    // don't process further as for such pjf neither pdjf will be created nor step of pjf will be updated
                                                                                    continue;
                                                                                }
                                                                            }
                                                                            
                                                                            // update step of pjf if required
                                                                            if (createPdjfsForTrainingStep != null) {
                                                                                pjf.compliancequest__Current_Training_Program_Step__c = createPdjfsForTrainingStep;
                                                                                pjfToBeUpdatedMap.put(pjf.Id, pjf);
                                                                            }
                                                                            
                                                                            // create new PDJF record for common active job functions ---This was from OOB ---
                                                                            //newPdjfs.add(createNewPDJF(pjf, req)); ---This was from OOB ---
                                                                            // allPsnIds.add(pjf.compliancequest__SQX_Personnel__c); ---This was from OOB ---
                                                                            
                                                                            //[FLEX-33] --------- {Start}
                                                                            //Personnel Business Unit                                                            
                                                                            Set<String> personnelBU = new Set<String>();
                                                                            List<String> conDocBU = new List<String>();
                                                                            personnelBU.addAll(pjf.compliancequest__SQX_Personnel__r.CQ_FLEX_Business_Unit__c.split(';'));
                                                                            
                                                                            //Controlled Document Business Unit
                                                                            if(req.compliancequest__SQX_Controlled_Document__r.CQ_FLEX_Business_Unit__c!=null){
                                                                                conDocBU = req.compliancequest__SQX_Controlled_Document__r.CQ_FLEX_Business_Unit__c.split(';');
                                                                            }
                                                                            
                                                                            //RetainAll method in Set extracts interesection values
                                                                            Boolean retailResult = personnelBU.retainAll(conDocBU);
                                                                            // create new PDJF record for common active job functions
                                                                            if(personnelBU.size()>0){
                                                                                newPdjfs.add(createNewPDJF(pjf, req));
                                                                                allPsnIds.add(pjf.compliancequest__SQX_Personnel__c);
                                                                            }
                                                                            //[FLEX-33] --------- {End}
                                                                        }
                                                                    }
         /**
         * Update PJF
         * --------------------
         * document owner may not have read and edit permission on all personnel records and its child record i.e. pjf
         */
        Database.update(pjfToBeUpdatedMap.values());
           
            String firstErrRecId = '';
            String processedPjfIdBeforeFirstError = '';
            String errMsgs = '';
            Boolean hasError = false;
            
            if (!newPdjfs.isEmpty()) {
                Set<Id> allDocIds = new Set<Id>{ req.compliancequest__SQX_Controlled_Document__c };
                Set<String> allDocNumbers = new Set<String>{ req.compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c.toUpperCase() };
                
                identifyRevisionTrainingType(newPdjfs, allPsnIds, allDocIds, allDocNumbers);
                
                skipPendingDocumentTrainingCountTrigger = true;
                
                /**
                 * Generate Trainings
                 */
                Database.SaveResult[] results = Database.insert(newPdjfs, false);
                
                for (Integer i = 0; i < results.size(); i++) {
                    if (!results[i].isSuccess()) {
                        hasError = true;
                        if (String.isBlank(firstErrRecId)) {
                            firstErrRecId = newPdjfs[i].compliancequest__SQX_Personnel_Job_Function__c;
                            errMsgs = getFormattedErrorMessage(results[i].getErrors());
                        }
                        
                        // remove pjf for which pdjf generation failed
                        pjfToBeUpdatedMap.remove(newPdjfs[i].compliancequest__SQX_Personnel_Job_Function__c);
                    }
                    else if (String.isBlank(firstErrRecId)) {
                        processedPjfIdBeforeFirstError = newPdjfs[i].compliancequest__SQX_Personnel_Job_Function__c;
                    }
                }
                
                try {
                    // update pending training count of the controlled document
                    setPendingDocumentsInControlledDoc(allDocIds);
                }
                catch (Exception ex) {
                    hasError = true;
                    req.compliancequest__Training_Job_Status__c = TRAINING_JOB_STATUS_ACTIVATION_ERROR;
                    req.compliancequest__Training_Job_Error__c = ex.getMessage();
                }
                
                skipPendingDocumentTrainingCountTrigger = false;
            }
            
            if (String.isNotBlank(firstErrRecId)) {
                req.compliancequest__Training_Job_Last_Processed_Record__c = processedPjfIdBeforeFirstError;
                req.compliancequest__Training_Job_Status__c = TRAINING_JOB_STATUS_ACTIVATION_ERROR;
                req.compliancequest__Training_Job_Error__c = getTruncatedText('First error record=' + firstErrRecId + '; Errors=' + errMsgs, errMaxLength, true);
            }
            else {
                req.compliancequest__Training_Job_Last_Processed_Record__c = lastPjfId;
                if (hasError == false && pjfCount < MAX_RECORDS_TO_PROCESS_BY_TRAINING_BATCH_JOB) {
                    req.compliancequest__Training_Job_Status__c = null;
                }
            }
            
         /**
          * Generate Training
          */
         Database.update(req);
            
     }
    
    /**
     * @description creates new PDJF object with default values from pjf and req with same job function
     * @param pjf    provided personnel job function
     * @param req    provided document requirement
     * @return  Personnel_Document_Job_Functions
     */
    public static compliancequest__SQX_Personnel_Document_Job_Function__c createNewPDJF(compliancequest__SQX_Personnel_Job_Function__c pjf, compliancequest__SQX_Requirement__c req) {
        compliancequest__SQX_Personnel_Document_Job_Function__c pdjf = new compliancequest__SQX_Personnel_Document_Job_Function__c();
        
        // set fields
        pdjf.compliancequest__SQX_Personnel_Job_Function__c = pjf.Id;
        pdjf.compliancequest__SQX_Requirement__c = req.Id;
        pdjf.compliancequest__Training_Type__c = TRAINING_TYPE_INITIAL; // initial as default
        pdjf.compliancequest__SQX_Assessment__c = getAssessmentId(TRAINING_TYPE_INITIAL, req);
        
        // link pjf and req in order to use later
        pdjf.compliancequest__SQX_Personnel_Job_Function__r = pjf;
        pdjf.compliancequest__SQX_Requirement__r = req;
        
        return pdjf;
    }
    
    /**
     * @description method to set the pending document training in the controlled document 
     * @param docIds    Doc ids.
     */
    public static void setPendingDocumentsInControlledDoc(Set<Id> docIds){
        
        List<compliancequest__SQX_Controlled_Document__c> docsToBeUpdated = new List<compliancequest__SQX_Controlled_Document__c>();
        
        for (compliancequest__SQX_Controlled_Document__c doc : [ SELECT Id,
                                                    compliancequest__Pending_Document_Training__c,
                                                    (
                                                        SELECT Id
                                                        FROM compliancequest__SQX_PersonnelDocumentTrainings__r
                                                        WHERE compliancequest__Status__c IN :PENDING_STATUSES
                                                        LIMIT :MAX_PENDING_TRAINING_COUNT
                                                    )
                                                FROM compliancequest__SQX_Controlled_Document__c
                                                WHERE Id IN :docIds ]) {
            docsToBeUpdated.add(new compliancequest__SQX_Controlled_Document__c(
                Id = doc.Id,
                compliancequest__Pending_Document_Training__c = doc.compliancequest__SQX_PersonnelDocumentTrainings__r.size()
            ));
            docIds.remove(doc.Id);
        }

        for (Id docId : docIds) {
            docsToBeUpdated.add(new compliancequest__SQX_Controlled_Document__c(
                Id = docId,
                compliancequest__Pending_Document_Training__c = 0
            ));
        }

        if(docsToBeUpdated.size() > 0){            
            /**
             * Doc training can be completed by the user who is not the owner of the doc
             */
            Database.update(docsToBeUpdated);
        }        
    }
    
    /**
     * @description identifies revision training type for new PDJFs
     * @param pdjfs                  PDJFs to identify revision training type
     * @param psnIds                 all personnel ids related to provided PDJFs
     * @param docIds                 all controlled document ids related to provided PDJFs
     * @param docNumbersInUpperCase  all controlled document numbers (in uppercase) related to provided PDJFs
     */
    public static void identifyRevisionTrainingType(List<compliancequest__SQX_Personnel_Document_Job_Function__c> pdjfs, Set<Id> psnIds, Set<Id> docIds, Set<String> docNumbersInUpperCase) {
        Map<Id, Id> prevRevMap = new Map<Id, Id>();
        Map<Id, Set<Id>> allDocsWithPrevRevisionsMap = new Map<Id, Set<Id>>();
        
        // For pdjfs, make the map of pjf and req to pdjf. This map will ensure whether currently creating pdjf 
        // will be of type retrain or not for particular pjf and requirement. 
        // Logic is : if the pjf and req key will have pdjf then it will be of type retrain else initial/revision
        Map<String, compliancequest__SQX_Personnel_Document_Job_Function__c> pjfReqToPdjfMap = new Map<String, compliancequest__SQX_Personnel_Document_Job_Function__c>();
        for (compliancequest__SQX_Personnel_Document_Job_Function__c pdjf : pdjfs) {
            pjfReqToPdjfMap.put('' + pdjf.compliancequest__SQX_Personnel_Job_Function__c + pdjf.compliancequest__SQX_Requirement__c, pdjf);
        }
        // read all documents revisions and immediate previous revisions
        for (List<compliancequest__SQX_Controlled_Document__c> allRevs : getAllRevisions(docNumbersInUpperCase).values()) {
            Set<Id> revIds = new Map<Id, compliancequest__SQX_Controlled_Document__c>(allRevs).keySet();
            
            for (Integer i = 0; i < allRevs.size(); i++) {
                Id docId = allRevs[i].Id;
                revIds.remove(docId);
                
                if (docIds.contains(docId)) {
                    // list all previous revs
                    allDocsWithPrevRevisionsMap.put(docId, new Set<Id>(revIds));
                    
                    // set immediate previous revision
                    if (i + 1 < allRevs.size()) {
                        prevRevMap.put(docId, allRevs[i + 1].Id);
                    }
                }
            }
        }
            
            // get completed personnel document job functions
            Set<String> psnDocWithCompletedInitialTrainings = new Set<String>();
            Map<String, compliancequest__SQX_Personnel_Document_Job_Function__c> completedPdjfs = new Map<String, compliancequest__SQX_Personnel_Document_Job_Function__c>();

            // get completed pdjfs to identify revision training
            for (compliancequest__SQX_Personnel_Document_Job_Function__c pdjf : [SELECT Id, compliancequest__Personnel_Id__c,compliancequest__Controlled_Document_Number__c,
                                                                    compliancequest__Controlled_Document_Id__c,compliancequest__Job_Function_Id__c,
                                                                    compliancequest__Training_Type__c,compliancequest__Training_Completion_Date__c,
                                                                    compliancequest__SQX_Personnel_Document_Training__c,compliancequest__SQX_Personnel_Job_Function__c,
                                                                    compliancequest__SQX_Requirement__c,compliancequest__Training_Status__c
                                                                FROM compliancequest__SQX_Personnel_Document_Job_Function__c
                                                                WHERE compliancequest__Personnel_Id__c IN :psnIds AND compliancequest__Controlled_Document_Number__c IN :docNumbersInUpperCase
                                                                ORDER BY compliancequest__Personnel_Id__c,compliancequest__Controlled_Document_Number__c,
                                                                    compliancequest__Controlled_Document_Id__c,compliancequest__Job_Function_Id__c,
                                                                    compliancequest__Training_Completion_Date__c DESC]) {                                                                        
                if (pdjf.compliancequest__Training_Status__c == STATUS_COMPLETE) {
                    String psnDocKey = '' + pdjf.compliancequest__Personnel_Id__c + pdjf.compliancequest__Controlled_Document_Id__c;
                    String psnDocJfKey = psnDocKey + pdjf.compliancequest__Job_Function_Id__c;
                    
                    if (pdjf.compliancequest__Training_Type__c == TRAINING_TYPE_INITIAL || pdjf.compliancequest__Training_Type__c == TRAINING_TYPE_RETRAIN) {
                        psnDocWithCompletedInitialTrainings.add(psnDocKey);
                    }
                    
                    // used for skipping revision training
                    if (!completedPdjfs.containsKey(psnDocJfKey)) {
                        // use last completed pdjf training in a revision per job function
                        completedPdjfs.put(psnDocJfKey, pdjf);
                    }
                }
                
                // set training type retrain
                compliancequest__SQX_Personnel_Document_Job_Function__c retrainTypePdjf = pjfReqToPdjfMap.get('' + pdjf.compliancequest__SQX_Personnel_Job_Function__c + pdjf.compliancequest__SQX_Requirement__c);
                if (retrainTypePdjf != null && retrainTypePdjf.compliancequest__Training_Type__c != TRAINING_TYPE_RETRAIN) {
                    retrainTypePdjf.compliancequest__Training_Type__c = TRAINING_TYPE_RETRAIN;
                    retrainTypePdjf.compliancequest__Comment__c = retrainTypePdjf.compliancequest__SQX_Personnel_Job_Function__r.compliancequest__Retrain_Comment__c;
                    retrainTypePdjf.compliancequest__SQX_Assessment__c = getAssessmentId(TRAINING_TYPE_RETRAIN, retrainTypePdjf.compliancequest__SQX_Requirement__r);
                }
            }
            
            // process remaining pdjfs with adhoc initial completed trainings to identify as revision training
            Set<Id> remainingPsnIds = new Set<Id>();
            Set<String> remainingDocNumbers = new Set<String>();
            Map<String, List<compliancequest__SQX_Personnel_Document_Job_Function__c>> remainingPdjfs = new Map<String, List<compliancequest__SQX_Personnel_Document_Job_Function__c>>();
            
            // identify PDJFs as revision training and skip training if needed
            for (compliancequest__SQX_Personnel_Document_Job_Function__c newPdjf : pdjfs) {
                Id psnId = newPdjf.compliancequest__SQX_Personnel_Job_Function__r.compliancequest__SQX_Personnel__c;
                Id docId = newPdjf.compliancequest__SQX_Requirement__r.compliancequest__SQX_Controlled_Document__c;
                
                if (newPdjf.compliancequest__Training_Type__c == TRAINING_TYPE_INITIAL) {
                    for (Id prevRevId : allDocsWithPrevRevisionsMap.get(docId)) {
                        String psnDocKey = '' + psnId + prevRevId;
                        
                        if (psnDocWithCompletedInitialTrainings.contains(psnDocKey)) {
                            // set revision training type when completed initial trainings are found in any previous revisions
                            newPdjf.compliancequest__Training_Type__c = TRAINING_TYPE_REVISION;
                            newPdjf.compliancequest__SQX_Assessment__c = getAssessmentId(TRAINING_TYPE_REVISION, newPdjf.compliancequest__SQX_Requirement__r);
                            break;
                        }
                    }
                    
                    if (newPdjf.compliancequest__Training_Type__c == TRAINING_TYPE_REVISION) {
                        Id immediatePrevRevId = prevRevMap.get(docId);
                        
                        if (immediatePrevRevId != null && newPdjf.compliancequest__SQX_Requirement__r.compliancequest__Skip_Revision_Training__c == true) {
                            String psnDocJfKey = '' + psnId + immediatePrevRevId + newPdjf.compliancequest__SQX_Personnel_Job_Function__r.compliancequest__SQX_Job_Function__c;
                            compliancequest__SQX_Personnel_Document_Job_Function__c completedPrevRevPdjf = completedPdjfs.get(psnDocJfKey);
                            
                            if (completedPrevRevPdjf != null) {
                                // skip training and link completed training of previous revision
                                newPdjf.compliancequest__SQX_Personnel_Document_Training__c = completedPrevRevPdjf.compliancequest__SQX_Personnel_Document_Training__c;
                                newPdjf.compliancequest__Training_Status__c = STATUS_COMPLETE;
                            }
                        }
                    }
                    else {
                        String docNumberInUpperCase = newPdjf.compliancequest__SQX_Requirement__r.compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c.toUpperCase();
                        String psnDocNumberKey = '' + psnId + docNumberInUpperCase;
                        
                        remainingPsnIds.add(psnId);
                        remainingDocNumbers.add(docNumberInUpperCase);
                        
                        if (!remainingPdjfs.containsKey(psnDocNumberKey)) {
                            remainingPdjfs.put(psnDocNumberKey, new List<compliancequest__SQX_Personnel_Document_Job_Function__c>());
                        }
                        remainingPdjfs.get(psnDocNumberKey).add(newPdjf);
                    }
                }
            }
            
            // process remaining pdjfs using adhoc initial completed trainings to identify revision training
            if (remainingPdjfs.size() > 0) {
                for (compliancequest__SQX_Personnel_Document_Training__c pdt : [ SELECT Id,compliancequest__SQX_Personnel__c,compliancequest__SQX_Controlled_Document__c,
                                                                    compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c
                                                                FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                WHERE compliancequest__SQX_Personnel__c IN :remainingPsnIds
                                                                    AND compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c IN :remainingDocNumbers
                                                                    AND compliancequest__Status__c = :STATUS_COMPLETE
                                                                ORDER BY compliancequest__SQX_Personnel__c,compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c,
                                                                    compliancequest__SQX_Controlled_Document__c,compliancequest__Completion_Date__c DESC ]) {
                    String docNumberInUpperCase = pdt.compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c.toUpperCase();
                    String psnDocNumberKey = '' + pdt.compliancequest__SQX_Personnel__c + docNumberInUpperCase;
                    
                    // identify revision training by adhoc initial completed trainings
                    if (remainingPdjfs.containsKey(psnDocNumberKey)) {
                        for (compliancequest__SQX_Personnel_Document_Job_Function__c newPdjf : remainingPdjfs.get(psnDocNumberKey)) {
                            Id docId = newPdjf.compliancequest__SQX_Requirement__r.compliancequest__SQX_Controlled_Document__c;
                            
                            if (newPdjf.compliancequest__Training_Type__c == TRAINING_TYPE_INITIAL && allDocsWithPrevRevisionsMap.get(docId).contains(pdt.compliancequest__SQX_Controlled_Document__c)) {
                                // set revision training type when adhoc initial completed training is found in any previous revisions
                                newPdjf.compliancequest__Training_Type__c = TRAINING_TYPE_REVISION;
                                newPdjf.compliancequest__SQX_Assessment__c = getAssessmentId(TRAINING_TYPE_REVISION, newPdjf.compliancequest__SQX_Requirement__r);
                            }
                        }
                    }
                }
            }
        }
    
    /**
     * @description returns assessment id for PDJF training type
     * @param trainingType   PDJF training type
     * @param req            requirement containing initial, revision and refresher assessment values including values in the related controlled document
     * @return               assessment Id
     */ 
    public static Id getAssessmentId(String trainingType, compliancequest__SQX_Requirement__c req)
    {
        Id assessmentId = null;
        
        if (trainingType == TRAINING_TYPE_REVISION) {
            assessmentId = req.compliancequest__SQX_Revision_Assessment__c == null ? req.compliancequest__SQX_Controlled_Document__r.compliancequest__SQX_Revision_Assessment__c : req.compliancequest__SQX_Revision_Assessment__c;
        }
        else if (trainingType == TRAINING_TYPE_REFRESHER) {
            assessmentId = req.compliancequest__SQX_Refresher_Assessment__c == null ? req.compliancequest__SQX_Controlled_Document__r.compliancequest__SQX_Refresher_Assessment__c : req.compliancequest__SQX_Refresher_Assessment__c;
        }
        else {
            // for initital and retrain types
            assessmentId = req.compliancequest__SQX_Initial_Assessment__c == null ? req.compliancequest__SQX_Controlled_Document__r.compliancequest__SQX_Initial_Assessment__c : req.compliancequest__SQX_Initial_Assessment__c;
        }
        
        return assessmentId;
    }
    
    /**
     * @description returns sorted list (first revision at the end) of all or released document revision history of a controlled document
     * @param doc   Doc type
     * @param listAllRevs   list of all revs
     * @return  RevisionHistory
     */
    public static List<compliancequest__SQX_Controlled_Document__c> getRevisionHistory(compliancequest__SQX_Controlled_Document__c doc, Boolean listAllRevs) {
        // read required controled doc fields to get revision history
        doc = [SELECT Id, Name, compliancequest__Document_Number__c, compliancequest__Revision__c, compliancequest__Date_Issued__c FROM compliancequest__SQX_Controlled_Document__c WHERE Id =: doc.Id];
        
        if (listAllRevs == true) {
            String documentNumber = doc.compliancequest__Document_Number__c.toUpperCase();
            return getAllRevisions(new Set<String>{ documentNumber }).get(documentNumber);
        }
        else {
            String docNumber = doc.compliancequest__Document_Number__c;
            Id docId = doc.Id;
            Date dateIssued = doc.compliancequest__Date_Issued__c;
            
            // blank revision is considered as first revision
            String queryRevs = getRevisionHistorySelectQueryString()
                               + ' WHERE compliancequest__Document_Number__c = :docNumber '
                               + '     AND Id != :docId '
                               + '     AND compliancequest__Date_Issued__c != null '
                               + '     AND compliancequest__Date_Issued__c <= :dateIssued '
                               + ' ORDER BY compliancequest__Date_Issued__c DESC NULLS FIRST, compliancequest__Revision__c DESC NULLS LAST ';
            
            List<compliancequest__SQX_Controlled_Document__c> revs = (List<compliancequest__SQX_Controlled_Document__c>)Database.query(queryRevs);
            return revs;
        }
    }
    
    /**
     * @description returns SOQL query string to get all records with selected fields in SQX_Revision_History_Columns fieldset and additional fields
     * @return  Revision History Select Query String
     */
    private static String getRevisionHistorySelectQueryString() {
        List<SObjectField> reqdFields = new List<SObjectField>{
            compliancequest__SQX_Controlled_Document__c.compliancequest__Changes__c,compliancequest__SQX_Controlled_Document__c.compliancequest__Change_Scope__c,
            compliancequest__SQX_Controlled_Document__c.compliancequest__Date_Issued__c,compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Number__c,
            compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Status__c,compliancequest__SQX_Controlled_Document__c.compliancequest__Duration__c,
            compliancequest__SQX_Controlled_Document__c.compliancequest__Effective_Date__c,compliancequest__SQX_Controlled_Document__c.compliancequest__Expiration_Date__c,
            compliancequest__SQX_Controlled_Document__c.Name,compliancequest__SQX_Controlled_Document__c.RecordTypeId,
            compliancequest__SQX_Controlled_Document__c.compliancequest__Revision__c,compliancequest__SQX_Controlled_Document__c.compliancequest__Title__c
        };
        String query = ' SELECT '
                       + getFieldList(SObjectType.compliancequest__SQX_Controlled_Document__c.fieldSets.compliancequest__SQX_Revision_History_Columns, reqdFields)
                       + ' FROM ' + SObjectType.compliancequest__SQX_Controlled_Document__c.getName() + ' ';
        return query;
    }
    
    /**
     * @description returns list of fields that can be used with dynamic query to read records
     * @param fldSet list of fields of a fieldset to include in the query string
     * @param fieldsToAdd additional list of fields that are not included in the provided fieldset
     * @return returns the list of fields in comma separated manner to be used in query string
     */
    public static String getFieldList(FieldSet fldSet, List<SObjectField> fieldsToAdd) {
        Schema.DescribeSObjectResult sobj = fldSet.getSObjectType().getDescribe();
        Map<String, SObjectField> allFields = sobj.fields.getMap();
        Map<String, SObjectField> fieldsToFetch = new Map<String, SObjectField>();
        // add given fields
        if (fieldsToAdd != null) {
            for (SObjectField fld : fieldsToAdd) {
                String fldName = fld.getDescribe().getName().toLowerCase();
                fieldsToFetch.put(fldName, fld);
            }
        }
        // add fields from fieldset
        for (FieldSetMember field : fldSet.getFields()){
            String fieldPath = field.getFieldPath();
            SObjectField validField = allFields.get(fieldPath);
            
            // if the fieldset contais a period, it means it is cross reference field which is not currently supported
            if (fieldPath.contains('.')) {
                throw new CQ_FLEX_ApplicationGenericException('No cross reference fields are supported');
            }
            
            // if a valid field object is not found throw an exception, this should never occur in a fieldset
            if (validField == null) {
                throw new CQ_FLEX_ApplicationGenericException('The field ' + fieldPath + ' is not present in the object');
            }
            
            fieldsToFetch.put(fieldPath.toLowercase(), validField);
        }
        
        return getFieldList(fieldsToFetch.values());
    }
    
    /**
     * @description Returns the list of fields that can be queried based on the profile
     * @param fields the list of fields to include in the query string
     * @return returns the list of fields in comma separated manner to be used in query string
     */
    public static String getFieldList(List<Schema.SObjectField> fields) {
        String fieldList = 'Id';
        
        for(integer index = 0; index < fields.size(); index++){
            DescribeFieldResult fieldResult = fields.get(index).getDescribe();
            if(fieldResult.getName() == 'Id' || !fieldResult.isAccessible()){
                continue;
            }
            DisplayType fieldType = fieldResult.getType();
            //Skipping Geo loaction type which causes serialization error(Internal Server Error)
            if(fieldType != DisplayType.Location){
                String fieldName= fieldResult.getName();
                Boolean isCustomField = fieldResult.isCustom();
                fieldList += ', ' + fieldName;
                
                if(fieldType == DisplayType.PickList) {
                    String picklistLabel = '';
                    if(isCustomField){
                        picklistLabel = fieldName.replace('__c', '') + '__label';
                    } else {
                        picklistLabel = fieldName + '__slabel';
                    }
                    fieldList += ', toLabel(' + fieldName + ') ' +  picklistLabel;
                }
                else if(fieldType == DisplayType.Reference) {
                    if(fieldResult.getRelationshipName() != null && !fieldResult.getReferenceTo().isEmpty()) {
                        SObjectType reference = fieldResult.getReferenceTo()[0];
                        String nameField = getNameField(reference);
                        if(!String.isBlank(nameField)) {
                            fieldList += ', ' + fieldResult.getRelationshipName() + '.' + nameField;
                        }
                    }
                }
            }
        }
        return fieldList;
    }
    /**
     * @description Returns the list of fields that can be queried based on the profile
     * @param sobjType to sobjtype.
     * @return returns NameField
     */
    private static String getNameField(SObjectType sobjType) {
        Map<String, SObjectField> fields = sobjType.getDescribe().fields.getMap();
        if(!fields.containsKey('Name') || !fields.get('Name').getDescribe().isNameField()) {
            for(String field : fields.keySet()) {
                if(fields.get(field).getDescribe().isNameField()) {
                    return field;
                }
            }
        }
        else{
            return 'Name';
        }
        
        return null;
    }
    
    /**
     * @description sorted list (first revision at the end) of all document revisions of controlled document numbers
     * @param documentNumbers stores Document numbers
     * @return sorted list (first revision at the end) of all document revisions of controlled document numbers
     */
    public static Map<String, List<compliancequest__SQX_Controlled_Document__c>> getAllRevisions(Set<String> documentNumbers) {
        Map<String, List<compliancequest__SQX_Controlled_Document__c>> allRevMap = new Map<String, List<compliancequest__SQX_Controlled_Document__c>>();
        
        // generate return list for all document numbers
        // use upper case as document number is not case sensitive
        for (String docNumber : documentNumbers) {
            allRevMap.put(docNumber.toUpperCase(), new List<compliancequest__SQX_Controlled_Document__c>());
        }
        
        String queryRevs = getRevisionHistorySelectQueryString()
                           + ' WHERE compliancequest__Document_Number__c IN :documentNumbers '
                           + ' ORDER BY compliancequest__Document_Number__c, compliancequest__Date_Issued__c DESC NULLS FIRST, compliancequest__Revision__c DESC NULLS LAST ';
        
        // blank revision is considered as first revision
        List<compliancequest__SQX_Controlled_Document__c> revs = Database.query(queryRevs);
        
        // generate revision history
        for (compliancequest__SQX_Controlled_Document__c rev : revs) {
            String docNumberInUpperCase = rev.compliancequest__Document_Number__c.toUpperCase();
            allRevMap.get(docNumberInUpperCase).add(rev);
        }
        
        return allRevMap;
    }
    
    /**
     * @description formatted error message
     * @return formatted error message
     * @param errors list of Database.Error
     */
    public static String getFormattedErrorMessage(List<Database.Error> errors){
        String errorMessage = '';
        for(Database.Error error : errors){
            errorMessage = errorMessage +'\r\n'+  error;
        }
        return errorMessage;
    }
    
    /**
     * @description truncates provided text to maximum length
     * @param text           string value to truncate if larger than maximum length
     * @param maxLength      maximum length for the text
     * @param addEllipsis    if <code>true</code>, appends ellipsis when truncating the provided text to maximum length, else does not add ellipsis
     * @return              returns trauncated value ending with ellipsis if length is greater than maximum length, else returns same value
     */
    public static String getTruncatedText(String text, Integer maxLength, Boolean addEllipsis) {
        String retVal = text;
        
        if (!String.isBlank(retVal)) {
            if (retVal.length() > maxLength) {
                if(addEllipsis){
                    retVal = retVal.left(maxLength - 3) + '...';
                }
                else {
                    retVal = retVal.left(maxLength);
                }
            }
        }
        
        return retVal;
    }
}