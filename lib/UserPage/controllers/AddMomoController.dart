import 'dart:convert';
import 'package:apiproject/networkHandler.dart';

class AddMomoController {
int ? _montant;
String ? _noTel;
NetworkHandler networkHandler = NetworkHandler();

AddMomoController(Map map){

    this._noTel = map["phone"];

  }

  Future<String> init() async {
  var map = new Map<String, String>();
   //control here
   
     
    map["tel"] = _noTel!;
 
    var responseAddMomo =  await networkHandler.post("/compte/addcompte",map);
     //AddMomo logic add here
     Map<String, dynamic> output = json.decode(responseAddMomo.body);

    if(responseAddMomo.statusCode == 200 || responseAddMomo.statusCode == 201){
        
        return output['msg'];
    }
        return output['error'];
 
  }

}
