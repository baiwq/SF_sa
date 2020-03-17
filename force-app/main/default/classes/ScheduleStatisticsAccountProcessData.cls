/*
	类名：ScheduleStatisticsAccountProcessData
	功能：
	功能逻辑：
	对应测试类：TestScheduleStatisticsAccount
	作者：Mark 柏文强-雨花石
	时间：2019-11-09
 */
global class ScheduleStatisticsAccountProcessData implements Schedulable 
{

	// 定时任务时间表达式
	public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    global void execute(SchedulableContext sc) 
    {
    	BatchStatisticsAccountProcessData batchSAPD = new BatchStatisticsAccountProcessData();
        Database.executeBatch(batchSAPD,101);
    }
}