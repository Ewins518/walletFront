class RechargeController {
static  int _solde = 100, montantTotalRecharger = 0;
int ? _montant;
String ? _noTel;

RechargeController(dynamic map){

    this._montant = map["montant"];
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