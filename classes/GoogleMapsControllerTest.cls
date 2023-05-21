@isTest
public class GoogleMapsControllerTest {
    @isTest
    static void testGetDistance() {
        Test.setMock(HttpCalloutMock.class, new GoogleMapsTestMock());
        String originAddress = '1 Main St Atlanta GA';
        String destinationAddress = '1 Main St New York NY';
        String travelMode = 'driving';
        String retString = GoogleMapsController.getDistance(originAddress, destinationAddress, travelMode);
        system.assertEquals(retString.contains('225 mi'), true);
    }
	
}