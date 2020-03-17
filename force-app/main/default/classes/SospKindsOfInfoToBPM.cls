global class SospKindsOfInfoToBPM{   
    global class AccountFields{
        webservice String AccountString;
    }
    global class SalesLeadFields{
        webservice String SalesLeadString;      
    }
    global class OpportunityFields{
        webservice String OpportunityString;      
    }
    global class ContractFields{
        webservice String ContractString;      
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
     webservice static Response AddAccountInfo(String sTime,String eTime){   //同步新建客户信息       
         Response resp = new Response();       
         try{           
             AccountFields afs = new AccountFields();
             afs.AccountString = new getObjectJsonString().getAddAccountJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP新建的客户信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=afs.AccountString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP新建的客户信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp;       
     }
     webservice static Response UpdateAccountInfo(String sTime,String eTime){   //同步修改客户信息
         Response resp = new Response();       
         try{           
             AccountFields afs = new AccountFields();
             afs.AccountString = new getObjectJsonString().getUpdateAccountJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP更新的客户信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=afs.AccountString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP更新的客户信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp;       
     }
     
     webservice static Response AddSalesLeadInfo(String sTime,String eTime){ //同步新建线索信息   
         Response resp = new Response();       
         try{           
             SalesLeadFields slfs = new SalesLeadFields();
             slfs.SalesLeadString = new getObjectJsonString().getAddSalesLeadJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP新建的线索信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=slfs.SalesLeadString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP新建的线索信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp;  
     }
     webservice static Response UpdateSalesLeadInfo(String sTime,String eTime){  //同步修改线索信息
         Response resp = new Response();       
         try{           
             SalesLeadFields slfs = new SalesLeadFields();
             slfs.SalesLeadString = new getObjectJsonString().getUpdateSalesLeadJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP更新的线索信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=slfs.SalesLeadString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP更新的线索信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp;
     }
     webservice static Response AddOpportunityInfo(String sTime,String eTime){  //同步新建机会信息   
         Response resp = new Response();       
         try{           
             OpportunityFields ofs = new OpportunityFields();
             ofs.OpportunityString = new getObjectJsonString().getAddOpportunityJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP新建的机会信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=ofs.OpportunityString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP新建的机会信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp; 
     }
     webservice static Response UpdateOpportunityInfo(String sTime,String eTime){  //同步修改机会信息
         Response resp = new Response();       
         try{           
             OpportunityFields ofs = new OpportunityFields();
             ofs.OpportunityString = new getObjectJsonString().getUpdateOpportunityJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP更新的机会信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message=ofs.OpportunityString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP更新的机会信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp; 
     }
     webservice static Response AddContractInfo(String sTime,String eTime){  //同步新建合同信息   
         Response resp = new Response();       
         try{           
             ContractFields cfs = new ContractFields();
             cfs.ContractString = new getObjectJsonString().getAddContractJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP新建的合同信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message = cfs.ContractString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP新建的合同信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp; 
     }
     webservice static Response UpdateContractInfo(String sTime,String eTime){  //同步修改合同信息
         Response resp = new Response();       
         try{           
             ContractFields cfs = new ContractFields();
             cfs.ContractString = new getObjectJsonString().getUpdateContractJsonString(sTime,eTime);   
             logClass.returnLog('成功', '已处理', 'SOSP更新的合同信息成功同步到BPM','正常');
             resp.flag = 'S';
             resp.message = cfs.ContractString;
         }catch(exception e){
             resp.flag = 'E';
             LogClass.returnLog('失败','未处理', 'SOSP更新的合同信息同步BPM失败,日期为'+ System.today()+ ';异常信息:' + e.getMessage(), '重要');
         }
         return resp;
     }
}