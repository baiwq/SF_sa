/**********************************************************************
 * 
 *
 *  
 *  {
        功能：计算金融事业部合同金额
        创建：任艳新 
    }
*************************************************************************/
public class CalculateFinancialAmount {
    
    public static void calculateAmount(Integer currentYear,Integer currentMonth,Date currentDay) {
        System.debug('进入');

        /**********************************************************************
 * 
 *
 *  {
        合同条件：
            审批通过 and 金融安防合同 and （合同状态是开通 or (合同状态是关闭 and 关闭日期是当年当月)）
        服务费用条件：
            审批通过  and （服务开通日期<=当前日期 and （服务结束日期=null OR 服务结束日期>=当前日期 OR (服务结束日期<当前日期 and 服务结束日期是当年当月)））
    }
*************************************************************************/
        try{
            List<Contract__c> conList = [Select id,Amount__c,contractNO__c,MonthServieceCost__c,SerciceCostDate__c
                                                    from Contract__c where approvalStatus__c=:'审批通过' and (RecordTypeName__c=:'安全服务合同审批通过' or RecordTypeName__c=:'安全服务合同' ) and (active__c =:'开通' or (active__c=:'关闭' and CALENDAR_MONTH(WebCloseDate__c)=:currentMonth and CALENDAR_YEAR(WebCloseDate__c)=:currentYear)) ];
            List<Contract__c> updateList = new List<Contract__c>();
            List<ServiceCharge__c> serviceList = [Select id,Amount__c,CostType__c,ServiceOpeningDate__c,EndOfService__c,Contract__c
                                                 from ServiceCharge__c where (ServiceOpeningDate__c<=:currentDay and (EndOfService__c =:null 
                                                 or EndOfService__c>=:currentDay or (EndOfService__c<:currentDay and CALENDAR_MONTH(EndOfService__c)=:currentMonth 
                                                                                     and CALENDAR_YEAR(EndOfService__c)=:currentYear)) ) and ApprovalStatus__c=:'审批通过' 
                                                  and Contract__c in: conList];
            List<FeeRecord__c> frList = new List<FeeRecord__c>();
            Map<String,List<ServiceCharge__c>> csMap = new  Map<String,List<ServiceCharge__c>>();
            List<ServiceCharge__c> updateSC = new List<ServiceCharge__c>();
            for(Contract__c c :conList){
                List<ServiceCharge__c> sList = new List<ServiceCharge__c>();
                for(ServiceCharge__c s :serviceList){
                    if(c.Id==s.Contract__c){
                        sList.add(s);
                    }       
                }
                csMap.put(c.Id,sList);
            }
            String conStr='';
            for(Contract__c con :conList){
                Decimal serviceFee=(con.amount__c==null?0:con.amount__c);
                if(csMap.get(con.Id)!=null&&csMap.get(con.Id).size()>0){
                   for(ServiceCharge__c service :csMap.get(con.Id) ){
                   system.debug('循环');
                   if(service!=null){
                       Integer openMonth = service.ServiceOpeningDate__c.Month();
                       Integer openYear = service.ServiceOpeningDate__c.Year();
                       Integer endMonth;
                       Integer endYear;
                       System.debug('1111');
                       
                       
                       //Decimal recordAmount = 0;
                       if((service.CostType__c=='设备费'||service.CostType__c=='安装服务费'||service.CostType__c=='巡检服务费'||service.CostType__c=='调整项') &&(service.ServiceOpeningDate__c.Month()==currentMonth&&service.ServiceOpeningDate__c.Year()==currentYear)){
                            System.debug('1112');
                            
                            serviceFee=serviceFee+(service.Amount__c==null?0:service.Amount__c);
                            FeeRecord__c fr1 = new FeeRecord__c();
                           	fr1.Amount__c = (service.Amount__c==null?0:service.Amount__c);
                          
                           	fr1.FeeDate__c = currentDay;
                           	fr1.Contract__c = con.Id;
                           	fr1.ServiceFee__c = service.Id;
                           	fr1.Type__c = service.CostType__c;
                           
                            frList.add(fr1);
                            //周期性费用 
                       }else if(service.CostType__c=='报警服务费'||service.CostType__c=='其他增值服务费'){
                            System.debug('1113');
                            if(service.EndOfService__c!=null){
                                System.debug('1114');
                                endMonth = service.EndOfService__c.Month();
                                endYear = service.EndOfService__c.Year();
                            }
                            FeeRecord__c fr2 = new FeeRecord__c();
                           	
                            
                           	fr2.FeeDate__c = currentDay;
                           	fr2.Contract__c = con.Id;
                           	fr2.ServiceFee__c = service.Id;
                           	fr2.Type__c = '服务费';
                            
                            //服务开通日期<=当前日期 and (服务结束日期>= 当前日期 OR 服务结束日期 = null ) ----当前日期为月末最后一天；数据为第一次按天计算和周期计算
                            if(service.ServiceOpeningDate__c<=currentDay&&(service.EndOfService__c>=currentDay||service.EndOfService__c==null)){
                                System.debug('1115');
                                //周期费用是首次计费
                                if(service.ServiceOpeningDate__c.Month()==currentMonth&&service.ServiceOpeningDate__c.Year()==currentYear){
                                    Integer firstDays = service.ServiceOpeningDate__c.daysBetween(currentDay)+1;
                                    
                                    serviceFee=serviceFee+(firstDays==0?1:firstDays)/30.4*(service.Amount__c==null?0:service.Amount__c);
                                    service.FirstAmount__c = serviceFee;
                                    fr2.Amount__c = (firstDays==0?1:firstDays)/30.4*(service.Amount__c==null?0:service.Amount__c);
                                    fr2.Status__c='开通月';
                                    
                                    updateSC.add(service);
                                }else{
                                    System.debug('1117');
                                    serviceFee=serviceFee+(service.Amount__c==null?0:service.Amount__c);
                                    fr2.Amount__c = (service.Amount__c==null?0:service.Amount__c);
                                    fr2.Status__c='正常月';
                                }
                                //费用最后一次按天计算    
                            }else{
                                //周期费用最后一次计费
                                if(endMonth==currentMonth&&endYear==currentYear){
                                    System.debug('1118');
                                    Integer finialDays = service.EndOfService__c.Day();
                                    System.debug('1119');
                                    serviceFee=serviceFee+finialDays/30.4*(service.Amount__c==null?0:service.Amount__c);
                                    service.FirstAmount__c = serviceFee;
                                    updateSC.add(service);
                                    fr2.Amount__c = finialDays/30.4*(service.Amount__c==null?0:service.Amount__c);
                                    fr2.Status__c='关闭月';
                                }
                            }
                            frList.add(fr2);
                        }
                    }
                }
                con.MonthServieceCost__c =(serviceFee-(con.amount__c==null?0:con.amount__c));
                con.amount__c =serviceFee;
                con.SerciceCostDate__c = currentDay;
                updateList.add(con);
                conStr=conStr+con.contractNO__c+',';
                    
                    
            }
        }
            if(updateList.size()>0){
                update updateList;
            }
            if(updateSC.size()>0){
                update updateSC;
            }    
            if(frList.size()>0){
                insert frList;
            }
            logClass.returnLog('成功', '已处理', '【计算金融事业部合同额】成功计算合同数：'+updateList.size()+',合同号：'+conStr, '正常');
        }catch(Exception e){
            logClass.returnLog('失败', '未处理', '【计算金融事业部合同额】错误信息'+e.getMessage(), '重要');
        }
                                                    
    }
}