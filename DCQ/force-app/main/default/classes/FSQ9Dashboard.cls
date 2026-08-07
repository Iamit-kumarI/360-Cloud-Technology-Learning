public class FSQ9Dashboard implements Schedulable{
    public void execute(SchedulableContext sc){
        List<AggregateResult>agResult=[Select Count(Id)totalCase,Priority From Case Where IsClosed=false Group By Priority];
        String body='Weekly open case summary';
        for(AggregateResult ar:agResult){
            body+='Priority'+ar.get('Priority')+' | Open Cases '+ar.get('totalCase');
        }
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{'amitkumar15351@gmail.com','amitkumaramitkumar15351@gmail.com'});
        mail.setSubject('Weekly Open case');
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}