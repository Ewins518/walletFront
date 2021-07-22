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
            svgSrc: "assets/icons/Documents.svg",
            title: "Nombre de transaction",
            numOfOpr: 0,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Nombre de renversement",
            numOfOpr: 0,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Montant total rechargé",
            numOfOpr: 28000,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Nombre de clients",
            numOfOpr: 0,
          ),
        ],
      ),
    );
  }
}
