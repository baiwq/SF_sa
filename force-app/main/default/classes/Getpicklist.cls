global class Getpicklist implements Schedulable{

    global void execute(SchedulableContext SC){  
                
        List<PickValues__c> del_PickValues = [select id from PickValues__c where FieldName__c = 'MainProductGroup' or FieldName__c = 'MainIndustrySales' ];
        if(del_PickValues.size() > 0){     
            delete del_PickValues;
        }
        
        //主责事业部
        List<Schema.PicklistEntry> MainProductGroupList = Schema.getGlobalDescribe().get('Opportunity').getDescribe().fields.getMap().get('MainProductGroup__c').getDescribe().getPicklistValues();
        
        PickValues__c  MainProductGroupVo = null;
        for(Schema.PicklistEntry MainProductGroup : MainProductGroupList)
        {
            MainProductGroupVo = new PickValues__c();
            MainProductGroupVo.name = MainProductGroup.getValue();
            MainProductGroupVo.FieldName__c = 'MainProductGroup';
            MainProductGroupVo.isActive__c = MainProductGroup.isActive()+'';
            insert MainProductGroupVo;
          	//System.debug('ple.getLabel: ' + ple.getLabel());
          	//System.debug('ple.getValue: ' + ple.getValue());
		  	//System.debug('ple.isActive: ' + ple.isActive());
        }
        
        
        //项目所属行业
        List<Schema.PicklistEntry> MainIndustrySalesList = Schema.getGlobalDescribe().get('Opportunity').getDescribe().fields.getMap().get('MainIndustrySales__c').getDescribe().getPicklistValues();
        
        PickValues__c  MainIndustrySalesVo = null;
        for(Schema.PicklistEntry MainIndustrySales : MainIndustrySalesList)
        {
            MainIndustrySalesVo = new PickValues__c();
            MainIndustrySalesVo.name = MainIndustrySales.getValue();
            MainIndustrySalesVo.FieldName__c = 'MainIndustrySales';
            MainIndustrySalesVo.isActive__c = MainIndustrySales.isActive()+'';
            insert MainIndustrySalesVo;
          	//System.debug('ple.getLabel: ' + ple.getLabel());
          	//System.debug('ple.getValue: ' + ple.getValue());
		  	//System.debug('ple.isActive: ' + ple.isActive());
        }
    }
}