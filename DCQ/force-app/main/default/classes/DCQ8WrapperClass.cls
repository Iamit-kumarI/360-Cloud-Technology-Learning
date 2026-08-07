public class DCQ8WrapperClass implements Comparable{
	
    @AuraEnabled
    @InvocableVariable
    public Id recordId;
    @AuraEnabled
    @InvocableVariable
    public String recordType;
    @AuraEnabled
    @InvocableVariable
    public String label;
    @AuraEnabled
    @InvocableVariable
    public Integer rank;
    
    public Integer compareTo(Object obj){
        DCQ8WrapperClass com=(DCQ8WrapperClass)obj;
        return rank-com.rank;
    }
}