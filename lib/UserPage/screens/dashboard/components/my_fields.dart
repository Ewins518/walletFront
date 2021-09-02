import 'package:apiproject/UserPage/controllers/FieldController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
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
   final _globalKey = GlobalKey<FormState>();
  String ? rcg ;
  
    
void dispose() {
    // Clean up the controller when the widget is disposed.
  _montantController.dispose(); 
   _numberController.dispose();
    super.dispose();
  }

@override
void initState(){
  //init ();
  initRecharge();
  super.initState();
}
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
               child: Form(
                 key: _globalKey,
                 child: Column(
                     children: [
                       buildTextField( "Number", true,_numberController ),
                       
                       buildTextField( "Montant",false, _montantController),
                     
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
                  if(_globalKey.currentState!.validate()){
                   Map<String,String> data = {
                          "phone": _numberController.text.trim(),
                          "montant": _montantController.text.trim(),
                          
                          };
                       
                   setState(() async{
                  
                       rcg = await RechargeController(data).init();
                       
                       Navigator.pop(context); 
                       dialog("Récharger compte", rcg!);   
                   });  
                    
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



  Widget buildTextField( String hintText, bool phone, TextEditingController _edit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
       autofocus: false ,
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
        validator: (value){
         if(phone){
           if(value!.isEmpty)
              return "Phone Number can't be empty";
            else if(value.length != 8)
              return "Enter a valide number";
          return null;
         }else {
           
             if(value!.isEmpty)
            return "Montant can't be empty";

          return null;
           }
        }
      ),
    );
  }

Future<Null> dialog(String title, String desc) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return new SimpleDialog(
        title: new Text(title, textScaleFactor: 1.4,),
        contentPadding: EdgeInsets.all(25.0),
        children: <Widget>[
          new Text(desc),
          new Container(height: 20.0,),
          new RaisedButton(
            color: Colors.teal,
            textColor: Colors.white,
            child: new Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            }
            
            )
        ],
      );
    }
  ); 
}

}
