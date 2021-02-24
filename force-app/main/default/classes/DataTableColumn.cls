public class DataTableColumn {
    
@AuraEnabled
public String label {get;set;}
@AuraEnabled
public String fieldName {get;set;}
@AuraEnabled
public String type {get;set;}
@AuraEnabled
public Boolean sortable {get;set;}

    
    public DataTableColumn(String label) {
        this.label = label;
        this.fieldName = label;
        this.type = 'text';
        this.sortable = true;
    }
}
