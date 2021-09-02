import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler 
{
  String baseurl = "ultrapay.herokuapp.com";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future get(String url1) async {
   Uri url = formater(url1);
  String token = (await storage.read(key: "token"))!;
    //user/register
    var response = await http.get(url,
    headers: {"Authorization": "Bearer $token"}
    );

  //   if(response.statusCode == 200|| response.statusCode ==201)
  //  {
  //    log.i(response.body);
  //    return json.decode(response.body);
  //  }
//
    log.i(response.body);
    log.i(response.statusCode);
     return response;
  }

  Future <http.Response> post(String url1, Map<String, String> body) async {
   Uri url =formater(url1);
   String token = (await storage.read(key: "token"))!;

    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json"
        },
      body: json.encode(body)
      );

   return response;
  }

   Future <http.Response> postWithoutToken(String url1, Map<String, String> body) async {
   Uri url =formater(url1);
   //String token = (await storage.read(key: "token"))!;

    var response = await http.post(
      url,
      headers: {
      //  "Authorization": "Bearer $token",
        "Content-type": "application/json"
        },
      body: json.encode(body)
      );

   return response;
  }

  Uri formater (String url){
    return Uri.https(baseurl,url);
  }
}