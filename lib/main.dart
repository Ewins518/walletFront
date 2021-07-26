import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apiproject/welcome_page.dart';
import 'package:apiproject/social_page.dart';

import 'UserPage/constants.dart';

const d_red = const Color(0xFFE9717D);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  _MyAppState createState() => _MyAppState();
  }
  
  class _MyAppState extends State<MyApp>{
    Widget page = WellcomePage();

    void initState() {
      super.initState();
      print("Inside initState");
      affiche();
    }

    
   void affiche  () async {
       bool visitingFlag = await getVisitingFlag();
      setVisitingFlag();
      if(visitingFlag == true){
        //it is the case when the user is visiting for not first
        setState (() {
        page = SocialPage();
        });
        print("Inside affiche: true");
      }else {
        //it is the case the user is visiting for first time
        setState (() {
       page = WellcomePage();
        });
       print("Inside affiche: false");
      }

     }

     Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Transfert Rapid',
          debugShowCheckedModeBanner: false, 
          theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
          home: page,
        );
      } 

}


setVisitingFlag () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("alreadyVisited", true);
}

getVisitingFlag () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
  print("Inside getVisiting");
  return alreadyVisited;
}