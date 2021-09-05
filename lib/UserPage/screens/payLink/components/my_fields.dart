import 'package:apiproject/UserPage/controllers/linkController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/responsive.dart';
import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../../constants.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddLink extends StatefulWidget {
  
  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  TextEditingController _descController = TextEditingController();
 final _globalKey = GlobalKey<FormState>();
   TextEditingController _montantController = TextEditingController();
  String ? result;
  LinkController ? link ;
  String ? email1;
  bool linkOk = false;

void dispose() {
    // Clean up the controller when the widget is disposed.
  _montantController.dispose(); 
   _descController.dispose();
    super.dispose();
  }

@override
void initState(){
  init ();
  initClient();
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
               child: Form(
                 key: _globalKey,
                 child: SingleChildScrollView(
                   child:
                     Column(
              
                         children: [
                           buildTextField( "Description", true, true, _descController),
                           
                           buildTextField( "Montant", false, false, _montantController),
                         
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
                 onPressed: (){
                   ArsProgressDialog progressDialog = ArsProgressDialog(
                	context,
                	blur: 2,
                	backgroundColor: Color(0x33000000),
                	animationDuration: Duration(milliseconds: 500));
                  
                  progressDialog.show();
                   if(_globalKey.currentState!.validate()){
                    Map<String,String> data = {
                          "desc": _descController.text,
                          "montant": _montantController.text,
                          };  
                    setState(() async {
                    
                    result = await LinkController(data).init();
                    progressDialog.dismiss();
                    Clipboard.setData(new ClipboardData (text: result));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Le lien est copié dans le presse papier")));
                   

                     Navigator.pop(context);
                    });
                       //   print(data);
                   }
                 },
                 child: new Text(
                   "continuer",
                    style: new TextStyle(color: Colors.green)
                    ),
                    
               )
          ],
        );
      }
    );
  }

  Widget buildTextField( String hintText, bool text, bool description, TextEditingController _edit) {
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
        validator: (value){
         if(description){
           if(value!.isEmpty)
              return "Description can't be empty";

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
}

