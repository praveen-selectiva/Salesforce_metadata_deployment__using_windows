public with sharing class Rule_bulkification_For_DML {
     public void databaseMethodInsideOfLoop(List<Account> accounts) {
        for (Account a : accounts) {
            Database.insert(a);
        }
    }

    public void dmlInsideOfLoop() {
        for (Integer i = 0; i < 151; i++) {
            Account account;
            // ...
            insert account;
        }
    }
}