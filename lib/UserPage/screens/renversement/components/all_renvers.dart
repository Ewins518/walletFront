import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/models/RenversModel.dart';
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
                renvers.length,
                (index) =>  recentOprDataRow(renvers[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentOprDataRow(Map<String, dynamic> fileInfo) {

 // Map <String, dynamic> map = fileInfo.toMap();

  int montant = fileInfo["montant"];
  return DataRow(
    cells: [
      DataCell(Text(fileInfo["noTel"])),
      DataCell(Text("$montant XOF")),
      DataCell(Text(fileInfo["date"])),
      
    ],
    
  );
}
