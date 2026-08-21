public class GetItType {
    public static String idBelongsto(String Ids){
        Long currentTimeInMilliSecond = Datetime.now().getTime();
        //System.debug('Hi i am method'+Ids.getSObjectType().getdescribe().getName);
        ///if(Ids.length()!=18)return 'Invalid Id';
        Map<String,String>objectMapping=new Map<String,String>();
        fillMap(objectMapping);
        System.debug(Datetime.now().getTime()-currentTimeInMilliSecond);
        return objectMapping.get(Ids.substring(2,3));
    }
    public static void fillMap(Map<String,String>mapParam){
        mapParam.put('0','Cases');
        mapParam.put('1','Account');
        mapParam.put('3','Contact');
        mapParam.put('6','Opportunity');
        mapParam.put('Q','Lead');
		mapParam.put('T','Task');     
        mapParam.put('5','People');
        mapParam.put('O','Reports');
        mapParam.put('9','Group');
    }
}