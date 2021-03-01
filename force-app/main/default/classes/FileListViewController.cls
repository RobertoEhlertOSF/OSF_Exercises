public with sharing class FileListViewController {
	@AuraEnabled
    public static List<File> getContentDocuments(String pageSize, String pageNumber, String libraryFilter) {     
        private Integer pSize = Integer.valueOf(pageSize);
        private Integer pNumber = Integer.valueOf(pageNumber)-1;
        private String likeLibraryFilter = '%' + libraryFilter + '%';
        private List<ContentWorkspaceDoc> workspaces = new List<ContentWorkspaceDoc>();
        
        if(string.isEmpty(libraryFilter)) {
            workspaces = [SELECT ContentDocument.Id, ContentWorkspace.Id, ContentDocument.Owner.Id, ContentDocument.Title, ContentWorkspace.Name, ContentDocument.Owner.Name, ContentDocument.LastModifiedDate 
							FROM ContentWorkspaceDoc LIMIT :Integer.valueOf(pSize) OFFSET :(pSize*pSize)];
        } else {
            workspaces =  [SELECT ContentDocument.Id, ContentWorkspace.Id, ContentDocument.Owner.Id, ContentDocument.Title, ContentWorkspace.Name, ContentDocument.Owner.Name, ContentDocument.LastModifiedDate 
							FROM ContentWorkspaceDoc WHERE ContentWorkspace.Name LIKE :likeLibraryFilter LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)];
        }
        List<File> files = new List<File>();
        
        for(ContentWorkspaceDoc w : workspaces) {
            File file = new File(
                w.ContentDocument.Id,
                w.ContentWorkspace.Id,
                w.ContentDocument.Owner.Id,
            	w.ContentDocument.Title,
                w.ContentWorkspace.Name,
                w.ContentDocument.Owner.Name,
                w.ContentDocument.LastModifiedDate
            );
            files.add(file);
         }
        return files;
    }
	
    @AuraEnabled
    public static List<ContentWorkspace> getSelectOptions() {
        return [SELECT Name FROM ContentWorkspace LIMIT 100];
    }   
    
    @AuraEnabled
    public static Integer getTotalDocs() {
        return [SELECT Count() FROM ContentDocument LIMIT 100];
    }
    
    @AuraEnabled
    public static void deleteItems(List<File> fileList) {        
        List<Id> contentDocIds = new List<Id>();

        for(File f : fileList) {
            contentDocIds.add(f.ContentDocumentId);
        }
                
        try{
            List<ContentDocument> doc = [SELECT Id FROM ContentDocument WHERE Id IN :contentDocIds];
        	delete doc;
        }
        catch(Exception ex) {
            HandleException he = new HandleException(ex, 'FileListViewController');
            he.logException();
        } 
    }
}