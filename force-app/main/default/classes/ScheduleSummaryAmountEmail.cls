global class ScheduleSummaryAmountEmail implements Schedulable {
    global void execute(SchedulableContext ctx) {
        
        OpportunitySummaryByEmailBatch osb = new OpportunitySummaryByEmailBatch();
        database.executeBatch(osb);
        //String cronExp = '0 0 10 ? 1/1 FRI#4 *';
        //System.scheduleBatch(osb, 'Email summary for accounts', cronExp);
    }
}