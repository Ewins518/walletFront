import 'package:apiproject/UserPage/controllers/MenuController.dart';
import 'package:apiproject/UserPage/screens/payLink/link_screen.dart';
import 'package:apiproject/UserPage/screens/renversement/renvers_screen.dart';
import 'package:apiproject/UserPage/screens/settings/settings_screen.dart';
import 'package:apiproject/UserPage/screens/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/img.png"),
          ),
          DrawerListTile(
            title: "Dashbord",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
               Navigator.push(
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
           },
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        MultiProvider(
                      providers: [
                       ChangeNotifierProvider(
                         create: (context) => MenuController(),
                       ),
                     ],
                  child: TransactionScreen(),
                 ),
                    ),
                  );
            },
          ),
          DrawerListTile(
            title: "Renversement",
            svgSrc: "assets/icons/menu_task.svg",
            press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        MultiProvider(
                      providers: [
                       ChangeNotifierProvider(
                         create: (context) => MenuController(),
                       ),
                     ],
                  child: RenversScreen(),
                 ),
                    ),
                  );},
          ),
          DrawerListTile(
            title: "Lien de paiment",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        MultiProvider(
                      providers: [
                       ChangeNotifierProvider(
                         create: (context) => MenuController(),
                       ),
                     ],
                  child: LinkScreen(),
                 ),
                    ),
                  );
            },
          ),
          DrawerListTile(
            title: "Documentation",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Developper",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        MultiProvider(
                      providers: [
                       ChangeNotifierProvider(
                         create: (context) => MenuController(),
                       ),
                     ],
                  child: SettingsScreen(),
                 ),
                    ),
                  );
                  },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
