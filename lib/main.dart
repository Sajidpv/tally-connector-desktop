import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
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
    try {
      final response =
          await http.get(Uri.parse('http://localhost:9000/TallyService'));

      if (response.statusCode == 200) {
        setState(() {
          tallyData = response.body;
        });
      } else {
        setState(() {
          tallyData = "Failed to fetch data from Tally.";
        });
      }
    } catch (e) {
      setState(() {
        tallyData = "Error: $e";
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
