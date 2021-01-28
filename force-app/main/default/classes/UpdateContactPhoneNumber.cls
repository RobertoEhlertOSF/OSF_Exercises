public class UpdateContactPhoneNumber implements Database.Batchable<sObject>, Database.Stateful {

    public Integer recordsProcessed = 0;

    private Id accountIdToBeUpdated;
    private string phoneToBeUpdated;

    public UpdateContactPhoneNumber(Id accountIdToBeUpdated, string phoneToBeUpdated){
        this.accountIdToBeUpdated = accountIdToBeUpdated;
        this.phoneToBeUpdated = phoneToBeUpdated;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {        
        return Database.getQueryLocator('SELECT Id, Phone FROM Contact WHERE AccountId = '
                                     +'\'' + String.escapeSingleQuotes(accountIdToBeUpdated) + '\'  AND Is_Primary_Contact__c = false');
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope){

        try{
            List<Contact> contactsToBeUpdated = new List<Contact>();

            for(Contact contactRecord : scope){
                contactRecord.Phone = phoneToBeUpdated;
                recordsProcessed++;
                contactsToBeUpdated.Add(contactRecord);
            }    
    
            update contactsToBeUpdated;
        }
        catch(Exception ex){
			HandleException Handle = new HandleException(ex);
            Handle.logException();
        }
    }

    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed.');
    }
}
