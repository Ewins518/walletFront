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
      
    var responseRecharge =  await networkHandler.post("/user/recharge",map);
     //recharge logic add here
     Map<String, dynamic> output = json.decode(responseRecharge.body);

    if(responseRecharge.statusCode == 200 || responseRecharge.statusCode == 201){
        
        return output['message'];
    }

    return output['err'];
 
  }

 void refresh(){
    demoRecentOpr.add(RecentOpr(
      noCompte: _noTel,
      date: DateTime.now(),
      montant: _montant,
      nature: _nature ));
  }
  

  void debiterCompte(){
    RechargeController._solde = _montant!;
  }

}

//NetworkHandler networkHandler = NetworkHandler();

//
// getSolde() async{ 
//     var recupSolde =  await networkHandler.get("/user/solde");
//     Map<String, dynamic> output = json.decode(recupSolde.body);
//
//     if(recupSolde.statusCode == 200 || recupSolde.statusCode == 201){
//       print(output['solde']);
//       return  output['solde'];
//     }
//    
//
//   return  "0";
//  }
//
//montantTotalRecharger() async{ 
//     var recupMTR =  await networkHandler.get("/user/montantrecharge");
//     Map<String, dynamic> output = json.decode(recupMTR.body);
//
//     if(recupMTR.statusCode == 200 || recupMTR.statusCode == 201){
//       print(output['result']);
//      RechargeController._solde = output['result'];
//        return  output['result'];
//     }
//  
//   return 0;
//  }
//  
//
// //Future<int> get solde async => await getSolde();
//  ///int.parse(getSolde().toString()) ;
 //Future<int> get montantTotalRecharge async =>await montantTotalRecharger();
