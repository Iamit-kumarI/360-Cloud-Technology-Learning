@RestResource(urlMapping='/contact/*')
global class ContactRestController {

    global class ContactRequest{
        public String name;
        public String phone;
        public String description;
        public String email;
    }
    // _____________________________________________ Post Request Create Contact ____________________________________
    @HttpPost
    global static String createContact(){
        RestRequest req=RestContext.request;
        ContactRequest data=(ContactRequest)JSON.deserialize(req.requestBody.toString(),ContactRequest.class);
        Contact curContact=new Contact(LastName=data.name,Phone=data.phone,Description=data.description,Email=data.email);
        insert curContact;
        return 'Contact Created With Id : '+curContact.Id;
    }
}