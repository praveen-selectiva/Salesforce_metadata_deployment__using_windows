public class timeCardScheduler implements Schedulable {
    public void execute(SchedulableContext sc){
        system.debug('helloooo scheduler job');
        Database.executeBatch(new missingTimeCardBatch());
    }
}