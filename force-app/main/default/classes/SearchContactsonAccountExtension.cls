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
    private Account accountRecord {get; set;}
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
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,string.valueof(ex)); 
            ApexPages.addmessage(myMsg);
        }
    }
    
    public void setAsPrimary(){
        
        try{
            //Reset contacts is primary attribute to false
            List<Contact> actualContacts = new List<Contact>();
      	    List<Contact> contactListToReset = new List<Contact>();
      
            for(Contact contact : [SELECT Id, Is_Primary_Contact__c FROM Contact WHERE AccountId = :accountRecord.Id AND (Is_Primary_Contact__c = true OR Id = :selectedContactId)]){
                if(contact.Id != selectedContactId){
                    contact.Is_Primary_Contact__c = false;                
                }
                else {
                    contact.Is_Primary_Contact__c = true;
                }
                dddcontactListToReset.add(contact);
            }
        
            update contactListToReset;
        }
        catch(Exception ex){

        }
    }    
}