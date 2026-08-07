public class FSQ6AccountRecordType {
	public static Map<String,Id>recordTypeMap;
    public static Id getRecordTypeId(String developerName){
        if(recordTypeMap==null){
            recordTypeMap=new Map<String,Id>();
            Map<String,Schema.RecordTypeInfo> rtInfo=Account.SObjectType.getDescribe().getRecordTypeInfosByDeveloperName();
            for(String name:rtInfo.keySet()){
                recordTypeMap.put(name,rtInfo.get(name).getRecordTypeId());
            }
        }
        return recordTypeMap.get(developerName);
    }
}