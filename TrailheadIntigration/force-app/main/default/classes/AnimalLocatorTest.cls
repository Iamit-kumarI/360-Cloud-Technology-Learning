@IsTest
private class AnimalLocatorTest {

    @IsTest
    static void testGetAnimalNameById() {

        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String result = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();

        System.assertEquals('chicken', result);
    }
}