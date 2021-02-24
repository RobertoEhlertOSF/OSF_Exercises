public with sharing class TreeViewRecords {
    @AuraEnabled(cacheable=true)
    public static List<TreeViewWrapper> getRecordsTreeView(String objectAPITreeView, String fieldsAPI){
        
        String query = '';
        String[] fields;
        
        if(!String.isEmpty(fieldsAPI)) {
            query = 'SELECT Name, Id, CreatedDate, ' + fieldsAPI + ' FROM ' + objectAPITreeView + ' ORDER BY CreatedDate ASC LIMIT 25';
            fields = fieldsAPI.split(',');
        }
        else {
            query = 'SELECT Name, Id, CreatedDate FROM ' + objectAPITreeView + ' ORDER BY CreatedDate ASC LIMIT 25';
        }

        Integer countName = 0;
        List<sObject> sObjList =  Database.query(query);
		List<TreeViewWrapper> rootList = new List<TreeViewWrapper>();
        
        if(sObjList.size() > 0){
            for(Integer i=0; i < sObjList.size(); i++) {
                List<TreeViewWrapper> childWrapper = new List<TreeViewWrapper>();                
				TreeViewWrapper wrapperRoot = new TreeViewWrapper(sObjList[i].get('Name').toString(), String.valueOf(++countName), false, childWrapper);
                childWrapper.add(new TreeViewWrapper(sObjList[i].get('Name').toString(), String.valueOf(++countName), false, new List<TreeViewWrapper>()));
                childWrapper.add(new TreeViewWrapper(sObjList[i].get('Id').toString(), String.valueOf(++countName), false, new List<TreeViewWrapper>()));
                childWrapper.add(new TreeViewWrapper(sObjList[i].get('CreatedDate').toString(), String.valueOf(++countName), false, new List<TreeViewWrapper>()));
                if(fields.size() > 0){
                    for(String field : fields) {
                        childWrapper.add(new TreeViewWrapper(sObjList[i].get(field.trim()).toString(),String.valueOf(++countName), false, new List<TreeViewWrapper>()));
                    }
                }               
                rootList.add(wrapperRoot);
        	}
        }        
        return rootList;
    }
}