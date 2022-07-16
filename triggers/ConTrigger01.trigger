trigger ConTrigger01 on Contact (before insert, before update,after insert,after update) {
    
    //execute before saving or updating the record
    if(Trigger.isBefore){
        //execute before saving or creating  the record in database
        if(Trigger.isInsert){
            system.debug('before insert');
        }
        //execute before updting the record in database
        if(Trigger.isUpdate){
            system.debug('before update');
        }
        
    } 
    //if no execution on before record save, It means This execute after record save or update
    // If the trigger is not a before trigger, it must be an after trigger.
    else {
        //execute After saving or creating  the record in database
        if(Trigger.isInsert){
            system.debug('After insert');
        }
        //execute After updting the record in database
        if(Trigger.isUpdate){
            system.debug('After update');
        }
    }
}