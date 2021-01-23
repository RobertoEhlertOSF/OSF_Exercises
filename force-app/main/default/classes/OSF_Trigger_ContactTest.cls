@isTest
private class OSF_Trigger_ContactTest {
    
    @isTest static void TestInsertNewPrimaryContact(){
    	Account newAccount = new Account(Name='Account for Testing');
    	insert newAccount;
        
    	Contact newContact = new Contact(lastName = 'LastName New', Is_Primary_Contact__c = true, AccountId = newAccount.Id);
    	insert newContact;
    
   		Contact testContact = new Contact(lastName = 'LastName Test', Is_Primary_Contact__c = true, AccountId = newAccount.Id);
    
    	Test.startTest();
        	Database.SaveResult result = Database.insert(testContact, false);
    	Test.stopTest();
        
        System.assert(result.getErrors().size() > 0);
        System.assert(!result.isSuccess());
    }    
}