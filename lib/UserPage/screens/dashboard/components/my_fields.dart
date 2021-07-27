import 'package:apiproject/UserPage/controllers/FieldController.dart';
import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:apiproject/UserPage/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class MyRef extends StatefulWidget {
  
  @override
  _MyRefState createState() => _MyRefState();
}

class _MyRefState extends State<MyRef> {
  bool isRechargeScreen = false;
  bool confirmer = false;
  TextEditingController _numberController = TextEditingController();
  TextEditingController _montantController = TextEditingController();
  Map<String, String> data = {};
  RechargeController ? rcg ;
    
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ref: ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
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
              label: Text("Récharger"),
            ),
          ],
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
          title:new Text("Récharger compte", textScaleFactor: 1, style: TextStyle(color: Colors.black),),
          content:   Container(
            width: 100,
            height: 120,
               margin: EdgeInsets.only(top: 20),
               child: Column(
                   children: [
                     buildTextField( "Number", _numberController ),
                     
                     buildTextField( "Montant", _montantController),
                   
                      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              ],
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
                   
                  data = {
                          "noTel": _numberController.text,
                          "montant": _montantController.text,
                          };  
                       
                   setState((){
                      solde += int.parse(_montantController.text); 
                      RechargeController.montantTotalRecharger  += int.parse(_montantController.text) ;
                       rcg = RechargeController(data);
                       rcg!.refresh();
                      _montantController.clear(); 
                      _numberController.clear();
                       Navigator.pop(context);    
                   });   
           
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

  Widget buildTextField( String hintText, TextEditingController _edit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
       autofocus: true ,
       controller: _edit,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.number,
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

