import 'package:flutter/material.dart';
import 'package:tally_connector/features/home/model/stock_list_reponse_model.dart';

class StockTable extends StatelessWidget {
  final List<StockItem> stockItems;

  const StockTable({super.key, required this.stockItems});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Stock List',style:TextStyle(fontSize:30,)),
              DataTable(
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("GST Applicable")),
                  DataColumn(label: Text("Base Units")),
                  DataColumn(label: Text("Opening Balance")),
                  DataColumn(label: Text("Opening Value")),
                  DataColumn(label: Text("Opening Rate")),
                  DataColumn(label: Text("Standard Price")),
                ],
                rows: stockItems.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item.name)),
                    DataCell(Text(item.gstApplicable)),
                    DataCell(Text(item.baseUnits)),
                    DataCell(Text(item.openingBalance)),
                    DataCell(Text(item.openingValue)),
                    DataCell(Text(item.openingRate)),
                    DataCell(Text(item.standardPrice)),
                  ]);
                }).toList(),
              ),
            ],
          ),
        
      ),
    );
  }
}
