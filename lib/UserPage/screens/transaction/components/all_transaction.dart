import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/models/RecentOperation.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({
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
            "All transactions",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Montant"),
                ),
                 DataColumn(
                  label: Text("Nature"),
                ),
              ],
              rows:  List.generate(
                transaction.length,
                (index) => recentOprDataRow(transaction[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentOprDataRow(Map<String, dynamic> fileInfo) {
  int montant = fileInfo["montant"];
  return DataRow(
    cells: [
      DataCell(Text(fileInfo["username"])),
      DataCell(Text(fileInfo["date"])),
      DataCell(Text("$montant XOF")),
      DataCell(Text(fileInfo["nature"])),
    ],
    
  );
}
