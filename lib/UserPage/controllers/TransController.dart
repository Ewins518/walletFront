import 'package:apiproject/UserPage/models/RecentOperation.dart';

class TransController {
static  int _solde = 100, nombreTransaction = 0;
int ? _montant;
String ? _noCompte;
static bool _recu = true;

TransController(dynamic map){

    this._montant = int.parse(map["montant"]);
    this._noCompte = map["noCompte"];

  }

  Map init() {
  var map = new Map<String, dynamic>();
   //control here
   if(numCorrect()){
     setSolde();
   }
    map["noCompte"] = _noCompte;
    map["montant"] = _montant;
   
    return map;
  }

  void refresh(){
    demoTransaction.add(RecentOpr(
      noCompte: _noCompte,
      date: DateTime.now(),
      montant: _montant,
      nature: recu ? "Réçu" : "Envoyé" ));
      
      demoRecentOpr.add(RecentOpr(
      noCompte: _noCompte,
      date: DateTime.now(),
      montant: _montant,
      nature: recu ? "Réçu" : "Envoyé" ));
  }

  bool numCorrect() {
    if(_noCompte!.length == 8)
      return true;
    return false;
  }

  void setSolde(){
    TransController._solde += _montant!; 
  }

  void debiterCompte(){
    TransController._solde -= _montant!;
  }

}
bool recu = TransController._recu;
 int nombreTransaction = TransController.nombreTransaction;
 