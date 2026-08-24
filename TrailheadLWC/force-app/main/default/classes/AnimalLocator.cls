public class AnimalLocator {

    public static String getAnimalNameById(Integer id) {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        Animal animal = (Animal)JSON.deserialize(res.getBody(), Animal.class);

        return animal.animal.name;
    }

    public class Animal {
        public AnimalDetails animal;
    }

    public class AnimalDetails {
        public Integer id;
        public String name;
        public String eats;
        public String says;
    }
}