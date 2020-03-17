/*
    类名：ScheduleStatisticsAccountProcessData
    作者：Mark 柏文强-雨花石
    时间：2019-11-21
	覆盖率：100%
    修改内容：
 */
@isTest
private class TestScheduleStatisticsAccount 
{
    static testMethod void testMethod1() 
    {
    	Test.startTest();
        ScheduleStatisticsAccountProcessData scheduleDate = new ScheduleStatisticsAccountProcessData();
        // scheduleDate.execute(SchedulableContext sc);

        String jobId = System.schedule('testBasicScheduledApex',ScheduleStatisticsAccountProcessData.CRON_EXP,new ScheduleStatisticsAccountProcessData());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

        Test.stopTest();
    }
}