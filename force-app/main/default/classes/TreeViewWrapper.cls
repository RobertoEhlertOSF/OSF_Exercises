public with sharing class TreeViewWrapper {  
	@AuraEnabled
    public String label;
    @AuraEnabled
	public String name;
    @AuraEnabled 
    public Boolean expanded;
    @AuraEnabled
    public List<TreeViewWrapper> items;
    
    public TreeViewWrapper(String label, String name, Boolean expanded, List<TreeViewWrapper> items){
        this.label = label;
        this.name = name;
        this.expanded = expanded;
        this.items = items;
    }
}