import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class AllAccount extends StatelessWidget {
  const AllAccount({
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
            "All Accounts",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("No Téléphone"),
                ),
                DataColumn(
                  label: Text("Date d'ajout"),
                ),
                DataColumn(
                  label: Text("Total réchargé"),
                ),
                 DataColumn(
                  label: Text("Total renversé"),
                ),
              ],
              rows:  List.generate(
                demoRecentOpr.length,
                (index) => recentOprDataRow(demoRecentOpr[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentOprDataRow(RecentOpr fileInfo) {
  int montant = fileInfo.montant!;
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.noCompte!)),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text("$montant XOF")),
       DataCell(Text("$montant XOF")),
    ],
    
  );
}
