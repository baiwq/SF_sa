trigger AccountGetCreditInfo on Account (before insert,before update) {
    for(Account acc:Trigger.new){
   
        if(Trigger.isInsert){
        //基本信息
            //1.企业性质
            Integer enterpriseProperty;
            if(acc.enterpriseProperty__c=='国企'){
                enterpriseProperty=0;
            }else if(acc.enterpriseProperty__c=='大型民营企业'){
                enterpriseProperty=-5;
            }else if(acc.enterpriseProperty__c=='民营企业'){
                enterpriseProperty=-10;
            }else if(acc.enterpriseProperty__c=='外资企业'){
                enterpriseProperty=-5;
            }else{
                enterpriseProperty=0;
            }
            acc.enterprisePropertyScore__c=enterpriseProperty;
            //2.企业注册成立时间
            Integer ZC;
            if(acc.ZC__c=='1年以内'){
                ZC=-15;
            }else if(acc.ZC__c=='1-3年（含）'){
                ZC=-10;
            }else if(acc.ZC__c=='3-5年（含）'){
                ZC=-5;
            }else if(acc.ZC__c=='5年以上'){
                ZC=0;
            }else{
                ZC=0;
            }
            acc.ZCScore__c=ZC;
            //3.企业注册资本
            Integer ZB;
            if(acc.ZB__c=='200万及以下'){
                ZB=-20;
            }else if(acc.ZB__c=='200-500万（含）'){
                ZB=-15;
            }else if(acc.ZB__c=='500-1000万（含）'){
                ZB=-10;
            }else if(acc.ZB__c=='1000-2000万（含）'){
                ZB=-5;
            }else if(acc.ZB__c=='2000万以上'){
                ZB=0;
            }else{
                ZB=0;
            }
            acc.ZBScore__c=ZB;
            //4.行业稳定性
            Integer HY1;
            if(acc.HY1__c=='风险行业'){
                HY1=-25;
            }else if(acc.HY1__c=='不稳定'){
                HY1=-20;
            }else if(acc.HY1__c=='稳定'){
                HY1=0;
            }else{
                HY1=0;
            }
            acc.HY1Score__c=HY1;
        //信用状况
            
            //1.买卖合同被告诉讼记录
            Integer SS1;
            if(acc.SS1__c=='8条以上'){
                SS1=-20;
            }else if(acc.SS1__c=='6-8条'){
                SS1=-15;
            }else if(acc.SS1__c=='3-5条'){
                SS1=-10;
            }else if(acc.SS1__c=='1-2条'){
                SS1=-5;
            }else if(acc.SS1__c=='无诉讼记录'){
                SS1=0;
            }else{
                SS1=0;
            }
            acc.SS1Score__c=SS1;
            //2.资产冻结记录
            Integer assetFreezdRecord;
            if(acc.assetFreezdRecord__c=='5000万以上'){
                assetFreezdRecord=-25;
            }else if(acc.assetFreezdRecord__c=='2000万-5000万（含）'){
                assetFreezdRecord=-20;
            }else if(acc.assetFreezdRecord__c=='1000-2000万（含）'){
                assetFreezdRecord=-15;
            }else if(acc.assetFreezdRecord__c=='500-1000万（含）'){
                assetFreezdRecord=-10;
            }else if(acc.assetFreezdRecord__c=='500万以下'){
                assetFreezdRecord=-5;
            }else if(acc.assetFreezdRecord__c=='无冻结记录'){
                assetFreezdRecord=0;
            }else{
                assetFreezdRecord=0;
            }
            acc.assetFreezdRecordScore__c=assetFreezdRecord;
            //3.经营异常
            Integer JJYC1;
            if(acc.JJYC1__c=='有'){
                JJYC1=-25;
            }else if(acc.JJYC1__c=='无'){
                JJYC1=0;
            }else{
                JJYC1=0;
            }
            acc.JJYC1Score__c=JJYC1;
            //4.被执行人信息
            Integer enforced;
            if(acc.enforced__c=='有'){
                enforced=-25;
            }else if(acc.enforced__c=='无'){
                enforced=0;
            }else{
                enforced=0;
            }
            acc.enforcedScore__c=enforced;
            //5.失信人信息
            Integer Dishonest;
            if(acc.Dishonest__c=='有'){
                Dishonest=-25;
            }else if(acc.Dishonest__c=='无'){
                Dishonest=0;
            }else{
                Dishonest=0;
            }
            acc.DishonestScore__c=Dishonest;
            //6.动产抵押
            Integer DC1;
            if(acc.DC1__c=='5000万以上'){
                DC1=-25;
            }else if(acc.DC1__c=='2000-5000万（含）'){
                DC1=-20;
            }else if(acc.DC1__c=='1000-2000万（含）'){
                DC1=-15;
            }else if(acc.DC1__c=='500-1000万（含）'){
                DC1=-10;
            }else if(acc.DC1__c=='500万及以下'){
                DC1=-5;
            }else if(acc.DC1__c=='无抵押'){
                DC1=0;
            }else{
                DC1=0;
            }
            acc.DC1Score__c=DC1;
            //7.股权出质
            Integer GQ1;
            if(acc.GQ1__c=='无出质'){
                GQ1=0;
            }else if(acc.GQ1__c=='500万及以下'){
                GQ1=-5;
            }else if(acc.GQ1__c=='500-1000万（含）'){
                GQ1=-10;
            }else if(acc.GQ1__c=='1000-2000万（含）'){
                GQ1=-15;
            }else if(acc.GQ1__c=='2000-5000万（含）'){
                GQ1=-20;
            }else if(acc.GQ1__c=='5000万以上'){
                GQ1=-25;
            }else{
                GQ1=0;
            }
            acc.GQ1Score__c=GQ1;
            //8.知识产权出质
            Integer ZS1;
            if(acc.ZS1__c=='无出质'){
                ZS1=0;
            }else if(acc.ZS1__c=='500万及以下'){
                ZS1=-5;
            }else if(acc.ZS1__c=='500-1000万（含）'){
                ZS1=-10;
            }else if(acc.ZS1__c=='1000-2000万（含）'){
                ZS1=-15;
            }else if(acc.ZS1__c=='2000-5000万（含）'){
                ZS1=-20;
            }else if(acc.ZS1__c=='5000万以上'){
                ZS1=-25;
            }else{
                ZS1=0;
            }
            acc.ZS1Score__c=ZS1;
        //历史合作情况
            //1.业务往来记录
            Integer YW1;
            if(acc.YW1__c=='正常业务往来'){
                YW1=0;
            }else if(acc.YW1__c=='2年以上无业务往来'){
                YW1=-10;
            }else{
                YW1=0;
            }
            acc.YW1Score__c=YW1;
        //回款情况
            //1.未按期付款比率
            Integer WFK1;
            if(acc.WFK1__c=='无欠款'){
                WFK1=0;
            }else if(acc.WFK1__c=='0-10%（含）'){
                WFK1=-5;
            }else if(acc.WFK1__c=='10%-20%（含）'){
                WFK1=-10;
            }else if(acc.WFK1__c=='20%-30%（含）'){
                WFK1=-15;
            }else if(acc.WFK1__c=='30%-40%（含）'){
                WFK1=-20;
            }else if(acc.WFK1__c=='40%以上'){
                WFK1=-25;
            }else{
                WFK1=0;
            }
            acc.WFK1Score__c=WFK1;
            //2.逾期1年以上应收账款
            Integer YS1;
            if(acc.YS1__c=='无欠款'){
                YS1=0;
            }else if(acc.YS1__c=='0-50万（含）'){
                YS1=-5;
            }else if(acc.YS1__c=='50-100万（含）'){
                YS1=-10;
            }else if(acc.YS1__c=='100-300万（含）'){
                YS1=-15;
            }else if(acc.YS1__c=='300-500万（含）'){
                YS1=-20;
            }else if(acc.YS1__c=='500万以上'){
                YS1=-25;
            }else{
                YS1=0;
            }
            acc.YS1Score__c=YS1;
        //不良记录
            //1.有无呆/坏帐记录
            Integer badRecord;
            if(acc.badRecord__c=='有'){
                badRecord=-25;
            }else if(acc.badRecord__c=='无'){
                badRecord=0;
            }else{
                badRecord=0;
            }
            acc.badRecordScore__c=badRecord;
            //2.有无起诉记录
            Integer sueRecord;
            if(acc.sueRecord__c=='有'){
                sueRecord=-25;
            }else if(acc.sueRecord__c=='无'){
                sueRecord=0;
            }else{
                sueRecord=0;
            }
            acc.sueRecordScore__c=sueRecord;
        //特殊减分项	
            //有无重大事件(影响支付能力)
            Integer event;
            if(acc.event__c=='有'){
                event=-25;
            }else if(acc.event__c=='无'){
                event=0;
            }else{
                event=0;
            }
            acc.eventScore__c=event;
        //特殊加分项
            //有付款担保
            Integer FK1;
            if(acc.FK1__c=='有'){
                FK1=10;
            }else if(acc.FK1__c=='无'){
                FK1=0;
            }else{
                FK1=0;
            }
            acc.FK1Score__c=FK1;
            //签署公司级战略合作协议
            Integer XY;
            if(acc.XY__c=='有'){
                XY=10;
            }else if(acc.XY__c=='无'){
                XY=0;
            }else{
                XY=0;
            }
            acc.XYScore__c=XY;
            Integer score =100+enterpriseProperty+ZC+ZB+HY1+SS1+assetFreezdRecord+
                				JJYC1+enforced+Dishonest+DC1+GQ1+ZS1+YW1+WFK1+YS1+badRecord+sueRecord+event+FK1+XY;
            acc.score__c=score;
            if(acc.industrySecondLevel__c =='学校及研究机构'||acc.industrySecondLevel__c=='市政'){
                acc.creditLevel__c='NR';
            }else{
                if(score>90){
                	acc.creditLevel__c='AAA';	    
                }else if(score>80&&score<=90){
                	acc.creditLevel__c='AA';    
                }else if(score>70&&score<=80){
                    acc.creditLevel__c='A';
                }else if(score>60&&score<=70){
                    acc.creditLevel__c='B';
                }else if(score>50&&score<=60){
                    acc.creditLevel__c='C';
                }else{
                    acc.creditLevel__c='C-';
                }
            }        
        }
        if(Trigger.isUpdate){
            Account accOld =Trigger.oldMap.get(acc.Id);
            if(acc.enterpriseProperty__c!=accOld.enterpriseProperty__c||
               acc.ZC__c!=accOld.ZC__c||
               acc.ZB__c!=accOld.ZB__c||
               acc.HY1__c!=accOld.HY1__c||
               acc.SS1__c!=accOld.SS1__c||
               acc.assetFreezdRecord__c!=accOld.assetFreezdRecord__c||
               acc.JJYC1__c!=accOld.JJYC1__c||
               acc.enforced__c!=accOld.enforced__c||
               acc.Dishonest__c!=accOld.Dishonest__c||
               acc.DC1__c!=accOld.DC1__c||
               acc.GQ1__c!=accOld.GQ1__c||
               acc.ZS1__c!=accOld.ZS1__c||
               acc.YW1__c!=accOld.YW1__c||
               acc.WFK1__c!=accOld.WFK1__c||
               acc.YS1__c!=accOld.YS1__c||
               acc.badRecord__c!=accOld.badRecord__c||
               acc.sueRecord__c!=accOld.sueRecord__c||
               acc.event__c!=accOld.event__c||
               acc.FK1__c!=accOld.FK1__c||
               acc.XY__c!=accOld.XY__c||
               acc.industrySecondLevel__c!=accOld.industrySecondLevel__c
              ){
                //基本信息
                    //1.企业性质
                    Integer enterpriseProperty;
                    if(acc.enterpriseProperty__c=='国企'){
                        enterpriseProperty=0;
                    }else if(acc.enterpriseProperty__c=='大型民营企业'){
                        enterpriseProperty=-5;
                    }else if(acc.enterpriseProperty__c=='民营企业'){
                        enterpriseProperty=-10;
                    }else if(acc.enterpriseProperty__c=='外资企业'){
                        enterpriseProperty=-5;
                    }else{
                        enterpriseProperty=0;
                    }
                  	acc.enterprisePropertyScore__c=enterpriseProperty;
                    //2.企业注册成立时间
                    Integer ZC;
                    if(acc.ZC__c=='1年以内'){
                        ZC=-15;
                    }else if(acc.ZC__c=='1-3年（含）'){
                        ZC=-10;
                    }else if(acc.ZC__c=='3-5年（含）'){
                        ZC=-5;
                    }else if(acc.ZC__c=='5年以上'){
                        ZC=0;
                    }else{
                        ZC=0;
                    }
                  	acc.ZCScore__c=ZC;
                    //3.企业注册资本
                    Integer ZB;
                    if(acc.ZB__c=='200万及以下'){
                        ZB=-20;
                    }else if(acc.ZB__c=='200-500万（含）'){
                        ZB=-15;
                    }else if(acc.ZB__c=='500-1000万（含）'){
                        ZB=-10;
                    }else if(acc.ZB__c=='1000-2000万（含）'){
                        ZB=-5;
                    }else if(acc.ZB__c=='2000万以上'){
                        ZB=0;
                    }else{
                        ZB=0;
                    }
                  	acc.ZBScore__c=ZB;
                    //4.行业稳定性
                    Integer HY1;
                    if(acc.HY1__c=='风险行业'){
                        HY1=-25;
                    }else if(acc.HY1__c=='不稳定'){
                        HY1=-20;
                    }else if(acc.HY1__c=='稳定'){
                        HY1=0;
                    }else{
                        HY1=0;
                    }
                  	acc.HY1Score__c=HY1;
                //信用状况
                    
                    //1.买卖合同被告诉讼记录
                    Integer SS1;
                    if(acc.SS1__c=='8条以上'){
                        SS1=-20;
                    }else if(acc.SS1__c=='6-8条'){
                        SS1=-15;
                    }else if(acc.SS1__c=='3-5条'){
                        SS1=-10;
                    }else if(acc.SS1__c=='1-2条'){
                        SS1=-5;
                    }else if(acc.SS1__c=='无诉讼记录'){
                        SS1=0;
                    }else{
                        SS1=0;
                    }
                  	acc.SS1Score__c=SS1;
                    //2.资产冻结记录
                    Integer assetFreezdRecord;
                    if(acc.assetFreezdRecord__c=='5000万以上'){
                        assetFreezdRecord=-25;
                    }else if(acc.assetFreezdRecord__c=='2000万-5000万（含）'){
                        assetFreezdRecord=-20;
                    }else if(acc.assetFreezdRecord__c=='1000-2000万（含）'){
                        assetFreezdRecord=-15;
                    }else if(acc.assetFreezdRecord__c=='500-1000万（含）'){
                        assetFreezdRecord=-10;
                    }else if(acc.assetFreezdRecord__c=='500万以下'){
                        assetFreezdRecord=-5;
                    }else if(acc.assetFreezdRecord__c=='无冻结记录'){
                        assetFreezdRecord=0;
                    }else{
                        assetFreezdRecord=0;
                    }
                  	acc.assetFreezdRecordScore__c=assetFreezdRecord;
                    //3.经营异常
                    Integer JJYC1;
                    if(acc.JJYC1__c=='有'){
                        JJYC1=-25;
                    }else if(acc.JJYC1__c=='无'){
                        JJYC1=0;
                    }else{
                        JJYC1=0;
                    }
                  	acc.JJYC1Score__c=JJYC1;
                    //4.被执行人信息
                    Integer enforced;
                    if(acc.enforced__c=='有'){
                        enforced=-25;
                    }else if(acc.enforced__c=='无'){
                        enforced=0;
                    }else{
                        enforced=0;
                    }
                  	acc.enforcedScore__c=enforced;
                    //5.失信人信息
                    Integer Dishonest;
                    if(acc.Dishonest__c=='有'){
                        Dishonest=-25;
                    }else if(acc.Dishonest__c=='无'){
                        Dishonest=0;
                    }else{
                        Dishonest=0;
                    }
                  	acc.DishonestScore__c=Dishonest;
                    //6.动产抵押
                    Integer DC1;
                    if(acc.DC1__c=='5000万以上'){
                        DC1=-25;
                    }else if(acc.DC1__c=='2000-5000万（含）'){
                        DC1=-20;
                    }else if(acc.DC1__c=='1000-2000万（含）'){
                        DC1=-15;
                    }else if(acc.DC1__c=='500-1000万（含）'){
                        DC1=-10;
                    }else if(acc.DC1__c=='500万及以下'){
                        DC1=-5;
                    }else if(acc.DC1__c=='无抵押'){
                        DC1=0;
                    }else{
                        DC1=0;
                    }
                  	acc.DC1Score__c=DC1;
                    //7.股权出质
                    Integer GQ1;
                    if(acc.GQ1__c=='无出质'){
                        GQ1=0;
                    }else if(acc.GQ1__c=='500万及以下'){
                        GQ1=-5;
                    }else if(acc.GQ1__c=='500-1000万（含）'){
                        GQ1=-10;
                    }else if(acc.GQ1__c=='1000-2000万（含）'){
                        GQ1=-15;
                    }else if(acc.GQ1__c=='2000-5000万（含）'){
                        GQ1=-20;
                    }else if(acc.GQ1__c=='5000万以上'){
                        GQ1=-25;
                    }else{
                        GQ1=0;
                    }
                  	acc.GQ1Score__c=GQ1;
                    //8.知识产权出质
                    Integer ZS1;
                    if(acc.ZS1__c=='无出质'){
                        ZS1=0;
                    }else if(acc.ZS1__c=='500万及以下'){
                        ZS1=-5;
                    }else if(acc.ZS1__c=='500-1000万（含）'){
                        ZS1=-10;
                    }else if(acc.ZS1__c=='1000-2000万（含）'){
                        ZS1=-15;
                    }else if(acc.ZS1__c=='2000-5000万（含）'){
                        ZS1=-20;
                    }else if(acc.ZS1__c=='5000万以上'){
                        ZS1=-25;
                    }else{
                        ZS1=0;
                    }
                  	acc.ZS1Score__c=ZS1;
                //历史合作情况
                    //1.业务往来记录
                    Integer YW1;
                    if(acc.YW1__c=='正常业务往来'){
                        YW1=0;
                    }else if(acc.YW1__c=='2年以上无业务往来'){
                        YW1=-10;
                    }else{
                        YW1=0;
                    }
                  	acc.YW1Score__c=YW1;
                //回款情况
                    //1.未按期付款比率
                    Integer WFK1;
                    if(acc.WFK1__c=='无欠款'){
                        WFK1=0;
                    }else if(acc.WFK1__c=='0-10%（含）'){
                        WFK1=-5;
                    }else if(acc.WFK1__c=='10%-20%（含）'){
                        WFK1=-10;
                    }else if(acc.WFK1__c=='20%-30%（含）'){
                        WFK1=-15;
                    }else if(acc.WFK1__c=='30%-40%（含）'){
                        WFK1=-20;
                    }else if(acc.WFK1__c=='40%以上'){
                        WFK1=-25;
                    }else{
                        WFK1=0;
                    }
                  	acc.WFK1Score__c=WFK1;
                    //2.逾期1年以上应收账款
                    Integer YS1;
                    if(acc.YS1__c=='无欠款'){
                        YS1=0;
                    }else if(acc.YS1__c=='0-50万（含）'){
                        YS1=-5;
                    }else if(acc.YS1__c=='50-100万（含）'){
                        YS1=-10;
                    }else if(acc.YS1__c=='100-300万（含）'){
                        YS1=-15;
                    }else if(acc.YS1__c=='300-500万（含）'){
                        YS1=-20;
                    }else if(acc.YS1__c=='500万以上'){
                        YS1=-25;
                    }else{
                        YS1=0;
                    }
                  	acc.YS1Score__c=YS1;
                //不良记录
                    //1.有无呆/坏帐记录
                    Integer badRecord;
                    if(acc.badRecord__c=='有'){
                        badRecord=-25;
                    }else if(acc.badRecord__c=='无'){
                        badRecord=0;
                    }else{
                        badRecord=0;
                    }
                  	acc.badRecordScore__c=badRecord;
                    //2.有无起诉记录
                    Integer sueRecord;
                    if(acc.sueRecord__c=='有'){
                        sueRecord=-25;
                    }else if(acc.sueRecord__c=='无'){
                        sueRecord=0;
                    }else{
                        sueRecord=0;
                    }
                  	acc.sueRecordScore__c=sueRecord;
                //特殊减分项	
                    //有无重大事件(影响支付能力)
                    Integer event;
                    if(acc.event__c=='有'){
                        event=-25;
                    }else if(acc.event__c=='无'){
                        event=0;
                    }else{
                        event=0;
                    }
                  	acc.eventScore__c=event;
                //特殊加分项
                    //有付款担保
                    Integer FK1;
                    if(acc.FK1__c=='有'){
                        FK1=10;
                    }else if(acc.FK1__c=='无'){
                        FK1=0;
                    }else{
                        FK1=0;
                    }
                  	acc.FK1Score__c=FK1;
                    //签署公司级战略合作协议
                    Integer XY;
                    if(acc.XY__c=='有'){
                        XY=10;
                    }else if(acc.XY__c=='无'){
                        XY=0;
                    }else{
                        XY=0;
                    }
                  	acc.XYScore__c=XY;
                    Integer score =100+enterpriseProperty+ZC+ZB+HY1+SS1+assetFreezdRecord+
                                        JJYC1+enforced+Dishonest+DC1+GQ1+ZS1+YW1+WFK1+YS1+badRecord+sueRecord+event+FK1+XY;
                    acc.score__c=score;
                    if(acc.industrySecondLevel__c =='学校及研究机构'||acc.industrySecondLevel__c=='市政'){
                        acc.creditLevel__c='NR';
                    }else{
                        if(score>90){
                            acc.creditLevel__c='AAA';	    
                        }else if(score>80&&score<=90){
                            acc.creditLevel__c='AA';    
                        }else if(score>70&&score<=80){
                            acc.creditLevel__c='A';
                        }else if(score>60&&score<=70){
                            acc.creditLevel__c='B';
                        }else if(score>50&&score<=60){
                            acc.creditLevel__c='C';
                        }else{
                            acc.creditLevel__c='C-';
                        }
                    }  
            }
        }
    }
}