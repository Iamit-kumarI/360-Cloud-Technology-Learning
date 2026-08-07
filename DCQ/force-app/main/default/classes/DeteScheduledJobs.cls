public class DeteScheduledJobs {
    public static void deleteScheduledJobs(){
        List<CronTrigger> scheduledJobs=[Select Id from CronTrigger where CronJobDetail.Name in ('Five Opportunity Daily')];
        System.debug(scheduledJobs.size());
        if(!scheduledJobs.isEmpty()){
            for(CronTrigger curJob:scheduledJobs){
                System.abortJob(curJob.Id);
            }
        }
    }
}