
import 'package:apiproject/UserPage/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/accounts.dart';
import 'components/my_fields.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                 // flex: 5,
                  child: Column(
                    children: [
                       AddAccount(),
                      SizedBox(height: defaultPadding),                                           
                       AllAccount(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                   //   if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
              //  if (!Responsive.isMobile(context))
              //    Expanded(
              //      flex: 2,
              //      child: StarageDetails(),
              //    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
