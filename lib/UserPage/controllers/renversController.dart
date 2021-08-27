import 'dart:convert';

import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/networkHandler.dart';

class RenversementController {
static  int _solde = 0;
int ? _montant;
String ? _noTel;
String _nature = "Réchargé";
NetworkHandler networkHandler = NetworkHandler();
RenversementController(Map map){

    this._montant = int.parse(map["montant"]);
    this._noTel = map["phone"];

  }

  Future<String> init() async {
  var map = new Map<String, String>();
   //control here
   
     
    map["tel"] = _noTel!;
    map["montant"] = _montant.toString();
      print(map);
    var responseRenversement =  await networkHandler.post("/compte/renverser",map);
     //Renversement logic add here
     Map<String, dynamic> output = json.decode(responseRenversement.body);

    if(responseRenversement.statusCode == 200 || responseRenversement.statusCode == 201){
        
        return output['msg'];
    }

    else  if(responseRenversement.statusCode == 400 || responseRenversement.statusCode == 404 )
    return output['msg'];

        return output['error'];
 
  }
  

  void debiterCompte(){
    RenversementController._solde = _montant!;
  }

}
