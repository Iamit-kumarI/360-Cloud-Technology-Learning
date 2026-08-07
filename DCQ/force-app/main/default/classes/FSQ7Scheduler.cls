public class FSQ7Scheduler implements Schedulable{
    public void execute(SchedulableContext sc){
        Database.executeBatch(new FSQ7(),200);
    }
}
//System.schedule(
//   'Case Safety Net',
//   '0 0 2 * * ?',
//    new FSQ7Scheduler()
//);