public class OpportunitySummaryByEmailBatch implements Database.Batchable<sObject>, Database.Stateful  {
         
    public Integer emailsSent = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator(
       		'SELECT Id, Name, ' +
            '(SELECT email FROM Contacts WHERE Is_Primary_Contact__c = true LIMIT 1), ' +
            '(SELECT Amount, isWon, isClosed FROM Opportunities ' +
            'WHERE CreatedDate = THIS_MONTH OR LastModifiedDate = THIS_MONTH)' +
            ' FROM Account '
        );
    }
    
     public void execute(Database.BatchableContext bc, List<Account> records){
        for(Account acc : records){
            
			Double amountClosedWon = 0;
			Double amountOpen = 0;
			Double amountClosedLost = 0;	
				
			for(Opportunity opp : acc.Opportunities ){
				
				if(!opp.isClosed){
					amountOpen += opp.Amount;
				}
				else if(opp.isClosed && opp.IsWon){
					amountClosedWon += opp.Amount;
				}
				else{
					amountClosedLost += opp.Amount;
				}  
			}
            //Only one primary contact per account.
            if(acc.Contacts.size() > 0 && acc.Contacts[0].email != null){
            	EmailSummaryforAccounts.sendEmail(acc.Name, acc.Contacts[0].email, amountOpen , amountClosedWon, amountClosedLost); 
                emailsSent++;
            }            
        } 
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Emails Sent: ' + emailsSent );
    } 
}