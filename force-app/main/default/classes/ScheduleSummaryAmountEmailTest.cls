@isTest
public class ScheduleSummaryAmountEmailTest {
    
	public static string CRON_EXP = '0 0 10 ? 1/1 FRI#4 *';
	
    @isTest
    private static void executeTest(){
       
        Test.startTest();
        ScheduleSummaryAmountEmail sae = new ScheduleSummaryAmountEmail();        
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, sae);
        Test.stopTest();

		integer jobsScheduled = [SELECT COUNT() FROM CronTrigger WHERE Id = :jobId];
    	System.assertEquals(1, jobsScheduled, 'expecting one scheduled job');
    	
    }
}