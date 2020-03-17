/*
    类名：BatchStatisticsAccountProcessData
    功能：合同签订情况：客户上一年签订合同情况，客户当年签订合同情况
        应收账款情况：1年以内应收账款，1-2年应收账款，2-3年应收账款，3-4年应收账款，4-5年应收账款，5年以上应收账款
    功能逻辑：
    对应测试类：TestBatchStatisticsAccount

    作者：Mark 柏文强-雨花石
    时间：2019-11-20

    修改内容：2019-11-21 客户上一年签订合同情况  修改为统计客户近三年签订合同金额

    修改内容：2019-12-10 
 */
global class BatchStatisticsAccountProcessData implements Database.Batchable<sObject>, Database.Stateful
{
    public List<Account> accList {set;get;}

    public Map<Id,Account> accountMap = new Map<Id,Account>(); // 统计客户信息

    // 查找字段，合同接收日期 
    // 12.06 添加发货日期不为空的
    public String query = '';

    global BatchStatisticsAccountProcessData() 
    {
        System.debug('构造=======汇总所有会员的数据信息====');
        this.query = 'select Id,AccountsReceivableOneYear__c,AccountsReceivableYears__c,AccountsReceivable23Years__c,AccountsReceivable34Years__c,AccountsReceivable45Years__c,AccountsReceivable5Years__c,ContractsSignedThatYear__c,ContractsSignedThreeYear__c,TotalAccountsReceivable__c,unshippedReceivableYears__c from Account';
    }

    global BatchStatisticsAccountProcessData(Set<Id> accSet) 
    {
        System.debug('构造=======汇总单个会员的数据信息==accSet==>'+accSet);
        String str = 'select Id,AccountsReceivableOneYear__c,AccountsReceivableYears__c,AccountsReceivable23Years__c,AccountsReceivable34Years__c,AccountsReceivable45Years__c,AccountsReceivable5Years__c,ContractsSignedThatYear__c,ContractsSignedThreeYear__c,TotalAccountsReceivable__c,unshippedReceivableYears__c from Account'
        +' where Id In(';
        String StrId = '';
        for (Id accId : accSet) 
        {
            StrId = '\''+accId+'\'';
        }
        this.query = str+strId+')';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        System.debug('=====start======>');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, list<sObject> scope) 
    {
        System.debug('=====execute===accountList=====>'+(List<Account>)scope);

        Set<Id> accSet = new Set<Id>(); 
        for (Account account : (List<Account>)scope)
        {
            accSet.add(account.Id);
        }

        // 查找条件 审批状态=审批通过，作废标记 !=是，合同取消!=合同合并取消，合同取消!=合同取消
        List<Contract__c> conList = [select Id,RecordTypeName__c,contractCancel__c,account__c,cancelMark__c,approvalStatus__c, contractReceptDate__c,amount__c,noReturnContractAmount__c,completelyDeliverDate__c,(select Id,surplusMoney__c,stageDate__c from MScontractPayment__r) from Contract__c where RecordTypeName__c!='历史合同' and contractCancel__c != '合同合并取消' and contractCancel__c != '合同取消' and cancelMark__c != '是' and approvalStatus__c = '审批通过' and account__c In:accSet];

        for (Contract__c contract : conList)
        {
            if(String.isNotBlank(contract.account__c) && accountMap.containsKey(contract.account__c))
            {
                System.debug('========存在客户数据========');
                calculateAll(contract);
            }
            else if(!accountMap.containsKey(contract.account__c))
            {
                System.debug('=======不存在客户数据=======');
                Account account = new Account(Id = contract.account__c,AccountsReceivableOneYear__c=0,AccountsReceivableYears__c=0,AccountsReceivable23Years__c=0,
                    AccountsReceivable34Years__c=0,AccountsReceivable45Years__c=0,AccountsReceivable5Years__c=0,
                    TotalAccountsReceivable__c=0,ContractsSignedThatYear__c=0,ContractsSignedThreeYear__c=0,ContractsSignedYear__c=0,unshippedReceivableYears__c=0);
                accountMap.put(contract.account__c,account);
                calculateAll(contract);
            }
        }
        System.debug('=======accountMap.values()======='+accountMap.values());
        update accountMap.values();
    }

    //更新客户上的统计字段
    global void calculateAll(Contract__c contract)
    {
        Id accountId = contract.account__c;
        Date receiveDate = contract.contractReceptDate__c;

        Integer thisYear = Date.today().year();    // 当前年份
        
        // 应收账款总计，上一年签订合同金额，三年签订合同金额
        setTotal(contract,thisYear,receiveDate,Date.today());
        // 1年以内应收账款，1-2年应收账款，2-3年应收账款，3-4年应收账款，4-5年应收账款，5年以上应收账款
        
        if(contract.MScontractPayment__r!=null && contract.MScontractPayment__r.size()!=0)
        {
            for (paymentTerm__c paymentTerm : contract.MScontractPayment__r) 
            {
                Date stageDate = paymentTerm.stageDate__c;
                if(stageDate!=null)
                {
                    System.debug('=======付款阶段日期不为空=======');
                    setYearTotal(accountId,paymentTerm,stageDate,Date.today(),contract);
                }
            }
        }
    }

    // 应收账款总计：1年以内应收账款，1-2年应收账款，2-3年应收账款，3-4年应收账款，4-5年应收账款，5年以上应收账款
    global void setYearTotal(Id accountId,PaymentTerm__c paymentTerm,Date stageDate,Date thisDate,Contract__c contract)
    {
        Account account = accountMap.get(accountId);
        // 2019-12-06 添加 “发货日期”字段验证
        if(null!=paymentTerm.surplusMoney__c || Double.valueOf(0)==paymentTerm.surplusMoney__c)
        {
            if(contract.completelyDeliverDate__c==null && stageDate < thisDate)
            {
                Decimal oneAmount = account.unshippedReceivableYears__c;
                account.unshippedReceivableYears__c = oneAmount + paymentTerm.surplusMoney__c;
                accountMap.put(accountId, account);
            }
            else
            { 
                if((stageDate.addDays(1826) < thisDate) || (stageDate.addDays(1826) == thisDate))
                {           
                    Decimal oneAmount = account.AccountsReceivable5Years__c;
                    account.AccountsReceivable5Years__c = oneAmount + paymentTerm.surplusMoney__c;
                    accountMap.put(accountId, account);
                }
                else if((stageDate.addDays(1461) < thisDate) || (stageDate.addDays(1461) == thisDate))
                {
                    Decimal oneAmount = account.AccountsReceivable45Years__c;
                    account.AccountsReceivable45Years__c = oneAmount + paymentTerm.surplusMoney__c;
                    accountMap.put(accountId, account);
                }
                else if((stageDate.addDays(1096) < thisDate) || (stageDate.addDays(1096) == thisDate))
                {
                    Decimal oneAmount = account.AccountsReceivable34Years__c;
                    account.AccountsReceivable34Years__c = oneAmount + paymentTerm.surplusMoney__c;
                    accountMap.put(accountId, account);
                }
                else if((stageDate.addDays(731) < thisDate) || (stageDate.addDays(731) == thisDate))
                {
                    Decimal oneAmount = account.AccountsReceivable23Years__c;
                    account.AccountsReceivable23Years__c = oneAmount + paymentTerm.surplusMoney__c;
                    accountMap.put(accountId, account);
                }
                else if((stageDate.addDays(366) < thisDate) || (stageDate.addDays(366) == thisDate))
                {
                    Decimal oneAmount = account.AccountsReceivableYears__c;
                    account.AccountsReceivableYears__c = oneAmount + paymentTerm.surplusMoney__c;
                    accountMap.put(accountId, account);
                }
                else
                {
                    if((stageDate < thisDate) || (stageDate == thisDate))
                    {
                        Decimal oneAmount = account.AccountsReceivableOneYear__c;
                        account.AccountsReceivableOneYear__c = oneAmount + paymentTerm.surplusMoney__c;
                        accountMap.put(accountId, account);
                    }
                }
            }
        }
        System.debug('==========setYearTotal结束=========');
    }

    // 应收账款总计，上一年签订合同金额 修改为 近三年签订合同金额，当年签订合同金额赋值
    global void setTotal(Contract__c contract,Integer thisYear,Date receiveDate,Date todayDate)
    {   
        Account account = accountMap.get(contract.account__c);
        if(null!=contract.noReturnContractAmount__c)
        {           
            Double totalAmout = account.TotalAccountsReceivable__c;
            account.TotalAccountsReceivable__c = totalAmout + contract.noReturnContractAmount__c;
            accountMap.put(contract.account__c, account);
        }
        
        if(null!=receiveDate && null!=contract.amount__c)
        {
            Integer receiveYear = receiveDate.year();  // 合同接收日期年份
            // 当年签订合同金额赋值
            if(thisYear==receiveYear)
            {
                System.debug('=======当年签订合同金额赋值=======');
                Double thisYearAmount = account.ContractsSignedThatYear__c;
                // 应收账款总计
                account.ContractsSignedThatYear__c = contract.amount__c + thisYearAmount;
                accountMap.put(contract.account__c, account);
            }
            // 上一年签订合同金额赋值
            // if(receiveDate.addDays(365) > todayDate || receiveDate.addDays(365) == todayDate)
            if(thisYear-1==receiveYear)
            {
                System.debug('=======上一年签订合同金额赋值=======');
                Double thisYearAmount = account.ContractsSignedYear__c;
                // 应收账款总计
                account.ContractsSignedYear__c = contract.amount__c + thisYearAmount;   
                accountMap.put(contract.account__c, account);
            }
            // 上一年签订合同金额赋值  修改为  近三年签订合同金额
            if(receiveDate.addDays(1095) > todayDate || receiveDate.addDays(1095) == todayDate)
            {
                System.debug('=======近三年签订合同金额赋值=======');
                Double thisYearAmount = account.ContractsSignedThreeYear__c;
                // 应收账款总计
                account.ContractsSignedThreeYear__c = contract.amount__c + thisYearAmount;   
                accountMap.put(contract.account__c, account);
            }
        }
        System.debug('======setTotal结束=======');
    }

    global void finish(Database.BatchableContext BC) 
    {

    }

}