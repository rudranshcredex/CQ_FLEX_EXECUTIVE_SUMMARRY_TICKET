({
    openPage : function(component,event){
        var recordId = component.get('v.recordId');
        //Open New Browser Tab with Visualforce Page
        window.open('/apex/CQ_FLEX_Signature_Manifest?id='+recordId,'_blank');
        //Close Action Button Modal
        $A.get('e.force:closeQuickAction').fire();
    }
})