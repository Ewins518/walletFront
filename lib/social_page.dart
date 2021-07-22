import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'delayed_animation.dart';
import 'package:apiproject/main.dart';
import 'package:apiproject/login_page.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        //leading: IconButton(
        //  icon: Icon(
        //    Icons.arrow_back,
        //    color: Colors.black,
        //    size: 30,
        //  ),
         // onPressed: () {
         //   Navigator.pop(context);
         // },
       // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DelayedAnimation(
              delay: 1000,
              child: Container(
                height: 200,
                child: Image.asset('images/WhatsApp.jpeg'),
              ),
            ),
            DelayedAnimation(
              delay: 1000,
              child: Container(
                  height: 200,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Connexion",
                          style: GoogleFonts.poppins(
                            color: d_red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Inscrivez-vous pour valider votre compte",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            DelayedAnimation(
              delay: 1300,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 48,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: d_red,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline_outlined),
                          SizedBox(width: 10),
                          Text('EMAIL')
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF576dff),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.facebook),
                          SizedBox(width: 10),
                          Text(
                            'FACEBOOK',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/google.png',
                            height: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'GOOGLE',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
