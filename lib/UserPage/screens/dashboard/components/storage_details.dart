import 'package:apiproject/UserPage/controllers/FieldController.dart';
import 'package:apiproject/UserPage/controllers/TransController.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            numOfOpr: RechargeController.montantTotalRecharger,
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
