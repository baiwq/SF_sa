global class GetContractUrl {
    global class Attachment{
        webservice String contractNoc;
        webservice String fileName;
        webservice String type;
        webservice String typeCode;
        webservice String fileUrl;
        webservice String isValid;
        webservice String isValidCode;
        webservice String Name;
        webservice Boolean isNewVersion;
        webService Datetime CHANGED_ON_DT;
    }
    public List<Attachment> attaList{get;set;}
    global class getList{
        webService List<Attachment> item;
        String AttachName = '';
        public getList(Datetime startDtime,Datetime endDtime){
            List<attachment__c> aList=[select Name,IsLastVersion__c ,contractNumber__c,documentName__c,attachmentURL__c,type__c,typeCode__c,isValid__c,isValidCode__c,LastModifiedDate from attachment__c where LastModifiedDate>= :startDtime and LastModifiedDate <=:endDtime order by LastModifiedDate limit 500];
            //List<attachment__c> aList=[select contractNumber__c,documentName__c,attachmentURL__c,type__c from attachment__c];
            item = new List<Attachment>();
            
            if(aList.size()>0){
                for(attachment__c a: aList){
                   AttachName = AttachName + a.Name +';';
                }
                LogClass.returnLog('成功','已处理','【获取附件接口】合同中间库成功抽取附件：开始时间：'+startDtime+'-'+'结束时间：'+endDtime+'时间段,合同附件编号为' + AttachName,'正常');
            }else{              
                LogClass.returnLog('成功','已处理','【获取附件接口】开始时间：'+startDtime+'-'+'结束时间：'+endDtime+'此时间段内无合同附件','正常');
            }
            for(attachment__c a : aList){
                Attachment at = new Attachment();
                at.contractNoc=a.contractNumber__c;
                at.fileName=a.documentName__c;
                at.type=a.type__c;
                at.typeCode=a.typeCode__c;
                at.fileUrl=a.attachmentURL__c;
                at.isValid=a.isValid__c;
                at.isValidCode=a.isValidCode__c;
                at.Name=a.Name;
                at.isNewVersion = a.IsLastVersion__c;
                at.CHANGED_ON_DT = a.LastModifiedDate;
                item.add(at);
            }
        }
    }
    global class urlList{
        webService List<getList> urlList ;
        public urlList(Datetime startDtime,Datetime endDtime){
           urlList  = new List<getList>();
           getList gList = new getList(startDtime,endDtime);
           // = gList.getList(startDtime,endDtime);
           urlList.add(gList);
        }
    }
    webservice static urlList queryAttachment(Datetime startDtime,Datetime endDtime){
        urlList url = new urlList(startDtime,endDtime);
        
        return url;
    }
}