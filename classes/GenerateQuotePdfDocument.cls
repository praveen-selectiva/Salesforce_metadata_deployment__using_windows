public with sharing class GenerateQuotePdfDocument{
    
    @InvocableMethod   
    public static void CreateQuote(List<Id> quoteIds)  
    {   
        Integer maxCallout = Integer.valueof(System.Label.MaxCalloutSizeForQuotePdf);
        //Get the Quote Template Id from Custom Label
        String quoteTemplateId = System.Label.QuoteTemplateId;
        Integer minQuoteSize = Integer.valueof(System.Label.MinQuoteSizeForFutureCallout);
        if (quoteIds.size() == minQuoteSize) {
            for (Integer i = 0; i < quoteIds.size(); i++) {
                createSpaPdf(quoteIds[i],quoteTemplateId); 
            }
        } else {
            // List to hold event objects to be published.
            List<SpaPdfCreation__e> spaPdfEventList = new List<SpaPdfCreation__e>();
            for (Integer i = 0; i < quoteIds.size(); i++) {
                if (i < maxCallout) {
                    // Create event objects.
                    SpaPdfCreation__e spaPdfEvent = new SpaPdfCreation__e(Id__c=quoteIds[i],InProgress__c=true,Quote_Template_Id__c=quoteTemplateId);
                    // Add event objects to the list.
                    spaPdfEventList.add(spaPdfEvent);
                } else {
                    System.debug('Future callout limit reached. Cannot make future callout to create SPA PDF more than 50');
                    break;
                }

            }
            // Call method to publish events.
            List<Database.SaveResult> results = EventBus.publish(spaPdfEventList);
            // Inspect publishing result for each event
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
                    }
                }
            }
        }
    }

    @AuraEnabled
    public static Map<String, Object> createSpaPdf(Id quoteId, String quoteTemplateId){
        List<Id> quoteIds = new List<Id>();
        Map<String, Object> result = new Map<String, Object>();
        quoteIds.add(quoteId);
        try {
            createQuoteFutureMethod(quoteIds,quoteTemplateId);
            result.put('status','success');
            result.put('message','The SPA PDF creation process has been queued. It will be created shortly');
        } catch (Exception ex) {
            result.put('status','errror');
            result.put('message',ex.getMessage());
        }
        return result;
    }

    @future(callout=true)
    public static void createQuoteFutureMethod (List<Id> quoteIds, String quoteTemplateId) {
        Map<String, Object> result = new Map<String, Object>();
        //Initialize the quote url                        
        String quoteUrl = '/quote/quoteTemplateDataViewer.apexp?';
        
        //List variable to get all the Quote Documents
        List<QuoteDocument> lstQuoteDoc = new List<QuoteDocument>();
        ApexLogger.Logger logger = ApexLogger.createLogger('GenerateQuotePDF');
        try {
                
            if(!quoteIds.isEmpty() && quoteIds.size() > 0) {
                for(Id quoteId :quoteIds) {
                    logger.setUniqueId(quoteId);
                    logger.setOperationType('CREATE SPA PDF');
                    logger.setAPIType(ApexLogger.APIType.SPA_PDF_GENERATION);
                    //Construct the quote URL to generate PDF
                    quoteUrl += 'id=' + quoteId;
                    quoteUrl += '&headerHeight=197&footerHeight=10';
                    quoteUrl += '&summlid=' + quoteTemplateId;
                    //call the quote url
                    PageReference pageRef = new PageReference(quoteUrl);
                    
                    //get the quotePdf
                    Blob quoteBlob;
                    if(Test.isRunningTest()) {
                        quoteBlob = Blob.valueOf('Generate Pdf');
                    } else {
                        if (quoteTemplateId != null && quoteTemplateId != '' && quoteId != null) {
                            quoteBlob = pageRef.getContentAsPDF();
                        } 
                    }
                    //initialze the QuoteDocument to hold the quote pdf for insertion
                    QuoteDocument quoteDoc = new QuoteDocument();
                    quoteDoc.Document = quoteBlob;
                    quoteDoc.QuoteId = quoteId;
                    try {
                        lstQuoteDoc.add(quoteDoc);
                    } catch (Exception e) {
                        logger.setStatus('Failed');
                        logger.log('Error in SPA PDF creation '+ e.getMessage());
                    }                
                }
            }
            
            if(!lstQuoteDoc.isEmpty() && lstQuoteDoc.size() > 0) {
                try {
                    Database.insert(lstQuoteDoc);
                    logger.setStatus('Success');
                    logger.log('SPA PDF created successfully'); 
                } catch (Exception ex) {
                    logger.setStatus('Failed');
                    logger.log('Error in SPA PDF creation '+ ex.getMessage()); 
                }
            }
        } catch (Exception e) {
            logger.setStatus('Failed');
            logger.log('Error in SPA PDF creation '+ e.getMessage()); 
        }
        finally
        {
            ApexLogger.commitLogs();//Commit logs
        }
    }
}