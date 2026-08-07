public class DCQ8SearchService {
    
    @AuraEnabled
    public static List<DCQ8WrapperClass> searchFromLWC(String searchTerm){
        return search(searchTerm);
    }
    
    public class DCQ8FlowRequestR {	
    	@InvocableVariable(required=true)
    	public String searchItem;
    }
    @invocableMethod(label='Global Search')
    public static List<List<DCQ8WrapperClass>> searchFromFlow(List<DCQ8FlowRequestR>requests){
        List<List<DCQ8WrapperClass>>response=new List<List<DCQ8WrapperClass>>();
        
        for(DCQ8FlowRequestR req:requests){
            response.add(search(req.searchItem));
        }
        return response;
    }
    
    public static List<DCQ8WrapperClass>search(String searchItem){
        List<DCQ8WrapperClass> wrapperList=new List<DCQ8WrapperClass>();
        
        //sosl main query 0->Account 1->Case 2->Contact
        List<List<SObject>> soslResult=[
            Find: searchItem
            In All fields
            Returning
            	Account(Id,Name),
            	Contact(Id,Name),
            	Case(Id,caseNumber,Subject)
        ];
        for(Account curAccount:(List<Account>)soslResult[0]){
            DCQ8WrapperClass newWrapper=new DCQ8WrapperClass();
            newWrapper.recordId=curAccount.Id;
            newWrapper.label=curAccount.Name;
            newWrapper.recordType='Account';
            newWrapper.rank=curAccount.Name.equalsIgnoreCase(searchItem)?1:2;
            wrapperList.add(newWrapper);
        }
        for(Contact curContact:(List<Contact>)soslResult[1]){
            DCQ8WrapperClass newWrapper=new DCQ8WrapperClass();
            newWrapper.recordId=curContact.Id;
            newWrapper.label=curContact.Name;
            newWrapper.recordType='Contact';
            newWrapper.rank=curContact.Name.equalsIgnoreCase(searchItem)?1:2;
            wrapperList.add(newWrapper);
        }
        //modify
        for(Case curCase:(List<Case>)soslResult[2]){
            DCQ8WrapperClass newWrapper=new DCQ8WrapperClass();
            newWrapper.recordId=curCase.Id;
            newWrapper.label=curCase.Subject;
            newWrapper.recordType='Case';
            newWrapper.rank=curCase.Subject!='null'&&curCase.Subject.equalsIgnoreCase(searchItem)?1:2;
            wrapperList.add(newWrapper);
        }
        wrapperList.sort();
        return wrapperList;
    }
}