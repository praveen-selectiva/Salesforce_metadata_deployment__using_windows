public class contactData {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact() {
       return [
            SELECT FirstName, LastName, Email, Phone, AccountId,Account.Name, Birthdate
            FROM Contact WHERE Birthdate != null
            ORDER BY LastModifiedDate DESC
            LIMIT 20
       ];
    }
    @AuraEnabled
    public static list<contact> getConList(){
        return [SELECT FirstName, LastName, Email, Phone, AccountId,Account.Name, Birthdate
            FROM Contact WHERE Birthdate != null
            ORDER BY LastModifiedDate DESC
            LIMIT 20];
    }
}