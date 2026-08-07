public class DCQ1Queueable implements Queueable, Database.AllowsCallouts{
	public List<Id>caseIds;
    public DCQ1Queueable(List<Id>caseId){
        this.caseIds=caseId;
    }
    public void execute(QueueableContext qc){
        List<Case>caseList=[Select Id,caseNumber from Case Where Id in: caseIds];
        Http http=new Http();
        for(Case curCase:caseList){
            HttpRequest req=new HttpRequest();
            req.setEndPoint('callout:/IncidentLogger/log');
            req.setMethod('Post');
            req.setHeader('Content-Type','application/json');
            
            Map<String,Object>payLoadBody=new Map<String,Object>();
            payLoadBody.put('CaseId',curCase.Id);
            payLoadBody.put('caseNumber',curCase.CaseNumber);
            req.setBody(JSON.serialize(payLoadBody));
            
            try{
                HttpResponse res=http.send(req);
                if(res.getStatusCode()==200){
                    IncedentResponseWrapper wrapper=(IncedentResponseWrapper)JSON.deserialize(res.getBody(),IncedentResponseWrapper.class);
                    curCase.External_Incident_Id__c=wrapper.incidentId;
                }  
            }catch(Exception e){
                System.debug('Callout failed '+e.getMessage());
            }
        } 
        if(!caseList.isEmpty()){
            update caseList;
        }
    }
    public class IncedentResponseWrapper{
        public Boolean success;
		public String incidentId;
        public String message;
    }
}