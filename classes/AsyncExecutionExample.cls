/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class AsyncExecutionExample implements Queueable {
    public void execute(QueueableContext context) {
        Account a = new Account(Name='tesu',Phone='(415) 555-1212');
        insert a;        
    }
}