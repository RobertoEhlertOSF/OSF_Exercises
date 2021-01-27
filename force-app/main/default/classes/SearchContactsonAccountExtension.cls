public with sharing class SearchContactsonAccountExtension {

    public string selectedContactId {get;set;} 

	public List<Contact> accountContacts{
        get{
            if(childContacts == null){
                childContacts = [SELECT
                                 Name,
                                 Title,
                                 Phone,
                                 Is_Primary_Contact__c 
                                 FROM Contact 
                                 WHERE AccountId = :accountRecord.id
                                 LIMIT 1000];
            }
            return childContacts;            
        }
        set;
    }    

    public string searchText
    {
        get{
            if (searchText==null){
                searchText = '';
            }
            return searchText;
        }
        set;
    }

    private List<Contact> childContacts;
    private Account accountRecord {
        get{
            if(accountRecord == null){
                accountRecord = (Account) sdtController.getRecord();
            }
            return accountRecord;
        }
        set;
    }
    private ApexPages.StandardController sdtController;

    public SearchContactsonAccountExtension(ApexPages.standardController sdtController) {

        this.sdtController = sdtController;
        accountRecord = (Account) sdtController.getRecord();
    }

    public void search(){

        string searchQuery = 
        'SELECT Name, Title, Phone, Is_Primary_Contact__C ' + 
        'FROM Contact ' +
        'WHERE AccountId = \'' + accountRecord.Id + '\' AND NAME LIKE \'%' + String.escapeSingleQuotes(searchText) + '%\'' +
        'ORDER BY NAME LIMIT 1000';

        try{
            childContacts = Database.query(searchQuery);
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.ERROR,string.valueof(ex))); 
        }
    }

    public void setAsPrimary(){

        try{
            Contact contactToUpdate = [SELECT Id, Is_Primary_Contact__c FROM Contact WHERE Id = :selectedContactId];
            contactToUpdate.Is_Primary_Contact__c = true;
            update contactToUpdate;
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.ERROR,string.valueof(ex))); 
        }
    }    
}