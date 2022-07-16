public with sharing class heatMapController {
    @AuraEnabled
    public static List<Account> getAccountData(){
        return [SELECT Id, Name, BillingLatitude, BillingLongitude
  FROM Account
  WHERE BillingLatitude != null and BillingLongitude  != null];
    }
}