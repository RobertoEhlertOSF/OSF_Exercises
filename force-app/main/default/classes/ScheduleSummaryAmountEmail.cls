global class ScheduleSummaryAmountEmail implements Schedulable {
    global void execute(SchedulableContext ctx) {
        
        OpportunitySummaryByEmailBatch Osb = new OpportunitySummaryByEmailBatch();
        Database.executeBatch(Osb);
       
    }
}