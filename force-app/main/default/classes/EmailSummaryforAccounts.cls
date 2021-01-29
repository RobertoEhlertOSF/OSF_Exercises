public class EmailSummaryforAccounts {
    
	public static void sendEmail(string accountName, string emailAddress, double amountOpen, double amountClosedWon, double amountClosedLost ){
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.toaddresses = new String[] {emailAddress};
            
		string emailStyle = '<head> <style type="text/css">' +
			' .fixed_headers th, .fixed_headers td { padding: 5px; text-align: center; } ' +
			' .fixed_headers td:nth-child(1), .fixed_headers th:nth-child(1) { min-width: 33%; } ' +
			' .fixed_headers td:nth-child(2), .fixed_headers th:nth-child(2) { min-width: 33%; } ' +
			' .fixed_headers td:nth-child(3), .fixed_headers th:nth-child(3) { width: 33%; } ' +
			' .fixed_headers thead { background-color: #333; color: #FDFDFD; } ' + 
			' .fixed_headers tbody tr:nth-child(even) { background-color: #DDD; } </style> ';
        
		string emailHeader = '<body> <table class="fixed_headers"> ' + 
			' <thead> <tr> <th>Account</th> <th>Stage</th> <th>Amount</th> </tr> </thead>';
           
		string emailBody = ' <tbody> ';
        
      	   emailBody += '<tr> <td>' + accountName + '</td> <td> Open 		  </td>	<td> $' + amountOpen 	   + '</td> </tr>' + 
						'<tr> <td>' + accountName + '</td> <td> Closed Won  </td> <td> $' + amountClosedWon  + '</td> </tr>' +
						'<tr> <td>' + accountName + '</td> <td> Closed Lost </td> <td> $' + amountClosedLost + '</td> </tr>';
        
       	emailBody += '</tbody> </table> </body>';
		mail.setHtmlBody('<html> ' + emailStyle + emailHeader + emailBody + '</html>');       
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}