/*
    类名：ApprovalAssignmentInvoice
    功能：当开票创建或者提交审批的时候，判断合同接收日期和确认收入日期两个字段是否有值。如果没有值，则从子对象开票项中获取。
            若子对象中存在合同接收日期或确认收入日期字段值为空的记录。则开票数据中的对应字段为空，不做赋值。
            若子对象中的合同接收日期和确认收入日期字段值均不为空，则开票数据中的对应字段为最近的日期。
    作者：Jimmy Cao 曹阳 雨花石
    时间：2019-08-06
*/
trigger ApprovalAssignmentInvoice on invoice__c (before update) 
{
    Set<Id> invoiceIds = new Set<Id>();
    for (invoice__c invoice : (List<invoice__c>)trigger.new) 
    {
        invoice__c old_invoice = (invoice__c)trigger.oldMap.get(invoice.Id);
        if (invoice.approvalStatus__c == '提交待审批' && old_invoice.approvalStatus__c != '提交待审批') 
        {
            invoiceIds.add(invoice.Id);
        }
    }

    if (invoiceIds != null && invoiceIds.size() > 0) 
    {
        List<invoice__c> invoiceList = [SELECT Id,ContractReceipt__c,ConfirmRevenue__c,
                                        (SELECT Id,ContractReceiptDate__c,ConfirmRevenue__c FROM invoiceLine__r)
                                        FROM invoice__c
                                        WHERE Id IN: invoiceIds];
        Set<Id> contractReceiptSet = new Set<Id>(); //合同接收日期赋值为空的集合。若在此集合中，则说明开票项中存在为空的。后续不再为此记录赋值
        Set<Id> confirmRevenueSet = new Set<Id>(); //确认收入日期赋值为空的集合。若在此集合中，则说明开票项中存在为空的。后续不再为此记录赋值
        //ConfirmRevenue__c
        for (invoice__c inv : invoiceList) 
        {
            invoice__c invoice = (invoice__c)trigger.newMap.get(inv.Id);
            for (invoiceItem__c item : inv.invoiceLine__r) 
            {
                //合同接收日期赋值
                if (!contractReceiptSet.contains(invoice.Id)) 
                {
                    if (item.ContractReceiptDate__c != null && inv.ContractReceipt__c == null) 
                    {
                        invoice.ContractReceipt__c = item.ContractReceiptDate__c;
                    }
                    else if (item.ContractReceiptDate__c != null && inv.ContractReceipt__c != null) 
                    {
                        if (item.ContractReceiptDate__c < inv.ContractReceipt__c) 
                        {
                            invoice.ContractReceipt__c = item.ContractReceiptDate__c;
                        }
                    }
                    else if(item.ContractReceiptDate__c == null)
                    {
                        invoice.ContractReceipt__c = null;
                        contractReceiptSet.add(invoice.Id);
                    }
                }

                //确认收入日期
                if (!confirmRevenueSet.contains(invoice.Id)) 
                {
                    if (item.ConfirmRevenue__c != null && inv.ConfirmRevenue__c == null) 
                    {
                        invoice.ConfirmRevenue__c = item.ConfirmRevenue__c;
                    }
                    else if (item.ConfirmRevenue__c != null && inv.ConfirmRevenue__c != null) 
                    {
                        if (item.ConfirmRevenue__c < inv.ConfirmRevenue__c) 
                        {
                            invoice.ConfirmRevenue__c = item.ConfirmRevenue__c;
                        }
                    }
                    else if(item.ConfirmRevenue__c == null)
                    {
                        invoice.ConfirmRevenue__c = null;
                        confirmRevenueSet.add(invoice.Id);
                    }
                }
            }
        }
    }
}