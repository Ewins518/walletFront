import 'package:apiproject/login_signup.dart';
import 'package:apiproject/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'UserPage/constants.dart';
import 'delayed_animation.dart';
import 'package:apiproject/social_page.dart';

class WellcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:bgColor.withOpacity(.95),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1000,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    "BIENVENUE sur transfert d'argent rapide!!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  child: Image.asset('images/img.jpeg'),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  height: 300,
                  child: Image.asset('images/WhatsApp.jpeg'),
                ),
              ),
              DelayedAnimation(
                delay: 3500,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: Text(
                    "Une solution rapide simple et fiable pour transferer de l'argent depuis n'importe où",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                   
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 4500,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[700],
                      shape: StadiumBorder(),
                      padding: EdgeInsets.all(13),
                    ),
                    child: Text('Commencer'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSignupScreen (),
                        )
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
