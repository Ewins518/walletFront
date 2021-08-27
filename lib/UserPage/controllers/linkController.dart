import 'dart:convert';

import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/networkHandler.dart';


class LinkController {
static  int _solde = 0;
int ? _montant;
String ? _desc;
NetworkHandler networkHandler = NetworkHandler();

LinkController(Map map){

    this._montant = int.parse(map["montant"]);
    this._desc = map["desc"];

  }

  Future<String> init() async {
  var map = new Map<String, String>();
   
    map["desc"] = _desc!;
    map["montant"] = _montant.toString();
      print(map);

    var responseRecharge =  await networkHandler.post("/link/paymentlink",map);
     //recharge logic add here
     Map<String, dynamic> output = json.decode(responseRecharge.body);

    if(responseRecharge.statusCode == 200 || responseRecharge.statusCode == 201){
        
        return output['lien_de_paiment'];
    }

    return output['msg'];
 
  }

}

NetworkHandler networkHandler = NetworkHandler();

getEmail() async{ 
     var recupSolde =  await networkHandler.get("/user/usermail");
     Map<String, dynamic> output = json.decode(recupSolde.body);
    print(output['email']);
   return  output['email'];
  }

