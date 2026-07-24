public with sharing class AddErrorToOpportunity {
    public static void AddErrorToOpportunity(Opportunity cur) {
        cur.addError('Cannot delete highvalue opportunities');
    }
}