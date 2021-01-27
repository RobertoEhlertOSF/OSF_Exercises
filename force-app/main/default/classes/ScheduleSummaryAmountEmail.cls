global class ScheduleSummaryAmountEmail implements Schedulable {
    global void execute(SchedulableContext ctx) {
        
        OpportunitySummaryByEmailBatch osb = new OpportunitySummaryByEmailBatch();
        Database.executeBatch(osb);
       
    }
}