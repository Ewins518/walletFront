import 'package:apiproject/UserPage/controllers/FieldController.dart';
import 'package:apiproject/UserPage/controllers/TransController.dart';
import 'package:apiproject/UserPage/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class AddLink extends StatefulWidget {
  
  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _numberController1 = TextEditingController();
   TextEditingController _montantController = TextEditingController();
   Map<String, String> data = {};
  TransController ? trans ;
  @override
  Widget build(BuildContext context) {
    //final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Solde: $solde",
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
              label: Text("Générer un lien de paiement"),
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
                   label: Text("Générer un lien de paiement"),
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
          title:new Text("Générer un lien", textScaleFactor: 1, style: TextStyle(color: Colors.black),),
          content:   Container(
            width: 110,
            height: 180,
               margin: EdgeInsets.only(top: 20),
               child: SingleChildScrollView(
                 child:
                   Column(
              
                       children: [
                         buildTextField( "Description", true, _numberController),
                         
                         buildTextField( "Montant", false, _montantController),
                       
                          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              ],
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
                 onPressed: (){

                    Map<String,String> data = {
                          "desc": _numberController.text,
                          "montant": _montantController.text,
                          };  
                    setState((){
                    recu = false;
                    solde -= int.parse(_montantController.text); 
                    trans = TransController(data);
                    trans!.refresh();
                    _numberController.clear();
                    _montantController.clear();
                     Navigator.pop(context);
                    });
                       //   print(data);
                  
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

  Widget buildTextField( String hintText, bool text, TextEditingController _edit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
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
      ),
    );
  }
}

