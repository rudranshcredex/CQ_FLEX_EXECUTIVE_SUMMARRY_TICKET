({
    //invokes when the component is loaded
    onInit : function(component, event, helper) {
        //retrives the group id from the custom settings and sets in recordId
        helper.invokeAction(component.get('c.getGroupId'), {
        }).then(function(data) {
            component.set("v.recordId", data);
        });
    }
})