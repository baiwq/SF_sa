public class SObjectSchema {
    public static void testSchema() {

        Map<String, Schema.SObjectType> m = Schema.getGlobalDescribe();
        system.debug('===size:' + m.size());
        objecets__c  test = null;
        integer i = 0;
        for(String n : m.keyset())
        {
           
            if(i>1000&&i<=1100){
                
                Schema.SObjectType sobj = m.get(n);
                Schema.DescribeSObjectResult objRe = sobj.getDescribe();
                String flage = '否';
                if( objRe.isCustom() ){
                        flage = '是';
                }
                String label = objRe.getLabel();
                system.debug('api='+ n+'label='+label);
                test = new objecets__c ();
                test.code__c = n;
                test.name = label;
                test.flage__c = flage;
                insert test;
            }
             i++;
        }
        
        
    }
    
}