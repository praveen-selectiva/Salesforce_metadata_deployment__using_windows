public class missingTimeCardBatch implements Database.Batchable<sObject>,Database.Stateful{
    
    public List<Map<String,String>> Data = new List<Map<String,String>>();
    
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name , ( Select id , name, Project__r.Name from TimeCards__r ) FROM Resource__c where Id NOT IN ( Select Resource__c from Assignment__c ) AND Id IN ( Select Resource__c from TimeCard__c )';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Resource__c> scope){
        
        for(Resource__c obj : scope){
            //system.debug(' == '+obj);
            for(TimeCard__c obj1 : obj.TimeCards__r){
                // system.debug('=== '+obj1.Project__r.Name);
                Map<String,String> myData = new Map<String,String>();
                
                String projectName = obj1.Project__r.Name;
                String resourceName = obj.Name;
                String timeCard = obj1.Name;
                myData.put('projectName', projectName);
                myData.put('timeCard', timeCard); 
                myData.put('resourceName', resourceName);
                Data.add(myData);
                
            }                 
        }
        
        system.debug(Data);
    }
    public void finish(Database.BatchableContext BC){
        system.debug('hello finish method');
        
        system.debug(Data);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'praveen.m@selectiva.com','vijay.y@selectiva.com','mahima.m@selectiva.com','indal.b@selectiva.com'}; 
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Salesforce Support ');
        mail.setSubject('TimeCard Batch Call');
        mail.setUseSignature(false);
        String myData = '';
        for(Map<String,String> data : Data){
            myData+='<tr><td> '+data.get('projectName')+'</td><td> '+data.get('resourceName')+'</td><td> '+data.get('timeCard')+'</td></tr>';
        }
        mail.setHtmlBody('<html lang="en"><head> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; border-color: black; text-align: center; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; text-align: center; } </style> </style></head><body> <h3>List of TimeCard that has no Assignments.</h3> <table> <tr> <th>Project Name</th> <th>Resource Name</th> <th>TimeCard Name</th> </tr>'+ myData +' </table></body></html>');
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
    }
}