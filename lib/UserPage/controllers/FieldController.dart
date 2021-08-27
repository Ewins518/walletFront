import 'dart:convert';

import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/networkHandler.dart';

class RechargeController {
static  int _solde = 0;
int ? _montant;
String ? _noTel;
String _nature = "Réchargé";
NetworkHandler networkHandler = NetworkHandler();
RechargeController(Map map){

    this._montant = int.parse(map["montant"]);
    this._noTel = map["phone"];

  }

  Future<String> init() async {
  var map = new Map<String, String>();
   //control here
   
     
    map["phone"] = _noTel!;
    map["montant"] = _montant.toString();
      
    var responseRecharge =  await networkHandler.post("/compte/recharge",map);
     //recharge logic add here
     Map<String, dynamic> output = json.decode(responseRecharge.body);

    if(responseRecharge.statusCode == 200 || responseRecharge.statusCode == 201){
        
        return output['message'];
    }

    return output['err'];
 
  }
  

  void debiterCompte(){
    RechargeController._solde = _montant!;
  }

}
