import 'dart:convert';

import 'package:apiproject/networkHandler.dart';

int ? solde;
int ? montantTotalRecharge;

NetworkHandler networkHandler = NetworkHandler();
void init ()async {

     solde = await getSolde();
     montantTotalRecharge = await montantTotalRecharger();
}

 getSolde() async{ 
     var recupSolde =  await networkHandler.get("/user/solde");
     Map<String, dynamic> output = json.decode(recupSolde.body);

     if(recupSolde.statusCode == 200 || recupSolde.statusCode == 201){
       print(output['solde']);
       return  output['solde'];
     }
    

   return  "0";
  }

montantTotalRecharger() async{ 
     var recupMTR =  await networkHandler.get("/user/montantrecharge");
     Map<String, dynamic> output = json.decode(recupMTR.body);

     if(recupMTR.statusCode == 200 || recupMTR.statusCode == 201){
       print(output['result']);
     
        return  output['result'];
     }
  
   return 0;
  }