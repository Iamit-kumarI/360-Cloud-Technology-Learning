public class ADE2Q1 {
	
    public class RequestInput{
        @InvocableVariable
        public String requestName;
        
        @InvocableVariable
        public String Email;
        
        @InvocableVariable
        public String Status;
    }
    public class RequestOutput{
        @InvocableVariable
        public Boolean Success;
        
        @InvocableVariable
        public String message;
    }
    
    @InvocableMethod(label='Create Request')
    public static List<RequestOutput> saveRequest(List<RequestInput>reqParam){
        List<RequestOutput> output=new List<RequestOutput>();
        for(RequestInput input:reqParam){
            RequestOutput otpt=new RequestOutput();
            try{
                Request__c req=new Request__c();
                req.Name=input.requestName;
                req.Email__c=input.Email;
                req.Status__c=input.Status;
                
                insert req;
                otpt.Success=true;
                otpt.message='Request Saved Successfully';
            }catch(DmlException ex){
                otpt.Success=false;
                otpt.message=ex.getDmlMessage(0);
            }
            output.add(otpt);
        }
        return output;
    }
    
}
//just add this in calling one screeflow it should have three inputs name,email,string and check success and print message