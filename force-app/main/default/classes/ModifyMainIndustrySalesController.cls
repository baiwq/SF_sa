/*
    类名：ModifyMainIndustrySalesController
    功能：变更记录项目所属行业页面的控制类
    作者：Jimmy Cao 曹阳 雨花石
    时间：2019-08-08
*/
public without sharing class ModifyMainIndustrySalesController {
    public Id dataId{get;set;}
    public String dataName{get;set;}
    public String ownerName{get;set;}
    public String createdByName{get;set;}
    public String fieldValue{get;set;}
    public String approverValue{get;set;}
    public String newFieldValue{get;set;}
    public String newApproverValue{get;set;}
    public salesLeads__c acc1{get;set;} //此处需要使用VF页面中的outPutField属性，所以定义两个对象类型的数据进行接收，此对象不做任何DML操作
    public salesLeads__c acc2{get;set;} //此处需要使用VF页面中的inPutField属性，所以定义两个对象类型的数据进行接收，此对象不做任何DML操作
    public Sobject data{get;set;}
    public FieldRelationship__c dataRelation{get;set;}
    public List<SelectOption> optionList{get;set;}
    public String saveResult{get;set;}
    public ModifyMainIndustrySalesController() 
    {
        /********* 根据传入的数据ID获取到对应的数据的对象类型，并从自定义设置中获取对应的对象信息 */
        String dataIdStr = apexpages.currentPage().getParameters().get('dataId');
        List<FieldRelationship__c> relationList = FieldRelationship__c.getall().values();
        if(dataIdStr != null && dataIdStr != '')
        {
            dataId = ID.valueOf(dataIdStr);
            String sobjectType = dataId.getSObjectType().getDescribe().getName();
            for(FieldRelationship__c rela : relationList)
            {
                if(sobjectType != null && sobjectType.equalsIgnoreCase(rela.ObjectAPI__c))
                {
                    dataRelation = rela;
                }
            }
        }
        /************根据ID和自定义设置中维护的信息获取到数据 */
        if(dataId != null && dataRelation != null && dataRelation.FieldAPI__c != null && dataRelation.ObjectAPI__c != null)
        {
            String sqlStr = 'SELECT Id,Name,CreatedBy.Name,Owner.Name,' 
                            + dataRelation.FieldAPI__c + ', ' + dataRelation.ApproverFieldAPI__c + ' FROM ' 
                            + dataRelation.ObjectAPI__c + ' WHERE Id = \'' + dataId + '\'';
            List<Sobject> objList = Database.query(sqlStr);
            if(objList != null && objList.size() > 0)
            {
                data = objList[0];
            }
            System.debug('CY======data:'+data);
            /******字段赋值 */
            dataName = String.valueOf(data.get('Name'));
            // ownerName = String.valueOf(data.get('Owner').Name);
            // createdByName = String.valueOf(data.get('CreatedBy').Name);
            fieldValue = String.valueOf(data.get(dataRelation.FieldAPI__c));
            approverValue = String.valueOf(data.get(dataRelation.ApproverFieldAPI__c));
            acc1 = new salesLeads__c();
            acc2 = new salesLeads__c();
            acc1.cpywdyfzr__c = String.valueOf(data.get(dataRelation.ApproverFieldAPI__c));
        }

        /*****************获取到自定义设置中配置的字段信息，如果为选项列表，则获取到选项值 */
        optionList = new List<SelectOption>();
        if(dataRelation == null || dataRelation.ObjectAPI__c == null)
        {
            return;
        }
        Schema.SObjectType descResult = Schema.getGlobalDescribe().get(dataRelation.ObjectAPI__c);
        Map<String, Schema.SObjectField> fieldMap = descResult.getDescribe().fields.getMap();
        if(fieldMap != null && fieldMap.containsKey(dataRelation.FieldAPI__c))
        {
            Schema.SObjectField field = fieldMap.get(dataRelation.FieldAPI__c);
            if ('PICKLIST'.equalsIgnoreCase(String.valueOf(field.getDescribe().getType()))) 
            {
                List<Schema.PicklistEntry> fieldOptions = field.getDescribe().getPicklistValues();
                optionList.add(new SelectOption('','--请选择--'));
                for(Schema.PicklistEntry sp : fieldOptions)
                {
                    optionList.add(new SelectOption(sp.getValue(),sp.getLabel()));
                }
            }
        }
    }

    public void GetApprover()
    {
        String LeadingCadrelike = '%'+newFieldValue+'%';
        List<StaffingTables__c> Staffing_list = [select LeadingCadre__c from StaffingTables__c where name like :LeadingCadrelike ];
        String LeadingCadre = '';
        if(Staffing_list.size() > 0 && Staffing_list.get(0) != null && acc2 != null)
        {
            LeadingCadre = Staffing_list.get(0).LeadingCadre__c;
            acc2.cpywdyfzr__c = LeadingCadre;
        }
    }

    public void SaveData()
    {
        Savepoint sp = Database.setSavepoint(); 
        Map<Id,Profile> ProfileMap = new Map<Id,Profile>([Select Id,Name from Profile WHERE Name like '%系统管理员%' OR Name like '%Administrator%']);
        try {
            Sobject sObj = Schema.getGlobalDescribe().get(dataId.getSObjectType().getDescribe().getName()).newSObject();
            sObj.put('Id' , dataId);
            sObj.put(dataRelation.FieldAPI__c , newFieldValue);
            sObj.put(dataRelation.ApproverFieldAPI__c , acc2.cpywdyfzr__c);
            UPDATE sObj;

            if (ProfileMap != null && ProfileMap.containsKey(UserInfo.getProfileId())) 
            {
                List<ProcessInstanceWorkItem> processList = 
                            new List<ProcessInstanceWorkItem>([SELECT Id, ActorId,OriginalActorId,ProcessInstance.TargetObjectId 
                                                                FROM ProcessInstanceWorkItem 
                                                                WHERE ProcessInstance.TargetObjectId =: dataId AND ActorId =: acc1.cpywdyfzr__c]);
                if (processList != null && processList.size() > 0) 
                {
                    ProcessInstanceWorkItem pi = processList[0];
                    pi.ActorId = acc2.cpywdyfzr__c;
                    update pi;
                }
            }
            else 
            {
                List<ProcessInstanceWorkItem> processList = 
                            new List<ProcessInstanceWorkItem>([SELECT Id, ActorId,OriginalActorId,ProcessInstance.TargetObjectId 
                                                                FROM ProcessInstanceWorkItem 
                                                                WHERE ProcessInstance.TargetObjectId =: dataId AND ActorId =: UserInfo.getUserId()]);
                if (processList != null && processList.size() > 0) 
                {
                    ProcessInstanceWorkItem pi = processList[0];
                    pi.ActorId = acc2.cpywdyfzr__c;
                    update pi;
                }
            }
            saveResult = 'SUCCESS';
        } 
        catch (Exception e) 
        {
            Database.rollback(sp); 
            saveResult = e.getMessage();
        }
    }
}