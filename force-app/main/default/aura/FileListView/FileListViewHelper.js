({
	getColumns : function(component) {
        component.set('v.columns', [
            {	label: 'Title',
                fieldName: 'urlFile',
                type: 'url',
                typeAttributes: {label: {fieldName: 'Title'},
                                target: '_self'}
            },
            {  label: 'Library',
               fieldName: 'urlLibrary',
               type: 'url',
               typeAttributes: {label: { fieldName: 'Library'},
                                target: '_self'}            
            },
            {	label: 'Owner',
                fieldName: 'urlOwner',
                type: 'url',
                typeAttributes: { label: { fieldName: 'Owner'},
                                target: '_self'}            
            },
            {	label: 'Last Modified Date',
                fieldName: 'LastModifiedDate',
                type: 'datetime',
                sortable: true 
            }
        ]);		
	},
    getDocuments : function(component){
        let hostname = window.location.hostname;                
		let action = component.get("c.getContentDocuments"); 
        let pageSize = component.get("v.pageSize").toString();
        let pageNumber = component.get("v.pageNumber").toString();
       	let libraryFilter = component.get("v.libraryFilter");
        action.setParams({
            'pageSize' : pageSize,
            'pageNumber' : pageNumber,
            'libraryFilter': libraryFilter
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let files = response.getReturnValue();
                files.forEach(function(item) {
                	item['urlFile'] = hostname + '/lightning/r/ContentDocument/' + item['ContentDocumentId'] + '/view';             
                    item['urlLibrary'] = hostname + '/lightning/r/ContentWorkspace/' + item['ContentDocumentId'] + '/view'; 
                    item['urlOwner'] = hostname + '/lightning/r/User/' + item['OwnerId'] + '/view'; 
                });
                
                if(files.length < component.get("v.pageSize")){
                    component.set("v.isLastPage", true);
                } else {
                    component.set("v.isLastPage", false);
                }
                
                component.set("v.file", files);	
            }
            else {
                console.log("Failed with state: " + state);
            }
        });        
        $A.enqueueAction(action);
	},    
    getSelectOptions : function(component){    
    	let actionSelect = component.get("c.getSelectOptions");
        	actionSelect.setCallback(this, function(response) {
            let stateSelectionAction = response.getState();
            if (stateSelectionAction === "SUCCESS") {
                component.set("v.options", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + stateSelectionAction);
            }
        });  
        $A.enqueueAction(actionSelect); 
    },
    getTotalCount : function(component){
        let actionGetTotal = component.get("c.getTotalDocs");
        actionGetTotal.setCallback(this, function(response) {
        	let state = response.getState();
        	if (state === "SUCCESS") {
        		component.set("v.dataSize", response.getReturnValue());
                let pageSize = component.get("v.pageSize");
        		let dataSize = response.getReturnValue();
        		let pagesLeft = Math.ceil(dataSize/pageSize);
        		component.set("v.pagesLeft", pagesLeft);
			}
        	else {
        		console.log("Failed with state: " + state);
        	}
        });
		$A.enqueueAction(actionGetTotal); 
    }
})