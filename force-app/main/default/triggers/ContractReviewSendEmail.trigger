trigger ContractReviewSendEmail on contractreview__c (after insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(contractreview__c newCC:trigger.new){
        
        
         String Title='<html>'+
                    '<form>'+
                    '<body>'+
                    '<table  >您好:<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;合同评审业绩比例创建提醒:<br/>'+
                    '<table border="1" style="border-collapse:collapse;text-align:center;width:800px;" id="table">'+
                        '<tr>'+
                            '<td style="background-color: #4876FF;width:8%"><p style="color: white">合同评审编号</p></td>'+
                            '<td style="background-color: #4876FF;width:8%"><p style="color: white">所属事业部</p></td>'+
                            '<td style="background-color: #4876FF;width:8%"><p style="color: white">合同金额</p></td>'+
                            '<td style="background-color: #4876FF;width:8%"><p style="color: white">分配比例</p></td>'+
                            '<td style="background-color: #4876FF;width:8%"><p style="color: white">业绩金额</p></td>'+
                        '</tr>';
                    String  foot='</table>'+
                    '<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如需拆分业绩，请登录SOSP系统操作，谢谢！<br/>'+
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
                    String body = '<br/><br/>';
                   
          
                //String user_mail = '';
                
          
                  if(Trigger.isInsert){
                      if(newCC.MainProductGroup__c!= null){
                        ContractReviewPGScaling__c  ContractReviewPGScalingVo = new ContractReviewPGScaling__c();
                        ContractReviewPGScalingVo.Allocation__c = 100;
                        ContractReviewPGScalingVo.contractreview__c = newCC.id;
                        ContractReviewPGScalingVo.ProductGroup__c = newCC.MainProductGroup__c;
                        if(newCC.ExchangeRate__c > 0){
                          ContractReviewPGScalingVo.PerformanceAmount__c = newCC.ExchangeRate__c*newCC.contractAmount__c;
                        }else{
                          ContractReviewPGScalingVo.PerformanceAmount__c = newCC.contractAmount__c;
                        }
                        insert ContractReviewPGScalingVo; 
                        
                        List<ContractReviewPGScaling__c> ContractReviewPGList = [select PerformanceAmount__c,Allocation__c,contractreview__c,contractAmount__c,ProductGroup__c from ContractReviewPGScaling__c where contractreview__c =:newCC.id];
                          for(ContractReviewPGScaling__c  le :ContractReviewPGList)
                            {
                                body += '<tr> '+
                                              '<td>'+newCC.name+'</td>'+
                                              '<td>'+le.ProductGroup__c+'</td>'+
                                              '<td>'+le.contractAmount__c+'</td>'+
                                              '<td>'+le.Allocation__c+'</td>'+
                                              '<td>'+le.PerformanceAmount__c+'</td>'+
                                        '</tr>';
                            }
                            finalbody += body + foot;
                       String[] toAddresses = null;
                        if(newCC.MainProductGroup__c == '输变电业务单元-电网控制事业部'){toAddresses = new String[1];toAddresses[0] = 'lili1@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-智能运行管控事业部'){toAddresses = new String[1];toAddresses[0] = 'bushaoming@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-电站事业部'){toAddresses = new String[1];toAddresses[0] = 'wanghaiyan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-仿真事业部'){toAddresses = new String[1];toAddresses[0] = 'geliyao@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-公共电力事业部'){toAddresses = new String[1];toAddresses[0] = 'chenfangqin@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-培训业务部'){toAddresses = new String[1];toAddresses[0] = 'hucuirong@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '配用电业务单元-配电开关'){toAddresses = new String[1];toAddresses[0] = 'daichangqing@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '配用电业务单元-配用电业务'){toAddresses = new String[1];toAddresses[0] = 'daichangqing@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '直流输电及电力电子业务单元-直流输电及电力电子产品'){toAddresses = new String[2];toAddresses[0] = 'yuanzhanhui@sf-auto.com';toAddresses[1] ='zhangyan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '直流输电及电力电子业务单元-感应加热与高频电源产品'){toAddresses = new String[1];toAddresses[0] = 'zhangjianxue_sy@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '四方智能（武汉）控制技术有限公司'){toAddresses = new String[1];toAddresses[0] = '	yangyonglin@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '国网业务部'){ toAddresses = new String[1];toAddresses[0] =  'wangyanhui@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '东北区'){ toAddresses = new String[1];toAddresses[0] =  'xushuguang@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华北区'){ toAddresses = new String[1];toAddresses[0] =  'jinhuanhuan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && (newCC.ownerDepartment__c == '西北区' || newCC.ownerDepartment__c == '新疆项目部')){ toAddresses = new String[1];toAddresses[0] =  'zhoubaocheng@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华中区'){ toAddresses = new String[1];toAddresses[0] =  'changjun@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华东区'){ toAddresses = new String[1];toAddresses[0] =  'zhangyun@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华南区'){ toAddresses = new String[1];toAddresses[0] =  'zhanghuajiao@sf-auto.com';}
                          
                         
                         if( toAddresses != null && toAddresses.size()!= 0){
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                //String[] toAddresses = new String[] {user_mail};
                                mail.setSaveAsActivity(false);
                                mail.setToAddresses(toAddresses);       
                                mail.setSenderDisplayName('合同评审事业部业绩通知');
                                mail.setSubject('合同评审');
                                mail.setHtmlBody(finalbody);
                                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                          }
                      }
                  }
                  
                

          
          
              if(Trigger.isUpdate){
                  contractreview__c  oldCC = Trigger.oldMap.get(newCC.id);
                  if(oldCC.MainProductGroup__c != newCC.MainProductGroup__c && newCC.approvalStatus__c =='草稿'){
                      List<ContractReviewPGScaling__c> ContractReviewPGList = [select PerformanceAmount__c,Allocation__c,contractreview__c,contractAmount__c,ProductGroup__c from ContractReviewPGScaling__c where contractreview__c =:newCC.id];
                      for(ContractReviewPGScaling__c  le :ContractReviewPGList)
                        {
                            body += '<tr> '+
                                          '<td>'+newCC.name+'</td>'+
                                          '<td>'+le.ProductGroup__c+'</td>'+
                                          '<td>'+le.contractAmount__c+'</td>'+
                                          '<td>'+le.Allocation__c+'</td>'+
                                          '<td>'+le.PerformanceAmount__c+'</td>'+
                                    '</tr>';
                        }
                       finalbody += body + foot;
                      String[] toAddresses = null;
                       if(newCC.MainProductGroup__c == '输变电业务单元-电网控制事业部'){toAddresses = new String[1];toAddresses[0] = 'lili1@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-智能运行管控事业部'){toAddresses = new String[1];toAddresses[0] = 'bushaoming@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-电站事业部'){toAddresses = new String[1];toAddresses[0] = 'wanghaiyan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-仿真事业部'){toAddresses = new String[1];toAddresses[0] = 'geliyao@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-公共电力事业部'){toAddresses = new String[1];toAddresses[0] = 'chenfangqin@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '发电及用电业务单元-培训业务部'){toAddresses = new String[1];toAddresses[0] = 'hucuirong@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '配用电业务单元-配电开关'){toAddresses = new String[1];toAddresses[0] = 'daichangqing@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '配用电业务单元-配用电业务'){toAddresses = new String[1];toAddresses[0] = 'daichangqing@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '直流输电及电力电子业务单元-直流输电及电力电子产品'){toAddresses = new String[2];toAddresses[0] = 'yuanzhanhui@sf-auto.com';toAddresses[1] ='zhangyan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '直流输电及电力电子业务单元-感应加热与高频电源产品'){toAddresses = new String[1];toAddresses[0] = 'zhangjianxue_sy@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '四方智能（武汉）控制技术有限公司'){toAddresses = new String[1];toAddresses[0] = '	yangyonglin@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '国网业务部'){ toAddresses = new String[1];toAddresses[0] =  'wangyanhui@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '东北区'){ toAddresses = new String[1];toAddresses[0] =  'xushuguang@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华北区'){ toAddresses = new String[1];toAddresses[0] =  'jinhuanhuan@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && (newCC.ownerDepartment__c == '西北区' || newCC.ownerDepartment__c == '新疆项目部')){ toAddresses = new String[1];toAddresses[0] =  'zhoubaocheng@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华中区'){ toAddresses = new String[1];toAddresses[0] =  'changjun@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华东区'){ toAddresses = new String[1];toAddresses[0] =  'zhangyun@sf-auto.com';}
                      else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部' && newCC.ownerDepartment__c == '华南区'){ toAddresses = new String[1];toAddresses[0] =  'zhanghuajiao@sf-auto.com';}
                          
                        if( toAddresses != null && toAddresses.size()!= 0){
                          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                          //String[] toAddresses = new String[] {user_mail};
                          mail.setSaveAsActivity(false);
                          mail.setToAddresses(toAddresses);       
                          mail.setSenderDisplayName('合同评审事业部业绩通知');
                          mail.setSubject('合同评审');
                          mail.setHtmlBody(finalbody);
                          Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                      }
                      
                      
                  }
                  
              }
                  
         
             
        }       
  }
}