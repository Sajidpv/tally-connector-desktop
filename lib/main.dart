// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tally Connector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TallyConnectorScreen(),
    );
  }
}

class TallyConnectorScreen extends StatefulWidget {
  const TallyConnectorScreen({super.key});

  @override
  State<TallyConnectorScreen> createState() => _TallyConnectorScreenState();
}

class _TallyConnectorScreenState extends State<TallyConnectorScreen> {
  TextEditingController tallyDataController = TextEditingController();
  bool _isSyncing = false;

  // Function to sync data with the Node.js server
  Future<void> _syncDataToServer(String tallyData) async {
    setState(() {
      _isSyncing = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:5001/sync-tally-data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'tallyData': tallyData}),
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data synced successfully!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sync data!')),
      );
    }

    setState(() {
      _isSyncing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tally Connector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tallyDataController,
              decoration: InputDecoration(labelText: 'Enter Tally Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSyncing
                  ? null
                  : () {
                      final tallyData = tallyDataController.text;
                      if (tallyData.isNotEmpty) {
                        _syncDataToServer(tallyData);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter data!')),
                        );
                      }
                    },
              child: _isSyncing
                  ? CircularProgressIndicator()
                  : Text('Sync to Server'),
            ),
          ],
        ),
      ),
    );
  }
}
