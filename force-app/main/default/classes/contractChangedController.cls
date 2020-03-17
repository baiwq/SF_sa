public class contractChangedController{

    public String cId {get;set;}
        public List<ProcessInstanceStep> getApprovalList(){
            if(cId!=null){
                List<ProcessInstance> process = [SELECT Id from ProcessInstance where TargetObjectId=:cId];
                List<ProcessInstanceStep> steps =[SELECT Id, ProcessInstanceId,ProcessInstance.ProcessDefinition.Name, StepStatus, OriginalActorId,OriginalActor.name, ActorId,Actor.name,
                                              Comments, StepNodeId, ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes,
                                              CreatedDate, CreatedById, SystemModstamp from ProcessInstanceStep where ProcessInstanceId in: process order by SystemModstamp desc];
                return steps;
            }else{
                return null;
            }
        }
}