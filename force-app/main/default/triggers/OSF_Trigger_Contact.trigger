trigger OSF_Trigger_Contact on Contact (before update, after update, before insert) {
    
    ContactTriggerHandler handler = new ContactTriggerHandler();

    if(Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }

    if(Trigger.isUpdate) {
        handler.handleBeforeUpdate(Trigger.newMap, Trigger.oldMap, Trigger.IsBefore);
    }
}