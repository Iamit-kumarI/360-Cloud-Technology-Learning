public with sharing class FSQ10ScreenFlowCapstone {
    
    public class ServiceRequest{
        @InvocableVariable(required=true)
        public String subject;
        @InvocableVariable
        public String description;
        @InvocableVariable
        public String priority;
    }
    
   public class ServiceOutput{
        @InvocableVariable
        public List<String> successStatus=new List<String>();
        
        @InvocableVariable
        public Id recordIdd;
    }
    @InvocableMethod(label='Create Service Request')
    public static List<ServiceOutput> createService(List<ServiceRequest> serviceReqeusts){
        List<Service_Request__c>newRequestList=new List<Service_Request__c>();
        for(ServiceRequest curRequest:serviceReqeusts){
            Service_Request__c req=new Service_Request__c();
            req.Subject__c=curRequest.subject;
            req.Priority__c=curRequest.priority;
            req.Description__c=curRequest.description;
            newRequestList.add(req);
        }
        //try catch Database.SaveResult
        Database.SaveResult[]result=Database.insert(newRequestList,false);
        List<ServiceOutput>outPutMessage=new List<ServiceOutput>();
        for(Database.SaveResult sr:result){
			ServiceOutput output=new ServiceOutput();
            if(sr.isSuccess()){
                output.recordIdd=sr.getId();
                output.successStatus.add('Success');
            }else{
                for(Database.Error er:sr.getErrors()){
                    output.successStatus.add(er.getMessage());
                }
                //output.recordIdd='A';
            }
            outPutMessage.add(output);
        }
        return outPutMessage;
    }
}