public with sharing class Cal_Warranty_Controller{
    public String conNumValue{get;set;}
    public List<contract__c> conList{get;set;}
    public String info{get;set;}
    
    public void calculateWarrantyDays(){     
        try{
        String[] strs= conNumValue.subString(0,conNumValue.length()).split(',');
        conList = database.Query('select id,name,contractName__c from contract__c where name in :strs');     
        
        new cal_warranty_Date().updateWarrantyStageDate(conList);  
        
        if(conList.size()>0) {          
            info='更新成功';
        }else{
            info='更新失败,没有捕获到合同号，请检查合同号输入格式是否正确!';
        }
        
        
        }catch(Exception e){
               Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.FATAL,String.ValueOf(e)));
        }
                         
    }
}