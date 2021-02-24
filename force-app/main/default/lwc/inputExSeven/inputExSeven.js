import { LightningElement, track, api, wire } from 'lwc';
import getRecordsTreeView from '@salesforce/apex/TreeViewRecords.getRecordsTreeView'
import getDataTableRecordsView from '@salesforce/apex/DatatableRecords.getDataTableRecordsView'
import getDataTableColumn from '@salesforce/apex/DatatableRecords.getDataTableColumns'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class InputExSeven extends LightningElement {
    @track treeItems;
    @track error;
    @track dataTableItems;
    @track objectAPI;
    @track fieldsAPI;
    @track columns = [{
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
        sortable: true
    },
    {
        label: 'Id',
        fieldName: 'Id',
        type: 'text',
        sortable: true
    },
    {
        label: 'Created Date',
        fieldName: 'CreatedDate',
        type: 'date',
        sortable: true
    }
]; 

    handleObjectAPITextChange(event){
        this.objectAPI = event.target.value;
    }

    handleObjectAPIFieldChange(event){
        this.fieldsAPI = event.target.value;
    }

    handleClick() {

        getDataTableColumn({ fieldsAPI: this.fieldsAPI })
        .then(result =>{
            this.columns = JSON.stringify(result);
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error on retrieving from Datatable Columns',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });

        getDataTableRecordsView({ objectAPIDataTable: this.objectAPI, fieldsAPI: this.fieldsAPI })
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

        getRecordsTreeView({ objectAPITreeView: this.objectAPI, fieldsAPI: this.fieldsAPI })
        .then(result =>{
            this.treeItems = result;
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error on retrieving from TreeView',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}
