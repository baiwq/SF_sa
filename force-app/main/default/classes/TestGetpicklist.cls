@isTest
public class TestGetpicklist{
   public static testMethod void TestGetpicklist(){
       PickValues__c MainProductGroupVo = new PickValues__c();
       MainProductGroupVo.name = 'MainProductGroup';
       MainProductGroupVo.FieldName__c = 'MainProductGroup';
       MainProductGroupVo.isActive__c = 'true';
       insert MainProductGroupVo;
       
       
       PickValues__c  MainIndustrySalesVo = new PickValues__c();
       MainIndustrySalesVo.name = 'MainIndustrySales';
       MainIndustrySalesVo.FieldName__c = 'MainIndustrySales';
       MainIndustrySalesVo.isActive__c = 'true';
       insert MainIndustrySalesVo;
       
   }
    
     @isTest static void testVolumeDecreaseUnderMin() {
        System.schedule('测试15分钟', '0 15 * * * ?', new Getpicklist());
        //System.assertEquals(0, newVolume);        
    }
    
    
     @isTest static void testOpptOvertimeEmail() {
        System.schedule('测试15分钟', '0 15 * * * ?', new OpptOvertimeEmail());
        //System.assertEquals(0, newVolume);        
    }
}