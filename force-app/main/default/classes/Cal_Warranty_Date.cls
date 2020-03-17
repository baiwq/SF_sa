public class Cal_Warranty_Date{

//计算合同质保期递归方法
    public void updateWarrantyStageDate(List<contract__c> contractList){  
        //传入合同个数小于等于1000条  直接计算全部质保期       
        if(contractList.size()<=1000){  
            changeListWarranty(contractList);
        }
        //大于1000 小于10000条  取前1000条计算质保期，剩下的当参数 进行下一轮递归
        else if(contractList.size()>1000 && contractList.size()<10000){
            List<contract__c> selectContractList = new List<contract__c>();
            for(integer i=0;i<1000;i++){
                selectContractList.add(contractList[i]);
            }
            List<contract__c> otherContractList = new List<contract__c>();
            for(integer j=1000;j<contractList.size();j++){
                otherContractList.add(contractList[j]);
            }
                      
            changeListWarranty(selectContractList);
            updateWarrantyStageDate(otherContractList);
        }
        //大于 等于 10000条，不做处理。
        else{
            return;
        }
    }
    
 //计算合同质保期主方法
    public void changeListWarranty(List<contract__c> CONList){
         List<Id> conIdList = new List<Id>();
         for(contract__c c:CONList){
             conIdList.add(c.id);               
         } 
         System.debug('CONList：' + CONList);
         System.debug('conIdList：' + conIdList);
                                  
         List<paymentTerm__c> AllStageDateList = [select id, stageDate__c, paymentStageDate__c,contract__c from paymentTerm__c where paymentStageDate__c != null and dateEqualYoN__c = false and contract__c in :conIdList];         
         Set<Id> aSet = new Set<Id>();
         for(paymentTerm__c ap:AllStageDateList){
             aSet.add(ap.contract__c);
             ap.stageDate__c = ap.paymentStageDate__c;
         }
         update AllStageDateList;     
         System.debug('质保期1-5更新成功: 合同号：' + AllStageDateList);

         //查询计算质保期用到的所谓的最大日期 查询所属合同号  
         List<paymentTerm__c> MaxStageDateList = [Select id, paymentStageDate__c, contract__c from paymentTerm__c where maxStageYoN__c = true and percentage__c != null and contract__c in:conIdList];
         if(MaxStageDateList.size() > 0) {
             Set<Id> cSet = new Set<Id>();
             Map<Id,Date> MDList = new Map<Id,Date>();
             for(paymentTerm__c mp:MaxStageDateList ){   
                 cSet.add(mp.contract__c);
                 MDList.put(mp.contract__c,mp.paymentStageDate__c);
             }
             System.debug('MDList：' + MDList);
         
         	 //查询所有计算完成的质保期  同样把值 放在新的（日期字段）值里
             List<paymentTerm__c> WarrantyStageDateList = [Select id, stageDate__c, contract__c, ZBQdays__c, percentage__c from paymentTerm__c where No__c = 6 and contract__c in :cSet];
             if(WarrantyStageDateList.size() > 0){
                 for(paymentTerm__c wp:WarrantyStageDateList){
                     try{ //没拿到日期基数值 直接置为空
                         wp.stageDate__c = MDList.get(wp.contract__c).addDays(Integer.valueOf(wp.ZBQdays__c)); 
                     }catch(Exception e){
                  	     wp.stageDate__c = null;
                     }                                                     
                 }
             }
             
             try{
                 update WarrantyStageDateList;
                 System.debug('质保期6更新成功: 合同号：' + WarrantyStageDateList);
             }catch(Exception e){
         	     System.debug('质保期更新失败: ' + String.valueof(e));
             }
         }
     }
}