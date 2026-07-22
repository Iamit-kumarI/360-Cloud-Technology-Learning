public with sharing class S1Q3 {
    public void fiveObjects(Integer noOfSubjectstoCreate) {
        List<String>caseSubjects=new List<String>();
        while(noOfSubjectstoCreate-->0){
            caseSubjects.add('I am subject '+noOfSubjectstoCreate+1);   
        }
        System.debug(caseSubjects);
        caseSubjects.add('I am one more request subject');
        System.debug(caseSubjects);
        caseSubjects.remove(0);
        System.debug(caseSubjects);
    }
}