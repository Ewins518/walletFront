import 'dart:convert';

import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/networkHandler.dart';

class AddMomoController {
static  int _solde = 0;
int ? _montant;
String ? _noTel;
String _nature = "Réchargé";
NetworkHandler networkHandler = NetworkHandler();

AddMomoController(Map map){

    this._noTel = map["phone"];

  }

  Future<String> init() async {
  var map = new Map<String, String>();
   //control here
   
     
    map["tel"] = _noTel!;
 
    var responseAddMomo =  await networkHandler.post("/user/addcompte",map);
     //AddMomo logic add here
     Map<String, dynamic> output = json.decode(responseAddMomo.body);

    if(responseAddMomo.statusCode == 200 || responseAddMomo.statusCode == 201){
        
        return output['msg'];
    }
        return output['error'];
 
  }

 void refresh(){
    demoRecentOpr.add(RecentOpr(
      noCompte: _noTel,
      date: DateTime.now(),
      montant: _montant,
      nature: _nature ));
  }
  

  void debiterCompte(){
    AddMomoController._solde = _montant!;
  }

}
