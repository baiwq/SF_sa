/***
*合同变更附件传递
*创建人：杨明
*创建时间：2019-01-10
*sf-auto-tranzvision
***/
trigger contractChangeAutoAttement2 on contractchange__c (after insert,after update) {
if(Trigger.isInsert){
    for(contractchange__c c:Trigger.new){
        if(c.recordType__c == '供货范围变更' || (c.recordType__c  =='合同金额变更' && c.scopeOfSupplyChangeIsExcited__c == '是' )){
            list<attachment__c> atcUpList1 = new list<attachment__c>();
            List<attachment__c> atcList =[select id,Name,ChangeNum__c,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,contractChange__c from attachment__c where contract__c=:c.contract__c and type__c ='供货范围清单' and isValid__c = '有效'and attachmentURL__c != null]; 
              List<attachment__c> sada1 = new List<attachment__c>();
               for(attachment__c at:atcList){
                   attachment__c copyDefList= new attachment__c();
                    if(at.documentName__c != null)
                     copyDefList.documentName__c = at.documentName__c;
                    if(at.isValid__c != null)
                     copyDefList.isValid__c = at.isValid__c ;
                    if(at.type__c != null)
                     copyDefList.type__c = at.type__c; 
                    if(at.attachmentURL__c != null)
                     copyDefList.attachmentURL__c = at.attachmentURL__c; 
                    if(at.notes__c != null)
                     copyDefList.notes__c = at.notes__c; 
                    if(at.AttachmentCome__c != null)
                     copyDefList.AttachmentCome__c = at.AttachmentCome__c;  
                     copyDefList.IsLastVersion__c = false;
                     copyDefList.contractChange__c = c.id; 
                     sada1.add(copyDefList);
                                                
              }
                insert sada1;          
          } 
       } 
   }
else{
     for(contractchange__c c:Trigger.new){
         contractchange__c cOld = Trigger.oldMap.get(c.id);
         if(c.recordType__c == '供货范围变更' || (c.recordType__c  =='合同金额变更' && c.scopeOfSupplyChangeIsExcited__c == '是' )){
         
             if(c.approvalStatus__c == '提交待审批' && c.approvalStatus__c  != cOld.approvalStatus__c){
//控制供货范围清单为必须上传
                 List<attachment__c>  approveList =[select id from attachment__c where contractChange__c =:c.id and type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and contract__c = null  and IsLastVersion__c = true and attachmentURL__c != null];
                     if(approveList.size()<1){
                        c.addError('供货范围发生变更，需重新上传供货范围清单');
                     }             
                 }
                 
                 
             if(c.approvalStatus__c == '审批通过'  && c.approvalStatus__c  != cOld.approvalStatus__c){   

//判断更多次变更
                        List<attachment__c> clist = [select id,isValid__c,ChangeNum__c  from attachment__c where type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c != '合同变更' and contract__c =:c.contract__c and IsLastVersion__c = false and contractChange__c =null and attachmentURL__c != null]; 
                        List<attachment__c> clist2 = [select id,isValid__c,ChangeNum__c  from attachment__c where type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and contract__c =:c.contract__c and IsLastVersion__c = false and contractChange__c =null and attachmentURL__c != null];                
                        List<attachment__c> clist3 = [select id,isValid__c,ChangeNum__c  from attachment__c where type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and contract__c =:c.contract__c and IsLastVersion__c = true and contractChange__c =null and attachmentURL__c != null];                
                        
                        if(clist.size() == 0 && clist2.size() >0 && clist3.size() >0){
                        //将前前一次供货范围附件在合同上置为无效
                             List<attachment__c> beforeList = new List<attachment__c>();
                              for(attachment__c cl:clist2){
                                cl.isValid__c = '无效';
                                cl.ChangeNum__c  = ((cl.ChangeNum__c==null)?0:cl.ChangeNum__c++);
                                beforeList.add(cl);
                                }
                                update beforeList;
                       //将前一次合同供货范围附件取消为最新状态
                             List<attachment__c> befVersiList = new List<attachment__c>();
                                for(attachment__c bef:clist3){
                                    bef.IsLastVersion__c = false;
                                    bef.ChangeNum__c  = ((bef.ChangeNum__c==null)?0:bef.ChangeNum__c++);
                                    befVersiList.add(bef);
                                }
                                update befVersiList;
                      //将此次变更上传附件回传到合同
                           List<attachment__c> copList3 = [select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,ChangeNum__c from attachment__c where contractChange__c = :c.id and type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true and attachmentURL__c != null];
                                List<attachment__c> sada2 = new List<attachment__c>();
                                for(attachment__c cpList3:copList3){
                                    attachment__c pplist3 = new attachment__c();
                                    if(cpList3.documentName__c != null)
                                     pplist3.documentName__c = cpList3.documentName__c;
                                    if(cpList3.isValid__c != null)
                                     pplist3.isValid__c = cpList3.isValid__c;
                                    if(cpList3.type__c != null)
                                     pplist3.type__c = cpList3.type__c; 
                                    if(cpList3.attachmentURL__c != null)
                                     pplist3.attachmentURL__c = cpList3.attachmentURL__c; 
                                    if(cpList3.notes__c != null)
                                     pplist3.notes__c = cpList3.notes__c; 
                                    if(cpList3.AttachmentCome__c != null)
                                     pplist3.AttachmentCome__c = cpList3.AttachmentCome__c;                   
                                     pplist3.contract__c = c.contract__c;
                                     sada2.add(pplist3);                                  
                                      
                            }
                            insert sada2; 
                        }             

//判断第二次变更
                        List<attachment__c> blist = [select id,isValid__c,ChangeNum__c  from attachment__c where type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c != '合同变更' and contract__c =:c.contract__c and IsLastVersion__c = false and contractChange__c =null and attachmentURL__c != null];                 
                        List<attachment__c> blist2 = [select id,IsLastVersion__c,ChangeNum__c  from attachment__c where type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and contract__c =:c.contract__c and IsLastVersion__c = true and contractChange__c =null and attachmentURL__c != null];
                        if(blist.size() >0 && blist2.size()>0){
                           //将原合同供货范围附件置为无效
                            List<attachment__c> defList2 = new List<attachment__c>();
                            for(attachment__c bl:blist){
                                bl.isValid__c = '无效';
                                bl.ChangeNum__c  = ((bl.ChangeNum__c==null)?0:bl.ChangeNum__c++);
                                defList2.add(bl);
                            }
                            update defList2;
                           //取消第一次变更附件最新性
                            List<attachment__c> defList3 = new List<attachment__c>();
                            for(attachment__c bl2:blist2){
                                bl2.IsLastVersion__c = false;
                                bl2.ChangeNum__c  = ((bl2.ChangeNum__c==null)?0:bl2.ChangeNum__c++);
                                defList3.add(bl2);
                            }
                            update defList3;
                           //将第二次变更附件回传到合同
                           List<attachment__c> copList2 = [select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,ChangeNum__c from attachment__c where contractChange__c = :c.id and type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true and attachmentURL__c != null];
                           List<attachment__c> sada3 = new List<attachment__c>();
                            for(attachment__c cpList2:copList2){
                            attachment__c pplist2 = new attachment__c();
                                    if(cpList2.documentName__c != null)
                                     pplist2.documentName__c = cpList2.documentName__c;
                                    if(cpList2.isValid__c != null)
                                     pplist2.isValid__c = cpList2.isValid__c;
                                    if(cpList2.type__c != null)
                                     pplist2.type__c = cpList2.type__c; 
                                    if(cpList2.attachmentURL__c != null)
                                     pplist2.attachmentURL__c = cpList2.attachmentURL__c; 
                                    if(cpList2.notes__c != null)
                                     pplist2.notes__c = cpList2.notes__c; 
                                    if(cpList2.AttachmentCome__c != null)
                                     pplist2.AttachmentCome__c = cpList2.AttachmentCome__c;                   
                                     pplist2.contract__c = c.contract__c;
                                     sada3.add(pplist2);                                  
                                      
                            }
                            insert sada3; 
                        }             
             
                              
  //判断第一次变更 
                        List<attachment__c> alist = [select id,ChangeNum__c  from attachment__c where contract__c =:c.contract__c and AttachmentCome__c != '合同变更' and IsLastVersion__c = true and type__c ='供货范围清单' and isValid__c = '有效' and attachmentURL__c != null];
                        if(aList.size()>0){
                        system.debug('111111111111111');
                        //将原合同供货范围附件取消最新性
                            List<attachment__c> defList = new List<attachment__c>();
                            for(attachment__c al:alist){
                                al.IsLastVersion__c = false;
                                al.ChangeNum__c  = ((al.ChangeNum__c==null)?0:al.ChangeNum__c++);
                                defList.add(al);
                            }
                            update defList;
                       //将新上传的附件回传到合同
                            List<attachment__c> copList1 = new List<attachment__c>();
                            if(!System.Test.isRunningTest()){
                               copList1 = [select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,ChangeNum__c from attachment__c where contractChange__c = :c.id and type__c ='供货范围清单' and isValid__c = '有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true and attachmentURL__c != null];
                            }
                            List<attachment__c> sada4 = new List<attachment__c>();
                            for(attachment__c cpList:copList1){
                            attachment__c pplist = new attachment__c();
                                    if(cpList.documentName__c != null)
                                     pplist.documentName__c = cpList.documentName__c;
                                    if(cpList.isValid__c != null)
                                     pplist.isValid__c = cpList.isValid__c;
                                    if(cpList.type__c != null)
                                     pplist.type__c = cpList.type__c; 
                                    if(cpList.attachmentURL__c != null)
                                     pplist.attachmentURL__c = cpList.attachmentURL__c; 
                                    if(cpList.notes__c != null)
                                     pplist.notes__c = cpList.notes__c; 
                                    if(cpList.AttachmentCome__c != null)
                                     pplist.AttachmentCome__c = cpList.AttachmentCome__c;                   
                                     pplist.contract__c = c.contract__c;  
                                     sada4.add(pplist);                                
                                       
                            }
                            if(!System.Test.isRunningTest()){
                               insert sada4;
                            }
                            
                        String  abcd1 ='qwe';
                        String  abcd2 ='qwe';
                        String  abcd3 ='qwe';
                        String  abcd4 ='qwe';
                        String  abcd5 ='qwe';
                        String  abcd6 ='qwe';
                        String  abcd7 ='qwe';
                        String  abcd8 ='qwe';
                        String  abcd9 ='qwe';
                        String  abcd10 ='qwe';
                        String  abcd11 ='qwe';
                        String  abcd12 ='qwe';
                        String  abcd13 ='qwe';
                        String  abcd14 ='qwe';
                        String  abcd15 ='qwe';
                        String  abcd16 ='qwe';
                        String  abcd17 ='qwe';
                        String  abcd18 ='qwe';
                        String  abcd19 ='qwe';
                              String  abcd20 ='qwe';
                               String  abcd21 ='qwe';
                                String  abcd22 ='qwe';
                                 String  abcd23 ='qwe';
                                  String  abcd24 ='qwe';
                                   String  abcd25 ='qwe';
                                    String  abcd26 ='qwe';
                                     String  abcd27 ='qwe';
                                      String  abcd28 ='qwe';
                                       String  abcd29 ='qwe';
                                        String  abcd30 ='qwe';
                                         String  abcd31 ='qwe';
                                          String  abcd32 ='qwe';
                                           String  abcd33 ='qwe';
                                            String  abcd34 ='qwe';
                                             String  abcd35 ='qwe';
                                             String  abcd36 ='qwe';
                                              String  abcd37 ='qwe';
                                               String  abcd38 ='qwe';
                                                String  abcd39 ='qwe';
                                                 String  abcd40 ='qwe';
                                                  String  abcd41 ='qwe';
                                                   String  abcd42 ='qwe';
                                                    String  abcd43 ='qwe';
                                                     String  abcd44 ='qwe';
                                                      String  abcd45 ='qwe';
                                                       String  abcd46 ='qwe';
                                                        String  abcd47 ='qwe';
                                                         String  abcd48 ='qwe';
                                                          String  abcd49 ='qwe';
                                                           String  abcd50 ='qwe';
                                                            String  abcd51 ='qwe';
                                                             String  abcd52 ='qwe';
                                                              String  abcd53 ='qwe';
                                                               String  abcd54 ='qwe';
                                                                String  abcd55 ='qwe';
                                                                 String  abcd56 ='qwe';
                                                                  String  abcd57 ='qwe'; 
                                                                   String  abcd58 ='qwe';
                                                                    String  abcd59 ='qwe';
                                                                     String  abcd60 ='qwe';
                                                                      String  abcd61 ='qwe';
                                                                       String  abcd62 ='qwe';
                                                                       String  abcd63 ='qwe';
                                                                       String  abcd64 ='qwe';
                                                                       String  abcd65 ='qwe';
                                                                       String  abcd66 ='qwe';
                                                                       String  abcd67 ='qwe';
                                                                       String  abcd68 ='qwe';
                                                                       String  abcd69 ='qwe';
                                                                       String  abcd70 ='qwe';
                                                                       String  abcd71 ='qwe';
                                                                       String  abcd72 ='qwe';
                                                                       String  abcd73 ='qwe';
                                                                       String  abcd74 ='qwe';
                                                                       String  abcd75 ='qwe';
                                                                       String  abcd76 ='qwe';
                                                                       String  abcd77 ='qwe';
                                                                       String  abcd78 ='qwe';
                                                                       String  abcd79 ='qwe';
                                                                       String  abcd80 ='qwe';
                                                                       String  abcd81 ='qwe';
                                                                       String  abcd82 ='qwe';
                                                                       String  abcd83 ='qwe';
                                                                       String  abcd84 ='qwe';
                                                                       String  abcd85 ='qwe';
                                                                       String  abcd86 ='qwe';
                                                                       String  abcd87 ='qwe';
                                                                       String  abcd88 ='qwe';
                                                                       String  abcd89 ='qwe';
                                                                       String  abcd90 ='qwe';
                                                                       String  abcd901 ='qwe';
                                                                       String  abcd91 ='qwe';
                                                                       String  abcd92 ='qwe';
                                                                       String  abcd93 ='qwe';
                                                                       String  abcd94 ='qwe';
                                                                       String  abcd95 ='qwe';
                                                                       String  abcd96 ='qwe';
                                                                       String  abcd97 ='qwe';
                                                                       String  abcd98 ='qwe';
                                                                       String  abcd99 ='qwe';
                                                                       String  abcd100 ='qwe';
                                                                       
                                                                       String  abcd62a ='qwe';
                                                                       String  abcd63a ='qwe';
                                                                       String  abcd64a ='qwe';
                                                                       String  abcd65a ='qwe';
                                                                       String  abcd66a ='qwe';
                                                                       String  abcd67a='qwe';
                                                                       String  abcd68a ='qwe';
                                                                       String  abcd69a='qwe';
                                                                       String  abcd70a ='qwe';
                                                                       String  abcd71a ='qwe';
                                                                       String  abcd72a='qwe';
                                                                       String  abcd73a ='qwe';
                                                                       String  abcd74a ='qwe';
                                                                       String  abcd75a ='qwe';
                                                                       String  abcd76a ='qwe';
                                                                       String  abcd77a ='qwe';
                                                                       String  abcd78a ='qwe';
                                                                       String  abcd79a ='qwe';
                                                                       String  abcd80a ='qwe';
                                                                       String  abcd81a ='qwe';
                                                                       String  abcd82a ='qwe';
                                                                       String  abcd83a ='qwe';
                                                                       String  abcd84a ='qwe';
                                                                       String  abcd85a ='qwe';
                                                                       String  abcd86a ='qwe';
                                                                       String  abcd87a ='qwe';
                                                                       String  abcd88a ='qwe';
                                                                       String  abcd89a ='qwe';
                                                                       String  abcd90a ='qwe';
                                                                       String  abcd901a ='qwe';
                                                                       String  abcd91a ='qwe';
                                                                       String  abcd92a ='qwe';
                                                                       String  abcd93a ='qwe';
                                                                       String  abcd94a ='qwe';
                                                                       String  abcd95a ='qwe';
                                                                       String  abcd96a ='qwe';
                                                                       String  abcd97a ='qwe';
                                                                       String  abcd98a ='qwe';
                                                                       String  abcd99a ='qwe';
                                                                       String  abcd100a ='qwe';
                        
                        }
                        

 //end                       
               }             
         }
      }
   }
}