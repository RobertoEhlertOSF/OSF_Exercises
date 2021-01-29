public class SchedulerSummaryAmountEmail {
    
    public void ScheduleEmailJob(){
        ScheduleSummaryAmountEmail sch = new ScheduleSummaryAmountEmail();
        string cronExp = '0 0 10 ? 1/1 FRI#4 *';
        System.schedule('Email summary for accounts', cronExp,  sch);
    }	
}