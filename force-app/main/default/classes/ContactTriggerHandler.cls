public with sharing class ContactTriggerHandler {
        
    boolean callNewJob = false;
    Id accountIdToBeUpdated;
    string phoneToBeUpdated;

    //Create validation for already existing primary contacts in accounts;
    public void handleBeforeInsert(List<Contact> newTriggerContact){
                
        List<Contact> notAllowedContacts = new List<Contact>();
        //Comparing primary contacts to be added to accounts that has primary contacts already.
        //If matches, they will be included in a black list.        
        for(Contact contact : newTriggerContact){
            if(!isValidPrimaryContactForInsert(contact.AccountId)){
				notAllowedContacts.add(contact);
            }
        }   

        for(Contact notAllowedContact : notAllowedContacts){
            notAllowedContact.addError('There is a primary contact that already exist.');
        }
    }

    public void handleBeforeUpdate(Map<Id, Contact> updatedMapContact, Map<Id, Contact> oldMapContact, boolean isBefore){
        
        
        List<Contact> oldAccountsWithPrimary = new List<Contact>();
        
        if(isBefore){
			oldAccountsWithPrimary = 
         	   [SELECT AccountId FROM Contact WHERE is_Primary_Contact__c = true];   
        }


        for(Id contactId : updatedMapContact.keySet()){
            Contact oldContact = oldMapContact.get(contactId);
			Contact updatedContact = updatedMapContact.get(contactId);
            
            if((oldContact.Phone != updatedContact.Phone) && (oldContact.Is_Primary_Contact__c == true)){
                accountIdToBeUpdated = updatedContact.AccountId;
                phoneToBeUpdated = updatedContact.Phone;
                callNewJob = true;
            }else if(oldContact.Is_Primary_Contact__c == false && updatedContact.Is_Primary_Contact__c == true){
                if(oldAccountsWithPrimary.size() > 0){
                    for(Contact contact : oldAccountsWithPrimary){
                        if(updatedContact.AccountId == contact.AccountId){
                            contact.AddError('There is a primary contact that already exist.');
                        }
                    }   
                }            	
        	}
        }

        if(callNewJob){
            UpdateContactPhoneNumber ucpn = new UpdateContactPhoneNumber(accountIdToBeUpdated, phoneToBeUpdated);
            Database.executeBatch(ucpn, 200);
        }
    }

    private boolean isValidPrimaryContactForInsert(string accountId){          
                
        boolean isAllowed = true;

        for(Contact contact : [SELECT AccountId FROM Contact WHERE Is_Primary_Contact__c = true]){
            if(AccountId == contact.AccountId){
                isAllowed = false;
            }
        } 
        return isAllowed;
    } 
}