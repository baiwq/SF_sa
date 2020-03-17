global class GetFileReturn{
   global String FileName{get;set;}
   global String FileUrl{get;set;}
   //public String ContractId{get;set;}
   global String RecordId{get;set;}
   global GetFileReturn(){
      //System.Debug('FileName:' + Apexpages.currentPage().getParameters().get('FileName'));
      //System.Debug('FileName:' + String.valueOf(EncodingUtil.base64Decode(Apexpages.currentPage().getParameters().get('FileName'))));
      //FileName = EncodingUtil.base64Decode(Apexpages.currentPage().getParameters().get('FileName'));
      //base64Decode
      FileName = Apexpages.currentPage().getParameters().get('FileName');
      FileUrl = Apexpages.currentPage().getParameters().get('FileUrl').replace('\\', '\\\\');
       
      //FileName = Apexpages.currentPage().getParameters().get('FileName');
      //FileUrl = Apexpages.currentPage().getParameters().get('FileUrl');
      RecordId = Apexpages.currentPage().getParameters().get('RecordId');
      //attachment__c atta =[select id,documentName__c ,attachmentURL__c from attachment__c where id=:RecordId];
      // atta.documentName__c=FileName;
       //atta.attachmentURL__c=FileUrl;
       //update atta;
      System.Debug('FileName---' + FileName);
      System.Debug('FileUrl---' + RecordId);
      System.Debug('RecordId---' + FileUrl);
      
      
   }
    @RemoteAction
    global static String updateAtta(String RecordId,String FileName,String FileUrl ){
        System.Debug('FileName---11' + FileName);
      System.Debug('FileUrl---11' + RecordId);
      System.Debug('RecordId---11' + FileUrl);
        attachment__c atta= [select id,documentName__c,attachmentURL__c from attachment__c where id=:RecordId];
        atta.documentName__c=FileName;
        atta.attachmentURL__c=FileUrl;
        update atta;
        return '成功';
    }
   
}