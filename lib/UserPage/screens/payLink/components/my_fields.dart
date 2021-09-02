import 'package:apiproject/UserPage/controllers/linkController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/responsive.dart';
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
                   if(_globalKey.currentState!.validate()){
                    Map<String,String> data = {
                          "desc": _descController.text,
                          "montant": _montantController.text,
                          };  
                    setState(() async {
                    
                    result = await LinkController(data).init();
                    Clipboard.setData(new ClipboardData (text: result));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Le lien est copié dans le presse papier")));
                    // String username = 'ewinsouromeo@gmail.com';
                    // String password = "Ewin's@518";

                    //  email1 = await getEmail();
                    //  SmtpServer ? smtpServer;
                    //  try {
                    //   final googleSignIn = GoogleSignIn.standard(scopes: [
                    //        'ewinsouromeo@gmail.com',
                    //        'https://www.googleapis.com/auth/gmail.send'
                    //      ]);
                    //    
                    //      // Signing in
                    //      final account = await googleSignIn.signIn();
                    //    
                    //      if (account == null) {
                    //        // User didn't authorize
                    //        return;
                    //      }
                    //    
                    //      final auth = await account.authentication;
                    //    
                    //      // Creating SMTP server from the access token
                    //      smtpServer = gmailXoauth2(auth.accessToken!);
                    //      print(smtpServer);
                   //// smtpServer = gmail(username, password);
                    //   final message = Message()
                    //   ..from = Address(username, 'Ultrapay')
                    //   ..recipients.add(email1) 
                    //   ..subject = 'Un lien de paiement' 
                    //   ..text = "Un nouveau de paiment vous a été envoyé. Copier et envoyer le à vos clients pour qu'ils puissent vous payer \n $result"; //body of the email
 //
                    //    try {
                    //       final sendReport = await send(message, smtpServer);
                    //       print('Message sent: ' + sendReport.toString());
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Un lien de paiement a été envoyer sur votre compte mail")));
//
                    //     } on MailerException catch (e) {
                    //       print('Message not sent. \n'+ e.toString()); //print if the email is not sent
                    //      
                    //     }
//
                    //   
                    // 
                    //  }on PlatformException catch (e) {
                    //       
                    //       print(e);
                    //  }

                      
                   // final Email email = Email(
                   //   body: "Un nouveau lien de paiement vous a été envoyé. $result",
                   //   subject: "Lien de paiment",
                   //   recipients: [email1!],
                   //   isHTML: false,
            // );

                  // await FlutterEmailSender.send(email);

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

