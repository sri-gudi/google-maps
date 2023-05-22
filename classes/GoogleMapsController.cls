public class GoogleMapsController {
    
    @auraEnabled
    public static String getDistance (String originAddress, String destinationAddress, String travelMode){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        originAddress = EncodingUtil.urlEncode(originAddress,'UTF-8');
        destinationAddress = EncodingUtil.urlEncode(destinationAddress,'UTF-8');
        String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
            + '?origins=' + originAddress
            + '&destinations=' + destinationAddress
            + '&units=imperial'
            + '&mode=' + travelMode
            + '&key=AIzaSyAtz0BoncTGOjWoEeVdmy0EI6eLHKJYc3E';
        
        req.setEndPoint(url);
        HttpResponse res = h.send(req);
        system.debug(res.getBody());
        DistanceWrapper obj = DistanceWrapper.parse(res.getBody());
        DistanceWrapper.Rows row = (DistanceWrapper.Rows)obj.rows.get(0);
        DistanceWrapper.Elements elem = (DistanceWrapper.Elements)row.elements.get(0);
        DistanceWrapper.Distance dist = (DistanceWrapper.Distance)elem.distance;
        DistanceWrapper.Distance duration = (DistanceWrapper.Distance)elem.duration;
        String distanceInMiles = dist.text;
        String travelDuration = duration.text;
        TravelModeRates__mdt mc = TravelModeRates__mdt.getInstance(travelMode);
        Decimal costOfTravel = mc.Travel_Cost_Per_Mile__c * Decimal.valueOf(distanceInMiles.replaceAll('[^0-9.]', ''));
        String returnString = '<b> Distance in Miles <b>:' + distanceInMiles + 
            '<br>' + '<b> Travel Duration <b>:' + travelDuration + 
        	'<br>' + '<b> Cost of Travel <b>:$' + costOfTravel.setScale(2, RoundingMode.HALF_UP);
        return returnString;
    }
}