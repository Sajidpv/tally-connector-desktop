import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tally_connector/api/api.dart';
import 'package:xml/xml.dart';

extension XmlFindOrNull on Iterable<XmlElement> {
  XmlElement? get firstOrNull => isEmpty ? null : first;
}
class ApiRepository {
  API api = API();

  // Function to connect to Tally and process the data
  Future<dynamic> connectTally(String url,dynamic data) async {
    try {
      final response = await api.sendRequest.post(
        url, // Specify your endpoint
        data: data,
      );

      if (response.statusCode == 200) {
        String xmlString = response.data; // Assume XML data is in response.data as a String

if (kDebugMode) {
 // print('tally response : $xmlString');
}
        // Process the large XML response incrementally and extract relevant data

        // Return parsed data to the API or process further as needed
        // Example of sending parsed data back to API
        return xmlString;

      } else {
        throw "Failed to fetch data from Tally. Status code: ${response.statusCode}";
      }
    } on DioException catch (ex) {
      if (ex.response?.statusCode == 401) {
        // Handle 401 errors (Unauthorized)
      }
      rethrow;
    } catch (ex) {
      if (kDebugMode) {
        print("Error: $ex");
      }
    }
  }





Future<Map<String, dynamic>> processLargeXml(String xmlString) async {
  try {
    XmlDocument document = XmlDocument.parse(xmlString);
    final parsedData = <String, dynamic>{};

    // ✅ Extract Company Name safely
    var companyElement = document.findAllElements('SVCURRENTCOMPANY').firstOrNull;
    parsedData['CompanyName'] = companyElement?.innerText ?? "Unknown Company";

    // ✅ Extract Units safely
    var units = document.findAllElements('UNIT');
    List<Map<String, String>> unitList = [];

    for (var unit in units) {
      unitList.add({
        'Name': unit.findElements('NAME').firstOrNull?.innerText ?? 'N/A',
        'OriginalName': unit.findElements('ORIGINALNAME').firstOrNull?.innerText ?? 'N/A',
        'GSTUOM': unit.findElements('GSTREPUOM').firstOrNull?.innerText ?? 'N/A',
      });
    }
    parsedData['Units'] = unitList;

    // ✅ Extract Stock Groups safely
    var stockGroups = document.findAllElements('STOCKGROUP');
    List<Map<String, String>> stockGroupList = [];

    for (var group in stockGroups) {
      stockGroupList.add({
        'Name': group.findElements('NAME').firstOrNull?.innerText ?? 'N/A',
        'BaseUnit': group.findElements('BASEUNITS').firstOrNull?.innerText ?? 'N/A',
        'CostingMethod': group.findElements('COSTINGMETHOD').firstOrNull?.innerText ?? 'N/A',
      });
    }
    parsedData['StockGroups'] = stockGroupList;

    // ✅ Extract Stock Items safely
    var stockItems = document.findAllElements('STOCKITEM');
    List<Map<String, String>> stockItemList = [];

    for (var item in stockItems) {
      stockItemList.add({
        'Name': item.findElements(' NAME').firstOrNull?.innerText ?? 'N/A',
        'Parent': item.findElements('PARENT').firstOrNull?.innerText ?? 'N/A',
        'BaseUnit': item.findElements('BASEUNITS').firstOrNull?.innerText ?? 'N/A',
        'CostingMethod': item.findElements('COSTINGMETHOD').firstOrNull?.innerText ?? 'N/A',
      });
    }
    parsedData['StockItems'] = stockItemList;

    return parsedData;
  } catch (e) {
    print("Failed to parse XML: $e");
    return {};
  }
}



}
