@isTest
global class GoogleMapsTestMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String json = '{'+
        '   \"destination_addresses\" : [ \"1 Main St Atlanta GA\" ],'+
        '   \"origin_addresses\" : [ \"1 Main St New York NY\" ],'+
        '   \"rows\" : ['+
        '      {'+
        '         \"elements\" : ['+
        '            {'+
        '               \"distance\" : {'+
        '                  \"text\" : \"225 mi\",'+
        '                  \"value\" : 361993'+
        '               },'+
        '               \"duration\" : {'+
        '                  \"text\" : \"3 hours 52 mins\",'+
        '                  \"value\" : 13943'+
        '               },'+
        '               \"status\" : \"OK\"'+
        '            }'+
        '         ]'+
        '      }'+
        '   ],'+
        '   \"status\" : \"OK\"'+
        '}';
        res.setBody(json);
        res.setStatusCode(200);
        return res;
    }
}