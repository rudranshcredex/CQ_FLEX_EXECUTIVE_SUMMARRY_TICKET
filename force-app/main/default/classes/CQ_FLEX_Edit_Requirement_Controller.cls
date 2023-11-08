/********************************** Revision History ************************************************************
 * @description
*1.[FLEX-37]-Trainings - New field Department/Area field in Job function + Edit Requirement screen continued
*2.[FLEX-53]:Trainings - Area configuration continued
*3.[FLEX-69]:Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
*4.[FLEX-412]:Training - JF requirements display of Related documents continued + Edit Requirement - Active JFs + CQ FLEX Apex Class VF Pages Permission Set.
*********************************** Revision History **************************************************************/
@SuppressWarnings('PMD.TooManyFields')
public without sharing class CQ_FLEX_Edit_Requirement_Controller {
    
    /**
     * @description variable of wraplist1 
     */
    public list<wrapJobFunctions> wraplist1{get;set;}
    /**
     * @description variable of searchstring 
     */    
    public string searchstring {get; set;}    
    public string ControlleddocId;
    public string Siteid;
    public string Record_Type_Developer_Name;
    /**
     * @description variable of selectedJF 
     */
    Public List<compliancequest__SQX_Job_Function__c> selectedJF{get;set;} 
    /**
     * @description variable of totalRecordCount 
     */
    Public Integer totalRecordCount{get;set;}
    /**
     * @description variable of fetchedRecordCount 
     */
    Public Integer fetchedRecordCount{get;set;}
    Public integer TotalRecs = 0;
    /**
     * @description variable of disCAR 
     */
    Public boolean disCAR{get;set;}
    /**
     * @description variable of disADN 
     */
    Public boolean disADN{get;set;}
    /**
     * @description variable of disRAN 
     */
    Public boolean disRAN{get;set;}
    Public integer OffsetSize = 0;
    Public integer LimitSize= 20;
    Public Set<id> SelectedAccountIds; 
    public map<id,boolean>ID_REFRESHER;
    /**
     * @description variable of defaultsite 
     */
    Public Set<string> defaultsite{get;set;}
    /**
     * @description variable of defaultvalue 
     */
    public compliancequest__SQX_Requirement__c defaultvalue{get;set;}
    set<id> Jfid=new set<id>();
    string TempInput='%%';

    List<String> SitesMQRFMS=new List<String>{'MQR - Corporate (Medical)','FMS - Corporate (Non-Medical)'};
    
    
    /**
     * @description Standard controller Constructor for get the current page id.
     * @param controller StandardController variable
     */
    public CQ_FLEX_Edit_Requirement_Controller (ApexPages.StandardController controller) {
        controlleddocId = ApexPages.currentPage().getParameters().get('id').escapeHtml4();    
        siteid= ApexPages.currentPage().getParameters().get('site').escapeHtml4(); 
        Record_Type_Developer_Name= ApexPages.currentPage().getParameters().get('recordtype').escapeHtml4(); 
        Defaultvalue = new compliancequest__SQX_Requirement__c();
        Defaultvalue.compliancequest__Level_of_Competency__c=ApexPages.currentPage().getParameters().get('Level_of_Competency').escapeHtml4();
        Defaultvalue.compliancequest__Refresher_Competency__c=ApexPages.currentPage().getParameters().get('Refresher_Competency').escapeHtml4();
        Defaultvalue.compliancequest__Refresher_Interval__c=Decimal.valueOf(ApexPages.currentPage().getParameters().get('Refresher_Interval').escapeHtml4());
        Defaultvalue.compliancequest__Days_to_Complete_Refresher__c=Decimal.valueOf(ApexPages.currentPage().getParameters().get('Days_to_Complete_Refresher').escapeHtml4());
        Defaultvalue.compliancequest__Days_in_Advance_to_Start_Refresher__c=Decimal.valueOf(ApexPages.currentPage().getParameters().get('Days_in_Advance_to_Start_Refresher').escapeHtml4());
        //Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c='Yes';
        TotalRecs = [Select Count() From compliancequest__SQX_Job_Function__c
                     WHERE compliancequest__Active__c=true];
        disCAR=false;
        disADN=false;
        disRAN=false;
        SelectedAccountIds = new Set<id>();
        ID_REFRESHER=new Map<id,boolean>();
        wraplist1 = new List<wrapJobFunctions>();        
        selectedJF  = new List<compliancequest__SQX_Job_Function__c>();        
        defaultsite = new Set<string>();
        
        list<string> addJFS=CQ_FLEX_Setting__c.getOrgDefaults().CQ_FLEX_Job_Functions__c.split(',');
        defaultsite.addAll(AddJFS); 
        
        list<compliancequest__SQX_Requirement__c> availreq_list=[SELECT id,compliancequest__SQX_Job_Function__c 
                                                                 FROM compliancequest__SQX_Requirement__c 
                                                                 WHERE compliancequest__SQX_Controlled_Document__c=:controlleddocId AND compliancequest__Active__c=true];
        
        for(compliancequest__SQX_Requirement__c  availreq:availreq_list)
        {
            Jfid.add(availreq.compliancequest__SQX_Job_Function__c);
        }               
    }
    

    /**
     * @description Set Selected Accounts.
     */
    public void setSelectedAccounts()
    {   
        
        for(wrapJobFunctions item: wraplist1)
        {
           
            if(item.selected)
            {    
                if(!this.SelectedAccountIds.contains(item.lns.id))
                {
                    this.SelectedAccountIds.add(item.lns.id);
                    this.ID_REFRESHER.put(item.lns.id,item.selected2);
                }
            }
            else
            {
                if(this.SelectedAccountIds.contains(item.lns.id))
                {
                    this.SelectedAccountIds.remove(item.lns.id);
                    this.ID_REFRESHER.remove(item.lns.id);
                }
            }
        }  
        
    }
    
    /**
     * @description Get Selected Accounts.
     * @return SelectedAccountIds size.
     */
    public Integer getSelectedCount(){
        return this.SelectedAccountIds.size();
    }
    
    
    /**
     * @description Get Selected Accounts Detail.
     * @return SelectedAccounts.
     */
    public List<compliancequest__SQX_Job_Function__c> getSelectedAccounts(){    
        List<compliancequest__SQX_Job_Function__c> objAccList = [Select id,name,CQ_FLEX_Area__r.name,CQ_FLEX_Department__c
                                                                 From compliancequest__SQX_Job_Function__c 
                                                                 Where ID IN : SelectedAccountIds];       
        
        return objAccList;
    }
    
    /**
     * @description Intiallize the list of the records to render the table.
     * @return wrapJFList
     */
    public wrapJobFunctions[] getwrapJFList()
    {        
        wraplist1 = new List<wrapJobFunctions>();
         list<compliancequest__SQX_Job_Function__c> jflist=new list<compliancequest__SQX_Job_Function__c>();
        list<compliancequest__SQX_Job_Function__c> jflistCount=new list<compliancequest__SQX_Job_Function__c>();
        
        if(siteid=='MQR - Corporate (Medical)' || siteid=='FMS - Corporate (Non-Medical)')
        { 
            jflistCount=[SELECT id,name,CQ_FLEX_Area__r.name,CQ_FLEX_Department__c
                    FROM compliancequest__SQX_Job_Function__c
                    WHERE ((name like: TempInput OR CQ_FLEX_Area__r.name like: TempInput OR CQ_FLEX_Department__c like: TempInput) 
                          AND (CQ_FLEX_Site__c IN: SitesMQRFMS
                               OR name in: defaultsite)) 
                    AND compliancequest__Active__c=true
                    ORDER BY name ASC];
         } 
        else{
            jflistCount=[SELECT id,name,CQ_FLEX_Area__r.name,CQ_FLEX_Department__c
                    FROM compliancequest__SQX_Job_Function__c
                    WHERE ((name like: TempInput or 
                            CQ_FLEX_Area__r.name like: TempInput 
                            OR CQ_FLEX_Department__c like: TempInput) 
                           AND CQ_FLEX_Site__c =:siteid) AND compliancequest__Active__c=true
                    ORDER BY name ASC ];        
            
        }
       
        
        if(siteid=='MQR - Corporate (Medical)' || siteid=='FMS - Corporate (Non-Medical)')
        { 
            jflist=[SELECT id,name,CQ_FLEX_Area__r.name,CQ_FLEX_Department__c
                    FROM compliancequest__SQX_Job_Function__c
                    WHERE ((name like: TempInput OR CQ_FLEX_Area__r.name like: TempInput OR CQ_FLEX_Department__c like: TempInput) 
                            AND (CQ_FLEX_Site__c IN: SitesMQRFMS
                                 OR name IN: defaultsite)) 
                    AND compliancequest__Active__c=true
                    ORDER BY name ASC LIMIT :LimitSize OFFSET :OffsetSize ];
         } 
        else{
            jflist=[SELECT id,name,CQ_FLEX_Area__r.name,CQ_FLEX_Department__c
                    FROM compliancequest__SQX_Job_Function__c
                    WHERE ((name like: TempInput or 
                            CQ_FLEX_Area__r.name like: TempInput 
                            OR CQ_FLEX_Department__c like: TempInput) 
                           AND CQ_FLEX_Site__c =:siteid) AND compliancequest__Active__c=true
                    ORDER BY name ASC LIMIT :LimitSize OFFSET :OffsetSize ];        
            
        }
       
        for(compliancequest__SQX_Job_Function__c jf:jflist)            
        {            
            wrapJobFunctions wrapJFList = new wrapJobFunctions();            
            if(!Jfid.contains(jf.id)) {
                wrapJFList.lns=jf;
                if(this.SelectedAccountIds.contains(jf.Id))
                {
                    wrapJFList.Selected = true;
                }
                else{
                    wrapJFList.Selected = false;
                }
                wraplist1.Add(wrapJFList);
            } 
        } 
        TotalRecs=jflistCount.size();
        return wraplist1;        
    }
    
    /**
     * @description Method to assign the search value to variable.
     */
    public void searchAccounts(){
        setSelectedAccounts();
        TempInput = '%' + searchstring + '%';        
    }
        
    /**
     * @description Method to process the selected records.
     * @return PageReference
     */
    public PageReference processSelected() {        
        setSelectedAccounts();       
        selectedJF  = GetSelectedAccounts();
        list<compliancequest__SQX_Requirement__c> reqlist=new list<compliancequest__SQX_Requirement__c>();
        for(compliancequest__SQX_Job_Function__c lns : selectedJF) {             
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            //req.compliancequest__Active__c=true;
            req.compliancequest__SQX_Controlled_Document__c=controlleddocId;
            req.compliancequest__SQX_Job_Function__c=lns.id;           
            req.compliancequest__Require_Refresher__c=ID_REFRESHER.get(lns.id);
            req.compliancequest__Activation_Date__c=null;
            req.compliancequest__Deactivation_Date__c=null;
            req.CQ_FLEX_Document_Recordtype_Name__c=Record_Type_Developer_Name;
            req.CQ_FLEX_Document_Site__c=siteid;
            req.compliancequest__Level_of_Competency__c=Defaultvalue.compliancequest__Level_of_Competency__c;
            req.compliancequest__Refresher_Competency__c=Defaultvalue.compliancequest__Refresher_Competency__c;
            req.compliancequest__Refresher_Interval__c=Defaultvalue.compliancequest__Refresher_Interval__c;
            req.compliancequest__Days_to_Complete_Refresher__c=Defaultvalue.compliancequest__Days_to_Complete_Refresher__c;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=Defaultvalue.compliancequest__Days_in_Advance_to_Start_Refresher__c;
            req.CQ_FLEX_Classroom_Assessment_Required__c=Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c;
            req.CQ_FLEX_Assessment_Document_Number__c=Defaultvalue.CQ_FLEX_Assessment_Document_Number__c;
            req.CQ_FLEX_Reason_Assessment_is_not_needed__c=Defaultvalue.CQ_FLEX_Reason_Assessment_is_not_needed__c;
            
            reqlist.add(req);            
        } 
        list<Database.SaveResult> results=new list<Database.SaveResult>();        
        //Add Error if Classroom_Assessment_Required is null,
        //when Level_of_Competency == Instructor Led with Assessment and site=='ALT - Althofen'.
        if(Defaultvalue.compliancequest__Level_of_Competency__c=='Instructor Led with Assessment' 
           && siteid=='ALT - Althofen' 
           && Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c==null
           && (Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Classroom Assessment Required?'));
        }
        else if(Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c=='Yes' 
                && siteid=='ALT - Althofen' 
                && Defaultvalue.CQ_FLEX_Assessment_Document_Number__c==null
                &&(Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {
            //Add Error if Assessment Document Number is null,
            //when Classroom_Assessment_Required==yes and Level_of_Competency == Instructor Led with Assessment and site=='ALT - Althofen'
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Assessment Document Number'));            
        }
        else if(Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c=='No'
                && siteid=='ALT - Althofen' 
                && Defaultvalue.CQ_FLEX_Reason_Assessment_is_not_needed__c==null
                && (Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {
            //Add Error if Reason Assessment is not needed is null,
            //when Classroom_Assessment_Required==No and Level_of_Competency == Instructor Led with Assessment and site=='ALT - Althofen'
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Reason Assessment is not needed'));
        }
        else
        {
            //Insert the selected Job funtions to the Requirement.
            results= Database.insert(reqlist, true); 
            if(results.size()!=0){
                if(results[0].isSuccess()){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Created Successfully.Thank you!'));
                    //Redirect the page to Controlled Document record page after creation of record successfully.         
                    PageReference pg = new PageReference('/'+controlleddocId);
                    pg.setRedirect(true);
                    return pg;
                }
                
            }
        }
        return null;        
    }
    
    /**
     * @description Wrapper class to bind check box and record.
     */
    @SuppressWarnings('PMD.ClassNamingConventions,PMD.EmptyStatementBlock')
    public class wrapJobFunctions {
        /**
         * @description Job_Function__c variable 
         */ 
        public compliancequest__SQX_Job_Function__c lns {get; set;}
        /**
         * @description stores selected
         */
        public Boolean selected {get; set;}
        /**
         * @description stores selected2
         */
        public Boolean selected2 {get; set;}
        /**
          * @description Constructor with parameter
          * @param a job function var
          */
        public wrapJobFunctions(compliancequest__SQX_Job_Function__c a) {
            
        }
        /**
          * @description Constructor without parameter
          */
        public wrapJobFunctions() {
            
        }        
    }
    

    /**
     * @description Method used for cancel.
     * @return PageReference
     */
    public PageReference cancel_goback() {
        PageReference pg = new PageReference('/'+controlleddocId);
        pg.setRedirect(true);
        return pg; 
    }
    
    /**
     * @description Method used for goto First Page.
     */
    public void firstPage()
    {
        setSelectedAccounts();
        OffsetSize = 0;
    }
    
    /**
     * @description Method used for goto previous Page.
     */
    public void previous()
    {
        setSelectedAccounts();
        OffsetSize = OffsetSize - LimitSize;
    }
    
    /**
     * @description Method used for goto next Page.
     */
    public void next()
    {
        setSelectedAccounts();        
        OffsetSize = OffsetSize + LimitSize;
    }
    
    /**
     * @description Method used for goto Last Page.
     */
    public void lastPage()
    {
        setSelectedAccounts();
        OffsetSize = totalrecs - math.mod(TotalRecs,LimitSize);
    }
    
    /**
     * @description Method to get the value of prev page.
     * @return boolean
     */
    public boolean getprev()
    {
        if(OffsetSize == 0)
        {
            return true;
        }            
        else
        {
            return false;
        }            
    }
    
    /**
     * @description Method to get the value of next page.
     * @return boolean
     */
    public boolean getnxt()
    {
        
        if((OffsetSize + LimitSize) > TotalRecs){
            return true;
        }            
        else{
            return false;
        }            
    }
    
    /**
     * @description Method to hide and unhide Classroom Assessment Required? field
     * @story [FLEX-69]:Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
     */
    public void onChangeFnCall()
    {		        
        if(Defaultvalue.compliancequest__Level_of_Competency__c=='Instructor Led with Assessment'
           && siteid=='ALT - Althofen' 
           && (Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {
            disCAR=true; 
        }        
        else
        {
            disCAR=false;  
            disADN=false;
            disRAN=false;  
            Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c=null;
            Defaultvalue.CQ_FLEX_Reason_Assessment_is_not_needed__c=null;
            Defaultvalue.CQ_FLEX_Assessment_Document_Number__c=null;
        }        
    }
    
    /**
     * @description Method to hide and unhide Reason Assessment is not needed and Assessment Document Number fields
     */
    public void onChangeCARCall()
    {        
        if(Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c=='Yes' 
           && siteid=='ALT - Althofen' 
           && (Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {
           disADN=true;
           disRAN=false;
            Defaultvalue.CQ_FLEX_Reason_Assessment_is_not_needed__c=null;
        }
        else if(Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c==null 
                && siteid=='ALT - Althofen' 
                && (Record_Type_Developer_Name=='Controlled_Document'||Record_Type_Developer_Name=='Course'||Record_Type_Developer_Name=='Template_Document'))
        {
            disADN=false;
            disRAN=false; 
            Defaultvalue.CQ_FLEX_Reason_Assessment_is_not_needed__c=null;
            Defaultvalue.CQ_FLEX_Assessment_Document_Number__c=null;
        }
        else
        {
            disADN=false;
            disRAN=true;
            Defaultvalue.CQ_FLEX_Assessment_Document_Number__c=null;
        }
            
    }
    
}