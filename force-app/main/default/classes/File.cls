public class File {	
    @AuraEnabled
    public String ContentDocumentId {get; set;}
    @AuraEnabled
    public String ContentWorkspaceId {get; set;}
    @AuraEnabled
    public String OwnerId {get; set;}
    @AuraEnabled
    public String Title {get; set;}
    @AuraEnabled
    public String Library {get; set;}
    @AuraEnabled
    public String Owner {get; set;}
    @AuraEnabled
    public DateTime LastModifiedDate {get; set;}
    
    public File(){}
    
    public File(String contentDocumentId, String contentWorkspaceId, String ownerId, String title, String library, String owner, DateTime lastModifiedDate){
        
        this.ContentDocumentId = contentDocumentId;
        this.ContentWorkspaceId = contentWorkspaceId;
        this.OwnerId = ownerId;
		this.Title = Title; 
        this.Library = library;
        this.Owner = owner;
        this.LastModifiedDate = lastModifiedDate;
    }
}