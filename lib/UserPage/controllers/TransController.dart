import 'dart:convert';

import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/networkHandler.dart';

class TransController {
static  int _solde = 100, nombreTransaction = 0;
String? _montant;
String ? _noCompte;
static bool _recu = true;
NetworkHandler networkHandler = NetworkHandler();

TransController(Map map){

    this._montant = map["montant"];
    this._noCompte = map["noCompte"];

  }

  Future<String> init() async{
  var map = new Map<String, String>();
  
    map["noCompte"] = _noCompte!;
    map["montant"] = _montant!;

    var responseTransaction =  await networkHandler.post("/user/transaction",map);
     //Transaction logic add here
     Map<String, dynamic> output = json.decode(responseTransaction.body);

    if(responseTransaction.statusCode == 200 || responseTransaction.statusCode == 201){
        
        return output['message'];
    }

    return output['error'];
 
  }

  void refresh(){
    demoTransaction.add(RecentOpr(
      noCompte: _noCompte,
      date: DateTime.now(),
      montant: int.parse(_montant!),
      nature: recu ? "Réçu" : "Envoyé" ));
  }

  bool numCorrect() {
    if(_noCompte!.length == 8)
      return true;
    return false;
  }

}
bool recu = TransController._recu;
 int nombreTransaction = TransController.nombreTransaction;
 