trigger pmAppTrigger1 on TimeCard__c (before insert, before update) {
    for(TimeCard__c tc : Trigger.new){
        list<Assignment__c> assignList = [SELECT Id, Name, Start_Date__c, End_Date__c FROM Assignment__c where Resource__c =: tc.Resource__c];
        if((assignList == null) || (assignList.size() == 0) ){
            system.debug('You can not create  time card on this resource without any assignment');
            tc.addError('You can not create  time card on this resource without any assignment');
        }
        for(Assignment__c assign : assignList){
                if(tc.Week_Ending__c <= assign.Start_Date__c){
                    tc.addError('Week end date is less then start date on Assignments');
                }
                if(tc.Week_Ending__c >= assign.End_Date__c){
                    tc.addError('Week end date is greter then end date on Assignments');
                }
                
          }
    }
}