public class CreateAccountContact {
    public static void contactAssociate(){
        Account acc = new Account();
        acc.Name = 'Unmapped Contacts rashi';
        insert acc;
        system.debug(acc);
        List<Contact> con = [select Id, Name, Account.Name, AccountId from Contact where Account.Name = '' limit 10];
        for(Contact c:con){
            system.debug(c);
            // update the record
            c.AccountId = acc.Id;
            system.debug(acc.Id);
        }
           update con;
    }
}