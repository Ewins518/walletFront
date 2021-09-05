import 'dart:async';
import 'dart:convert';

import 'package:apiproject/networkHandler.dart';
import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flash/flash.dart';
import 'UserPage/constants.dart';
import 'UserPage/controllers/MenuController.dart';
import 'UserPage/screens/main/main_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registrationEmailController = TextEditingController();
  final registrationPasswordController = TextEditingController();
  final registrationUserController = TextEditingController();
  bool isSignupScreen = true;
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  final Completer completer = new Completer();
 
  
  bool isRememberMe = false;
  bool validate = false;
  bool circular = false;
  String errorText = "" ;

@override
void dispose() {
    // Clean up the controller when the widget is disposed.
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registrationEmailController.dispose();
    registrationPasswordController.dispose();
    registrationUserController.dispose();
     //_route?.removeScopedWillPopCallback(_onWillPop);
     //_route = null;
    super.dispose();
  }


//void changedExternalState() {
//  super.changedExternalState();
//  _modalBarrier.markNeedsBuild();
//  if (_scopeKey.currentState != null)
//    _scopeKey.currentState!._forceRebuildPage();
//}
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

    
    return Scaffold(
      backgroundColor: bgColor.withOpacity(.95),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: bgColor.withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Bienvenue sur ",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "UltraPay",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Inscrivez-vous pour continuer"
                          : "Veuillez vous connecter",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? size.height * .25 : size.height * .27,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? size.height * .47 : size.height * .47,
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * .90,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 50),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "CONNEXION",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "INSCRIPTION",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
           Positioned(
            top: MediaQuery.of(context).size.height - 90,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? "Ou s'inscrire avec " : "Ou se connecter avec",
                 style: TextStyle(
                       fontSize: 13,
                       fontWeight: FontWeight.bold,
                       color: Colors.white)
                     ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTextButton(MaterialCommunityIcons.facebook,
                          "Facebook", Palette.facebookColor),
                      buildTextButton(MaterialCommunityIcons.google_plus,
                          "Google", Palette.googleColor),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
         key: _globalKey,
        child: Column(
          children: [
            buildTextField(Icons.mail_outline, "info@demouri.com", false, true, false, loginEmailController),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "**********", true, false, false, loginPasswordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMe,
                      activeColor: Colors.black,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      },
                    ),
                    Text("Remember me",
                        style: TextStyle(fontSize: 12, color: Palette.textColor1))
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: _globalKey,
        child: Column(
          children: [
            buildTextField(MaterialCommunityIcons.account_outline, "Nom et prénom",
                false, false, true, registrationUserController),
            buildTextField(
                MaterialCommunityIcons.email_outline, "email", false, true, false, registrationEmailController),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "password", true, false, false, registrationPasswordController),
            
          ],
        ),
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 420 : 425,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? InkWell(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFCC80), Color(0xFFEF5350)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),

                  onTap: () async {

                    if (!isSignupScreen) {
                      if(_globalKey.currentState!.validate()){
                     ArsProgressDialog progressDialog = ArsProgressDialog(
                  	context,
                  	blur: 2,
                  	backgroundColor: Color(0x33000000),
                  	animationDuration: Duration(milliseconds: 500));
                     
                     progressDialog.show();
                        
                       Map<String,String> data = {
                          "email": loginEmailController.text.trim(),
                          "password": loginPasswordController.text.trim(),
                          }; 
                            
                          var response =  await networkHandler.postWithoutToken("/user/login",data);
                          
                          if(response.statusCode == 200 || response.statusCode == 201){
                            Map<String, dynamic> output = json.decode(response.body);
                            print(output['token']);
                            await storage.write(key: "token", value: output['token']);

                             setState(() {
                              validate = true;
                              circular = false;
                              progressDialog.dismiss();
                            });
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                      builder: (context) =>
                        MultiProvider(
                      providers: [
                       ChangeNotifierProvider(
                         create: (context) => MenuController(),
                       ),
                     ],
                  child: MainScreen(),
                 ),
                ),
                 (route) => false
                 );
                    } else if (response.statusCode == 401) {

                       setState(() {
                              Map<String, dynamic> output = json.decode(response.body);
                              validate = false;
                              print(output['error']);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(output['error'])));
                               errorText = output['error'];
                              circular = false;
                            }); 
                     }
                    else{
                            setState(() {
                              String output = json.decode(response.body);
                              validate = false;
                              errorText = output;
                              circular = false;
                            });
                          }
                  } 
                }
                  else {
                    
                 if(_globalKey.currentState!.validate()){

                ArsProgressDialog progressDialog = ArsProgressDialog(
                	context,
                	blur: 2,
                	backgroundColor: Color(0x33000000),
                	animationDuration: Duration(milliseconds: 500));
                  
                  progressDialog.show();

                      Map<String,String> data = {
                          "name": registrationUserController.text.trim(),
                          "email": registrationEmailController.text.trim(),
                          "password": registrationPasswordController.text.trim(),
                          };   
                          print(data);
                          var responseRegister =  await networkHandler.post("/user/register",data);
                         //login logic add here
                        if(responseRegister.statusCode == 200 || responseRegister.statusCode == 201){
                           
                           Map<String,String> data1 = {
                          "email": registrationEmailController.text.trim(),
                          "password": registrationPasswordController.text.trim(),
                          }; 
                        
                        var response = await networkHandler.postWithoutToken("/user/login",data1);

                        if(response.statusCode == 200 || response.statusCode == 201){
                                    
                            Map<String, dynamic> output = json.decode(response.body);
                            print(output['token']);
                            await storage.write(key: "token", value: output['token']);
                            setState(() {
                              validate = true;
                              circular = false;
                              progressDialog.dismiss();
                            });

                                   Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                  MultiProvider(
                                  providers: [
                                   ChangeNotifierProvider(
                                     create: (context) => MenuController(),
                                   ),
                            ],
                          child: MainScreen(),
                       ),
                      ),
                      );
                     }
                     else if (response.statusCode == 403) {

                       setState(() {
                              Map<String, dynamic> output = json.decode(response.body);
                              validate = false;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(output['error'])));
                               errorText = output['error'];
                              circular = false;
                            }); 
                     }
                      else
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network Error")));
                          
                   }
                 }
                }
              },
              )
                
              : Center(),
        ),
      ),
    );
  }

  Widget buildTextField( IconData icon, String hintText, bool isPassword,
   bool isEmail, bool isName, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        style: TextStyle(color: Colors.black),
       keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
       validator: (value){
         if(isName){
           if(value!.isEmpty)
              return "Le nom d'utilisateur ne peut être vide";

            else if(value.split(' ').length < 2)
              return   "Nom et prénom svp";

            return null;
         }else {
           if(isEmail){
             if(value!.isEmpty)
            return "Email can't be empty";

          if(!value.contains("@"))
            return "Email is invalide";

          return null;
           }
           else {
             if(value!.isEmpty)
            return "Password can't be empty";
          
          if(value.length < 7)
            return "Password lenght must >= 7";
          return null;
           }
         }
       },
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
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
