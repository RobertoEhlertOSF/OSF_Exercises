trigger OSF_Trigger_Contact on Contact (before insert, before update, after update) {

    ContactTriggerHandler handler = new ContactTriggerHandler();

    if(Trigger.isInsert) {
        handler.handleBeforeCreate(Trigger.new);
    }

    if(Trigger.isUpdate) {
        handler.handleBeforeUpdate(Trigger.newMap, Trigger.oldMap);
    }
}