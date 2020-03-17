public class ImpFindApprover {
    
   //发电业务单元
   public ID findDzApprover(String MainProductGroup,String OwnerCenter,String ownerDepartment,String OwnerProvince){
      ID itemID = null;
       if(MainProductGroup == '发电及用电业务单元-仿真事业部'){
           //郭东霞
           itemID = '00528000006Iqej';
       }else if(MainProductGroup == '发电及用电业务单元-工业物联网解决方案'){
           //邓俊波
           itemID = '0050I000009BIoT';
       }else if(MainProductGroup == '发电及用电业务单元-安全用电解决方案'){
           //胡倩
           itemID = '00528000006EsJe';  
       }else if(MainProductGroup == '发电及用电业务单元-电站保护自动化解决方案' ||MainProductGroup == '发电及用电业务单元-企业电力保护自动化解决方案' ||MainProductGroup == '发电及用电业务单元-自控解决方案'){
           if(ownerDepartment =='钢铁冶金行业销售部'){
               //郭东明
               itemID = '0050I000009l8lu';  
           }else if(ownerDepartment =='轨道交通行业销售部'){
               //陈方勤
               itemID = '00528000006Ewqh';  
           }else if(ownerDepartment =='石油化工行业销售部'){
			   //刘培军
               itemID = '0050I000009llAo';  
           }else if(OwnerProvince == '四川' || OwnerProvince == '重庆' ||OwnerProvince == '云南'){
               //李金奎
               itemID = '00528000006Iqd8'; 
           }else if(OwnerProvince == '河南'||OwnerProvince == '湖北'||OwnerProvince == '湖南'||OwnerProvince == '江西'||OwnerProvince == '西藏'||OwnerProvince == '豫鄂发电'||OwnerProvince == '江苏'||OwnerProvince == '浙江'||OwnerProvince == '上海'||OwnerProvince == '福建'||OwnerProvince == '安徽'||OwnerProvince == '山东'||OwnerProvince == '江浙沪发电'||OwnerProvince == '山东发电'||OwnerProvince == '广东'||OwnerProvince == '贵州'||OwnerProvince == '深圳'||OwnerProvince == '广西'||OwnerProvince == '海南'||OwnerProvince == '粤贵发电'){
               //师建华
               itemID = '00528000005AQf0';        
           }else if(OwnerProvince == '辽宁'||OwnerProvince == '吉林'||OwnerProvince == '蒙东'||OwnerProvince == '黑龙江'||OwnerProvince == '黑蒙辽发电'||OwnerProvince == '天津'||OwnerProvince == '河北'||OwnerProvince == '山西'||OwnerProvince == '内蒙古'||OwnerProvince == '冀北'||OwnerProvince == '北京'||OwnerProvince == '疆北'||OwnerProvince == '疆南'||OwnerProvince == '陕西'||OwnerProvince == '青海'||OwnerProvince == '甘肃'||OwnerProvince == '宁夏'||OwnerProvince == '陕西发电'||OwnerProvince == '发电一部'||OwnerProvince == '发电二部'||OwnerProvince == '发电三部'){
                //李进
               itemID = '00528000006Iqoh';
           }else{
              	//国海龙
           		itemID = '00528000005AScp'; 
           }
       }else{
           //高峰
           itemID = '00528000007AKVI'; 
       }
       return itemID;
   }
    
     //销售中心总经理
     public ID findSalesCenterManager(String OwnerCenter,String MainIndustrySales){
      ID itemID = null;
      if(OwnerCenter == '行业销售中心'){ 
          //高峰
          itemID =  '00528000007AKVI';
      
      }else if(OwnerCenter == '电力系统销售中心' && (MainIndustrySales == '电网业务' || MainIndustrySales == '发电业务')){
             //吴延龙
              itemID = '00528000005WuxV'; 
      }else if(OwnerCenter == '电力系统销售中心' && (MainIndustrySales == '用电业务'|| MainIndustrySales == '配用电业务')){
             //张兴
             itemID = '00528000005LQGi';
      }else if(OwnerCenter == '电力系统销售中心' && (MainIndustrySales == '' || MainIndustrySales == null)){        
             //吴延龙
              itemID = '00528000005WuxV';
      }else if(OwnerCenter == '电力系统销售中心' && (MainIndustrySales != ''&& MainIndustrySales != null &&MainIndustrySales != '电网业务' && MainIndustrySales != '发电业务'&&MainIndustrySales != '用电业务'&& MainIndustrySales != '配用电业务')){        
           //高峰
          itemID =  '00528000007AKVI';
      }else{
          itemID = null;
      }
      return itemID;
   }
    
    //输变电
    public ID findsbdApprover(String OwnerCenter,String ownerDepartment,String OwnerProvince){
      ID itemID = null;
      if(ownerDepartment == '国网产业销售部'){ 
          //卢孟杰
          itemID =  '00528000006Iqon';
      }else if(ownerDepartment == '东北区'){
          //陈景琳
          itemID =  '0050I000009nOJ8';
      }else if(ownerDepartment == '华北区'){ 
          //罗敬舸
          itemID =  '0050I000009nOIt';
      }else if(ownerDepartment == '西北区' || ownerDepartment == '新疆项目部'){ 
           //陈景琳
          itemID =  '0050I000009nOJ8';
      }else if(ownerDepartment == '华中区'){ 
         //卢孟杰
          itemID =  '00528000006Iqon';
      }else if(ownerDepartment == '华东区'){ 
          //李秀红
          itemID =  '0050I000009nOIy';
      }else if(OwnerProvince == '广东'||OwnerProvince == '南网组'||OwnerProvince == '深圳'){ 
          //韦史净
          itemID =  '00528000006Iqoo';
      }else if(OwnerProvince == '广西'||OwnerProvince == '贵州'||OwnerProvince == '云南' ||OwnerProvince == '海南' ){ 
          //唐竹蓓
          itemID =  '0050I000009nOJD';
      }else{
          //张道磊
          itemID =  '00528000006Iqom';

      }
      return itemID;
   }
    
    
    
    //产品业务单元财务BP
    public ID findProductBusinessBP(String MainProductGroup){
      ID itemID = null;
      if(MainProductGroup == '直流输电及电力电子业务单元-直流输电及电力电子产品' ||MainProductGroup == '直流输电及电力电子业务单元-感应加热与高频电源产品'|| MainProductGroup == '直流输电及电力电子业务单元-直流输电及电力电子事业部'|| MainProductGroup == '直流输电及电力电子业务单元-四方三伊'|| MainProductGroup == '直流输电及电力电子业务单元-电子式互感器'){ 
          //孙永刚
          itemID =  '00528000005CdPw';
      
      }else if(MainProductGroup == '配用电业务单元-配电开关' ||MainProductGroup == '配用电业务单元-配用电业务'|| MainProductGroup == '配用电业务单元-配用电二次'|| MainProductGroup == '配用电业务单元-配用电一次'|| MainProductGroup == '配用电业务单元-肯尼亚'){
         
          //周阳
          itemID =  '00528000005Donb';
      }else if(MainProductGroup == '输变电业务单元-电网保护自动化事业部' ||MainProductGroup == '输变电业务单元-电网控制事业部'  ||MainProductGroup == '输变电业务单元-智能运行管控事业部'|| MainProductGroup == '输变电业务单元-状态监测研发部'){
         
          //徐蓓蓓
          itemID =  '0050I000009le1Q';
          
      }else if( MainProductGroup == '发电及用电业务单元-电站保护自动化解决方案' || MainProductGroup == '发电及用电业务单元-企业电力保护自动化解决方案' || MainProductGroup == '发电及用电业务单元-仿真事业部' || MainProductGroup == '发电及用电业务单元-自控解决方案' || MainProductGroup == '发电及用电业务单元-工业物联网解决方案' || MainProductGroup == '发电及用电业务单元-安全用电解决方案' ){
         
          //张熙东
          itemID =  '00528000006Ib3c';
       
      }else{
          itemID = null;
      }
      return itemID;
   }
    
    
    //销售组织BP
    public ID findSalesOrganizationBP(String ownerCenter){
      ID itemID = null;
      if(ownerCenter == '国际业务' ||ownerCenter == '印度子公司'){ 
          //李燕春
          itemID =  '0050I000009miFY';
      
      }else if(ownerCenter == '电力系统销售中心'){
         
          //汪姝
          itemID =  '0050I000009miFx';
      }else if(ownerCenter == '行业销售中心'){
         
          //汪姝
          itemID =  '0050I000009miFx';
          
      }else{
         itemID = null;
      }
      return itemID;
   }
    
    
    public void TestString(){
        String test1 = 'test1';
        String test2 = 'test2';
        String test3 = 'test3';
        String test4 = 'test4';
        String test5 = 'test5';
        String test6 = 'test6';
        String test7 = 'test7';
        String test8 = 'test8';
        String test9 = 'test9';
        String test10 = 'test10';
        String test11 = 'test11';
        String test12 = 'test12';
        String test13 = 'test13';
        String test14 = 'test14';
        String test15 = 'test15';
        String test16 = 'test16';
        String test17 = 'test17';
        String test18 = 'test18';
        String test19 = 'test19';
        String test20 = 'test20';
        String test21 = 'test21';
        String test22 = 'test22';
        String test23 = 'test23';
        String test24 = 'test24';
        String test25 = 'test25';
        String test26 = 'test26';
        String test27 = 'test27';
        String test28 = 'test28';
        String test29 = 'test29';
        String test30 = 'test30';
        String test31 = 'test31';
        String test32 = 'test32';
        String test33 = 'test33';
        String test34 = 'test34';
        String test35 = 'test35';
        String test36 = 'test36';
        String test37 = 'test37';
        String test38 = 'test38';
        String test39 = 'test39';
        String test40 = 'test40';
        String test41 = 'test41';
        String test42 = 'test42';
        String test43 = 'test43';
        String test44 = 'test44';
        String test45 = 'test45';
        String test46 = 'test46';
        String test47 = 'test47';
        String test48 = 'test48';
        String test49 = 'test49';
        String test50 = 'test50';
        String test51 = 'test51';
        String test52 = 'test52';
        String test53 = 'test53';
        String test54 = 'test54';
        String test55 = 'test55';
        String test56 = 'test56';
        String test57 = 'test57';
        String test58 = 'test58';
        String test59 = 'test59';
        String test60 = 'test60';
        String test61 = 'test61';
        String test62 = 'test62';
        String test63 = 'test63';
        String test64 = 'test64';
        String test65 = 'test65';
        String test66 = 'test66';
        String test67 = 'test67';
        String test68 = 'test68';
        String test69 = 'test69';
        String test70 = 'test70';
        String test71 = 'test71';
        String test72 = 'test72';
        String test73 = 'test73';
        String test74 = 'test74';
        String test75 = 'test75';
        String test76 = 'test76';
        String test77 = 'test77';
        String test78 = 'test78';
        String test79 = 'test79';
        String test80 = 'test80';
        String test81 = 'test81';
        String te123st1 = 'test1';
        String te123st2 = 'test2';
        String te123st3 = 'test3';
        String te123st4 = 'test4';
        String te123st5 = 'test5';
        String te123st6 = 'test6';
        String te123st7 = 'test7';
        String te123st8 = 'test8';
        String te123st9 = 'test9';
        String te123st10 = 'test10';
        String te123st11 = 'test11';
        String te123st12 = 'test12';
        String te123st13 = 'test13';
        String te123st14 = 'test14';
        String te123st15 = 'test15';
        String te123st16 = 'test16';
        String te123st17 = 'test17';
        String te123st18 = 'test18';
        String te123st19 = 'test19';
        String te123st20 = 'test20';
        String te123st21 = 'test21';
        String te123st22 = 'test22';
        String te123st23 = 'test23';
        String te123st24 = 'test24';
        String te123st25 = 'test25';
        String te123st26 = 'test26';
        String te123st27 = 'test27';
        String te123st28 = 'test28';
        String te123st29 = 'test29';
        String te123st30 = 'test30';
        String te123st31 = 'test31';
        String te123st32 = 'test32';
        String te123st33 = 'test33';
        String te123st34 = 'test34';
        String te123st35 = 'test35';
        String te123st36 = 'test36';
        String te123st37 = 'test37';
        String te123st38 = 'test38';
        String te123st39 = 'test39';
        String te123st40 = 'test40';
        String te123st41 = 'test41';
        String te123st42 = 'test42';
        String te123st43 = 'test43';
        String te123st44 = 'test44';
        String te123st45 = 'test45';
        String te123st46 = 'test46';
        String te123st47 = 'test47';
        String te123st48 = 'test48';
        String te123st49 = 'test49';
        String te123st50 = 'test50';
        String te123st51 = 'test51';
        String te123st52 = 'test52';
        String te123st53 = 'test53';
        String te123st54 = 'test54';
        String te123st55 = 'test55';
        String te123st56 = 'test56';
        String te123st57 = 'test57';
        String te123st58 = 'test58';
        String te123st59 = 'test59';
        String te123st60 = 'test60';
     }
}