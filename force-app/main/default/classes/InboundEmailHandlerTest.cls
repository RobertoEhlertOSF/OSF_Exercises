@isTest global class InboundEmailHandlerTest {
    
    @isTest static void handleInboundEmailSingleTest() {
     	Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
      	Account newAccount = new Account(Name='Account Test');
        insert newAccount;
        
        Contract newContract = new Contract(Status='Draft', ContractTerm = 6, AccountId = newAccount.Id);
        insert newContract;
        
        Order newOrder = new Order(
            Status='Draft',
			AccountId = newAccount.Id,
            ContractId = newContract.Id,
            EffectiveDate = date.today()
        );
        
        insert newOrder;
        
        //Email Setup
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
		Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        Order orderWithNumber = [SELECT OrderNumber FROM Order WHERE Id = :newOrder.Id];
        
        email.Subject = 'Service Request';
        email.plainTextBody = 'This is a request for service from ' + orderWithNumber.OrderNumber + ' may you help me?';
        envelope.fromAddress = 'roberto.ehlert@osf.digital';
        
        Test.startTest();        
		InboundEmailHandler.handleInboundEmail(email, envelope);
        
        //Assert the included case__ associated with the order
        List<AggregateResult> totalCount = [SELECT Count(Id) FROM Case WHERE Order__c = :newOrder.Id];
        System.assertEquals(1, (Integer) totalCount[0].get('expr0'));

        Test.stopTest();
    }
    
    @isTest static void handleInboundEmailTestException(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        email.Subject = 'Service Request';
        email.plainTextBody = 'This is a request for service from 99999999 may you help me?';
        envelope.fromAddress = 'roberto.ehlert@osf.digital';
        
        Test.startTest();
        try{
        	InboundEmailHandler.handleInboundEmail(email, envelope);
        }
        catch(Exception ex){
			System.assert(ex.getMessage().contains('This order does not exist'));
        }
		Test.stopTest();        
    }   
}