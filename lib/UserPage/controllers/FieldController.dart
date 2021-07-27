import 'package:apiproject/UserPage/models/RecentOperation.dart';

class RechargeController {
static  int _solde = 100, montantTotalRecharger = 0;
int ? _montant;
String ? _noTel;
String _nature = "Réchargé";

RechargeController(dynamic map){

    this._montant = int.parse(map["montant"]);
    this._noTel = map["noTel"];

  }

  Map init() {
  var map = new Map<String, dynamic>();
   //control here
   if(numCorrect()){
     setSolde();
   }
    map["noTel"] = _noTel;
    map["montant"] = _montant;
   
    return map;
  }

 void refresh(){
    demoRecentOpr.add(RecentOpr(
      noCompte: _noTel,
      date: DateTime.now(),
      montant: _montant,
      nature: _nature ));
  }

  bool numCorrect() {
    if(_noTel!.length == 8)
      return true;
    return false;
  }

  void setSolde(){
    RechargeController._solde += _montant!; 
  }

  void debiterCompte(){
    RechargeController._solde -= _montant!;
  }

}

 int solde = RechargeController._solde;
 