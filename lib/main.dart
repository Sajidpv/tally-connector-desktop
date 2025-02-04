import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:9000/your-tally-websocket-endpoint'),
  );

  channel.stream.listen((message) {
    if (kDebugMode) {
      print('Received message: $message');
    }
  });

  channel.sink.add('Send your request to Tally');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tally Sync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TallySyncScreen(),
    );
  }
}

class TallySyncScreen extends StatefulWidget {
  const TallySyncScreen({super.key});

  @override
  State<TallySyncScreen> createState() => _TallySyncScreenState();
}

class _TallySyncScreenState extends State<TallySyncScreen> {
  String tallyData = "Fetching data...";

  @override
  void initState() {
    super.initState();
    fetchTallyData();
  }

  Future<void> fetchTallyData() async {
    final String xmlCompanyData = '''
<ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Export</TALLYREQUEST>
    <TYPE>Data</TYPE>
    <ID>Company</ID>
  </HEADER>
  <BODY>
    <DESC>
      <STATICVARIABLES>
        <SVCURRENTCOMPANY></SVCURRENTCOMPANY>
      </STATICVARIABLES>
    </DESC>
  </BODY>
</ENVELOPE>
    ''';
    final String xmlVoucherData = '''
<ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Export</TALLYREQUEST>
    <TYPE>Data</TYPE>
    <ID>Voucher</ID>
  </HEADER>
  <BODY>
    <DESC>
      <STATICVARIABLES>
        <SVCURRENTCOMPANY>Your Company Name</SVCURRENTCOMPANY>
      </STATICVARIABLES>
    </DESC>
  </BODY>
</ENVELOPE>
    ''';
    final String xmlLedgerData = '''
   <ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Export</TALLYREQUEST>
    <TYPE>Data</TYPE>
    <ID>Ledger</ID>
  </HEADER>
  <BODY>
    <DESC>
      <STATICVARIABLES>
        <SVCURRENTCOMPANY>Your Company Name</SVCURRENTCOMPANY>
      </STATICVARIABLES>
    </DESC>
  </BODY>
</ENVELOPE>
    ''';
    final String xmlStockData = '''
    <ENVELOPE>
      <HEADER>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Data</TYPE>
        <ID>Stock Summary</ID>
      </HEADER>
      <BODY>
        <DESC>
          <STATICVARIABLES>
            <SVCURRENTCOMPANY>Your Company Name</SVCURRENTCOMPANY>
          </STATICVARIABLES>
        </DESC>
      </BODY>
    </ENVELOPE>
    ''';

    try {
      // Send POST request with XML data
      final response = await http.post(
        Uri.parse('http://localhost:9000/TallyService'), // Tally's API endpoint
        headers: {
          'Content-Type': 'application/xml'
        }, // Set the content type to XML
        body: xmlCompanyData, // Send the XML data as the body
      );

      if (response.statusCode == 200) {
        setState(() {
          tallyData = response.body; // Display response from Tally
        });
      } else {
        setState(() {
          tallyData =
              "Failed to fetch data from Tally. Status code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        tallyData = "Error: $e"; // Handle errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tally Sync App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tally Data:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              tallyData,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchTallyData,
              child: const Text('Fetch Tally Data'),
            ),
          ],
        ),
      ),
    );
  }
}
