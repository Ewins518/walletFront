import 'package:apiproject/UserPage/controllers/TransController.dart';
import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatefulWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  _StarageDetailsState createState() => _StarageDetailsState();
}


class _StarageDetailsState extends State<StarageDetails> {

  @override
void initState(){
  init ();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
     int mtr = montantTotalRecharge!;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Solde",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/trans.svg",
            title: "Nombre de transaction",
            numOfOpr: nombreTransaction,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/renvers.svg",
            title: "Nombre de renversement",
            numOfOpr: 0,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/drop_box.svg",
            title: "Montant total rechargé",
            numOfOpr: mTR ? mtr : 0,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/client.svg",
            title: "Nombre de clients",
            numOfOpr: 0,
          ),
        ],
      ),
    );
  }
}
