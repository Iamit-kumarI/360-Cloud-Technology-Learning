trigger LeadEmailCheck on Lead (before insert,before update) {
    Set<String>emailSet=new Set<String>();
    for(Lead cur:Trigger.new){
        if(cur.Email!=null)emailSet.add(cur.Email);
    }
    List<Lead>leadlistWithEmail=[Select Id,Email from Lead where Email in:emailSet];
    
    Set<String>existingEmail=new Set<String>();
    for(Lead cur:leadlistWithEmail){
        existingEmail.add(cur.Email);
    }  
    for(Lead cur:Trigger.new){
        if(cur.Email!=null&&existingEmail.contains(cur.Email)){
            cur.addError('A Lead with this email already exists');
        }
    }
}