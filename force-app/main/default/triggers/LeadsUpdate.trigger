trigger LeadsUpdate on salesLeads__c (before update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(integer i=0; i<trigger.new.size(); i++){
         salesLeads__c sa = trigger.new[i];
         
// 如果线索管理责任人点击修改为 已分发，则修改字段
         if(sa.assignOrNot__c == true && trigger.old[i].assignOrNot__c == false){
            sa.approvalStatus__c = '已分发';
            sa.assignDate__c  = System.today();
         }
      
// 如果线索管理责任人点击修改为修改了Owner，则自动添加分享规则    
      if(sa.OwnerId != trigger.old[i].OwnerId){ 
         try{
            salesLeads__Share  ss = new salesLeads__Share();
            ss.RowCause = Schema.salesLeads__Share.RowCause.SHARE__c;
            ss.AccessLevel = 'Read';
            ss.UserOrGroupId = sa.CreatedById;
            ss.ParentId = sa.id;
            insert ss;
         }catch(Exception e){
            sa.addError(System.Label.Lead_SharingError);
         }
      }
       
// 勾选已分发的线索必须填写线索分发日期       
      if(sa.assignOrNot__c && sa.assignDate__c == null){ 
          sa.addError(System.Label.Lead_AssignError);
       }
        

//如果已立项，转成机会点      
      if(sa.approvalStatus__c == '已立项'){  //如果已立项
         if((sa.recordType__c != '单板单装置') && (sa.promoter__c == null || sa.projectManager__c == null)){  //最后审批通过时，这两个字段不能为空
            sa.addError(System.Label.Leads_LeaderError);
         }
           
/***       
* 线索名称  机会点名称
* 客户名  客户名
* 线索类型 项目类型  少一个字段 Pass
* 记录类型  记录类型
* 资金来源 资金来源
* 线索行业 机会点行业
* 预估金额  预估金额
* 预计招标时间 预计招标时间
* 客户项目所处阶段 客户项目所处阶段
* 项目分类    项目分类    
* 项目分级  项目分级
* 供货设备属性 供货设备属性
* 项目发起人
* 项目经理
* Owner
* 融资项目 融资项目
* 线索类型 项目类型
* 工程类别
***/        
        

        
         else if(sa.convertStatus__c == '未转化'){  //如果已转化，则不能再次转化
            Opportunity o = new Opportunity();
            o.name = sa.name;
            o.AccountId = sa.account__c;
            o.StageName = '引导客户';
            
          
            o.RecordTypeId = [Select id from RecordType where Name =:sa.recordType__c and SobjectType = :'Opportunity'].id;
            //国际专有信息
            if(sa.recordType__c=='常规'||sa.recordType__c=='集招/集采'||sa.recordType__c =='备品备件'||sa.recordType__c =='小额订单'){
                if(sa.bidLanguage__c!=null){
                    o.bidLanguage__c=sa.bidLanguage__c;
                }
                
                if(sa.equipmentInterfaceLanguage__c!=null){
                    o.equipmentInterfaceLanguage__c=sa.equipmentInterfaceLanguage__c;
                }
                
                if(sa.equipmentFileLanguage__c!=null){
                    o.equipmentFileLanguage__c=sa.equipmentFileLanguage__c;
                }
                
                if(sa.projectGoal__c!=null){
                    o.projectGoal__c=sa.projectGoal__c;
                }
                
                if(sa.projectTrackingPlan__c!=null){
                    o.projectTrackingPlan__c=sa.projectTrackingPlan__c;
                }
                
                if(sa.projectTrackingStrategy__c!=null){
                    o.projectTrackingStrategy__c=sa.projectTrackingStrategy__c;
                }
                
                if(sa.overseasAchievement__c!=null){
                    o.overseasAchievement__c=sa.overseasAchievement__c;
                }
                
                if(sa.finalUserAchievement__c!=null){
                    o.finalUserAchievement__c=sa.finalUserAchievement__c;
                }
                
                if(sa.finalUserQualificationRequireme__c!=null){
                    o.finalUserQualificationRequireme__c=sa.finalUserQualificationRequireme__c;
                }
                
                if(sa.finalUserAcceptability__c!=null){
                    o.finalUserAcceptability__c=sa.finalUserAcceptability__c;
                }
                
                if(sa.deliverWorkRange__c!=null){
                    o.deliverWorkRange__c=sa.deliverWorkRange__c;
                }
                if(sa.expectBidDate__c != null){
                    o.expectBidDate__c = sa.expectBidDate__c;
                    o.CloseDate = sa.expectBidDate__c.addDays(90);
                }
            }
            
            if(sa.fundSource__c != null){
               o.fundSource__c = sa.fundSource__c;
            }
          
            if(sa.industry__c != null){
               o.opportunityIndustry__c = sa.industry__c;
            }
            if(sa.industrySecondLevel__c!= null){
               o.industrySecondLevel__c= sa.industrySecondLevel__c;
            }
      

            if(sa.estimatedAmount__c != null){
               o.expectAmount__c = sa.estimatedAmount__c;
            }
          
            //2019-01-14 小额订单业务机会的默认值
            if(sa.recordType__c == '小额订单'){
              o.StageName = '谈判与签订合同';
              o.wonOrLost__c = '是';
              o.bidPossibility__c = '100%';
            }

            if(sa.recordType__c=='单板单装置'){
                if(sa.expectedSignDate__c != null){
                    o.CloseDate = sa.expectedSignDate__c;
                }
                if(sa.expectBidDate__c != null){
                    o.expectBidDate__c = sa.expectBidDate__c;
                }
            }
            if(sa.projectStage__c != null){
               o.projectStage__c = sa.projectStage__c;
            }
            if(sa.implementationStation__c != null){
               o.implementationStation__c= sa.implementationStation__c;
            }
            if(sa.country__c != null){
               o.country__c= sa.country__c;
            }
            if(sa.province__c != null){
               o.province__c= sa.province__c;
            }
             if(sa.stationLevel__c!= null){
               o.voltageLevel__c= sa.stationLevel__c;
            }
             if(sa.capacity__c!= null){
               o.capacity__c= sa.capacity__c;
            }
            if(sa.projectCategory__c != null){
               o.classification__c = sa.projectCategory__c;
            }
         
            if(sa.projectLevel__c != null){
               o.rating__c = sa.projectLevel__c;
            }
            
            if(sa.projectType__c != null){
               o.projectType__c = sa.projectType__c;
            }
            
            if(sa.Promoter__c != null){
               o.Promoter__c = sa.Promoter__c;
            }
            
            if(sa.projectManager__c != null){
               o.salesProjectManager__c = sa.projectManager__c;
            }
            //TOP项目 5个字段
            
            if(sa.operationTime__c != null){
                o.operationTime__c = sa.operationTime__c;
            }
            if(sa.designAccount__c != null){
                o.designAccount__c = sa.designAccount__c;
            }
            if(sa.projectOwnerName__c != null){
                o.projectOwner__c = sa.projectOwnerName__c;
            }
            if(sa.projectDesigner__c != null){
                o.projectDesigner__c = sa.projectDesigner__c;
            }
            if(sa.contractorAccount__c != null){
                o.contractorAccount__c = sa.contractorAccount__c;
            }
            

            //付肖 20190420  添加 事业部 行业 
            if(sa.ProductGroup__c != null){
                o.ProductGroup__c = sa.ProductGroup__c;
            }

            if(sa.IndustrySales__c != null){
                o.IndustrySales__c = sa.IndustrySales__c;
            }


            if(sa.MainProductGroup__c != null){
                o.MainProductGroup__c = sa.MainProductGroup__c;
            }

            if(sa.MainIndustrySales__c != null){
                o.MainIndustrySales__c = sa.MainIndustrySales__c;
            }



            o.OwnerId = sa.OwnerId;
            o.leadSource__c = sa.id;
          
            try{       //创建机会点
               insert o;
               system.debug('aa---'+o.Id);
            }catch(Exception e){
                sa.addError(System.Label.Lead_CvtOppError);
            }
          
            try{       //转化成机会点产品
               List<opportunityProduct__c> OP = new List<opportunityProduct__c>(); 
               List<leadsProduct__c> LPList = [select id, product__c, price__c, comments__c from leadsProduct__c where Leads__c =:sa.id];  // 查询该产品的价格手册并 limit 1
               for(leadsProduct__c lp:LPList){
                  OP.add(new opportunityProduct__c(opportunity__c = o.id,product__c = lp.product__c,comments__c = lp.comments__c, price__c = lp.price__c));
               }
               insert OP;
               //2019-01-14 添加小额订单是自动创建业绩分配比例，默认线索所有人100%
               if(sa.recordType__c =='备品备件'||sa.recordType__c =='小额订单'){
                    commisionSplit__c cs =new commisionSplit__c();
                    cs.opportunity__c =o.Id;
                    cs.approvalStatus__c='审批通过';
                    cs.OwnerId = sa.OwnerId;
                    insert cs;
                    commisionUser__c cu = new commisionUser__c();
                    cu.performanceProportion__c = 100;
                    cu.member__c = sa.OwnerId;
                    cu.OwnerId = sa.OwnerId;
                    cu.commisionSplit__c = cs.Id;
                    insert cu;
               } 
            }catch(Exception e){
               sa.addError(System.Label.Lead_CvtOppProError);
            }
            
            sa.convertStatus__c = '已转化';
         }
      }   
   }  
}}