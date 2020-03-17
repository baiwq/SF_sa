/*
 *合同信息变更审批通过时发生邮件通知
 *修改人：任艳新
 *修改日期：2018-2-5
 **/
trigger ContractChangeSendEmail on contractchange__c (after update) {
   for(contractchange__c cc :Trigger.new){
      contractchange__c oldCC = Trigger.oldMap.get(cc.id);  
      if(cc.recordType__c=='合同信息变更' &&cc.approvalStatus__c == '审批通过' && oldCC.approvalStatus__c != cc.approvalStatus__c){
         EmailTemplate template = [Select id from EmailTemplate where DeveloperName =:'contractChangeNotifyTemplate' limit 1];
         //FuncPools FP = new FuncPools();
         //String[] strs = FP.getEmails(cc.notifyTo__c);
         //FP.sendEmails(strs,cc.OwnerId,cc.id,ET.id); 
         //合同信息变更审批通过时发生邮件通知2018-2-5
          if(cc.ownerDepartment__c =='感应加热业务'){
              EmailToProject.exe_sendEmail('合同信息变更通知', cc.contractNO__c, cc.OwnerId, cc.Id, template.Id,'wangyongli_sy@sf-auto.com',null);
          }else{
              EmailToProject.exe_sendEmail('合同信息变更通知', cc.contractNO__c, cc.OwnerId, cc.Id, template.Id,'shm@sf-auto.com',null);
          }
          
      }
      
      if(cc.recordType__c=='供货范围变更' &&cc.approvalStatus__c == '审批通过' && oldCC.approvalStatus__c != cc.approvalStatus__c){
          if(cc.ownerDepartment__c=='感应加热业务'){
              List<String> otherEmail = new List<String>();
             otherEmail.add('hebinglong_sy@sf-auto.com');
             otherEmail.add('wangfeng_sy@sf-auto.com');
             otherEmail.add('guanjingxian_sy@sf-auto.com');
             otherEmail.add('liujing_sy@sf-auto.com');                
             EmailTemplate templatebg = [Select id from EmailTemplate where DeveloperName =:'contractChangeNotifyTemplate' limit 1];
             EmailToProject.exe_sendEmail('供货范围变更通知', cc.contractNO__c, cc.OwnerId, cc.Id, templatebg.Id,'wangyongli_sy@sf-auto.com',otherEmail);
          }      
      }
       
       
       if(cc.recordType__c=='事业部业绩调整变更' &&cc.approvalStatus__c == '审批通过' && oldCC.approvalStatus__c != cc.approvalStatus__c){
                	 List<ContractChangePGScaling__c > ContractReviewPGList = [select PerformanceAmount__c,Allocation__c,ContractChange__c,contractAmountRMB__c,ProductGroup__c from ContractChangePGScaling__c  where ContractChange__c   =:cc.id];
      	     if(ContractReviewPGList.size() > 0){
                        
                 String Title='<html>'+
                            '<form>'+
                            '<body>'+
                            '<table  >您好:<br/>&nbsp;&nbsp;&nbsp;'+
                            '&nbsp;&nbsp;&nbsp;&nbsp;合同变更业绩比例调整提醒:<br/>'+
                            '<table border="1" style="border-collapse:collapse;text-align:center;width:800px;" id="table">'+
                                '<tr>'+
                                    '<td style="background-color: #4876FF;width:8%"><p style="color: white">合同变更编号</p></td>'+
                                    '<td style="background-color: #4876FF;width:8%"><p style="color: white">所属事业部</p></td>'+
                                    '<td style="background-color: #4876FF;width:8%"><p style="color: white">合同金额</p></td>'+
                                    '<td style="background-color: #4876FF;width:8%"><p style="color: white">分配比例</p></td>'+
                                    '<td style="background-color: #4876FF;width:8%"><p style="color: white">业绩金额</p></td>'+
                                '</tr>';
                            String  foot='</table>'+
                            '<br/>祝你工作愉快！<br/>'+
                            '____________________________________________'+
                            '<br/>'+
                            '本邮件由CRM系统产生，请勿回复！。<br/>'+
                            '如有任何疑问或者建议，请联系系统管理员。'+
                            '</table>'+
                            '</body>'+
                            '</form>'+
                            '</html>';
        
                            String finalbody =Title;
                            String body;
                            List<String> UserMailList = new List<String>();

                            for(ContractChangePGScaling__c  le :ContractReviewPGList)
                            {
                                body += '<tr> '+
                                              '<td>'+cc.name+'</td>'+
                                              '<td>'+le.ProductGroup__c+'</td>'+
                                              '<td>'+le.contractAmountRMB__c+'</td>'+
                                              '<td>'+le.Allocation__c+'</td>'+
                                              '<td>'+le.PerformanceAmount__c+'</td>'+
                                        '</tr>';
                                
                                if(le.ProductGroup__c == '输变电业务单元-电网控制事业部'){UserMailList.add('lili1@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-智能运行管控事业部'){UserMailList.add('bushaoming@sf-auto.com');}
                                else if(le.ProductGroup__c == '发电及用电业务单元-电站事业部'){UserMailList.add('wanghaiyan@sf-auto.com');}
                                else if(le.ProductGroup__c == '发电及用电业务单元-仿真事业部'){UserMailList.add('geliyao@sf-auto.com');}
                                else if(le.ProductGroup__c == '发电及用电业务单元-公共电力事业部'){UserMailList.add( 'chenfangqin@sf-auto.com');}
                                else if(le.ProductGroup__c == '发电及用电业务单元-培训业务部'){UserMailList.add('hucuirong@sf-auto.com');}
                                else if(le.ProductGroup__c == '配用电业务单元'){UserMailList.add('daichangqing@sf-auto.com');}
                                else if(le.ProductGroup__c == '配用电业务单元'){UserMailList.add('daichangqing@sf-auto.com');}
                                else if(le.ProductGroup__c == '直流输电及电力电子业务单元-直流输电及电力电子产品'){UserMailList.add('yuanzhanhui@sf-auto.com');UserMailList.add('zhangyan@sf-auto.com');}
                                else if(le.ProductGroup__c == '直流输电及电力电子业务单元-感应加热与高频电源产品'){UserMailList.add('zhangjianxue_sy@sf-auto.com');}
                                else if(le.ProductGroup__c == '四方智能（武汉）控制技术有限公司'){UserMailList.add('yangyonglin@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '国网业务部'){ UserMailList.add('wangyanhui@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '东北区'){ UserMailList.add('xushuguang@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '华北区'){ UserMailList.add('jinhuanhuan@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && (cc.ownerDepartment__c == '西北区' || cc.ownerDepartment__c == '新疆项目部')){ UserMailList.add('zhoubaocheng@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '华中区'){ UserMailList.add('changjun@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '华东区'){ UserMailList.add('zhangyun@sf-auto.com');}
                                else if(le.ProductGroup__c == '输变电业务单元-电网保护自动化事业部' && cc.ownerDepartment__c == '华南区'){ UserMailList.add('zhanghuajiao@sf-auto.com');}

                            }
                            finalbody += body + foot;
          
							//String user_mail = '';
                         
                       if( UserMailList.size() > 0){
   						   String[] toAddresses = new String[UserMailList.size()];

                  
                           for(integer i=0;i<UserMailList.size();i++){
                               toAddresses[i]=UserMailList.get(i);
                            }
                           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                           //String[] toAddresses = new String[] {user_mail};
                           mail.setSaveAsActivity(false);
                           mail.setToAddresses(toAddresses);       
                           mail.setSenderDisplayName('合同变更事业部业绩通知');
                           mail.setSubject('合同变更');
                           mail.setHtmlBody(finalbody);
                           Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

                       }
                      
                   }
               
                        
                
                  
      }
   }
}