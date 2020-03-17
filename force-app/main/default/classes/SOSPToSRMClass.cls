global class SOSPToSRMClass {
    global class Sourcing{
        webservice String Name;
        webservice String ContractNo;
        webservice String RecordType;
        webservice String Type;
        webservice String Owner;
        webservice String PayType;
        webservice String PaymentRatio;
        webservice String SalesOwner;
        webservice Decimal InquiryAmount;
        webservice Decimal BidAmount;
        webservice String OtherPaymentComment;
    }
    global class Materiel{
        webservice String Name;
        webservice String MaterielCode;
        webservice String Model;
        webservice Integer Numbers;
        webservice String Unit;
        webservice Decimal InquiryUnitPrice;
        webservice String PaymentDate;
        webservice String SupplyCycle;
        webservice String ManufactorNameAndPhone;
        webservice String ApplyReason;
        webservice String Req_num;
    }
    global class SourcingUrl{
        webservice String CreatedDate;
        webservice String CreatedBy;
        webservice String DocumentName;
        webservice String DocumentType;
        webservice String AttachmentURL;
        webservice String IsValid;
        webservice String Name;
        webservice String Req_num;
    }
    global class ApprovalHistory{
        webservice String ApprovalStep;
        webservice String ApprovalStatus;
        webservice String Actor;
        webservice String ApprovalDate;
        webservice String Comments;
        webservice String Req_num;
    }
    global class returnCls{
        webservice Sourcing sourcing;
        webservice List<SourcingUrl> urlList;
        webservice List<ApprovalHistory> historyList;
        webservice List<Materiel> materielList;
    }
    global class Response{
        webservice String flag;
        webservice String faultstring;
        webservice List<returnCls> retList;
    }
    webservice static Response getList(Datetime startTime,Datetime endTime){
        Response response = new Response();
        response.retList = new List<returnCls>();
        try{
            List<notCommonOutsourcing__c> notList =[select id, Name,paymentRatio__c,
                    contractNo__c,RecordTypeName__c,salesOwnerSRM__c,ownerSRM__c,inquiryAmount1__c,bidAmount1__c,payType__c,type__c 
                                from notCommonOutsourcing__c where approvalTime__c>=:startTime.addHours(-8) and 
                                            approvalTime__c<=:endTime.addHours(-8) limit 200];
            Map<String,Sourcing> smap = new Map<String,Sourcing>();
        
            if(notList.size()>0){
                String mess='';
                for(notCommonOutsourcing__c notCom : notList){
                    Sourcing sour = new Sourcing();
                    sour.Name=notCom.Name;
                    sour.ContractNo=notCom.contractNo__c;
                    sour.RecordType=notCom.RecordTypeName__c;
                    sour.Type=notCom.type__c;
                    sour.Owner=notCom.ownerSRM__c;
                    sour.PayType=notCom.payType__c;
                    sour.PaymentRatio=notCom.paymentRatio__c;
                    sour.InquiryAmount = notCom.inquiryAmount1__c;
                    sour.BidAmount = notCom.bidAmount1__c;
                    sour.SalesOwner =notCom.salesOwnerSRM__c;
                    smap.put(notCom.id, sour);
                    mess=mess+notCom.Name+';';
                }
                mess=mess.substring(0, mess.length()-1);
                response.flag='S';
                Map<Sourcing,List<SourcingUrl>> snotMap=getUrlList(smap);
                Map<Sourcing,List<ApprovalHistory>> appMap = getApprovals(smap);
                Map<Sourcing,List<Materiel>> maMap = getMateriel(smap);
                for(Sourcing sou :appMap.keySet()){
                    returnCls re = new returnCls();
                    re.sourcing=sou;
                    if(snotMap.size()>0){
                        re.urlList=snotMap.get(sou);
                    }else{
                        re.urlList=null;
                    }
                    if(appMap.size()>0){
                        re.historyList=appMap.get(sou);
                    }else{
                        re.historyList=null;
                    }
                    if(maMap.size()>0){
                        re.materielList=maMap.get(sou);
                    }else{
                        re.materielList=null;
                    }
                    response.retList.add(re);
                }   
                logClass.returnLog('成功', '已处理', '【SRM接口】SRM系统在'+startTime+'到'+endTime+'时间段内，成功抽取非常用外购：'+mess, '正常');
            }else{
                response.flag='S';
                logClass.returnLog('成功', '已处理', '【SRM接口】SRM系统在'+startTime+'到'+endTime+'时间段内，没有抽取到非常用外购', '正常');
            }
        }catch(Exception e){
            response.flag='Y';
            response.faultstring=e.getMessage();
             LogClass.returnLog('失败','未处理','【SRM接口】Sosp系统返回错误信息：' + e.getMessage(),'重要');
        }
        return response;        
    }
    public static Map<Sourcing,List<SourcingUrl>> getUrlList(Map<String,Sourcing> smap){
        List<attachment__c> attaList = [select Name,contractNumber__c,type__c,attachmentURL__c,documentName__c,
                                        notCommonOutsourcing__c,createdBySRM__c,CreatedDate,isValid__c from attachment__c where notCommonOutsourcing__c in:smap.keySet()];
        Map<Sourcing,List<SourcingUrl>> ssuMap = new Map<Sourcing,List<SourcingUrl>>();
        for(String common : smap.keySet()){
            List<SourcingUrl> sUrlList = new List<SourcingUrl>();
            for(attachment__c atta : attaList){
                if(common==atta.notCommonOutsourcing__c){
                    SourcingUrl sUrl =new SourcingUrl();
                    sUrl.CreatedDate=atta.CreatedDate.format('yyyy-MM-dd HH:mm:ss');
                    sUrl.CreatedBy=atta.createdBySRM__c;
                    sUrl.DocumentName=atta.documentName__c;
                    sUrl.DocumentType=atta.type__c;
                    sUrl.AttachmentURL=atta.attachmentURL__c;
                    sUrl.IsValid=atta.isValid__c;
                    sUrl.Name=atta.Name;
                    sUrl.Req_num=smap.get(common).Name;
                    sUrlList.add(sUrl);
                }
            }
            ssuMap.put(smap.get(common), sUrlList);
        }
        return ssuMap;
    }
    public static Map<Sourcing,List<ApprovalHistory>> getApprovals(Map<String,Sourcing> smap){
        List<String> deIds = new List<String>();
        List<ProcessDefinition> definitions = [SELECT Id, Name, DeveloperName, Type, Description, TableEnumOrId, LockType, State, CreatedDate, 
            CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp from ProcessDefinition where TableEnumOrId='notCommonOutsourcing__c'];
        for(ProcessDefinition definition:definitions){
            deIds.add(definition.id);
        }
        Map<String,String> nodeMap = new Map<String,String>();
        List<ProcessNode> nodes=[SELECT Id, Name, DeveloperName, ProcessDefinitionId, Description, SystemModstamp 
                    from ProcessNode where ProcessDefinitionId in: deIds];
        for(ProcessNode node : nodes){
            nodeMap.put(node.Id, node.Name);
        }
        List<String> instanIds =new List<String>();
        List<ProcessInstance> instances= [SELECT Id, ProcessDefinitionId, TargetObjectId from ProcessInstance where TargetObjectId in: smap.keySet()];
        for(ProcessInstance instance:instances){
            instanIds.add(instance.id);
        }
        List<ProcessInstanceStep> steps=[SELECT Id, ProcessInstanceId,ProcessInstance.TargetObjectId, StepStatus, OriginalActorId, ActorId,Actor.LastName, Comments, StepNodeId, 
                 ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes, CreatedDate, 
                 CreatedById, SystemModstamp from ProcessInstanceStep where ProcessInstanceId in:instanIds and StepStatus != 'NoResponse'];
        Map<Sourcing,List<ApprovalHistory>> appMap = new Map<Sourcing,List<ApprovalHistory>>();
        if(steps.size()>0){   
            for(String objId : smap.keySet()){
                List<ApprovalHistory> appList= new List<ApprovalHistory>();
                for(ProcessInstanceStep step:steps){
                    if(objId==step.ProcessInstance.TargetObjectId){
                        ApprovalHistory app = new ApprovalHistory();
                        app.ApprovalStep=nodeMap.get(step.StepNodeId);
                        if(step.StepStatus=='Started'){
                            app.ApprovalStatus='提交待审批';
                        }else if(step.StepStatus=='Approved'){
                            app.ApprovalStatus='审批通过';
                        }else if(step.StepStatus=='Rejected'){
                            app.ApprovalStatus='审批拒绝';
                        }
                        app.Actor=step.Actor.LastName;
                        app.ApprovalDate=step.SystemModstamp.format('yyyy-MM-dd HH:mm:ss');
                        app.Comments = step.Comments;
                        app.Req_num=smap.get(objId).Name;
                        appList.add(app);
                    } 
                }
                appMap.put(smap.get(objId), appList);
            }
        }
        return appMap;
    }
    public static Map<Sourcing,List<Materiel>> getMateriel(Map<String,Sourcing> smap){
        List<materiel__c> maList = [select id,Name,unit__c,materielCode__c,manufactorNameAndPhone__c,number__c,supplyCycle__c,model__c,applyReason__c,inquiryUnitPrice__c,paymentDate__c,notCommonOutsourcing__c from materiel__c where notCommonOutsourcing__c in:smap.keySet()];
        Map<Sourcing,List<Materiel>> maMap = new Map<Sourcing,List<Materiel>>();
        if(maList.size()>0){
            for(String souId :smap.keySet()){
                List<Materiel> materList = new List<Materiel>();
                for(materiel__c ma : maList){
                    if(souId==ma.notCommonOutsourcing__c){
                        Materiel m = new Materiel();
                        m.Name = ma.Name;
                        m.MaterielCode=ma.materielCode__c;
                        m.Model=ma.model__c;
                        m.Numbers=Integer.valueOf(ma.number__c);
                        m.InquiryUnitPrice=ma.inquiryUnitPrice__c;
                        m.PaymentDate=ma.paymentDate__c;
                        m.Unit = ma.unit__c;
                        m.SupplyCycle=ma.supplyCycle__c;
                        m.ManufactorNameAndPhone=ma.manufactorNameAndPhone__c;
                        m.ApplyReason=ma.applyReason__c;
                        m.Req_num=smap.get(souId).Name;
                        materList.add(m);
                    }                    
                }
                maMap.put(smap.get(souId), materList);
            }
        }
        return maMap;
    }
}