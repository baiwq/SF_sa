global class NotifyOutsourcing {

    
      webservice  static String EamilToNotifyOutsourcing(String tbid,String ContractreviewCode,String opportunityCode,String OwnerId){ 
          String Endword = opportunityCode.substring(opportunityCode.length()-1,opportunityCode.length());
          String NoEmail = '';
          String NoName = '';
          if(Endword=='1'||Endword=='6'){
              
              NoEmail = 'zhaopei@sf-auto.com';
              NoName = '赵培';

          }else if(Endword=='2'||Endword=='7'){
              
              NoEmail = 'huangsihui@sf-auto.com';
              NoName = '黄思慧';

         // }else if(Endword=='3'||Endword=='8'){
              
             // NoEmail = 'zhangjianbo@sf-auto.com';
              //NoName = '张健搏';

          }else if(Endword=='4'){
              
              NoEmail = 'lianglijun@sf-auto.com';
              NoName = '梁丽君';

          }else if(Endword=='9' || Endword=='3'){
              
              NoEmail = 'wangheli@sf-auto.com';
              NoName = '王荷丽';

          }else if(Endword=='5' || Endword=='8'){
              
              NoEmail = 'fengxiaoqian@sf-auto.com';
              NoName = '冯晓倩';
              
          }else if(Endword=='0'){
              
              NoEmail = 'panmei@sf-auto.com';
              //NoEmail = 'fuxiao@sf-auto.com';
              NoName = '潘美';
              
          }
          
          if(NoEmail != '' && NoEmail != null){
              
              EmailTemplate template = [Select id from EmailTemplate where DeveloperName =:'NotifyOutsourcingEmail' limit 1];
              EmailToProject.exe_sendEmail('合同评审提醒', ContractreviewCode, OwnerId, tbid, template.Id,NoEmail,null);
              contractreview__c contractreview =  [ select NotifyOutsourcName__c from contractreview__c where id =:tbid];
              contractreview.NotifyOutsourcName__c = NoName;
              update contractreview;
          }
          
          
          
          return '已通知外购评审专家，专家姓名:'+NoName;  
      } 

    
    

      
}