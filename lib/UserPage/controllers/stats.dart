import 'dart:convert';

import 'package:apiproject/networkHandler.dart';

int ? solde;
int ? montantTotalRecharge;
List clients = [];

NetworkHandler networkHandler = NetworkHandler();
void init ()async {

     solde = await getSolde();
     montantTotalRecharge = await montantTotalRecharger();
     clients = await getClient();
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

getClient() async{ 
     var recupClient =  await networkHandler.get("/user/getlinkusers");
     Map<String, dynamic> output = json.decode(recupClient.body);

     if(recupClient.statusCode == 200 || recupClient.statusCode == 201){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getSendTransaction() async{ 
     var recupST =  await networkHandler.get("/user/getsendtransaction");

     Map<String, dynamic> output = json.decode(recupST.body);

     if(recupST.statusCode == 200 || recupST.statusCode == 201 || recupST.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getRcvTransaction() async{ 
     var recupRT =  await networkHandler.get("/user/getreceivetransaction");

     Map<String, dynamic> output = json.decode(recupRT.body);

     if(recupRT.statusCode == 200 || recupRT.statusCode == 201 || recupRT.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }