public class SchedularClassForQ1 implements Schedulable{
    public void execute(SchedulableContext sc){
        Database.executeBatch(new DeleteLastTenDaysAccount(),200);
    }
}