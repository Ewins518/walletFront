import 'dart:async';

import 'package:apiproject/UserPage/controllers/MenuController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/screens/dashboard/dashboard_screen.dart';
import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../responsive.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
final Completer completer = new Completer();
 

@override
void initState(){
  
  init ();
  initRecharge();
  super.initState();
 
}
    
void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
