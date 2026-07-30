public class Person {
	public String name='Amit';
    public Integer age=23;
    public String email='amitkumar15351tab@gmail.com';
    public String phone='9044095533';
    public String address='Ashok vihar phase II Gurugram';
    public Integer salary=300000;
    public void personInfo(){
		System.debug(name);
        System.debug(age);
        System.debug(email);
        System.debug(phone);
        System.debug(address);
        System.debug(salary);
    }
    public String checkAge(){
        return age<60?'less than 60':'old age';
    }
}