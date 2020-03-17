trigger TbbaozhengjinAfterInsert on tbbaozhengjin__c (after insert) {
    for(tbbaozhengjin__c tb : Trigger.new){
//修改业务机会上是否存在投标保证金
        Opportunity o =[Select tbIsExist__c from Opportunity where id=: tb.opportunity__c ];
        o.tbIsExist__c=true;
        update o;
    }
}