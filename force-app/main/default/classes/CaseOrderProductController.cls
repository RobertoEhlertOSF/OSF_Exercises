public with sharing class CaseOrderProductController {
    @AuraEnabled(cacheable=true)
    public static List<OrderItemWrapper> getOrderItems(String orderNumber){

    List<OrderItem> items = new List<OrderItem>();
    List<OrderItemWrapper> wrappers = new List<OrderItemWrapper>();

    items = [SELECT Id, OrderId, PricebookEntry.Product2.Id, PricebookEntry.Product2.Name, Quantity, UnitPrice FROM OrderItem WHERE Order.OrderNumber = :orderNumber];
            
    if(!items.isEmpty()){
        for(OrderItem item : items){
            wrappers.add(new OrderItemWrapper(item.Id, item.PricebookEntry.Product2.Id, item.OrderId, item.PricebookEntry.Product2.Name, item.Quantity, item.UnitPrice));
        }
    }
    return wrappers;
    }

    @AuraEnabled
    public static void createCaseProduct(List<OrderItemWrapper> items){
        System.debug(items);
        List<Case_Products__c> caseProducts = new List<Case_Products__c>();
        try {
            for(OrderItemWrapper wr : items){
              caseProducts.add(new Case_Products__c(Name = wr.ProductName, Product__c = wr.ProductId, Case__c = (new Case(Status='New', Origin='Web').Id), Order__c=wr.OrderId));
            }

            insert caseProducts;
        } catch (Exception e) {
            HandleException he = new HandleException('CaseOrderProductCotroller', e);
            he.logException();
        }
    }
}
