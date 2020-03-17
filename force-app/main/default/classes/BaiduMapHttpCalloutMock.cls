@isTest
global class BaiduMapHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('"formatted_address":ABCDFFEFFSFHKDSHFJKSDSFKHDJ:"business"DSJKHFS');
        response.setStatusCode(200);
        return response; 
    }
}