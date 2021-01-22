public with sharing class ContactTriggerHandler {
        
    boolean callNewJob = false;
    Id accountIdToBeUpdated;
    string phoneToBeUpdated;

    //Create validation for already existing primary contacts in accounts;
    public void handleBeforeInsert(List<Contact> newTriggerContact){
                
        for(Contact contact : newTriggerContact){
            
        }
    }

    public void handleBeforeUpdate(Map<Id, Contact> newMapContact, Map<Id, Contact> oldMapContact){

        for(Contact contact : newMapContact.new){
            Contact oldContact = oldMapContact.get(contact.Id);
    
            if(oldContact.Phone != contact.Phone && contact.Is_Primary_Contact__c){
                accountIdToBeUpdated = contact.AccountId;
                phoneToBeUpdated = contact.Phone;
                callNewJob = true;
            }
        }

        if(callNewJob){
            UpdateContactPhoneNumber ucpn = new UpdateContactPhoneNumber(accountIdToBeUpdated, phoneToBeUpdated);
            Database.executeBatch(ucpn, 200);
        }
    }
}
