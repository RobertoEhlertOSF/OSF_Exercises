({
	doInit : function(component, event, helper) {      
        helper.getColumns(component);
        helper.getDocuments(component, helper);
        helper.getSelectOptions(component);
        helper.getTotalCount(component);
	},    
    handleRowAction : function(component, event, helper) {
    	var selRows = event.getParam('selectedRows');
        component.set("v.delIds",selRows);
        var btnDelete = component.find("btnDelete");
        if(selRows.length === 0){                            
        	btnDelete.set('v.disabled',true);
       	}
        else{
        	btnDelete.set('v.disabled',false);
        }        
    },
    doDelete : function(component, event, helper){
        if(confirm('Are you sure you want to delete these items?')) {
        	var delIdList = component.get("v.delIds");
        	var action = component.get('c.deleteItems');
        	action.setParams({lstId : delIdList});
        	action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                alert('Successfully Deleted');   
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);                                    
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
        }
    },
    // this function call on click on the next page button 
    handleNext : function(component, event, helper) { 
        let pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getDocuments(component, helper);
    },
    // this function call on click on the previous page button  
    handlePrev : function(component, event, helper) {        
        let pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getDocuments(component, helper);
    },    
    handleChangePagination : function(component, event, helper) {
        let selectedOption = event.getParam("value");
        component.set("v.pageSize", selectedOption);
        helper.getDocuments(component, helper);
        helper.getTotalCount(component);
    },
    handleChangePaginationLibraryFilter : function(component, event, helper) {
        let selectedOption = event.getSource().get("v.value");
        component.set("v.libraryFilter", selectedOption);
        helper.getDocuments(component);
        helper.getTotalCount(component);
    }
})