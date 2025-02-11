import 'package:flutter/material.dart';
import 'package:tally_connector/features/home/view/screens/home_screen.dart';

void main() {
  // final channel = WebSocketChannel.connect(
  //   Uri.parse('ws://localhost:9000'),
  // );

  // channel.stream.listen((message) {
  //   if (kDebugMode) {
  //     print('Received message: $message');
  //   }
  // });

  // channel.sink.add('Send your request to Tally');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tally Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TallySyncScreen(),
    );
  }
}
