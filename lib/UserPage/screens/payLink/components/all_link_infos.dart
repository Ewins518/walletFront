import 'package:apiproject/UserPage/controllers/stats.dart';
import 'package:apiproject/UserPage/models/ClientsModel.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class AllLinkInfo extends StatelessWidget {
  const AllLinkInfo ({
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
            "Paiement reçu",
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
                  label: Text("Description"),
                ),
              ],
              rows:  List.generate(
                clients.length,
                (index) => recentOprDataRow(clients[index]),
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
      DataCell(Text(fileInfo["desc"])),
    ],
    
  );
}
