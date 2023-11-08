({
    //invokes when the component is loaded
    onInit : function(component, event, helper) {
        //retrives the developerName from the custom settings and sets in developerName
        helper.invokeAction(component.get('c.getDeveloperName'), {
        }).then(function(data) {
            component.set("v.developerName", data);
        });
    }
})