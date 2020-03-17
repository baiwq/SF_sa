public class UpdateAccountsReceivableOneYear{
	public static void getList(){
        
        List<Account> UpdateAccountList = new List<Account>();
        Date myDateStart = date.valueOf(System.today().addYears(-1));
        System.debug('123123--------'+myDateStart);
        Boolean flag=false;
        String message='';
            try{
                List<Account> AccountList = [select id from Account where accountStatus__c = '有效'];
                System.debug(AccountList.size());
                if(AccountList.size()>0){
                    Decimal noReturnContractAmount = 0;
                    for(Account newCC : AccountList){
                      AggregateResult AmountObj=[select sum(noReturnContractAmount__c) noReturnContractAmount_sum  from Contract__c where account__c  =:newCC.id and completelyDeliverDate__c >=:myDateStart];
                      if(AmountObj.get('noReturnContractAmount_sum')!=null){
                           noReturnContractAmount = Decimal.valueOf(AmountObj.get('noReturnContractAmount_sum')+'');
                      }
                      newCC.AccountsReceivableOneYear__c = noReturnContractAmount;
                      UpdateAccountList.add(newCC); 
                    }
                }
               if(UpdateAccountList.size()>0){
                    update UpdateAccountList;
                    flag=true;
                    
                }else{
                    flag=true;
                    message='无更新列表';
                }
            }catch(Exception e){
                flag=false;
                message=e.getMessage();    
            }finally{
                if(flag){
                    LogClass.returnLog('成功','已处理','【1年以内应收账款】：' + System.today() + '，' +message,'重要');
                }else{
                    LogClass.returnLog('失败','未处理','【1年以内应收账款】：' + System.today() + '，失败原因：' + message,'重要');
                }
                
           }
    }
}