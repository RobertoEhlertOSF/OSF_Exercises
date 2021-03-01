 public with sharing class OrderItemWrapper {

@AuraEnabled
public Id Id {get; set;}
@AuraEnabled
public Id ProductId {get; set;}
@AuraEnabled
public Id OrderId {get; set;}
@AuraEnabled
public String ProductName {get; set;}
@AuraEnabled
public Decimal Quantity {get; set;}
@AuraEnabled
public Decimal UnitPrice {get; set;}

public OrderItemWrapper(){}

    public OrderItemWrapper(String Id, String ProductId, String OrderId, String ProductName, Decimal Quantity, Decimal UnitPrice){
        this.Id = Id;
        this.ProductId = ProductId;
        this.OrderId = OrderId;
        this.ProductName = ProductName;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
    }
}

