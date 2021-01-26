@isTest
public class OpportunitySummaryByEmailBatchTest {
    
    @testSetup
    private static void setup(){
        
		List<Account> accountList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Contact> ContactList = new List<Contact>();
        
        for(integer a = 0; a < 5; a++){
            Account acc = new Account(Name='Test Account ' + a);
            accountList.add(acc);
        }
        
        insert accountList;
        
        for (integer a = 0; a<accountList.size(); a++){
            Opportunity oppProspecting = new Opportunity();
            oppProspecting.Name = 'Opp Prospecting ' + a;
            oppProspecting.AccountId = accountList[a].Id;
            oppProspecting.CloseDate =  System.today() + 30;
            oppProspecting.StageName = 'Prospecting';
            oppProspecting.Amount = 15000;
            
            Opportunity oppClosedWon = new Opportunity();
            oppClosedWon.Name = 'Opp Closed Won ' + a;
            oppClosedWon.AccountId = accountList[a].Id;
            oppClosedWon.CloseDate =  System.today() + 30;
            oppClosedWon.StageName = 'Prospecting';
			oppClosedWon.Amount = 30000;
            
            Opportunity oppClosedLost = new Opportunity();
            oppClosedLost.Name = 'Opp Test ' + a;
            oppClosedLost.AccountId = accountList[a].Id;
            oppClosedLost.CloseDate =  System.today() + 30;
            oppClosedLost.StageName = 'Prospecting';
            oppClosedLost.Amount = 7000;
            
            oppList.add(oppProspecting);
            oppList.add(oppClosedWon);
            oppList.add(oppClosedLost);            
        }
        
        insert oppList;
        
        for(integer a = 0 ;a<accountList.size(); a++){
            Contact newContact = 
                new Contact(lastName = 'Contact Test ' + a,
                            is_Primary_Contact__c = true,
                            email='roberto.ehlert@osf.digital',
                            accountId = accountList[a].Id);
            contactList.add(newContact);
        }
        insert contactList;
    }

    @isTest
    private static void BatchOpportunityTest(){
        Test.startTest();
        	OpportunitySummaryByEmailBatch osb = new OpportunitySummaryByEmailBatch();
       		Id batchId = Database.executeBatch(osb);
        Test.stopTest();
        
    }
}