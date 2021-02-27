import { LightningElement, track } from 'lwc';

import getOrderItems from '@salesforce/apex/CaseOrderProductController.getOrderItems'
import createCaseProduct from '@salesforce/apex/CaseOrderProductController.createCaseProduct'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class ComponentExEight extends LightningElement {

    @track columns = [
        {
            fieldName: 'ProductName',
            label: 'Product Name',
            cellAttributes: { iconName: { fieldName: 'standard:scan_card' } }
        },
        {
            fieldName: 'UnitPrice',
            label: 'Price',
        },
        {
            fieldName: 'Quantity',
            label: 'Quantity',
        }
    ];

    @track dataTableItems;
    @track searchOrderNumber;
    @track selectedRows;

    handleOrderNumberChange(event){
        this.searchOrderNumber = event.target.value;
    }

    handleClickSelectAll(){
        $( '#datatable input[type="checkbox"]' ).prop('checked', this.checked);
    }

    getSelected() {
        console.log("getSelectedRows => ", this.template.querySelector('lightning-datatable').getSelectedRows());
    }

    handleCreateCaseProduct(){
        let dt = this.template.querySelector('lightning-datatable');
        let dtRows = dt.getSelectedRows();
        
        console.log(dt.getSelectedRows());
        createCaseProduct({ items: dtRows })
        .then(result =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Created',
                    message: 'It was created new Product Cases.',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error on creating new Order Product Cases',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }   

    handleClickSearch(){
        console.log(this.searchOrderNumber);
        getOrderItems({ orderNumber: this.searchOrderNumber })
        .then(result =>{
            this.dataTableItems = result;
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error on retrieving from Datatable',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}