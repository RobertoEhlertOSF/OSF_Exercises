public with sharing class DataTableRecords{
    @AuraEnabled(cacheable=true)
    public static List<sObject> getDataTableRecordsView(String objectAPIDataTable, String fieldsAPI){

        String query = '';
        if(!String.isEmpty(fieldsAPI)){
            query = 'SELECT Name, Id, CreatedDate, ' + fieldsAPI + ' FROM ' + objectAPIDataTable + ' ORDER BY CreatedDate ASC LIMIT 25';
        }
        else{
            query = 'SELECT Name, Id, CreatedDate, FROM ' + objectAPIDataTable + ' ORDER BY CreatedDate ASC LIMIT 25';
        }
         
        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<DataTableColumn> getDataTableColumns(String fieldsAPI){

        //Static columns
        String allFields = 'Name,Id,CreatedDate';
        List<DataTableColumn> columns = new List<DataTableColumn>();
        if(!String.isEmpty(fieldsAPI)) {
            allFields += ',' +  fieldsAPI;       
        }
        for(String column : allFields.split(',')){
            columns.add(new DataTableColumn(column));
        }

        return columns;
    }
}
