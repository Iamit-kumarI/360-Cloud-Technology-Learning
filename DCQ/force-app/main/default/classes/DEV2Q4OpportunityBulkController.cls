public class DEV2Q4OpportunityBulkController {

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpenOpportunity(){
        return [SELECT Id, Name, StageName, CloseDate, Amount FROM Opportunity
                WHERE IsClosed = false
                ORDER BY CloseDate ASC
                LIMIT 10];
    }

    @AuraEnabled
    public static void updateOpportunities(List<Id> oppIds, String stageNameParam, Date closeDateParam){
        if (oppIds == null || oppIds.isEmpty()) {
            throw new AuraHandledException('Please select at least one Opportunity');
        }

        List<Opportunity> oppList = [SELECT Id, StageName, CloseDate FROM Opportunity WHERE Id IN :oppIds];
        for (Opportunity curOpp : oppList) {
            if (stageNameParam != null) {
                curOpp.StageName = stageNameParam;
            }
            if (closeDateParam != null) {
                curOpp.CloseDate = closeDateParam;
            }
        }

        try {
            update oppList;
        } catch (DmlException e) {
            throw new AuraHandledException('Error updating opportunities: ' + e.getMessage());
        }
    }
}