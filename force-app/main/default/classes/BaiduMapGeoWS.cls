public class BaiduMapGeoWS{
   public static String GetAddress(Decimal lat,Decimal lon){
       String baiduKey = 'DitSVBX4vNDmCWruC1smGXaSLabLPV2q';
       String latlon = String.valueOf(lat) + ',' + String.valueOf(lon);
       String url = 'https://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=' + latlon + '&output=json&pois=1&ak=' + baiduKey;
       
       Http http = new Http();
       HttpRequest request = new HttpRequest();
       request.setEndpoint(url);
       request.setMethod('POST');
       request.setHeader('Content-Type', 'application/json;charset=UTF-8');
       request.setBody('{"name":"mighty moose"}');
       
       HTTPResponse res = http.send(request);
       String str = String.valueOf(res.getBody());
       str = str.subString(str.indexOf('"formatted_address":') + 21 ,str.indexOf('"business"')-2);
       
       return str;
   }
}