/*
 *大区未发货合同金额修改2018-02-27
 **/
public class FuncPools{

//找到某人的年度计划重点情况并返回记录的ID    
   public ID findPlanItemID(String Year,String Month,String Category,String UsrID){
      ID itemID = null;
      List<PlanAndExeStatus__c> PEList = [Select id from PlanAndExeStatus__c where year__c = :Year and month__c =:Month and contractOrReturn__c =:Category and OwnerID__c =:UsrID];
      System.Debug('查找重点工作项 Query:Select id from PlanAndExeStatus__c where year__c = ' + Year + ' and month__c =' + Month + ' and contractOrReturn__c =' + Category + ' and OwnerID__c =' + UsrID );
      if(PEList.size() >= 1){
         return PEList[0].id;
      }else{
         return itemID;
      } 
   }
   
//找到某人的年度计划重点情况并返回记录的ID    
   public Map<ID, String> findYearPlanByID(String Year,String Month,String Category,String UsrID){
      Map<ID, String> MS = New Map<ID, String>();
      List<PlanAndExeStatus__c> PEList = [Select id,departmentName__c from PlanAndExeStatus__c where year__c = :Year and month__c =:Month and contractOrReturn__c =:Category and OwnerID__c =:UsrID];
      if(PEList.size() >= 1){
         MS.put(PEList[0].id, PEList[0].departmentName__c);
      }
      return MS;
   }
   
//找到某部门的年度计划重点情况并返回记录的ID    
   public ID findPlanItemIDDepart(String Year,String Month,String Category,String Depart){
      ID itemID = null;
      List<PlanAndExeStatus__c> PEList = [Select id from PlanAndExeStatus__c where year__c = :Year and month__c =:Month and contractOrReturn__c =:Category and departmentName__c =:Depart];
      System.Debug('查找重点工作项 Query:Select id from PlanAndExeStatus__c where year__c = ' + Year + ' and month__c =' + Month + ' and contractOrReturn__c =' + Category + ' and departmentName__c =' + Depart );
      if(PEList.size() >= 1){
         return PEList[0].id;
      }else{
         return itemID;
      } 
   }
    
//Auto付款方式
   public String SyncPayment(String contractid,Decimal amount){
      Decimal tempAmount = amount;
      Decimal totalPecent = 0;
      Decimal num = 0;
      String paymentStage = '';
      List<paymentTerm__c> ptList = [Select id, percentage__c, stage__c, collectionAmount__c, backMoney__c, surplusMoney__c, No__c from paymentTerm__c where contract__c = :contractid order by No__c];
      if(ptList.size() > 0){
         for(Integer a = 0;a < ptList.size(); a++){
            if(ptList[a].surplusMoney__c == null){
               return '合同金额为空或回款阶段百分比为空';
            }
         }
         
         for(Integer a = 0;a < ptList.size(); a++){
            if(ptList[a].percentage__c == null){
               return '回款阶段百分比为空';
            }
         }
         
         for(Integer a = 0;a < ptList.size(); a++){
            totalPecent = totalPecent + ptList[a].percentage__c;
         }  
         
         if(totalPecent != 100){
            return '回款阶段百分比不等于100%';
         }   
         
         for(Integer b = 0;b < ptList.size(); b++){
            if(ptList[b].collectionAmount__c == 0){
               ptList[b].backMoney__c = 0;
               ptList[b].collectionStatus__c = '已回款';
               continue;
            }
            if(tempAmount == 0){
               ptList[b].backMoney__c = 0;
               ptList[b].collectionStatus__c = '未回款';
               System.Debug('No1::' + ptList[b].No__c +':' + ptList[b].stage__c + tempAmount + '@' +ptList[b].backMoney__c);
              //continue;
            }else if(tempAmount >= ptList[b].collectionAmount__c){   
               ptList[b].backMoney__c = ptList[b].collectionAmount__c;
               tempAmount = tempAmount - ptList[b].collectionAmount__c;
               ptList[b].collectionStatus__c = '已回款';
               System.Debug('No2::' + ptList[b].No__c +':' + ptList[b].stage__c + tempAmount +'@' +ptList[b].backMoney__c);
            }else if(tempAmount < ptList[b].collectionAmount__c){
               ptList[b].backMoney__c = tempAmount;
               tempAmount = 0;
               ptList[b].collectionStatus__c = '回款中';
               System.Debug('No::3' + ptList[b].No__c +':' + ptList[b].stage__c + tempAmount +'@' +ptList[b].backMoney__c);
            }
         }
         update ptList;
         return 'Success';   
      }else{
         System.Debug('没有付款方式记录,应该是被人删掉了');
         return '没有付款方式记录';
      }
   }
   
   public String digitUppercase(String num){  
        String[] fraction = new List<String>{'角', '分'};  
        String[] digit = new List<String>{ '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' };  
        String[] unit1 = new List<String>{'', '拾', '佰', '仟'};//把钱数分成段,每四个一段,实际上得到的是一个二维数组  
        String[] unit2 = new List<String>{'元', '万', '亿','万亿'}; //把钱数分成段,每四个一段,实际上得到的是一个二维数组    

        String strVal = String.valueOf(num);  
        String head = strVal.substring(0,strVal.length()-3);         //整数部分  
        String endflag = strVal.substring(strVal.length()-2,strVal.length());              //小数部分  
        String endMoney='';  
        String headMoney = '';
       if('0.00'.equals(num)){
           return '零元整';
       }
        if('00'.equals(endflag)){  
            endMoney = '整';  
        }else{  
            if(!endflag.substring(0,1).equals('0')){  
                endMoney+=digit[Integer.valueOf(endflag.substring(0,1))]+'角';  
            }else if(endflag.substring(0,1).equals('0') && !endflag.substring(1,2).equals('0')){  
                endMoney+= '零';  
            }  
            if(!endflag.substring(1,2).equals('0')){  
                endMoney+=digit[Integer.valueOf(endflag.substring(1,2))]+'分';  
            }  
        }  
        String[] chars = head.split(''); 
        Map<String,Boolean> maps = new Map<String,Boolean>();//段位置是否已出现zero  
        boolean zeroKeepFlag = false;//0连续出现标志  
        Integer vidxtemp = 0;  
        for(Integer i=0;i<chars.size();i++){  
            Integer idx = Math.mod((chars.size()-1-i),4);//段内位置  unit1  
            Integer vidx = (chars.size()-1-i)/4;//段位置 unit2  
            String s = digit[Integer.valueOf(String.valueOf(chars[i]))];  
            if(!'零'.equals(s)){  
                headMoney += s +unit1[idx]+unit2[vidx];  
                zeroKeepFlag = false;  
            }else if(i==chars.size()-1 || maps.get('zero'+vidx)!=null){  
                headMoney += '' ;  
            }else{  
                headMoney += s;  
                zeroKeepFlag = true;  
                maps.put('zero'+vidx,true);//该段位已经出现0；  
            }  
            if(vidxtemp!=vidx || i==chars.size()-1){  
                headMoney = headMoney.replaceAll(unit2[vidx],'');  
                headMoney+=unit2[vidx];  
            }  
            if(zeroKeepFlag && Math.mod((chars.size()-1-i),4)==0){  
                headMoney = headMoney.replaceAll('零','');  
            }  
        }  
        return headMoney+endMoney;  
    }
      
//根据多选框值返回邮件地址清单   
    public List<String> getEmails(String emailAddress){
       List<String> TempValueList = emailAddress.split(';');
       List<String> Results = new List<String> ();
       String s;
       for(Integer i=0;i < TempValueList.size(); i++){
           Results.add(TempValueList[i].subString(TempValueList[i].indexOf('[')+1,TempValueList[i].length()-1));
       }
       return Results;
    }
     
//发送一封、多封邮件 标准对象  
    public void sendEmails(String[] toAddress,String objectId,String TemplateId){
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setToAddresses(toAddress);
       mail.setReplyTo('sam.sun@tranzvision.com.cn');
       mail.setSenderDisplayName('四方继保SOSP项目组');
       mail.setTemplateId(TemplateId);
       mail.setTargetObjectId(objectId);
       mail.saveAsActivity = false;
       mail.setWhatId('a0HN0000006MhDB');//'a0HN0000006MhDB'
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
     }
     
//发送一封、多封邮件 自定义对象   
     public void sendEmails(String[] toAddress,String objectId,String whatId,String TemplateId){
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setToAddresses(toAddress);
       mail.setReplyTo('sam.sun@tranzvision.com.cn');
       mail.setSenderDisplayName('四方继保SOSP项目组');
       mail.setTemplateId(TemplateId);
       mail.setTargetObjectId(objectId);
       mail.saveAsActivity = false;
       mail.setWhatId(whatId);
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
     }
     
//得到下拉列表值的Code
     public Map<String,Map<String,String>> getCodeValues(String ObjectName){
        List<codeRule__c> CRList = [Select id, Name , picklistValue__c, picklistName__c, enabledOrNot__c, code__c from codeRule__c where objectName__c=:ObjectName and enabledOrNot__c=true order by picklistName__c];
        Map<String,Map<String,String>> MSS = new Map<String,Map<String,String>>();
        Map<String,String> MS = new Map<String,String>();
        String strTemp = '';
        String strTempValues = '';
        for(Integer i = 0 ; i < CRList.size(); i++ ){
           if(i == 0){
              strTemp = CRList[0].picklistName__c;
           }
           
           if(strTemp != CRList[i].picklistName__c){
              strTempValues = CRList[i].picklistName__c;
              strTemp = CRList[i].picklistName__c;
              MSS.put(CRList[i-1].picklistName__c,MS);
              MS = new Map<String,String>();
              MS.put(CRList[i].picklistValue__c,CRList[i].code__c);
           }else{
              MS.put(CRList[i].picklistValue__c,CRList[i].code__c);
           }
           
           if(i == CRList.size() - 1){
              MSS.put(CRList[i].picklistName__c,MS);  
           }
        }
        System.Debug('MSS:' + MSS);
        return MSS;  
     }
    //合同备注
    public String updateComments(String comments,String commentsContract,String Id){
        if((comments+commentsContract).length()<=220){
            List<invoiceItem__c> items =[select contractNumber__c from invoiceItem__c where invoice__c=:Id];
            List<String> numList = new List<String>();
            
            for(invoiceItem__c invo : items){
                numList.add(invo.contractNumber__c);    
            }
           /* for(Integer a=0;a<numList.size();a++){
                for(Integer b=numList.size()-1;b>a;b--){
                    if(numList[a]==numList[b]){
                        numList.remove(b);
                    }
                }
            }*/
            String notes='';
            if(numList.size()>0){
                String str='';
                String InvoiceNotes = '';
                for(String s : numList){
                    str=str+';'+s;
                }    
                notes = str.substring(1, str.length());
                commentsContract=notes;
                if(!System.Test.isRunningTest()){
                     List<InvoiceNotes__c> InvoiceNoteslist =[select notes__c from InvoiceNotes__c where name=:commentsContract or ContractName__c =:commentsContract];
                    if(InvoiceNoteslist.size() > 0){
                        InvoiceNotes = ','+InvoiceNoteslist.get(0).notes__c;
                    }
                }
                if(comments != null ){
                    return comments+'\\'+commentsContract+InvoiceNotes;
                   
                }else{
                    return commentsContract+','+InvoiceNotes;
                }
            }else{
                return comments + ' ';
            }   
        }    
        return '字段长度大于220';
    }
    
//得到该大区的无合同发货总额
   public Decimal getAmountNoContract(String areaName){
      Set<String> SS = new Set<String>();
      Decimal noReturnContractAmount=0;
      List<AggregateResult> SList = [SELECT sum(noReturnContractAmount__c) from Shipping__c where area__c = :areaName and contractOrNot__c=:'无'];
      if(SList.size()>0){
          return Double.ValueOf(SList[0].get('expr0'));    
      }else{
          return 0;
      }
      /*for(shipping__c S:SList){
          SS.add(S.contracts__c);
      }
      List<Contract__c> ARList = [Select noReturnContractAmount__c from Contract__c where Id in :SS and salesTeamDepartment__c = :areaName and contractOrNot__c =:'无'];
      if(ARList.size() > 0){
         for(Contract__c con:ARList){
             noReturnContractAmount=noReturnContractAmount+con.noReturnContractAmount__c;
         }
         return noReturnContractAmount;
      }else{
         return noReturnContractAmount;
      }*/
   }
   
//得到该销售逾期未返回合同数
   public Integer getSalesNoContract(String UserId){
      List<AggregateResult> ARList = [Select count(id) from Contract__c where accountManager__c = :UserId and contractOrNot__c =:'无' and contractPreReturnDate__c < :System.today()];
      return ARlist.size();
   }
   
//得到签约客户已返回合同数
   public Integer getAccountNoContractCount(String AccountID){
      List<AggregateResult> ARList = [Select count(id) from Contract__c where contractOrNot__c =:'有' and account__c=:AccountID];
      return ARlist.size();
   }

//判断该开票项上的合同号是否是开票上的合同号
     public boolean VerifyInvoiceItem(String ContractID,String AccountID){
        Contract__c c = [Select account__c from Contract__c where id =:ContractID];
        if(c.account__c != AccountID){
           return false;
        }
        
        return true;
     }
//根据客户ID查询该客户下面所有合同 
    public void getContractInfo(String AccountID){
        List<AggregateResult> ARList =[select sum(contractAmountRMB__c),count(id) from Contract__c where account__c =:AccountID ];
        Account aa = [select contractAmount__c,contractNumber__c from Account where id=:AccountID];
        if(ARList.size()>0){
            if(aa.contractAmount__c==null){
                aa.contractAmount__c=0;
            }else{
                aa.contractAmount__c=Double.valueOf(ARList[0].get('expr0'));
            }
            if(aa.contractNumber__c==null){
                aa.contractNumber__c=0;
            }else{
                aa.contractNumber__c=Double.valueOf(ARList[0].get('expr1'));
            }
        }
    }
    
    public boolean getReturnPermission(){
       ID currentProfile = Userinfo.getProfileId();
       List<Profile> PList = [Select id,Name from Profile where (Name = :'System Administrator' or Name =:'系统管理员' or Name like :'B-%') and id =:currentProfile];
       if(PList.size() >=1 ){
          return true;
       }
       return false;
    }
    
//选履约查合同号
    public String queryContractName(String lvId){
        String str = '';
        guaranteeLetter__c gl=[select id, contractNumber__c from guaranteeLetter__c where id =:lvId];
        if(gl.contractNumber__c!=null){
            str=gl.contractNumber__c;
        }else{
            system.debug('履约保证金无合同');
        }
        return str;
    }
    
//更新该开票的所有开票项的金额到合同已开金额上(默认值 ➕ 累加值的方法)  开票头审批通过
    public void SetContractInvoice(String invoiceId){
       List<invoiceItem__c> IIList = [Select id, ALL_SAP__c,invoiceAmount__c, contract__c  from invoiceItem__c where invoice__c =:invoiceId];
       if(IIList.size() > 0){
          for(invoiceItem__c iitemp:IIList){
             Contract__c c = [Select id, invoiceSumAmount__c from Contract__c  where id =:iitemp.contract__c];
             c.invoiceSumAmount__c = c.invoiceSumAmount__c + iitemp.ALL_SAP__c;
             update c;
          }
       }
    }
    
//更新该开票的所有开票项的金额到合同已开金额上(默认值 ➕ 累加值的方法)  发票作废
    public void SetContractInvoiceZF(String invoiceId){
       List<invoiceItem__c> IIList = [Select id, ALL_SAP__c,invoiceAmount__c, contract__c  from invoiceItem__c where invoice__c =:invoiceId];
       if(IIList.size() > 0){
          for(invoiceItem__c iitemp:IIList){
             Contract__c c = [Select id, invoiceSumAmount__c from Contract__c  where id =:iitemp.contract__c];
             c.invoiceSumAmount__c = c.invoiceSumAmount__c - iitemp.ALL_SAP__c;
             update c;
          }
       }
    }
    
//更新该收据的所有收据项的金额到合同收据金额上(默认值 ➕ 累加值的方法) 收据审批通过
    public void SetContractReceipt(String receiptId){
       List<receiptItem__c> IIList = [Select id, receiptAmount__c, contract__c  from receiptItem__c where invoiceReceipt__c =:receiptId];
       if(IIList.size() > 0){
          for(receiptItem__c iitemp:IIList){
             Contract__c c = [Select id, receiptTotalAmount__c from Contract__c  where id =:iitemp.contract__c];
             c.receiptTotalAmount__c = c.receiptTotalAmount__c + iitemp.receiptAmount__c;
             update c;
          }
       }
    }
    
    public String getEndpointUrl(String ClassName){
       //Boolean flag = System.URL.getSalesforceBaseUrl().getHost().contains('ap7');
       //Boolean flag = URL.getSalesforceBaseUrl().getHost().left(2).equalsignorecase('cs');
       Boolean flag = [SELECT IsSandbox FROM Organization].IsSandbox;
       system.debug('uri---'+URL.getSalesforceBaseUrl().getHost());
       system.debug('flag---'+flag);
       if(!flag){
          if(ClassName == 'EsbMossGetcontractinvo'){
             return Label.Z_EsbMossGetcontractinvo;
          }else if(ClassName == 'EsbMossInsertContractInvoice'){
             return Label.Z_EsbMossInsertContractInvoice;
          }else if(ClassName == 'EspFindbytime'){
             return Label.Z_EspFindbytime;
          }else if(ClassName == 'FileServerToken'){
             return Label.Z_FileServerToken;
          }else if(ClassName == 'OrgCurrencyZfiDocumentGeneral'){
             return Label.Z_OrgCurrencyZfiDocumentGeneral;
          }else if(ClassName == 'ZsdCustomerCreate'){
             return Label.Z_ZsdCustomerCreate;
          }else if(ClassName == 'CreateCPQOrder'){
             return Label.CreateCPQOrder;
          }else if(ClassName == 'StatusToCPQ'){
             return Label.StatusToCPQ;
          }else if(ClassName == 'ContractChangeInterface'){
             return Label.Z_ContractChange;
          }
       }else{
          if(ClassName == 'EsbMossGetcontractinvo'){
             return Label.Z_EsbMossGetcontractinvo_Test;
          }else if(ClassName == 'EsbMossInsertContractInvoice'){
             return Label.Z_EsbMossInsertContractInvoice_Test;
          }else if(ClassName == 'EspFindbytime'){
             return Label.Z_EspFindbytime_Test;
          }else if(ClassName == 'FileServerToken'){
             return Label.Z_FileServerToken_Test;
          }else if(ClassName == 'OrgCurrencyZfiDocumentGeneral'){
             return Label.Z_OrgCurrencyZfiDocumentGeneral_Test;
          }else if(ClassName == 'ZsdCustomerCreate'){
             return Label.Z_ZsdCustomerCreate_Test;
          }else if(ClassName == 'CreateCPQOrder'){
             return Label.CreateCPQOrder_Test;
          }else if(ClassName == 'StatusToCPQ'){
             return Label.StatusToCPQ_Test;
          }else if(ClassName == 'ContractChangeInterface'){
             return Label.Z_ContractChange_Test;
          }
       }
       return 'ERROR，Parameter is not found.';
    }
}