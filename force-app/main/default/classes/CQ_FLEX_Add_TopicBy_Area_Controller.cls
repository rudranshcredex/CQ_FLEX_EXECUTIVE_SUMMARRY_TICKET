/********************************** Revision History ************************************************************
*@description : 
*1.[FLEX-52]-Documents - Area configuration continued
*********************************** Revision History **************************************************************/
public with sharing class CQ_FLEX_Add_TopicBy_Area_Controller {
    /**
     * @description variable to store the record and checkbox
     */
    public list<wrapJobFunctions> wraplist1{get;set;}
    /**
     * @description variable to store the searchstring
     */        
    public string searchstring {get; set;}    
    public string ControlleddocId;
    public string Siteid;
    /**
     * @description variable to store the selectedArea
     */
    Public List<compliancequest__SQX_Site__c> selectedArea{get;set;} 
    /**
     * @description variable to store the topic_name
     */
    Public Set<string> topic_name{get;set;}
    /**
     * @description variable to store the totalRecordCount
     */
    Public Integer totalRecordCount{get;set;}
    /**
     * @description variable to store the fetchedRecordCount
     */
    Public Integer fetchedRecordCount{get;set;}
    Public integer TotalRecs = 0;
    Public integer OffsetSize = 0;
    Public integer LimitSize= 20;
    Public Set<id> SelectedAreaIds; 
    Public Set<String> DeselectedAreaIds; 
    set<id> Areaid=new set<id>();
    string TempInput='%%';
    
    
    /**
     * @description : Standard controller Constructor for get the current page id.
     * @param controller gets the current record
     */ 
    public CQ_FLEX_Add_TopicBy_Area_Controller (ApexPages.StandardController controller) {
        ControlleddocId = ApexPages.currentPage().getParameters().get('id').escapeHtml4();
        Siteid= ApexPages.currentPage().getParameters().get('site');
		topic_name=new set<string>();
        SelectedAreaIds = new Set<id>();
        DeselectedAreaIds = new Set<String>();
        wraplist1 = new List<wrapJobFunctions>();        
        selectedArea  = new List<compliancequest__SQX_Site__c>(); 
        
        //Get Topic names assigned to current controlled doc
        list<TopicAssignment> ta_list=[SELECT id,EntityId,Topic.name from TopicAssignment where EntityId =: ControlleddocId];
        for(TopicAssignment ta:ta_list)
        {
           topic_name.add(ta.Topic.name); 
        }
        
        //Get Area names with the Topic names
        list<compliancequest__SQX_Site__c> cqarea_list=[SELECT id,name from compliancequest__SQX_Site__c where name in: topic_name];
        for(compliancequest__SQX_Site__c cqarea:cqarea_list)
        {
            SelectedAreaIds.add(cqarea.id); 
            DeselectedAreaIds.add(cqarea.name); 
        }
        
    }
    
    /**
     * @description : Set Selected Areas.
     */
    public void setSelectedAreas()
    {           
        for(wrapJobFunctions item: wraplist1)
        {           
            if(item.selected)
            {    
                if(!this.SelectedAreaIds.contains(item.lns.id))
                {
                    this.SelectedAreaIds.add(item.lns.id);
                }
            }
            else
            {
                if(this.SelectedAreaIds.contains(item.lns.id))
                {
                    this.SelectedAreaIds.remove(item.lns.id);
                }
            }
        }  
        
    }
    
    /**
     * @description : Get Selected Areas.
     * @return SelectedAreaIds size.
     */
    public Integer getSelectedCount(){
        return this.SelectedAreaIds.size();
    }
    
    /**
     * @description : Get Selected Areas.
     * @return SelectedAreas.
     */
    public List<compliancequest__SQX_Site__c> getSelectedAreas(){    
        List<compliancequest__SQX_Site__c> areaList = [Select id,name
                                                                 From compliancequest__SQX_Site__c 
                                                                 Where ID IN : SelectedAreaIds];       
        
        return areaList;
    }
    
    /**
     * @description : Intiallize the list of the records to render the table.
     * @return wraplist1.
     */
    public wrapJobFunctions[] getwrapJFList()
    {        
        wraplist1 = new List<wrapJobFunctions>();
       
        TotalRecs=[SELECT count()
                   FROM compliancequest__SQX_Site__c 
                   WHERE (name like: TempInput OR 
                          CQ_FLEX_Department_Name__c like: TempInput OR 
                          CQ_FLEX_Site__c like: TempInput) AND CQ_FLEX_Site__c =:Siteid];
        list<compliancequest__SQX_Site__c> areaList=[SELECT id,name,CQ_FLEX_Site__c,compliancequest__SQX_Business_Unit__r.name
                                                     FROM compliancequest__SQX_Site__c 
                                                     WHERE (name like: TempInput OR 
                                                            CQ_FLEX_Department_Name__c like: TempInput OR 
                                                            CQ_FLEX_Site__c like: TempInput) AND CQ_FLEX_Site__c =:Siteid 
                                                     ORDER BY name ASC LIMIT :LimitSize OFFSET :OffsetSize];
        
       
        for(compliancequest__SQX_Site__c jf:areaList)            
        {            
            wrapJobFunctions wrapJFList = new wrapJobFunctions();            
            wrapJFList.lns=jf;
            if(this.SelectedAreaIds.contains(jf.Id))
            {
                wrapJFList.Selected = true;
            }
            else
            {
                wrapJFList.Selected = false;
            }
            wraplist1.Add(wrapJFList);             
        } 
        return wraplist1;        
    }
    
    /**
     * @description : Method to assign the search value to variable.
     */
    public void searchAreas(){
        setSelectedAreas();
        TempInput = '%' + searchstring + '%';        
    }
    
    
    
    /**
     * @description : Method to process the selected records.
     * @return PageReference or null
     */
    public PageReference processSelected() { 
		set<string> site_areaname=new set<string>();
        set<string> topic_names=new set<string>();
        set<string> allAreasSel=new set<string>();
        set<string> deselected_Areas=new set<string>();
        list<topic> newAreas=new list<topic>();
        list<TopicAssignment> reqlist=new list<TopicAssignment>();

        setSelectedAreas();       
        selectedArea  = getSelectedAreas();
        
        for(compliancequest__SQX_Site__c jf:selectedArea)
        {
            allAreasSel.add(jf.name);
            if(!(topic_name.contains(jf.name))){
                site_areaname.add(jf.name); 
            }           
        }
        
        list<Topic> topicslist=[SELECT id,name
                        FROM topic where name in: site_areaname];
        for(topic topic_single:topicslist)
        {
            topic_names.add(topic_single.name);
        }
        
        for(string s_a : site_areaname)
        {
            if(!(topic_names.contains(s_a)))
            {
                topic top=new topic(name=s_a); 
                newAreas.add(top);
            }                             
        }
        if(newAreas.size()!=0){
            Insert newAreas;
        }
        
        
        list<Topic> topics=[SELECT id,name
                        FROM topic where name in: site_areaname];
        
        for(Topic lns : topics) {             
            TopicAssignment topass=new TopicAssignment();
            //req.compliancequest__Active__c=true;
            topass.EntityId=ControlleddocId;
            topass.Topicid=lns.id;           
            reqlist.add(topass);            
        } 
        
        //Insert the selected Topic to the Controlled document.
        Database.SaveResult[] results = Database.insert(reqlist, true);
        
        for(string ar:DeselectedAreaIds)
        {
            if(!(allAreasSel.contains(ar)))
            {
                deselected_Areas.add(ar);
            }                
        }
        
        list<TopicAssignment> tadl_list=[SELECT id,EntityId,Topic.name from TopicAssignment where Topic.name in: deselected_Areas limit 900];
        Database.DeleteResult[] del_results=new Database.DeleteResult[]{};
            
        if(tadl_list.size()!=0)
        {
            del_results = Database.delete(tadl_list, true); 
        }
        
        if(results.size()!=0){
            if(results[0].isSuccess()){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Created Successfully.Thank you!'));
                //Redirect the page to Controlled Document record page after creation of record successfully.         
                PageReference pg = new PageReference('/'+ControlleddocId);
                pg.setRedirect(true);
                return pg;
            }
            
        }
        
        if(del_results.size()!=0){
            if(del_results[0].isSuccess()){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Records Deleted Successfully.Thank you!'));
                //Redirect the page to Controlled Document record page after deletion of record successfully.         
                PageReference pg = new PageReference('/'+ControlleddocId);
                pg.setRedirect(true);
                return pg;
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
          * @description variable to store the Sites
          */
        public compliancequest__SQX_Site__c lns {get; set;}
        /**
          * @description variable to store the selected value.
          */
        public Boolean selected {get; set;}
        
        /**
          * @description Constructor with parameter
          * @param a site var
          */
        public wrapJobFunctions(compliancequest__SQX_Site__c a) {
            
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
        PageReference pg = new PageReference('/'+ControlleddocId);
        pg.setRedirect(true);
        return pg; 
    }
    
    /**
     * @description Method used for goto First Page.
     */
    public void firstPage()
    {
        setSelectedAreas();
        OffsetSize = 0;
    }
    
    /**
     * @description Method used for goto previous Page.
     */
    public void previous()
    {
        setSelectedAreas();
        OffsetSize = OffsetSize - LimitSize;
    }
    
    /**
     * @description Method used for goto next Page.
     */
    public void next()
    {
        setSelectedAreas();        
        OffsetSize = OffsetSize + LimitSize;
    }
    
    /**
     * @description Method used for goto Last Page.
     */
    public void lastPage()
    {
        setSelectedAreas();
        OffsetSize = TotalRecs - math.mod(TotalRecs,LimitSize);
    }
    
    /**
     * @description Method used for goto prev Page.
     * @return PageReference
     */
    public boolean getprev()
    {
        if(OffsetSize == 0){
            return true;
        }            
        else{
            return false;
        }            
    }
    
    /**
     * @description Method used for goto next Page.
     * @return PageReference
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
}