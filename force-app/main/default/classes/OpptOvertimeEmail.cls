global class OpptOvertimeEmail implements Schedulable{

    global void execute(SchedulableContext SC){  
           	Date overdue = System.today();
            
            String body = '';
        	String[] toAddresses = null;
            String Title = '';
            String  foot = '';
            String finalbody = '';
            String login_url = URL.getSalesforceBaseUrl().toExternalForm()+'/'; 
              Title='<html>'+
                  '<form>'+
                  '<body>'+
                  '<table  >您好:<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业务机会预计招标即将超时提醒:<br/>'+
                  '<table border="1" style="border-collapse:collapse;text-align:center;width:800px;" id="table">'+
                  '<tr>'+
                  '<td style="background-color: #4876FF;width:8%"><p style="color: white">业务机会编号</p></td>'+
                  '<td style="background-color: #4876FF;width:8%"><p style="color: white">业务机会名称</p></td>'+
                  '<td style="background-color: #4876FF;width:8%"><p style="color: white">业务机会记录类型</p></td>'+
                  '<td style="background-color: #4876FF;width:8%"><p style="color: white">预计招标时间</p></td>'+
                  '</tr>';
              foot='</table>'+
                  '<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如需操作，请登录SOSP系统操作，谢谢！<br/>'+
                  '<br/>祝你工作愉快！<br/>'+
                  '____________________________________________'+
                  '<br/>'+
                  '本邮件由CRM系统产生，请勿回复！。<br/>'+
                  '如有任何疑问或者建议，请联系系统管理员。'+
                  '</table>'+
                  '</body>'+
                  '</form>'+
                  '</html>';
            
          	List<Opportunity> oppoList = [ Select id,OwnerEmail__c,ownerid,opportunityNumber__c,opportunityRecordType__c,expectBidDate__c,Name,StageName from Opportunity where expectBidDate__c =:overdue and (StageName !='赢单' and StageName !='丢单' and StageName != '项目暂停')];

            List<AggregateResult> GroupID_List = [select ownerid from Opportunity where expectBidDate__c =:overdue group by ownerid ];
          	if(oppoList.size()>0){
                for(AggregateResult groupID : GroupID_List){
                    integer i = 0;
					String UserEmail = '';
                    finalbody = '';
                    finalbody =Title;
                    for(Opportunity oppt : oppoList){
                        if(groupID.get('ownerid') == oppt.ownerid){
                            body = '<br/><br/>';
                            body += '<tr> '+
                                '<td><a href="'+login_url+oppt.Id+'">'+oppt.opportunityNumber__c+'</a></td>'+
                                '<td>'+oppt.name+'</td>'+
                                '<td>'+oppt.opportunityRecordType__c +'</td>'+
                                '<td>'+oppt.expectBidDate__c+'</td>'+
                                '</tr>';
                            finalbody += body;
                            if(i == 0 ){
                                UserEmail = oppt.OwnerEmail__c;
                            }
                            i++;
                        }                       
                    }
                    finalbody += foot;
                    toAddresses = new String[1];
                    toAddresses[0] = UserEmail;
                    System.debug('i==='+i);
                    System.debug('UserEmail===='+UserEmail);
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setSaveAsActivity(false);
                    mail.setToAddresses(toAddresses);       
                    mail.setSenderDisplayName('业务机会预计招标即将超时提醒');
                    mail.setSubject('业务机会');
                    mail.setHtmlBody(finalbody);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                }
                
            }
    }

}