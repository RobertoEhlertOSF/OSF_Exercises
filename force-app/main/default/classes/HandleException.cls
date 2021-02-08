public class HandleException extends Exception{
    
    private Exception ex;
    private String className;
    
    public HandleException(Exception ex, String ClassName){
		this.ex = ex; 
        this.className = className;
    }
    
    public void logException(){
        Error_Log__c errorLog = new Error_Log__c();
        errorLog.Name = className;
        errorLog.StackError__c = ex.getStackTraceString();   
        errorLog.Message__c = ex.getMessage();
        
		insert errorLog;
    }
}