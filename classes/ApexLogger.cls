/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class ApexLogger {
    //cache of log
       public static Map<String,Log> logs = new Map<String,Log>();
        public enum APIType {INBOUND,OUTBOUND,SGIP,PERMIT,PLATFORM,SUNNOVA,SOLAR_OPTIMUM,Platform_Create,Platform_Qualify,Platform_Send_File_To_S3,SPA_PDF_GENERATION}
        public class DmlPermissionException extends Exception{}

       //Wrapper class to hold attachment
       public class Log{
           public Enphase_Logger__c log;
           public Boolean isLogChanged = false;
           public String body='';
           public Log(Enphase_Logger__c log, String body){
               this.log = log;
               this.body = body;
           }
       }
      
       //Creation of logger instance
       public static ApexLogger.Logger createLogger(String logName){       
           if(logs.get(logName)==null){
               logs.put(logName,new Log(new Enphase_Logger__c(Name=logName),''));
           }
           return new ApexLogger.Logger(logName);
       }
      
       //method to log
       @TestVisible
       private static void log(String loggerName,String logMessage){
           if(loggerName == null || loggerName == 'y' ) return;
           if(logs.get(loggerName) == null){
               createLogger(loggerName);
           }      
           logs.get(loggerName).body = logs.get(loggerName).body + '\n'+ logMessage;
          
       }

       @TestVisible
        private static void logRequest(String loggerName,String logMessage){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            logs.get(loggerName).isLogChanged = true;
            logs.get(loggerName).log.Request__c = logMessage;
        }
    
        @TestVisible
        private static void setOperationType(String loggerName,String operationType){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            logs.get(loggerName).isLogChanged = true;
            logs.get(loggerName).log.Operation_Type__c = operationType;
        }
    
        @TestVisible
        private static void logResponse(String loggerName,String logMessage){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            logs.get(loggerName).isLogChanged = true;
            logs.get(loggerName).log.Response__c += logMessage;
        }
    
    
        @TestVisible
        private static void setStatus(String loggerName,String status){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            logs.get(loggerName).isLogChanged = true;
            logs.get(loggerName).log.Status__c = status;
        }

        @TestVisible
        private static String getStatus(String loggerName){
          return logs.get(loggerName).log.Status__c;
        }

        @TestVisible
        private static void setAPIType(String loggerName,APIType theApiType){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            if(theApiType == APIType.INBOUND ){
                logs.get(loggerName).log.API_Type__c = 'Inbound';
            }
            if(theApiType == APIType.OUTBOUND ){
                logs.get(loggerName).log.API_Type__c = 'Outbound';
            }
            if(theApiType == APIType.SGIP){
                logs.get(loggerName).log.API_Type__c = 'SGIP';
            }
            if(theApiType == APIType.PERMIT){
                logs.get(loggerName).log.API_Type__c = 'Permit';
            }
            if(theApiType == APIType.PLATFORM){
                logs.get(loggerName).log.API_Type__c = 'Platform';
            }
            if(theApiType == APIType.SUNNOVA){
                logs.get(loggerName).log.API_Type__c = 'SUNNOVA';
            }
            if(theApiType == APIType.SOLAR_OPTIMUM){
                logs.get(loggerName).log.API_Type__c = 'SOLAR OPTIMUM';
            }
            if(theApiType == APIType.Platform_Create){
                logs.get(loggerName).log.API_Type__c = 'Platform Create';
            }
            if(theApiType == APIType.Platform_Qualify){
                logs.get(loggerName).log.API_Type__c = 'Platform Qualify';
            }
            if(theApiType == APIType.Platform_Send_File_To_S3){
                logs.get(loggerName).log.API_Type__c = 'Platform Send File To S3';
            }
            if(theApiType == APIType.SPA_PDF_GENERATION){	
                logs.get(loggerName).log.API_Type__c = 'SPA PDF Generation';
            }
        }
    
       //Set the Unique Id
       @TestVisible
        private static void setUniqueId(String loggerName,String uniqueId){
            if(loggerName == null || loggerName == '' ) return;
            if(logs.get(loggerName) == null){
                createLogger(loggerName);
            }
            logs.get(loggerName).log.UniqueIdentifier__c = uniqueId;
        }
       //wrapper class to hold logs     
       public class Logger{
            String loggerName;
            public Logger(String loggerName){
                this.loggerName = loggerName;
                }
                public void log(String log){
                    ApexLogger.log(loggerName,log);
                }
            public  void setUniqueId(String uniqueId){
                ApexLogger.setUniqueId(loggerName,uniqueId);
            }
            public  void setOperationType(String  operationType){
                ApexLogger.setOperationType(loggerName,operationType);
            }
            public void logRequest(String logMessage){
                ApexLogger.logRequest(loggerName,logMessage);
            }
            public void logResponse(String logMessage){
                ApexLogger.logResponse(loggerName,logMessage);
            }
            public void setStatus(String status){
                ApexLogger.setStatus(loggerName,status);
            }
            public String getStatus(){
                return ApexLogger.getStatus(loggerName);
            }
    
            public void setAPIType(APIType theApiType){
                ApexLogger.setAPIType(loggerName, theApiType);
            }
       }
      
       //Commit method to commit all logs at once
       public static void commitLogs(){
           try{
               List<Enphase_Logger__c> allLogs = new List<Enphase_Logger__c>();
               for(Log lg : logs.values()){
                   lg.log.Body__c = lg.Body;
                   allLogs.add(lg.log);
               }
                              
            if(!Schema.sObjectType.Enphase_Logger__c.isCreateable() ) {
                throw new DmlPermissionException('Insufficient permissions');
            }             
                          
               insert allLogs;
           }catch(Exception ex){
             System.debug('Error in logging-->'+ex.getMessage());
           }
       }
        
         public static Map<String,Log> getLogs(){
        return logs;
      }
    }