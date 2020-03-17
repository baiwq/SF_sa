public class PerformanceInterface {

    @future(callout=true)
    public static void SaveAchievementinfo(String id,String achievement_id, String department, String contract_no, String achievement_scale, String achievement_money, String achievement_type, String achievement_datetime ){
        PerformanceImp SaveAchievementinfo = new PerformanceImp();
        SaveAchievementinfo.SaveAchievementinfo(id, achievement_id, department, contract_no,achievement_scale,achievement_money,achievement_type,achievement_datetime);
    }
    
    
    @future(callout=true)
    public static void EditAchievementinfo(String id,String achievement_id, String department, String contract_no, String achievement_scale, String achievement_money, String achievement_type, String achievement_datetime ){
        PerformanceImp EditAchievementinfo = new PerformanceImp();
        EditAchievementinfo.EditAchievementinfo(id, achievement_id, department, contract_no,achievement_scale,achievement_money,achievement_type,achievement_datetime);
    }
    
}