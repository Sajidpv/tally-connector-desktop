import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tally_connector/api/api_repository.dart';
import 'package:tally_connector/api/xml_data_envelops.dart';
import 'package:tally_connector/api/xml_import_request.dart';
import 'package:tally_connector/features/home/model/ledger_list_response_model.dart';
import 'package:tally_connector/features/home/model/stock_list_reponse_model.dart';
import 'package:tally_connector/features/home/view/widgets/stock_list.dart';
import 'package:xml/xml.dart' as xml;
class TallySyncScreen extends StatefulWidget {
  const TallySyncScreen({super.key});

  @override
  State<TallySyncScreen> createState() => _TallySyncScreenState();
}

class _TallySyncScreenState extends State<TallySyncScreen> {
  Map<String, dynamic> tallyData = <String, dynamic>{};
  String error = '';
  List<StockItem> ledgers = [];
  Ledger? selectedLedger;
  bool isLoading = false;
  final ApiRepository _apiRepository = ApiRepository();
  final TextEditingController urlController =
      TextEditingController(text: 'http://localhost');
  final TextEditingController portController =
      TextEditingController(text: '9000');
  @override
  void initState() {
    super.initState();
    // fetchTallyData();
  }

  Future<void> fetchTallyData() async {
    setState(() {
      isLoading = true;
    });
    debugPrint("Fetching data from tally...");

    try {
      // Send POST request with XML data
      final response = await _apiRepository.connectTally(
          '${urlController.text}:${portController.text}',
          xmlTransactionVoucherAddRequest // Send the XML data as the body
          );
      // final StockListReponseModel ledgerResponse = StockListReponseModel.fromXml(response);
      // final ledgerList =
      //     ledgerResponse.body.data.stockItems ;

         final document = xml.XmlDocument.parse(response);
      final lineError = document.findAllElements("LINEERROR").isNotEmpty
          ? document.findAllElements("LINEERROR").first.innerText
          : "";

      if (lineError.isNotEmpty) {
        setState(() {
          error="Tally Error: $lineError";
        });
        print("Tally Error: $lineError");
      } else {
        print("Stock item added successfully!");
      }
 print(response);
      setState(() {
        // tallyData = response; // Display response from Tally
        isLoading = false;
        ledgers ;
        // if (ledgers.isNotEmpty) {
        //   selectedLedger = ledgers.first;
        // }
      });
    } catch ( e,stacktrace) {
      setState(() {
        isLoading = false;
        tallyData = {}; // Handle errors

        String errorMessage = e.toString();
        print(
          stacktrace,
        );
        error = 'Failed to connecting to Tally: $errorMessage';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tally Sync App"),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: urlController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Url'),
                          ),
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Port'),
                          ),
                          controller: portController,
                        )),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: fetchTallyData,
                      icon:
                          const Icon(Icons.sync, size: 20, color: Colors.white),
                      label: const Text('Connect'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: isLoading
                        ? [
                            Center(child: CircularProgressIndicator()),
                            Text('Connecting..')
                          ]
                        : [
                            if (ledgers.isEmpty)
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 20,
                                  children: [
                                    Icon(
                                      Icons.sync_problem_rounded,
                                      size: 50,
                                      color: Colors.redAccent,
                                    ),
                                    Text(error.isEmpty
                                        ? 'Company not connected.'
                                        : error),
                                  ],
                                ),
                              )
                             else ...[
                              Icon(
                                Icons.sync,
                                size: 50,
                                color: Colors.green,
                              ),
                              Text('Company connected.'),
                              if (ledgers.isNotEmpty)
                              StockTable(stockItems: ledgers),
                                // DropdownButton<Ledger>(
                                //   value: selectedLedger,
                                //   items: ledgers.map((ledger) {
                                //     return DropdownMenuItem(
                                //       value: ledger,
                                //       child:
                                //           Text(ledger.name ?? "Unnamed Ledger"),
                                //     );
                                //   }).toList(),
                                //   onChanged: (newValue) {
                                //     setState(() {
                                //       selectedLedger = newValue;
                                //     });
                                //   },
                                // ),
                              // selectedLedger != null
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text("Ledger Details:",
                              //               style: TextStyle(
                              //                   fontSize: 18,
                              //                   fontWeight: FontWeight.bold)),
                              //           SizedBox(height: 10),
                              //           buildDetailRow(
                              //               "Name", selectedLedger?.name),
                              //           buildDetailRow("Reserved Name",
                              //               selectedLedger?.reservedname),
                              //           buildDetailRow("Is Deleted",
                              //               selectedLedger?.isdeleted?.type),
                              //           buildDetailRow(
                              //               "Language ID",
                              //               selectedLedger
                              //                   ?.languagenameList?.languageid),
                              //           buildDetailRow(
                              //               "Language Name",
                              //               selectedLedger?.languagenameList
                              //                   ?.nameList?.name),
                              //         ],
                              //       )
                              //     : Center(
                              //         child: Text("No ledger selected",
                              //             style: TextStyle(fontSize: 16))),
                            ],
                          ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? "N/A"),
        ],
      ),
    );
  }
}
