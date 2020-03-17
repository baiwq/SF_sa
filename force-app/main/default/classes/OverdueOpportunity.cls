public class OverdueOpportunity {
    public static void getData(){
        Date overdue = System.today().addDays(-30);
        List<Opportunity> upopList = new List<Opportunity>();
        Boolean flag=false;
        String message='';
        try{
            List<Opportunity> oppoList = [ Select id,Name,StageName,endReason__c from Opportunity where level1center__c ='销售中心' and ( level3Province__c !='电源产品推广部' Or level3Province__c !='感应加热销售部' Or level3Province__c !='感应加热国际业务部' Or level3Province__c !='感应加热商务管理部' Or level3Province__c !='机械自动化销售' ) and (StageName ='引导客户' Or StageName ='制定并提交解决方案') and expectBidDate__c<=:overdue];
            if(oppoList.size()>0){
                for(Opportunity oppo : oppoList){
                    oppo.StageName='丢单';
                    oppo.endReason__c ='项目逾期';
                    message=message+oppo.Id+',';
                    upopList.add(oppo);
                }
            }
            if(upopList.size()>0){
                update upopList;
                flag=true;
                
            }else{
                flag=true;
                message='无逾期业务机会';
            }
        }catch(Exception e){
            flag=false;
            message=e.getMessage();    
        }finally{
            if(flag){
                LogClass.returnLog('成功','已处理','【逾期业务机会】到期日期：' + System.today() + '，逾期日期：' + overdue + '逾期业务机会数：' +upopList.size()+',业务机会：'+message,'重要');
            }else{
                LogClass.returnLog('失败','未处理','【逾期业务机会】到期日期：' + System.today() + '，逾期日期：' + overdue + '，失败原因：' + message,'重要');
            }
            
        }
        
        
    }
}