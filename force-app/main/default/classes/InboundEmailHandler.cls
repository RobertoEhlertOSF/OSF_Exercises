global class InboundEmailHandler implements Messaging.InboundEmailHandler {
    
    global static Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        try{
            
            Set<String> emailOrderNumbers = new Set<String>();
            
            //First group doesn't allow numbers or characters before ORD- Preffix
            //Second group is looking for 4 correspondences that matches exacly the ORD- preffix.
            //Third Group is looking for 4 correspondences that are numbers
            //Fourth Group doesn't allow numbers or characters after the numbers correspondence.
            //String regex = '([^0-9]|[^A-Za-z]|$)([ORD-]{4})([^0-9]|[^A-Za-z]|$)';            
            String regex = '([^0-9]|^)([0-9]{8})([^0-9]|$)';
            Matcher emailMatcher = Pattern.compile(regex)
            						.matcher(email.subject + ' ' + email.plainTextBody);
                        
            if(emailMatcher.find()){
                
                for(Integer a = 0; a<emailMatcher.groupCount(); a++){
                    if(emailMatcher.group(a).trim().length() > 0){
                        emailOrderNumbers.add(emailMatcher.group(a).trim());
                        System.debug(emailMatcher.group(a).trim());
                    }
                }
                                
               	List<Order> emailOrders = [SELECT Id FROM Order WHERE OrderNumber IN :emailOrderNumbers];
                List<Case> emailCases = new List<Case>();
                
                for(Order orderRecord : emailOrders){
                	Case newCase = new Case(Status = 'new', Origin = 'email');
                    newCase.Order__c = orderRecord.Id;
                    emailCases.add(newCase);
                }                
                insert emailCases;              
            }            
            return result;
        }
        catch(Exception ex){
            ex.setMessage('this order does not exist. ' + ex.getMessage());
            HandleException exHandler = new HandleException(ex,'InboundEmailHandler');
            return null;
		}
    }
}