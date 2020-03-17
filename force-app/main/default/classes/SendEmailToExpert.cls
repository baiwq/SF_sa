global class SendEmailToExpert {
    global class ResponseCls{
        
        webservice Boolean Flag;
        webService String Content;
    }
    webservice static ResponseCls exe_SendEmail(String objectapi,String objectId,String whatId,String TemplateId){
        ResponseCls resp = new ResponseCls();
        bidReview__c br;
        contractreview__c cr;
        try{
            Set<String> toAddress = new Set<String>();
            if(objectapi =='bidReview__c'){
                br = [select id,dateOfDeliveryReviewExpert__r.Email, outsourcingReviewExpert__r.Email,
                                    technologyReviewExpert__r.Email, serviceReviewExpert__r.Email,
                                   legalReviewExpert__r.Email,financeReviewExpert__r.Email,
                                   warrantyPeriodReviewExpert__r.Email,InternalControlReview__r.Email
                                   from bidReview__c where id =:whatId limit 1]; 
                //交货期 dateOfDeliveryReviewExpert__c 
                if(br.dateOfDeliveryReviewExpert__r.Email!=null){
                    toAddress.add(br.dateOfDeliveryReviewExpert__r.Email);
                }
                //外购 outsourcingReviewExpert__r.Email 
                if(br.outsourcingReviewExpert__r.Email!=null){
                    toAddress.add(br.outsourcingReviewExpert__r.Email);
                }
                //技术 technologyReviewExpert__r 
                if(br.technologyReviewExpert__r.Email!=null){
                    toAddress.add(br.technologyReviewExpert__r.Email);
                }
                //服务 serviceReviewExpert__r 
                if(br.serviceReviewExpert__r.Email!=null){
                    toAddress.add(br.serviceReviewExpert__r.Email);
                }
                //法务 legalReviewExpert__r 
                if(br.legalReviewExpert__r.Email!=null){
                    toAddress.add(br.legalReviewExpert__r.Email);
                }
                //财务 financeReviewExpert__r 
                if(br.financeReviewExpert__r.Email!=null){
                    toAddress.add(br.financeReviewExpert__r.Email);
                }
                //质保期 warrantyPeriodReviewExpert__r 
                if(br.warrantyPeriodReviewExpert__r.Email!=null){
                    toAddress.add(br.warrantyPeriodReviewExpert__r.Email);
                }
                
                 //内控 InternalControlReview__r 
                if(br.InternalControlReview__r.Email!=null){
                    toAddress.add(br.InternalControlReview__r.Email);
                }
            }else if(objectapi =='contractreview__c'){
                cr = [select id ,dateOfDeliveryReviewExpert__r.Email, 
                                        outsourcingReviewExpert__r.Email,
                                    	technologyReviewExpert__r.Email, 
                                   		legalReviewExpert__r.Email,financeReviewExpert__r.Email,
                                   		warrantyPeriodReviewExpert__r.Email,InternalControlReview__r.Email
                                        from contractreview__c where id =:objectId limit 1]; 
                
                //交货期 dateOfDeliveryReviewExpert__c 
                if(cr.dateOfDeliveryReviewExpert__r.Email!=null){
                    toAddress.add(cr.dateOfDeliveryReviewExpert__r.Email);
                }
                //外购 outsourcingReviewExpert__r.Email 
                if(cr.outsourcingReviewExpert__r.Email!=null){
                    toAddress.add(cr.outsourcingReviewExpert__r.Email);
                }
                //技术 technologyReviewExpert__r 
                if(cr.technologyReviewExpert__r.Email!=null){
                    toAddress.add(cr.technologyReviewExpert__r.Email);
                }
                
                //法务 legalReviewExpert__r 
                if(cr.legalReviewExpert__r.Email!=null){
                    toAddress.add(cr.legalReviewExpert__r.Email);
                }
                //财务 financeReviewExpert__r 
                if(cr.financeReviewExpert__r.Email!=null){
                    toAddress.add(cr.financeReviewExpert__r.Email);
                }
                //质保期 warrantyPeriodReviewExpert__r 
                if(cr.warrantyPeriodReviewExpert__r.Email!=null){
                    toAddress.add(cr.warrantyPeriodReviewExpert__r.Email);
                }
                //内控 InternalControlReview__r 
                if(cr.InternalControlReview__r.Email!=null){
                    toAddress.add(cr.InternalControlReview__r.Email);
                }
            }
            if(toAddress.size()>0){
                List<String> emailList = new List<String>();
                emailList.addAll(toAddress);
                EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:TemplateId limit 1];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(emailList);
                mail.setReplyTo('sam.sun@tranzvision.com.cn');
                mail.setSenderDisplayName('四方继保SOSP项目组');
                mail.setTemplateId(template.Id);
                mail.setTargetObjectId(objectId);
                mail.saveAsActivity = false;
                mail.setWhatId(whatId);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
                system.debug('toAddress---'+toAddress);
                system.debug('objectId---'+objectId);
                system.debug('whatId---'+whatId);
                system.debug('TemplateId---'+TemplateId);
                if(objectapi =='bidReview__c'){
                    if(br!=null){
                        br.IsEmailExpert__c='已通知';
                        Update br;
                    }
                }else if(objectapi =='contractreview__c'){
                    if(cr!=null){
                        cr.IsEmailExpert__c='已通知';
                        Update cr;
                    }
                }
                resp.Flag = true;
            }else{
                resp.Flag = false;
                resp.Content = '请选择各项评审负责人';
            }
            
            
        }catch(Exception e){
            resp.Flag = false;
            resp.Content = 'SOSP系统错误信息：'+e.getMessage();
        }
        return resp;
    }
}