import 'dart:convert';

import 'package:apiproject/networkHandler.dart';

int ? solde;
int ? montantTotalRecharge;
List clients = [];
List transaction = [];
List transact = [];
List<List> renversement = [];
List recharge = [];
List momo = [];
bool mTR = false;
List renvers = [];

NetworkHandler networkHandler = NetworkHandler();
void init ()async {

   solde = await getSolde();
   montantTotalRecharge = await montantTotalRecharger();
}

void initRenversement() async {
   renversement = await getRenversement();
   renvers = convert(renversement);

}

void initTransaction() async {
   transact = await getSendTransaction() ;
   transaction = await getRcvTransaction() ; 
   transaction = transaction + transact;
}

void initClient() async {
   clients = await getClient();
}

void initRecharge() async {
   recharge = await getRecharge();
}

void initMomo() async {
   momo = await getMomoAccount();
}

 getSolde() async{ 
     var recupSolde =  await networkHandler.get("/compte/solde");
     Map<String, dynamic> output = json.decode(recupSolde.body);

     if(recupSolde.statusCode == 200 || recupSolde.statusCode == 201){
       print(output['solde']);
       return  output['solde'];
     }
    

   return  "0";
  }

montantTotalRecharger() async{ 
     var recupMTR =  await networkHandler.get("/compte/montantrecharge");
     Map<String, dynamic> output = json.decode(recupMTR.body);

     if(recupMTR.statusCode == 200 || recupMTR.statusCode == 201){
       print(output['result']);
      if(output['result'] != null)
        mTR = true;

      return  output['result'];
     }
  
   return 0;
  }

getClient() async{ 
     var recupClient =  await networkHandler.get("/link/get/linkusers");
     Map<String, dynamic> output = json.decode(recupClient.body);

     if(recupClient.statusCode == 200 || recupClient.statusCode == 201){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getSendTransaction() async{ 
     var recupST =  await networkHandler.get("/compte/getsendtransaction");

     Map<String, dynamic> output = json.decode(recupST.body);

     if(recupST.statusCode == 200 || recupST.statusCode == 201 || recupST.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getRcvTransaction() async{ 
     var recupRT =  await networkHandler.get("/compte/getreceivetransaction");

     Map<String, dynamic> output = json.decode(recupRT.body);

     if(recupRT.statusCode == 200 || recupRT.statusCode == 201 || recupRT.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getRenversement() async{ 
     var recupR =  await networkHandler.get("/compte/getrenversement");

     Map<String, dynamic> output = json.decode(recupR.body);

     if(recupR.statusCode == 200 || recupR.statusCode == 201){
       print(output['Renversement']);
     
        return  output['Renversement'];
     }
  
   return 0;
  }

  getRecharge() async{ 
     var recupR =  await networkHandler.get("/compte/getrecharge");

     Map<String, dynamic> output = json.decode(recupR.body);

     if(recupR.statusCode == 200 || recupR.statusCode == 201 || recupR.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  getMomoAccount() async{ 
     var recupR =  await networkHandler.get("/compte/getallmomo");

     Map<String, dynamic> output = json.decode(recupR.body);

     if(recupR.statusCode == 200 || recupR.statusCode == 201 || recupR.statusCode == 403){
       print(output['allData']);
     
        return  output['allData'];
     }
  
   return 0;
  }

  List convert(List<List> list) {
   List listFinal = [];
   int i = 0, j = 0 ;

   for(i = 0; i < list.length; i++)
     for(j = 0; j < list[i].length; j++)
     listFinal.add(list[i][j]);
     
   return listFinal;
 }