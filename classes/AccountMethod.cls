/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : he
 * @last modified on  : 07-18-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class AccountMethod {
	
    @AuraEnabled
    public static List<Account> findAllList(){
        System.debug('hello');
        return [SELECT Id, Name, ( SELECT Name,Phone FROM Contacts ) FROM Account LIMIT 25];
    }
    
    @AuraEnabled
    public static List<Account> findByName(String searchKey){
        String name = '%' + searchKey + '%';
        return [SELECT Id, Name, ( SELECT Name,Phone FROM Contacts ) FROM Account WHERE name LIKE :name LIMIT 25];
    }
    
    @AuraEnabled
    public static Account findById(String accountId){
        system.debug('hello');
        system.debug(accountId);
        return [SELECT Id, Name, ( SELECT Name,Phone FROM Contacts ) FROM Account WHERE Id =: accountId];
    }
    
    @AuraEnabled
    public static List<sobject> getRecentRecords(String ObjectName, String limits){
        system.debug(ObjectName);
        system.debug(limits);
        
        List<Id> recentlyViewedIds = new List<Id>();
        Integer limitofRecord = Integer.valueOf(String.escapeSingleQuotes(limits));
        for(sObject obj : [Select Id from RecentlyViewed where Type =:String.escapeSingleQuotes(ObjectName)] ){
             recentlyViewedIds.add(obj.Id);
        }
        System.debug(recentlyViewedIds);
        
        String queryString = 'Select '+ 'Id, Name'+
                             ' from '+ String.escapeSingleQuotes(ObjectName) +
                             ' where ID IN:recentlyViewedIds Limit '+ limitofRecord;
      	system.debug(database.query(queryString));
    	return database.query(queryString);
        
    }
    
    
}