import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class AllRenvers extends StatelessWidget {
  const AllRenvers({
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
            "All Renversements",
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
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Montant"),
                ),
              ],
              rows:  List.generate(
                demoRenversement.length,
                (index) => recentOprDataRow(demoRenversement[index]),
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
      DataCell(Text(fileInfo.date!.toString())),
      DataCell(Text("$montant XOF")),
    ],
    
  );
}
