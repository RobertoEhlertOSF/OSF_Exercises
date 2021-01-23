@isTest
private class UpdateContactPhoneNumberTest {
    
    private static Id newAccountId;
        
	@testSetup
    private static void setup(){       
        
        Account newAccount = new Account();
        newAccount.name = 'Agro Company';
        insert newAccount;
        newAccountId = newAccount.Id;
        
        List<Contact> newContacts = new List<Contact>();
             
        for(integer a=0; a<19; a++){
            newContacts.add(
                new Contact(
                    lastname = 'Last ' + a,
                    AccountId = newAccountId,
                    Phone = '0000'+ a,
                    Is_Primary_Contact__c = false
                ));
        }
        
        Contact mainContact = new Contact(
        	lastname = 'Main Acc',
            AccountId = newAccountId,
            Phone = '123456789',
            Is_Primary_Contact__c = true
        );
        
        newContacts.add(mainContact);
        
        insert newContacts;
    }
    
    @isTest
    private static void test(){        

        Contact mainContact =
            [SELECT Id, AccountId, Is_Primary_Contact__c FROM Contact Where lastName = 'Main Acc' AND Phone = '123456789' AND Is_Primary_Contact__c = TRUE];
        
        Test.startTest();                   
        UpdateContactPhoneNumber ucpn = new UpdateContactPhoneNumber(mainContact.AccountId, '123456789' );
        Database.executeBatch(ucpn);
        Test.stopTest();

   		System.assertEquals(20, [SELECT count() FROM Contact WHERE AccountId = :mainContact.AccountId AND Phone = '123456789']);
    }
}