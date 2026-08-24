@IsTest
global class AnimalLocatorMockFail implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {

        HttpResponse res = new HttpResponse();
        res.setStatusCode(500);

        return res;
    }
}