import 'package:apiproject/UserPage/controllers/renversController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class AskRenvers extends StatefulWidget {
  
  @override
  _AskRenversState createState() => _AskRenversState();
}

class _AskRenversState extends State<AskRenvers> {
  TextEditingController _numberController = TextEditingController();
    TextEditingController _montantController = TextEditingController();
      final _globalKey = GlobalKey<FormState>();
        String ? rvsm;
        @override
      void dispose() {
    // Clean up the controller when the widget is disposed.
  _montantController.dispose(); 
   _numberController.dispose();
    super.dispose();
  }
    @override
void initState(){
  init ();
  initRenversement();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    //final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Solde: $solde f",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if(!Responsive.isMobile(context))
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: recharge,
              icon: Icon(Icons.add),
              label: Text("Demander un renversement"),
            ),
          ],
        ),
        if(Responsive.isMobile(context))
        Align(
          alignment: Alignment.centerRight,
            child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child:       
                 ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: recharge,
                  icon: Icon(Icons.add),
                  label: Text("Demander un renversement"),
                ),
              
            ),
          ),
      ],
    );
    
  }
  Future <Null> recharge() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title:new Text("Effectuer renversement", textScaleFactor: 1, style: TextStyle(color: Colors.black),),
          content:   Container(
            width: 110,
            height: 150,
               margin: EdgeInsets.only(top: 20),
               child: Form(
                 key: _globalKey,
                 child: SingleChildScrollView(
                   child:
                     Column(
              
                         children: [
                           buildTextField( "No Téléphone", false, true,_numberController),
                           
                           buildTextField( "Montant", false, false,_montantController),
                         
                            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              ],
          ),
                 ),
               ),
               ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget> [
            new FlatButton(
                 onPressed: (){
                   Navigator.pop(context);
                 },
                 child: new Text(
                   "Annuler",
                    style: new TextStyle(color: Colors.red)
                    ),
               ),
                  new FlatButton(
                 onPressed: () async {

                   if(_globalKey.currentState!.validate()){
                    Map<String,String> data = {
                          "noTel": _numberController.text,
                          "montant": _montantController.text,
                          };  

                       rvsm = await RenversementController(data).init();
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(rvsm!)));

                   Navigator.pop(context);
                 }
                 },
                 child: new Text(
                   "Continuer",
                    style: new TextStyle(color: Colors.green)
                    ),
               )
          ],
        );
      }
    );
  }

  Widget buildTextField( String hintText, bool text, bool phone, TextEditingController _edit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: _edit,
        style: TextStyle(color: Colors.black),
        keyboardType: text ? TextInputType.text : TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
          validator: (value) {
            if(phone){
              if(value!.isEmpty)
                return "Entrer le numéro de téléphone";
            }
            else{
             if(value!.isEmpty)
                return "Entrer le montant"; 
            }
          }
      ),
    );
  }
}

