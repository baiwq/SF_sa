@isTest
public class TestSospKindsOfInfoToBPM{
    static testMethod void TestToBPM(){
        SospKindsOfInfoToBPM.Response s1 = SospKindsOfInfoToBPM.AddAccountInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s2 = SospKindsOfInfoToBPM.UpdateAccountInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s3 = SospKindsOfInfoToBPM.AddSalesLeadInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s4 = SospKindsOfInfoToBPM.UpdateSalesLeadInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s5 = SospKindsOfInfoToBPM.AddOpportunityInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s6 = SospKindsOfInfoToBPM.UpdateOpportunityInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s7 = SospKindsOfInfoToBPM.AddContractInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        SospKindsOfInfoToBPM.Response s8 = SospKindsOfInfoToBPM.UpdateContractInfo('2017-09-20 09:00:13','2017-09-24 09:00:13');
        
        SospKindsOfInfoToBPM.Response s10 = SospKindsOfInfoToBPM.AddAccountInfo('aa','ss');
        SospKindsOfInfoToBPM.Response s20 = SospKindsOfInfoToBPM.UpdateAccountInfo('aa','ss');
        SospKindsOfInfoToBPM.Response s30 = SospKindsOfInfoToBPM.AddSalesLeadInfo('aa','ss ');
        SospKindsOfInfoToBPM.Response s40 = SospKindsOfInfoToBPM.UpdateSalesLeadInfo('aa','ss ');
        SospKindsOfInfoToBPM.Response s50 = SospKindsOfInfoToBPM.AddOpportunityInfo('aa','ss ');
        SospKindsOfInfoToBPM.Response s60 = SospKindsOfInfoToBPM.UpdateOpportunityInfo('aa','ss ');
        SospKindsOfInfoToBPM.Response s70 = SospKindsOfInfoToBPM.AddContractInfo(' aa','ss');
        SospKindsOfInfoToBPM.Response s80 = SospKindsOfInfoToBPM.UpdateContractInfo(' aa','ss');
        
    }
}