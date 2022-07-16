trigger SpaPdfCreationTrigger on SpaPdfCreation__e (after insert) {
    for (SpaPdfCreation__e event : Trigger.New) {
        if (event.InProgress__c == true) {
            GenerateQuotePdfDocument.createSpaPdf(event.Id__c, event.Quote_Template_Id__c);
        }
    }
}