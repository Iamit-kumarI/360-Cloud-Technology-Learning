trigger AQ3 on Case (after insert,after update,after delete){
    List<AggregateResult>aggrigateCaseList=[Select Count(Id) openCount,AccountId from Case where IsClosed=false];
    
}