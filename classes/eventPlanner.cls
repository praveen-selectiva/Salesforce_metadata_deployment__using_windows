public with sharing class eventPlanner {
    @AuraEnabled(cacheable=true)
    public static list<contact> getConList(){
        return [SELECT Name, Email, Phone, AccountId,Account.Name, Birthdate
            FROM Contact WHERE Birthdate != null
            ORDER BY LastModifiedDate DESC
            LIMIT 20];
    }
}