@isTest(seeAllData=true)
public class TestSendEmailToSpecial {
	public static testMethod void testSendEmailClass(){
    	EmailTemplate et = new EmailTemplate();
        et.Name='test';
        et.DeveloperName='test12';
        et.FolderId=UserInfo.getUserId();
        et.TemplateType='visualforce';
        et.Markup='<messaging:emailTemplate subject="特殊产品通知" recipientType="Contact" relatedToType="quatation__c"> <messaging:htmlEmailBody > <html> <head></head> <body> <p>您好 ,</p> <br/><p>有新的报价需要您配置特殊产品价格；</p> <br/><p>业务机会名称：{!relatedTo.opportunity__r.Name},</p> <br/><p>报价管理编号：{!relatedTo.Name}.</p> <br/><br/><a href="https://cs58.salesforce.com/{!relatedTo.id}">https://cs58.salesforce.com/{!relatedTo.id}</a> </body> </html> </messaging:htmlEmailBody> </messaging:emailTemplate>';
        insert et;
        List<String> toAddress = new List<String>();
        toAddress.add('123@1231.com');
        SendEmailToSpecial.exe_SendEmail(toAddress, UserInfo.getUserId(), '', et.Id);
    }
}