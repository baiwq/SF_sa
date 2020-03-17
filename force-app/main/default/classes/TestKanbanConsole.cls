// SAM
@isTest(seeAllData=true)
public class TestKanbanConsole{
   @isTest static void Kanban1() {
      
      PageReference pageRef = Page.KanbanConsole;
      Test.setCurrentPage(pageRef);  
      
      Test.setMock(HttpCalloutMock.class, new BaiduMapHttpCalloutMock()); 
      KanbanConsole kc = new KanbanConsole();
      kc.ApprovalStrTranz('Pending');
      
      Account a = [Select Id from Account where approvalStatus__c=:'草稿' limit 1];
      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Submitting request for approval.');
      req1.setObjectId(a.id);
      req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req1.setSubmitterId(UserInfo.getUserId()); 
      //req1.setProcessDefinitionNameOrId('account_approval');
      req1.setSkipEntryCriteria(true);
      Approval.ProcessResult result = Approval.process(req1); 
      
   }   
}